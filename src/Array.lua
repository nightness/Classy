-- This is an abstract class, or maybe better called a prototype template. It's inherited by the
-- prototypes of Classy.DataSet and Classy.List
Classy.Array = {
    -- Number of data elements
    length = function(self) return #self._data; end,
    -- Clone the data set's table
    --      returns a simple copy of the self._data table... Unlike copy() which returns a new Classy.DataSet object.
    clone = function(self)
        -- Duplicate the data table before returning the result
        local ret = {}
        for key, value in ipairs(self._data) do ret[key] = value; end
        return ret;
    end,
    -- Copy the data set (copy only copies used indexed values)
    --      returns a Classy.DataSet object
    copy = function(self)
        local result = Classy.getClass(Classy.getClassName(self)).new()
        for i = 1, #self._data do result:add(self._data[i]); end
        return result;
    end,
    -- Are the two data sets equal, both contain the same elements and no additional elements
    equals = function(self, arrayClass)
        if (#self._data ~= #arrayClass._data) then return false end
        for i = 1, #self._data do
            if (not arrayClass:find(self._data[i])) then return false; end
        end
        return true;
    end,
    -- Sorts the data set
    -- Arg2 is optional, compareFunction should return true if the first element is < the second element.
    --      If the function omitted it defaults to the operator <.
    sort = function(self, compareFunction)
        table.sort(self._data, compareFunction);
    end,
    -- Return true if array is empty
    isEmpty = function(self)
        return (#self._data == 0)
    end,
    -- return true if the array contains the specified value
    contains = function(self, value)
        if (value == nil) then return false end
        local result = false;
        self:forEach(function (v)
            if (not result and v == value) then
                result = true
                return
            end
        end)
        return result;
    end,
    -- Valid Calls...
    -- :forEach(func, errorHandler, Arg1) - Use an error handler
    -- :forEach(func, nil, Arg1) - Don't use a specified error handler, let Blizzard handle errors
    -- :forEach(func, Classy.NoOp, Arg1) - Use an error handler that ignore any error
    -- :forEach(func, Arg1), in this case, Arg1 can not be a function; if it is, it's assumed to be the error handler.
    forEach = function(self, func, errorHandler, ...)
        -- Loop though all items in the data set
        for index = 1, #self._data do
            if (type(errorHandler) == "function") then
                xpcall(func, errorHandler, self._data[index], ...);
            elseif (errorHandler ~= nil) then
                func(self._data[index], errorHandler, ...);
            else
                func(self._data[index], ...);
            end
        end
    end,
    -- Map function
    -- Returns the results after applying the given function to each item of a given array
    map = function(self, handler, ...)
        if (type(handler) ~= "function") then
            error("map() - Invalid handler");
        end
        -- The result needs to be the same type as self
        local result = Classy.getClass(Classy.getClassName(self)).new()
        -- Build the result
        for index = 1, self:length() do
            -- Prepare arguments for handler
            local args = { ... }
            local t = { self:get(index) }
            for arg = 1, #args do
                local list = args[arg];
                table.insert(t, list:get(index))
            end
            -- Invoke handler and and return value to the result list
            result:add(handler(Classy.unpack(t)));
        end
        return result;
    end
}