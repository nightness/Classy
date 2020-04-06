--[[
    Each value can only exist once in these DataSets. This allows a simple remove-by-value instead of remove-by-index.
]] --
Classy.DataSet = {
    new = function(constructor, existingData)
        return Classy.createInstance(Classy.DataSet.prototype,
                                     constructor, existingData);
    end,
    prototype = Classy.inheritFrom(Classy.Array, {
        constructor = function(self)
            self._className = "Classy.DataSet";
            self._data = {}
        end,
        -- Find the index of data
        find = function(self, value)
            for i = 1, #self._data do
                if (self._data[i] == value) then return i; end
            end
        end,
        -- Add data to the data set
        add = function(self, value)
            local index = self:find(value);
            if (index) then return false end-- Don't add twice
            self._data[#self._data + 1] = value;
            return true;
        end,
        -- :get(index) - Returns data values by index
        get = function(self, index)
            if (not index) then return nil end
            return self._data[index]
        end,
        -- Removes data from the self._data table
        remove = function(self, value)
            local index = self:find(value);
            if (not index) then return end-- Value not found
            table.remove(self._data, index);
        end,
        -- Union set function
        --      Return a Classy.DataSet that contians all elements that are in at least one of the two data sets
        union = function(self, dataSet)
            local ret = Classy.DataSet.new();
            for i = 1, self:length() do ret:add(self._data[i]); end
            for i = 1, dataSet:length() do ret:add(dataSet._data[i]); end
            return ret;
        end,
        -- Intersection set function
        --      Return a Classy.DataSet that contians all elements that exist in both data sets
        intersection = function(self, dataSet)
            local ret = Classy.DataSet.new();
            for i = 1, self:length() do
                local data = self._data[i];
                if (dataSet:find(data)) then ret:add(data); end
            end
            for i = 1, dataSet:length() do
                local data = dataSet._data[i];
                if (self:find(data)) then ret:add(data); end
            end
            return ret;
        end,
        -- Symetric difference set function
        --      Returns the set of all objects that are a member of exactly one of A and B (elements which are in one of the sets, but not in both)
        difference = function(self, dataSet)
            local ret = Classy.DataSet.new(); -- ToDo: class here should be self._className
            for i = 1, self:length() do
                local data = self._data[i];
                if (not dataSet:find(data)) then ret:add(data); end
            end
            for i = 1, dataSet:length() do
                local data = dataSet._data[i];
                if (not self:find(data)) then ret:add(data); end
            end
            return ret;
        end
    })
}

