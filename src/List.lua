-- A basic list of data
Classy.List = {
    new = function(constructor, existingData)
        return Classy.createInstance(Classy.List.prototype, constructor, existingData);
    end,
    prototype = Classy.inheritFrom(Classy.Array, {
        constructor = function(self)
            self._className = "Classy.List";
            self._data = {}
        end,
        add = function(self, value)
            self._data[#self._data + 1] = value;
        end,
        merge = function(self, list)
            if (Classy.getClassName(list) == self._className or (type(list) == "table" and #list)) then
                list:forEach(function (value)
                    self:add(value);
                end)
            end
        end,
        get = function(self, value)
            if (not value) then return self._data end
            return self._data[value]
        end,
        remove = function(self, index)
            table.remove(self._data, index)
        end,
    })
}
