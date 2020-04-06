--
-- Classy's Stack datatype
--
Classy.Stack = {
    new = function (constructor)
        return Classy.createInstance(Classy.Stack.prototype, constructor);
    end,
    prototype = {
        constructor = function(self, ...)
            self._className = "Classy.Stack";
            self._collection = Classy.Collection.new();
        end,

        reset = function (self)
            self._collection:reset();
        end,

        push = function(self, arg)
            self._collection:pushleft(arg);
        end,

        pop = function(self)
            return self._collection:popleft();
        end,
    },
}

--
-- A stack that invokes callbacks, sutabile to undo actions. This stack will invoke callbacks on undo() calls.
--
Classy.UndoStack = {
    new = function (constructor)
        return Classy.createInstance(Classy.UndoStack, constructor);
    end,

    constructor = function(self, ...)
        self._className = "Classy.UndoStack";
        self._collection = Classy.Collection.new()
    end,

    reset = function (self)
        self._collection:reset();
    end,

    add = function(self, callback)
        self._collection:pushleft(callback)
    end,

    undo = function(self)
        if (not self._collection:isEmpty()) then
            local callback = self._collection:popleft()
            -- Callback is a function
            if (type(callback) == "function") then
                callback()
                return true;
            -- Callback is a Job (or is a table that has an invoke() function)
            elseif (type(callback) == "table" and type(callback.invoke) == "function") then
                callback.invoke(); 
                return true;
            end
        end
        return false
    end,
}