-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

local Mixin = require("soul/Mixin")

--------------------------------------------------------------------------
-- @module  Class
--
-- @desc    Provides Class functionality.
--
-- @summary Package is a base 'Class' that all classes must extend.
--          Supports:
--              - Single Inheritance
--              - Constructors
--              - Type Checking
--              - Copying
--
-- @note    Relatively lightweight, does not copy individual methods when
--          inheriting; uses metatables.
-- @link    http://www.lua.org/pil/16.2.html
--
-- @todo    Create formal tests.
-- @todo    Add argument checking.
--------------------------------------------------------------------------
local Class = Mixin:copy()

--------------------------------------------------------------------------
-- @method  extend
--
-- @desc    Used to create new 'Class' tables.
--
-- @summary Creates an empty table that 'inherits' from self, sets that
--          tables 'super' to self, then returns it.
--
-- @warning Useage of __super may cause undefined behavior, use parent
--          class directly instead.
--
-- @param   self    Table to perform operations on.
-- @param   ...     Tables to implement.
--
-- @return  A new instance of self.
--------------------------------------------------------------------------
function Class:extend (...)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    instance.__super = self

    -- force instance to inherit args
    instance:implement(...)

    return instance
end

--------------------------------------------------------------------------
-- @method  implement
--
-- @desc    Used to include any number of 'interfaces'.
--
-- @summary Loops through arguments and includes each into self as long
--          as no 'Class' keys exist.
--
-- @warning Overrides similar keys.
--
-- @note    Similar to 'extend', but with non Classes.
--
-- @param   self    Table to perform operations on.
-- @param   ...     Tables to implement.
--------------------------------------------------------------------------
function Class:implement (...)
    local args = {...}

    for i, v in ipairs(args) do
        local continue = true

        for k, v2 in pairs(Class) do
            if v[k] then
                continue = false
            end
        end

        if continue then
            self:include(v)
        else
            error("Cannot implement '" .. v .. "', reason: 'Class' keys \
                found")
        end
    end
end

--------------------------------------------------------------------------
-- @method  __init
--
-- @desc    A template constructor that is called when creating 'new'
--          instances of self.
--
-- @note    Calling self's 'parent' constructor should always be done.
--          This can be done by directly using the parent 'Class' table
--          and passing self to it's constructor.
--
-- @param   self    Table to perform operations on.
--------------------------------------------------------------------------
function Class:__init ()
    -- Initialize vars and call super...
end

--------------------------------------------------------------------------
-- @method  new
--
-- @desc    Used to create instances from self.
--
-- @summary Creates an empty table that extends from self, initializes
--          it, then returns it.
--
-- @param   self    Table to perform operations on.
-- @param   ...     Arguments to constructor.
--
-- @return  A new and initialized instance.
--------------------------------------------------------------------------
function Class:new (...)
    local instance = self:extend()
    instance:__init(...)

    return instance
end

--------------------------------------------------------------------------
-- @method  copy
-- @override
--
-- @desc    Used to copy instances.
--
-- @summary Creates a copy of self by extending self's 'Class' table and
--          copying each key and value.
--
-- @note    To insure proper copy one can override this. All deratives
--          should directly call extend from parent 'Class' table,
--          similarly to how one calls the parent constructor.
--
-- @param   self    Table to perform operations on.
--
-- @return  A copy of self.
--------------------------------------------------------------------------
function Class:copy ()
    local copy = self.__super:extend()

    Mixin.include(copy, self)

    return copy
end

--------------------------------------------------------------------------
-- @method  isa
--
-- @desc    Used as a means of type-checking 'Class' instances and tables.
--
-- @summary Checks if other is equal to self or if other is an ancestor of
--          self.
--
-- @param   self    Table to perform operations on.
-- @param   other   Class to type-check against.
--
-- @return  True or false if other is a type of or is other.
--------------------------------------------------------------------------
function Class:isa (other)
    if self == other then
        return true
    end

    local parent = self.__super
    while parent do
        if parent == other then
            return true
        end
        parent = parent.__super
    end
    return false
end


return Class
