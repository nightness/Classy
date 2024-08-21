Classy.Vector = {
    -- Creates a new Vector instance
    new = function (constructor, existingData)
        return Classy.createInstance(Classy.Vector.prototype, constructor, existingData)
    end,

    -- Prototype for the Vector class
    prototype = {
        constructor = function(self, ...)
            self._className = "Classy.Vector"
            self._data = {...}  -- Initialize the vector with the provided elements
        end,

        -- Returns the dimension (length) of the vector
        dimension = function(self)
            return #self._data
        end,

        -- Adds another vector to this vector
        add = function(self, other)
            assert(self:dimension() == other:dimension(), "Vectors must be of the same dimension")
            local result = Classy.Vector.new()
            for i = 1, self:dimension() do
                result:addElement(self._data[i] + other._data[i])
            end
            return result
        end,

        -- Subtracts another vector from this vector
        subtract = function(self, other)
            assert(self:dimension() == other:dimension(), "Vectors must be of the same dimension")
            local result = Classy.Vector.new()
            for i = 1, self:dimension() do
                result:addElement(self._data[i] - other._data[i])
            end
            return result
        end,

        -- Multiplies this vector by a scalar
        multiplyByScalar = function(self, scalar)
            local result = Classy.Vector.new()
            for i = 1, self:dimension() do
                result:addElement(self._data[i] * scalar)
            end
            return result
        end,

        -- Computes the dot product of this vector and another vector
        dotProduct = function(self, other)
            assert(self:dimension() == other:dimension(), "Vectors must be of the same dimension")
            local result = 0
            for i = 1, self:dimension() do
                result = result + (self._data[i] * other._data[i])
            end
            return result
        end,

        -- Computes the magnitude (length) of the vector
        magnitude = function(self)
            local sumOfSquares = 0
            for i = 1, self:dimension() do
                sumOfSquares = sumOfSquares + (self._data[i] ^ 2)
            end
            return math.sqrt(sumOfSquares)
        end,

        -- Normalizes the vector (makes it a unit vector)
        normalize = function(self)
            local mag = self:magnitude()
            assert(mag ~= 0, "Cannot normalize a zero vector")
            return self:multiplyByScalar(1 / mag)
        end,

        -- Adds an element to the vector (used internally)
        addElement = function(self, value)
            table.insert(self._data, value)
        end,

        -- Retrieves the value at a specific index
        getElement = function(self, index)
            return self._data[index]
        end,

        -- Converts the vector to a string for easy printing
        toString = function(self)
            return "{" .. table.concat(self._data, ", ") .. "}"
        end,
    }
}
