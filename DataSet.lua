--[[
    Classy.DataSet is a collection that ensures each value exists only once.
    This allows for simple removal by value instead of by index, and supports set operations.
]]
Classy.DataSet = {
    -- Creates a new instance of a DataSet
    new = function(constructor, existingData)
        return Classy.createInstance(Classy.DataSet.prototype, constructor, existingData)
    end,

    prototype = Classy.inheritFrom(Classy.Array, {
        -- Constructor initializes the DataSet with an empty internal data array
        constructor = function(self)
            self._className = "Classy.DataSet"
            self._data = {}  -- Internal storage for dataset values
        end,

        -- Finds the index of a value in the dataset
        -- Returns the index if found, or nil if not found
        find = function(self, value)
            for i = 1, #self._data do
                if self._data[i] == value then return i end
            end
            return nil
        end,

        -- Adds a unique value to the dataset
        -- Returns true if the value was added, or false if it already existed
        add = function(self, value)
            if self:find(value) then return false end  -- Prevent duplicate entries
            self._data[#self._data + 1] = value
            return true
        end,

        -- Retrieves a value by its index
        -- Returns the value at the specified index, or nil if the index is out of bounds
        get = function(self, index)
            if not index or index < 1 or index > #self._data then return nil end
            return self._data[index]
        end,

        -- Removes a value from the dataset
        -- Does nothing if the value is not found
        remove = function(self, value)
            local index = self:find(value)
            if not index then return end  -- Value not found, no action needed
            table.remove(self._data, index)
        end,

        -- Performs a union operation with another dataset
        -- Returns a new DataSet containing all unique elements from both datasets
        union = function(self, dataSet)
            local result = Classy.DataSet.new()
            -- Add elements from the current dataset
            for i = 1, self:length() do
                result:add(self._data[i])
            end
            -- Add elements from the other dataset
            for i = 1, dataSet:length() do
                result:add(dataSet._data[i])
            end
            return result
        end,

        -- Performs an intersection operation with another dataset
        -- Returns a new DataSet containing only the elements common to both datasets
        intersection = function(self, dataSet)
            local result = Classy.DataSet.new()
            for i = 1, self:length() do
                local data = self._data[i]
                if dataSet:find(data) then
                    result:add(data)
                end
            end
            return result
        end,

        -- Performs a symmetric difference operation with another dataset
        -- Returns a new DataSet containing elements that are in either dataset but not in both
        difference = function(self, dataSet)
            local result = Classy.DataSet.new()
            -- Add elements unique to the current dataset
            for i = 1, self:length() do
                local data = self._data[i]
                if not dataSet:find(data) then
                    result:add(data)
                end
            end
            -- Add elements unique to the other dataset
            for i = 1, dataSet:length() do
                local data = dataSet._data[i]
                if not self:find(data) then
                    result:add(data)
                end
            end
            return result
        end,
    })
}
