-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

--------------------------------------------------------------------------
-- @module  Class
--
-- @test
--------------------------------------------------------------------------

local dev = require("libdev/dev")
dev.defaultPackages()

local Class = require("soul/Class")

-- Interface
--
local Tastable = {}

function Tastable:taste ()
    error("Not Implemented!")
end

-- Base Class
--
local Pizza = Class:extend(Tastable)

function Pizza:__init (name)
    Class.__init(self)
    self.name = name
end

-- Sub Class
--
local CheesePizza = Pizza:extend()

function CheesePizza:__init ()
    Pizza.__init(self, "Cheese")
end

function CheesePizza:taste ()
    print(self.name .. " is good!")
end

-- Results
--
local instance = CheesePizza:new()
instance:taste()

local instance2 = Pizza:new()
instance2:taste()
