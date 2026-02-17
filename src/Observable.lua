Classy.Observable = {
    -- Creates a new Observable instance with an initial value
    new = function(initialValue)
        return Classy.createInstance(Classy.Observable.prototype, function(self)
            self._value = initialValue  -- Initialize the observable value
        end)
    end,

    prototype = {
        -- Constructor initializes the Observable with an empty set of listeners
        constructor = function(self)
            self._className = "Classy.Observable"
            self._listeners = Classy.DataSet.new()  -- Store unique listeners
        end,

        -- Returns the current value of the Observable
        get = function(self)
            return self._value
        end,

        -- Sets a new value for the Observable and notifies listeners if the value has changed
        set = function(self, value)
            if value ~= self._value then
                self._value = value
                self:invokeValueChanged(value)  -- Notify listeners about the change
            end
        end,

        -- Subscribes a function to the Observable's value changes
        subscribe = function(self, func)
            if type(func) == "function" then
                self._listeners:add(func)  -- Add the listener function
            end
        end,

        -- Unsubscribes a function from the Observable's value changes
        unsubscribe = function(self, func)
            self._listeners:remove(func)  -- Remove the listener function
        end,

        -- Default error handler for listener invocation errors
        invokeErrorHandler = function(self, err)
            print("Observable invoke error: " .. tostring(err))
        end,

        -- Invokes all subscribed listeners when the value changes
        invokeValueChanged = function(self, newValue)
            -- Copy the listeners to avoid modification during iteration
            local listeners = self._listeners:clone()

            -- Notify all listeners of the new value
            for _, listener in ipairs(listeners) do
                if listener then
                    -- Call each listener with error handling
                    xpcall(listener, function(err) self:invokeErrorHandler(err) end, newValue)
                end
            end
        end,
    },
}
