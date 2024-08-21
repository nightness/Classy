Classy.Stack = {
    -- Creates a new Stack instance
    new = function(initializer)
        return Classy.createInstance(Classy.Stack.prototype, initializer)
    end,

    prototype = {
        -- Constructor initializes the Stack with an empty Collection
        constructor = function(self, ...)
            self._className = "Classy.Stack"
            self._collection = Classy.Collection.new()  -- Internal storage for stack elements
        end,

        -- Resets the stack to its initial empty state
        reset = function(self)
            self._collection:reset()  -- Clear the underlying collection
        end,

        -- Pushes an element onto the stack
        push = function(self, arg)
            self._collection:pushleft(arg)  -- Add element to the top of the stack
        end,

        -- Pops and returns the top element from the stack
        pop = function(self)
            if self:isEmpty() then
                error("Classy.Stack: pop from an empty stack")  -- Error handling for empty stack
            end
            return self._collection:popleft()  -- Remove element from the top of the stack
        end,

        -- Peeks at the top element of the stack without removing it
        peek = function(self)
            if self:isEmpty() then
                return nil  -- Return nil if the stack is empty
            end
            return self._collection:get(self._collection.first)  -- Return the top element
        end,

        -- Checks if the stack is empty
        isEmpty = function(self)
            return self._collection:isEmpty()  -- Returns true if the stack is empty
        end,

        -- Returns the number of elements in the stack
        size = function(self)
            return self._collection.last - self._collection.first + 1  -- Calculate the size of the stack
        end,
    },
}
