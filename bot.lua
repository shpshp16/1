package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'
URL = require('socket.url')
JSON = require('dkjson')
HTTPS = require('ssl.https')
dofile('utilities.lua')
----config----
local bot_api_key = "240744035:AAFXAqleC1XGZBJT-y_o0bwAw6_Y4rKr3aE" --BOT TOKEN 239337969:AAHz3YqsGePyWrE7n2a7zk6AUyd0yGlt2I0
local You = 197103788  --ID ADMIN 131232407
local BASE_URL = "https://api.telegram.org/bot"..bot_api_key
local BASE_FOLDER = ""
local start = [[ ]]

-------

----utilites----
do

function translate(source_lang, target_lang, text)
  local path = "http://translate.google.com/translate_a/single"
  -- URL query parameters
  local params = {
    client = "gtx",
    ie = "UTF-8",
    oe = "UTF-8",
    hl = "en",
    dt = "t",
    tl = target_lang or "en",
    sl = source_lang or "auto",
    q = URL.escape(text)
  }

  local query = format_http_params(params, true)
  local url = path..query

  local res, code = https.request(url)
  if code > 200 then
  return 
  end
  local trans = res:gmatch("%[%[%[\"(.*)\"")():gsub("\"(.*)", "")

  return trans
end

function run(msg, matches)
  if #matches == 1 then
    print("First")
    local text = matches[1]
    return translate(nil, nil, text)
  end

  if #matches == 2 then
    print("Second")
    local target = matches[1]
    local text = matches[2]
    return translate(nil, target, text)
  end

  if #matches == 3 then
    print("Third")
    local source = matches[1]
    local target = matches[2]
    local text = matches[3]
    return translate(source, target, text)
  end

end

return {
  description = "Translate some text", 
  usage = {
    "[/!]tr text. Translate the text to English.",
    "[/!]tra target_lang text.",
    "[/!]tr source.target text",
  },
  patterns = {
    "^[/!]tr ([%w]+).([%a]+) (.+)",
    "^[/!]tr ([%w]+) (.+)",
    "^[/!]tr (.+)",
  }, 
  run = run 
}

end

end
save_data('mico.db', add)
save_data('ban.db', ban)
print("Bot halted")
