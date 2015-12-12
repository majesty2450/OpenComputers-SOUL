
local Subject = require("soul/Subject")

local Person = Subject:extend()
function Person:__init (name)
    Subject.__init(self)
    self.name = name
end
function Person:talk()
    print("Hello!")
    self:notify("alert", "talk")
end

local bob = Person:new("Bob")
local function alert(subject, signal, key)
    print(subject.name .. " has a notification: '" .. signal .. "'!")
end

bob:register("alert", alert)
bob:talk()
