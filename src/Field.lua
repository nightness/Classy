--[[
    Classy.Field
    Abstract base class for managing a 2D array of values.
    This class provides foundational methods for setting and getting values in a 2D grid.
    It serves as a base class for more specialized structures like matrices.
]]
Classy.Field = {
    -- Initializes the Field with an empty 2D array
    base = function(self)
        self._baseName = "Classy.Field"
        self._data = {}  -- 2D array storage
    end,

    -- Sets a value at position (x, y) in the 2D array
    set = function(self, x, y, value)
        -- Ensure that the row exists
        if type(self._data[x]) ~= "table" then
            self._data[x] = {}  -- Initialize the row if it doesn't exist
        end
        self._data[x][y] = value  -- Set the value at the specified position
    end,

    -- Gets a value at position (x, y) in the 2D array
    get = function(self, x, y)
        -- Return the value at the specified position if it exists
        if type(self._data[x]) == "table" then
            return self._data[x][y]
        end
        return nil  -- Return nil if the position is out of bounds or unset
    end,

    -- Clears the entire 2D array (Optional Enhancement)
    clear = function(self)
        self._data = {}  -- Reset the data to an empty table
    end,
}
