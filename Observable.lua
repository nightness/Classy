Classy.Observable = {
    new = function (initialValue)
        return Classy.createInstance(Classy.Observable.prototype, function (self)
            self._value = initialValue;
        end);
    end,
    prototype = {
        constructor = function (self)
            self._className = "Classy.Observable";
            self._listeners = Classy.DataSet.new();
        end,
        get = function (self) 
            return self._value;
        end,
        set = function (self, value)
            if (value ~= self._value) then
                self._value = value;
                self:invokeValueChanged(value);
            end
        end,
        subscribe = function (self, func)
            -- Subscribe to value changed events
            if (type(func) == "function") then
                self._listeners:add(func);
            end
        end,
        unsubscribe = function (self, func)
            -- Unsubscribe to value changed events
            self._listeners:remove(func);
        end,
        invokeErrorHandler = function (err)
            addon.Debug("Observable invoke error: "..tostring(err));
        end,        
        invokeValueChanged = function (self, newValue)
            -- Clones the handler array
            local listeners = self._listeners:clone();            
            -- Invoke all functions in _listeners.
            for key, value in ipairs(listeners) do
                if (listeners[key]) then
                    xpcall(listeners[key], self.invokeErrorHandler, newValue)
                end
            end
        end,
    },
}