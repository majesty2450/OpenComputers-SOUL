-- The MIT License (MIT)
-- Copyright (c) 2015 Ryan M. Wackelin

local Class = require("soul/Class")

--------------------------------------------------------------------------
-- @module  Subject
--
-- @desc    Provides Observer Pattern functionality.
--
-- @summary Allows registering callback functions to 'listen' to signals
--          that the class can produce.
--
-- @todo    Create formal tests.
-- @todo    Add argument checking.
--------------------------------------------------------------------------
local Subject = Class:extend()

function Subject:__init ()
    Class.__init(self)

    -- table indexed by signals of listener arrays
    self.listeners = {}
end

--------------------------------------------------------------------------
-- Registers a new callback to listen for a signal. All callbacks have the
-- form: (subject, signal, ...data).
--------------------------------------------------------------------------
function Subject:register (signal, callback)
    if self.listeners[signal] then
        self.listeners[signal][#self.listeners[signal] + 1] = callback
    else
        self.listeners[signal] = {}
        self.listeners[signal][1] = callback
    end
end

--------------------------------------------------------------------------
-- Notifies all listeners of signal, signals are just numeric or stringed
-- identifiers. Notification MUST happen manually, each method that can
-- notify must explicitly notify.
--------------------------------------------------------------------------
function Subject:notify (signal, ...)
    local callbacks = self.listeners[signal]
    for k, v in ipairs(callbacks) do
        v(self, signal, ...)
    end
end


return Subject
