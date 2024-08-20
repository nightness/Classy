Classy.Hashtable = {
    new = function(initializer)
        return Classy.createInstance(Classy.Hashtable.prototype, initializer)
    end,
    prototype = {
        -- Constructor initializes the hashtable and sets up its properties
        constructor = function(self)
            self._className = "Classy.Hashtable"
            self:clear()  -- Initialize an empty hashtable
        end,

        -- Returns the number of key-value pairs in the hashtable
        size = function(self)
            return self._size
        end,

        -- Clears the hashtable, removing all key-value pairs
        clear = function(self)
            self._data = {}  -- Internal storage for key-value pairs
            self._size = 0    -- Tracks the number of key-value pairs
        end,

        -- Creates a deep copy of the current hashtable and returns it
        copy = function(self)
            local result = Classy.Hashtable.new()
            self:forEach(function(key, value)
                result:put(key, value)
            end)
            return result
        end,

        -- Merges another hashtable into this one, overwriting existing keys
        merge = function(self, hashtable)
            hashtable:forEach(function(key, value)
                self:put(key, value)
            end)
        end,

        -- Checks if the hashtable is empty (no key-value pairs)
        isEmpty = function(self)
            return self._size == 0
        end,

        -- Checks if a given key exists in the hashtable
        containsKey = function(self, key)
            return self._data[key] ~= nil
        end,

        -- Checks if a given value exists in the hashtable
        containsValue = function(self, value)
            local result = false
            self:forEach(function(_, v)
                if v == value then result = true end
            end)
            return result
        end,

        -- Removes a key-value pair from the hashtable by key
        remove = function(self, key)
            if type(key) ~= "string" then
                error("Classy.Hashtable.remove: Key argument requires a string value")
            end
            if self._data[key] ~= nil then
                self._data[key] = nil
                self._size = self._size - 1
            end
        end,

        -- Adds or updates a key-value pair in the hashtable
        put = function(self, key, value)
            if type(key) ~= "string" then
                error("Classy.Hashtable.put: Key argument requires a string value")
            end
            -- Increment size if a new key is being added
            if self._data[key] == nil and value ~= nil then
                self._size = self._size + 1
            -- Decrement size if an existing key is being removed (value set to nil)
            elseif self._data[key] ~= nil and value == nil then
                self._size = self._size - 1
            end
            self._data[key] = value
        end,

        -- Retrieves the value associated with a key, or returns the default value if the key is not found
        get = function(self, key, default)
            if type(key) ~= "string" then
                error("Classy.Hashtable.get: Key argument requires a string value")
            end
            return self._data[key] or default
        end,

        -- Returns a Classy.List of all keys in the hashtable, optionally sorted
        getKeys = function(self, sort)
            local result = Classy.List.new()
            self:forEach(function(k, _)
                result:add(k)
            end)
            if sort then
                result:sort()
            end
            return result
        end,

        -- Returns a Classy.List of all values in the hashtable, optionally sorted
        getValues = function(self, sort)
            local result = Classy.List.new()
            self:forEach(function(_, v)
                result:add(v)
            end)
            if sort then
                result:sort()
            end
            return result
        end,

        -- Checks if two hashtables are equal in terms of key-value pairs
        equals = function(self, otherHashtable)
            if self == otherHashtable then return true end

            -- Ensure both objects are hashtables
            if not (otherHashtable and otherHashtable._className == self._className) then
                return false
            end

            -- Check if they have the same size
            if self:size() ~= otherHashtable:size() then
                return false
            end

            -- Compare key-value pairs in both hashtables
            local result = true
            self:forEach(function(key, value)
                if otherHashtable:get(key) ~= value then
                    result = false
                end
            end)
            return result
        end,

        -- Iterates over each key-value pair in the hashtable, applying the given function
        -- Valid Calls...
        --  :forEach(func, errorHandler, Arg1) - Use an error handler
        --  :forEach(func, nil, Arg1) - Don't use a specified error handler, let Blizzard handle errors
        --  :forEach(func, Classy.NoOp, Arg1) - Use an error handler that ignore any error
        --  :forEach(func, Arg1), in this case, Arg1 can not be a function; if it is, it's assumed to be the error handler.
        forEach = function(self, func, errorHandler, ...)
            for key, value in pairs(self._data) do
                if type(errorHandler) == "function" then
                    xpcall(func, errorHandler, key, value, ...)
                elseif errorHandler ~= nil then
                    func(key, value, errorHandler, ...)
                else
                    func(key, value, ...)
                end
            end
        end,
    },
}
