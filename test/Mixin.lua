-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

--------------------------------------------------------------------------
-- @module  Mixin
--
-- @test
--------------------------------------------------------------------------

local dev = require("libdev/dev")
dev.defaultPackages()

local Mixin = require("soul/Mixin")

local Pizza = Mixin:copy()
Pizza.white = true

local Cheese = Mixin:copy()
Cheese.mozzarella = true
Cheese.age = 5

local CheesePizza = Pizza:copy()
CheesePizza:include(Cheese)

print("Pizza hasa Cheese: \t", Pizza:hasa(Cheese))
print("Pizza hasa Cheese (function): ", Pizza:hasa(Cheese, "function"))
print("Cheese hasa CheesePizza: ", Cheese:hasa(CheesePizza))
print("Cheese hasa CheesePizza (function, number): ", Cheese:hasa(CheesePizza, "function", "number"))
print("Cheese Pizza hasa Pizza: ", CheesePizza:hasa(Pizza))
print("Cheese Pizza hasa Cheese: ", CheesePizza:hasa(Cheese))
