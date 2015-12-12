
local Stack = require("soul/Stack")

local events = Stack:new()

print("Push: ", "hello")
events:push("hello")
print("Push: ", "talk")
events:push("talk")
print("Push: ", "goodbye")
events:push("goodbye")

print("Pop: ", events:pop())
print("Pop: ", events:pop())
print("Peek: ", events:peek())

print("Empty...")
events:empty()

print("Pop: ", events:pop())
