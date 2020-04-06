-- Matrix
Classy.Matrix = {
    new = function(constructor, existingData)
        return Classy.createInstance(Classy.Matrix.prototype, constructor, existingData);
    end,
    prototype = Classy.inheritFrom(Classy.Field, {
        constructor = function(self)
            self:base();
            self._className = "Classy.Matrix";
        end,
        add = function(self, matrix)

        end,
        subtract = function(self, matrix)

        end,
        multiply = function(self, matrixOrArray)

        end,
        transpose = function(self)

        end,
    })
}
