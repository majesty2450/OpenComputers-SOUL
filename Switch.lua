-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

local Class = require("soul/Class")

--------------------------------------------------------------------------
-- @module  Switch
--
-- @desc    Provides Switch Case functionality.
--
-- @todo    Create formal tests.
-- @todo    Add argument checking.
--------------------------------------------------------------------------
local Switch = Class:extend()

function Switch:__init (cases, default_case, compact)
    Class.__init(self)

    if cases and compact then
        self.cases = {}
        for k, v in pairs(cases) do
            self:case(k, v)
        end
    else
        self.cases = cases or {}
    end
    self.default_case = default_case or function() end
end

function Switch:case (keys, action)
    if type(keys) == "table" then
        for k, v in pairs(keys) do
            self.cases[v] = action
        end
    else
        self.cases[keys] = action
    end
end

function Switch:default (action)
    self.default_case = action
end

function Switch:select (key, ...)
    if self.cases[key] then
        return self.cases[key](...)
    else
        return self.default_case(...)
    end
end



return Switch
