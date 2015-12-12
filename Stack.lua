-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

local Class = require("soul/Class")

--------------------------------------------------------------------------
-- @module  Stack
--
-- @desc    Provides Stack functionality.
--
-- @todo    Create formal tests.
-- @todo    Add argument checking.
--------------------------------------------------------------------------
local Stack = Class:extend()

function Stack:__init ()
    Class.__init(self)

    self.data = {}
end

function Stack:push (var)
    self.data[self:length() + 1] = var
end

function Stack:pop ()
    local var = self.data[self:length()]
    self.data[self:length()] = nil
    return var
end

function Stack:peek ()
    if self:length() > 0 then
        return self.data[self:length()]
    else
        error("Stack is empty!")
    end
end

function Stack:empty ()
    self.data = {}
end

function Stack:length ()
    return #self.data
end


return Stack
