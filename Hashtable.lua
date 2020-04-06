Classy.Hashtable = {
    new = function (constructor)
        return Classy.createInstance(Classy.Hashtable.prototype, constructor)
    end,
    prototype = {
        constructor = function(self)
            self._className = "Classy.Hashtable"
            self:clear();
        end,
        size = function(self)
            return self._size
        end,
        clear = function(self)
            self._data = { }
            self._size = 0;
        end,
        copy = function(self)
            local result = Classy.Hashtable.new()
            self:forEach(function (key, value)
                result:add(key, value)
            end)
            return result
        end,
        merge = function(self, hashtable)
            hashtable:forEach(function (key, value)
                self:add(key, value)
            end)
        end,
        isEmpty = function(self)
            return (self._size == 0)
        end,
        containsKey = function(self, key)
            return (self._data[key] ~= nil);
        end,
        containsValue = function(self, value)
            local result = false
            self:forEach(function (_, v)
                if (v == value) then result = true end
            end)            
            return result
        end,
        remove = function (self, key)
            if (type(key) ~= "string") then
                error("Classy.Hashtable.put: Key argument requires a string value");
            end
            if (self._data[key] ~= nil) then
                self._data[key] = nil
                self._size = self._size - 1;
            end
        end,
        put = function(self, key, value)
            if (type(key) ~= "string") then
                error("Classy.Hashtable.put: Key argument requires a string value");
            end
            -- This is a new key, increase size
            if (self._data[key] == nil and value ~= nil) then
                self._size = self._size + 1
            end
            -- Adjust size, setting nil removes the element
            if (self._data[key] ~= nil and value == nil) then
                self._size = self._size - 1;
            end
            self._data[key] = value
        end,
        get = function(self, key, default)
            if (type(key) ~= "string") then
                error("Classy.Hashtable.get: Key argument requires a string value");
            end
            return self._data[value] or default
        end,
        -- Returns a Classy.List of all kets
        getKeys = function(self, sort)
            local result = Classy.List.new();
            self:forEach(function (k, v)
                result:add(k)
            end)
            if (sort) then
                result:sort()
            end
            return result
        end,
        -- Returns a Classy.List of all values
        getValues = function(self, sort)
            local result = Classy.List.new();
            self:forEach(function (k, v)
                result:add(v)
            end)
            if (sort) then
                result:sort()
            end
            return result
        end,
        -- Valid Calls...
        -- :forEach(func, errorHandler, Arg1) - Use an error handler
        -- :forEach(func, nil, Arg1) - Don't use a specified error handler, let Blizzard handle errors
        -- :forEach(func, Classy.NoOp, Arg1) - Use an error handler that ignore any error
        -- :forEach(func, Arg1), in this case, Arg1 can not be a function; if it is, it's assumed to be the error handler.
        forEach = function(self, func, errorHandler, ...)
            for key, value in pairs(self._data) do
                if (type(errorHandler) == "function") then
                    xpcall(func, errorHandler, key, value, ...);
                elseif (errorHandler ~= nil) then
                    func(key, value, errorHandler, ...);
                else
                    func(key, value, ...);
                end                
            end
        end,
    },
}