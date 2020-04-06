Classy.Collection = {
    new = function (constructor)
        return Classy.createInstance(Classy.Collection.prototype, constructor);
    end,
    prototype = {
        constructor = function (list)
            list._className = "Classy.Collection";
            list.first = 0;
            list.last = -1;
        end,
        reset = function (list)
            -- Pop all too?
            list.first = 0;
            list.last = -1;
        end,
        isEmpty = function (list)
            return (list.first == 0 and list.last == -1)
        end,
        pushleft = function (list, value)
            local first = list.first - 1
            list.first = first
            list[first] = value
        end,
        pushright = function (list, value)
            local last = list.last + 1
            list.last = last
            list[last] = value
        end,
        popleft = function (list)
            local first = list.first
            if first > list.last then error("Classy.Collection: list is empty") end
            local value = list[first]
            list[first] = nil        -- to allow garbage collection
            list.first = first + 1
            return value
        end,
        popright = function (list)
            local last = list.last
            if list.first > last then error("Classy.Collection: list is empty") end
            local value = list[last]
            list[last] = nil         -- to allow garbage collection
            list.last = last - 1
            return value
        end
    },
}