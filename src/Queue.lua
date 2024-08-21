Classy.Queue = {
    -- Creates a new Queue instance
    new = function(initializer)
        local instance = Classy.createInstance(Classy.Queue.prototype)
        if initializer then
            initializer(instance)
        end
        return instance
    end,

    prototype = {
        -- Constructor initializes the Queue with an empty Collection
        constructor = function(self, ...)
            self._className = "Classy.Queue"
            self._collection = Classy.Collection.new()  -- Internal storage for queue elements
        end,

        -- Adds an element to the queue (enqueue)
        enqueue = function(self, arg)
            self._collection:pushright(arg)  -- Add element to the end of the queue
        end,

        -- Removes and returns the next element from the queue (dequeue)
        dequeue = function(self)
            if self:isEmpty() then
                error("Classy.Queue: dequeue from an empty queue")  -- Error handling for empty queue
            end
            return self._collection:popleft()  -- Remove element from the front of the queue
        end,

        -- Checks if the queue is empty
        isEmpty = function(self)
            return self._collection:isEmpty()  -- Returns true if the queue is empty
        end,

        -- Returns the number of elements in the queue
        size = function(self)
            return self._collection.last - self._collection.first + 1  -- Calculate the size of the queue
        end,

        -- Peeks at the next element in the queue without removing it
        peek = function(self)
            if self:isEmpty() then
                return nil  -- Return nil if the queue is empty
            end
            return self._collection:get(self._collection.first)  -- Return the element at the front of the queue
        end,
    },
}
