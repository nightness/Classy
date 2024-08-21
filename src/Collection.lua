Classy.Collection = {
    -- Creates a new instance of a Collection using the provided initializer
    new = function(initializer)
        return Classy.createInstance(Classy.Collection.prototype, initializer)
    end,

    prototype = {
        -- Constructor initializes the collection, setting up the internal structure
        constructor = function(self)
            self._className = "Classy.Collection"  -- Identifies the class name for this object
            self.first = 0                         -- Index of the first element in the collection
            self.last = -1                         -- Index of the last element in the collection
            self.data = {}                         -- Table to hold the collection's data
        end,

        -- Resets the collection to its initial empty state
        reset = function(self)
            self.first = 0        -- Reset the first index
            self.last = -1        -- Reset the last index
            self.data = {}        -- Clear the data table
        end,

        -- Checks if the collection is empty
        isEmpty = function(self)
            return self.first > self.last  -- Collection is empty if first index is greater than last
        end,

        -- Adds a value to the left side (front) of the collection
        pushleft = function(self, value)
            self.first = self.first - 1             -- Decrement first index
            self.data[self.first] = value           -- Store the value at the new first index
        end,

        -- Adds a value to the right side (end) of the collection
        pushright = function(self, value)
            self.last = self.last + 1               -- Increment last index
            self.data[self.last] = value            -- Store the value at the new last index
        end,

        -- Removes and returns the value from the left side (front) of the collection
        popleft = function(self)
            if self:isEmpty() then
                error("Classy.Collection: list is empty")  -- Error if attempting to pop from an empty collection
            end
            local value = self.data[self.first]      -- Retrieve the value at the first index
            self.data[self.first] = nil              -- Remove the value to allow garbage collection
            self.first = self.first + 1              -- Increment first index to the next element
            return value                             -- Return the removed value
        end,

        -- Removes and returns the value from the right side (end) of the collection
        popright = function(self)
            if self:isEmpty() then
                error("Classy.Collection: list is empty")  -- Error if attempting to pop from an empty collection
            end
            local value = self.data[self.last]       -- Retrieve the value at the last index
            self.data[self.last] = nil               -- Remove the value to allow garbage collection
            self.last = self.last - 1                -- Decrement last index to the previous element
            return value                             -- Return the removed value
        end,

        -- Checks if two collections are equal by comparing their contents
        equals = function(self, otherCollection)
            if self == otherCollection then
                return true  -- Collections are equal if they are the same object
            end

            -- Check if the other object is a collection and of the same class
            if not (otherCollection and otherCollection._className == self._className) then
                return false
            end

            -- Both collections are empty
            if self:isEmpty() and otherCollection:isEmpty() then
                return true
            end

            -- Compare the size of the collections
            if (self.last - self.first) ~= (otherCollection.last - otherCollection.first) then
                return false
            end

            -- Compare each element in the collections
            local index1 = self.first
            local index2 = otherCollection.first
            while index1 <= self.last do
                if self.data[index1] ~= otherCollection.data[index2] then
                    return false  -- Collections are not equal if any corresponding elements differ
                end
                index1 = index1 + 1
                index2 = index2 + 1
            end

            return true  -- Collections are equal if all corresponding elements match
        end
    }
}
