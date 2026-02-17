Classy.Matrix = {
    -- Creates a new Matrix instance with an optional initial size and value
    new = function(rows, cols, initialValue)
        return Classy.createInstance(Classy.Matrix.prototype, function(self)
            self:base()  -- Initialize the base structure from Classy.Field
            self._className = "Classy.Matrix"
            self:initialize(rows, cols, initialValue)
        end)
    end,

    prototype = Classy.inheritFrom(Classy.Field, {
        -- Constructor initializes the Matrix
        constructor = function(self)
            self:base()  -- Initialize the base structure from Classy.Field
            self._className = "Classy.Matrix"
        end,

        -- Initializes the matrix with a specific size and initial value
        initialize = function(self, rows, cols, initialValue)
            rows, cols = rows or 0, cols or 0
            initialValue = initialValue or 0

            for i = 1, rows do
                self._data[i] = {}
                for j = 1, cols do
                    self._data[i][j] = initialValue
                end
            end
        end,

        -- Adds another matrix to the current matrix
        add = function(self, matrix)
            if #self._data == 0 then error("Classy.Matrix.add: Matrix is empty") end
            -- Ensure the matrices have the same dimensions
            local rows, cols = #self._data, #self._data[1]
            if rows ~= #matrix._data or cols ~= #matrix._data[1] then
                error("Classy.Matrix.add: Matrices must have the same dimensions")
            end

            local result = Classy.Matrix.new(rows, cols)
            for i = 1, rows do
                for j = 1, cols do
                    result._data[i][j] = self._data[i][j] + matrix._data[i][j]
                end
            end

            return result
        end,

        -- Subtracts another matrix from the current matrix
        subtract = function(self, matrix)
            if #self._data == 0 then error("Classy.Matrix.subtract: Matrix is empty") end
            -- Ensure the matrices have the same dimensions
            local rows, cols = #self._data, #self._data[1]
            if rows ~= #matrix._data or cols ~= #matrix._data[1] then
                error("Classy.Matrix.subtract: Matrices must have the same dimensions")
            end

            local result = Classy.Matrix.new(rows, cols)
            for i = 1, rows do
                for j = 1, cols do
                    result._data[i][j] = self._data[i][j] - matrix._data[i][j]
                end
            end

            return result
        end,

        -- Multiplies the current matrix by another matrix or a scalar
        multiply = function(self, matrixOrScalar)
            if #self._data == 0 then error("Classy.Matrix.multiply: Matrix is empty") end
            local result

            if type(matrixOrScalar) == "number" then
                -- Scalar multiplication
                local rows, cols = #self._data, #self._data[1]
                result = Classy.Matrix.new(rows, cols)
                for i = 1, rows do
                    for j = 1, cols do
                        result._data[i][j] = self._data[i][j] * matrixOrScalar
                    end
                end
            elseif type(matrixOrScalar) == "table" and matrixOrScalar._className == "Classy.Matrix" then
                -- Matrix multiplication
                local rowsA, colsA = #self._data, #self._data[1]
                local rowsB, colsB = #matrixOrScalar._data, #matrixOrScalar._data[1]

                if colsA ~= rowsB then
                    error("Classy.Matrix.multiply: Number of columns in the first matrix must equal the number of rows in the second matrix")
                end

                result = Classy.Matrix.new(rowsA, colsB)
                for i = 1, rowsA do
                    for j = 1, colsB do
                        result._data[i][j] = 0
                        for k = 1, colsA do
                            result._data[i][j] = result._data[i][j] + self._data[i][k] * matrixOrScalar._data[k][j]
                        end
                    end
                end
            else
                error("Classy.Matrix.multiply: Argument must be a number (scalar) or another matrix")
            end

            return result
        end,

        -- Transposes the current matrix
        transpose = function(self)
            if #self._data == 0 then error("Classy.Matrix.transpose: Matrix is empty") end
            local rows, cols = #self._data, #self._data[1]
            local result = Classy.Matrix.new(cols, rows)

            for i = 1, cols do
                for j = 1, rows do
                    result._data[i][j] = self._data[j][i]
                end
            end

            return result
        end,

        -- Calculates the determinant of the matrix (only for square matrices)
        determinant = function(self)
            local rows, cols = #self._data, #self._data[1]
            if rows ~= cols then
                error("Classy.Matrix.determinant: Determinant can only be calculated for square matrices")
            end

            -- Base case for 1x1 matrix
            if rows == 1 then return self._data[1][1] end

            -- Base case for 2x2 matrix
            if rows == 2 then
                return self._data[1][1] * self._data[2][2] - self._data[1][2] * self._data[2][1]
            end

            -- Recursive case for larger matrices
            local det = 0
            for i = 1, cols do
                local subMatrix = self:getSubMatrix(1, i)
                det = det + ((i % 2 == 1 and 1 or -1) * self._data[1][i] * subMatrix:determinant())
            end

            return det
        end,

        -- Returns the sub-matrix after removing a specific row and column
        getSubMatrix = function(self, row, col)
            local rows, cols = #self._data, #self._data[1]
            local subMatrix = Classy.Matrix.new(rows - 1, cols - 1)

            local sub_i = 1
            for i = 1, rows do
                if i == row then
                    goto continue
                end
                subMatrix._data[sub_i] = {}
                local sub_j = 1
                for j = 1, cols do
                    if j == col then
                        goto continue_inner
                    end
                    subMatrix._data[sub_i][sub_j] = self._data[i][j]
                    sub_j = sub_j + 1
                    ::continue_inner::
                end
                sub_i = sub_i + 1
                ::continue::
            end

            return subMatrix
        end,

        -- Calculates the inverse of the matrix (only for square matrices)
        inverse = function(self)
            local det = self:determinant()
            if det == 0 then
                error("Classy.Matrix.inverse: Matrix is singular and cannot be inverted")
            end

            local rows, cols = #self._data, #self._data[1]
            local adjugate = Classy.Matrix.new(rows, cols)

            for i = 1, rows do
                for j = 1, cols do
                    local subMatrix = self:getSubMatrix(i, j)
                    adjugate._data[j][i] = ((i + j) % 2 == 1 and -1 or 1) * subMatrix:determinant()
                end
            end

            return adjugate:multiply(1 / det)
        end,

        -- Returns a string representation of the matrix for easy visualization
        toString = function(self)
            if #self._data == 0 then return "" end
            local rows, cols = #self._data, #self._data[1]
            local str = ""

            for i = 1, rows do
                for j = 1, cols do
                    str = str .. tostring(self._data[i][j]) .. "\t"
                end
                str = str .. "\n"
            end

            return str
        end,
    })
}
