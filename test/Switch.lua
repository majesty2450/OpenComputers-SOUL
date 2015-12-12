
local dev = require("libdev/dev")
dev.defaultPackages()

local Switch = require("soul/Switch")

local function greeting (name)
    print("Hi, " .. name .. "!")
end
local function farewell (name)
    print("See you later, " .. name .. "!")
end
local function question ()
    print("Good, and you?")
end
local function unknown (name)
    print("I do not understand " .. name .. ".")
end

local react = Switch:new()
react:case({"hello", "hi"}, greeting)
react:case({"goodbye", "see you later"}, farewell)
react:case("how are you", question)
react:default(unknown)

local react_inline = Switch:new({
    [{"hello", "hi"}]                = greeting,
    [{"goodbye", "see you later"}]   = farewell,
    [{"how are you"}]                = question
}, unknown, true)

local input = io.read()
react:select(input, "ryan")
react_inline:select(input, "ryan")
