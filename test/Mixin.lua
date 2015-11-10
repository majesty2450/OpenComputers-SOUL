-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

--------------------------------------------------------------------------
-- @module  Mixin
-- 
-- @test
--------------------------------------------------------------------------

local Mixin = require("soul/Mixin")

local Pizza = Mixin:copy()
Pizza.white = true

local Cheese = Mixin:copy()
Cheese.mozzarella = true

local CheesePizza = Pizza:copy()
CheesePizza:include(Cheese)

print("Pizza hasa Cheese: \t", Pizza:hasa(Cheese))
print("Cheese Pizza hasa Pizza: ", CheesePizza:hasa(Pizza))
print("Cheese Pizza hasa Cheese: ", CheesePizza:hasa(Cheese))