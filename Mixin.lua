-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

--------------------------------------------------------------------------
-- @module  Mixin
--
-- @desc    Provides Mixin functionality.
--
-- @summary Mixins are defined by their ability to 'include' other mixins
--          and to copy themselves.
--
-- @note    Can act as an 'interface'. The 'hasa' function allows primitive
--          type checking.
--
-- @todo    Create formal tests.
-- @todo    Add argument checking.
--------------------------------------------------------------------------
local Mixin = {}


--------------------------------------------------------------------------
-- @method  include
--
-- @desc    Used to copy other mixins into self.
--
-- @summary Loops through other mixin and copies all fields.
--
-- @warning Overrides similar keys.
--
-- @param   self    Table to perform operations on.
-- @param   other   Table to copy.
--------------------------------------------------------------------------
function Mixin:include (other)
    for k, v in pairs(other) do
        self[k] = v
    end
end

--------------------------------------------------------------------------
-- @method  copy
--
-- @desc    Used to copy self.
--
-- @summary Creates a copy of self by copying each key and value into a
--          new table.
--
-- @note    To insure proper copy one can override this.
--
-- @param   self    Table to perform operations on.
--
-- @return  A copy of self.
--------------------------------------------------------------------------
function Mixin:copy ()
    local copy = {}

    for k, v in pairs(self) do
        copy[k] = v
    end

    return copy
end

--------------------------------------------------------------------------
-- @method  hasa
--
-- @desc    Used as a means of type-checking 'Mixin's and tables.
--
-- @summary Checks if other is equal to self or if other is contained in
--          self. Only checks key's as it allows changes. Keys can be
--          filtered by var args.
--
-- @param   self    Table to perform operations on.
-- @param   other   Class to type-check against.
-- @param   ...     The types of keys to filter by. Nil implies all.
--
-- @return  True or false if other has a type of or is other.
--------------------------------------------------------------------------
function Mixin:hasa (other, ...)
    if self == other then
        return true
    end

    local args = {...}

    -- If there are filters
    if args[1] then
        -- loop through keys in other
        for k, v in pairs(other) do
            -- filter
            for k2, v2 in ipairs(args) do
                if type(other[k]) == v2 then
                    -- check if key exists
                    if not self[k] then
                        return false
                    end
                end
            end
        end
    -- no filters
    else
        -- loop through keys in other
        for k, v in pairs(other) do
            -- check if key exists
            if not self[k] then
                return false
            end
        end
    end

    return true
end


return Mixin
