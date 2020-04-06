-- Field - A 2D Array of values
-- Abstract class
Classy.Field = {
    base = function(self)
        self._baseName = "Classy.Field";
        self._data = {}
    end,
    set = function(self, x, y, value)
        if (type(self._data[x]) ~= "table") then
            self._data[x] = {}
        end
        self._data[x][y] = value;
    end,
    get = function(self, x, y)
        if (type(self._data[x]) == "table") then
            return self._data[x][y]
        end
    end,
}
