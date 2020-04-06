Classy.Queue = {
    new = function (constructor)
        return Classy.createInstance(Classy.Queue.prototype, constructor);
    end,
    prototype = {
        constructor = function(self, ...)
            self._className = "Classy.Queue";
            self._collection = Classy.Collection.new();
        end,

        add = function(self, arg)
            self._collection:pushleft(arg);
        end,

        next = function(self)
            return self._collection:popright();
        end,
    },
}