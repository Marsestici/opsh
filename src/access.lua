ip_bind_time = 604800  --封禁IP时间 48小时
ip_time_out = 86400    --指定ip访问频率时间段 24小时
connect_count = 7      --指定ip访问频率计数最大值

local rulematch = ngx.re.find
local unescape = ngx.unescape_uri
--连接redis
local redis = require "resty.redis"
local cache = redis.new()
local ok , err = cache.connect(cache,"xxxx","6379")
local aok, aerr = cache.auth(cache, "zzzzz")

--如果连接失败，跳转到脚本结尾
if not ok then
    goto A
end

if not aok then
    goto A
end

cache:set_timeout(60000)

function waf_output()
    ngx.header.content_type = "text/html"
    ngx.say("<script>window.location.href='http://www.daiba.com';</script>")
    ngx.exit(ngx.status)
end

function get_rule(rulefilename)
    local io = require 'io'
    local RULE_PATH = "/usr/local/nginx/conf/rules"
    local RULE_FILE = io.open(RULE_PATH..'/'..rulefilename,"r")
    if RULE_FILE == nil then
        return
    end
    RULE_TABLE = {}
    for line in RULE_FILE:lines() do
        table.insert(RULE_TABLE,line)
    end
    RULE_FILE:close()
    return(RULE_TABLE)
end


function get_client_ip()
    CLIENT_IP = ngx.req.get_headers()["X_real_ip"]
    if CLIENT_IP == nil then
        CLIENT_IP = ngx.req.get_headers()["X_Forwarded_For"]
    end
    if CLIENT_IP == nil then
        CLIENT_IP  = ngx.var.remote_addr
    end
    if CLIENT_IP == nil then
        CLIENT_IP  = "unknown"
    end
    return CLIENT_IP
end

function get_user_agent()
    USER_AGENT = ngx.var.http_user_agent
    if USER_AGENT == nil then
       USER_AGENT = "unknown"
    end
    return USER_AGENT
end

function log_record(method, url, data, ruletag)
    --ngx.say(ngx.req.get_Method())
    local cjson = require("cjson")
    local io = require 'io'
    local LOG_PATH = "/usr/local/nginx/logs/waf"
    local CLIENT_IP = get_client_ip()
    local USER_AGENT = get_user_agent()
    local SERVER_NAME = ngx.var.server_name
    local LOCAL_TIME = ngx.localtime()
    local log_json_obj = {
                 client_ip = CLIENT_IP,
                 local_time = LOCAL_TIME,
                 server_name = SERVER_NAME,
                 user_agent = USER_AGENT,
                 attack_method = method,
                 req_url = url,
                 req_data = data,
                 rule_tag = ruletag,
              }
    local LOG_LINE = cjson.encode(log_json_obj)
    local LOG_CONT = LOCAL_TIME .."\t\t".. CLIENT_IP .."\t\t".. SERVER_NAME .."\t\t".. USER_AGENT .."\t\t".. method .."\t\t".. url .."\t\t".. data .."\t\t".. ruletag
    local LOG_NAME = LOG_PATH..'/'..ngx.today().."_waf.log"
    local file = io.open(LOG_NAME,"a")
    if file == nil then
        return
    end
    --file:write(LOG_LINE.."\n")
    file:write(LOG_CONT.."\n")
    file:flush()
    file:close()
end

function set_blacklist()
    --查询ip是否在封禁段内，若在则返回403错误代码
    --因封禁时间会大于ip记录时间，故此处不对ip时间key和计数key做处理
    is_bind , err = cache:get("BLACKFLAG_".. get_client_ip())
    if tonumber(is_bind ) == 1 then
        waf_output()
    end

    start_time , err = cache:get("TIMEFLAG_".. get_client_ip())
    ip_count , err = cache:get("REGISTER_".. get_client_ip())

    --如果ip记录时间大于指定时间间隔或者记录时间或者不存在ip时间key则重置时间key和计数key
    --如果ip时间key小于时间间隔，则ip计数+1，且如果ip计数大于ip频率计数，则设置ip的封禁key为1
    --同时设置封禁key的过期时间为封禁ip的时间
    if start_time == ngx.null or os.time() - start_time > ip_time_out then
        res , err = cache:set("TIMEFLAG_".. get_client_ip(), os.time())
        res , err = cache:set("REGISTER_".. get_client_ip(), 1)
    else
        ip_count = ip_count + 1
        res , err = cache:incr("REGISTER_".. get_client_ip())
        if ip_count >= connect_count then
            res , err = cache:set("BLACKFLAG_".. get_client_ip(),1)
            res , err = cache:expire("BLACKFLAG_"..get_client_ip(), ip_bind_time)
        end
    end

end

function url_args_attack_check()
    local ARGS_RULES = get_rule('args.rule')
    for _,rule in pairs(ARGS_RULES) do
        local REQ_ARGS = ngx.req.get_uri_args()
        for key, val in pairs(REQ_ARGS) do
            if type(val) == 'table' then
                ARGS_DATA = table.concat(val, " ")
            else
                ARGS_DATA = val
            end
            if ARGS_DATA and type(ARGS_DATA) ~= "boolean" and rule ~="" and rulematch(unescape(ARGS_DATA),rule,"jo") then
                log_record('DENY_URL_ARGS', ngx.var.request_uri, "-", rule)
                set_blacklist()
            end
        end
    end
end

url_args_attack_check()

--结尾标记
::A::
local ok, err = cache:close()
