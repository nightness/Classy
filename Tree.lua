Classy.Tree = {
    Node = {
        -- Creates a new Tree Node instance
        new = function(value)
            return Classy.createInstance(Classy.Tree.Node.prototype, function(self)
                self._value = Classy.Observable.new(value)  -- Initialize the node value as an observable
            end)
        end,

        prototype = {
            -- Constructor initializes the Tree Node with an empty list of children
            constructor = function(self, ...)
                self._className = "Classy.Tree.Node"
                self._children = Classy.LinkedList.new()  -- Internal storage for child nodes
            end,

            -- Gets the children of the node, or finds specific children if a value is provided
            get = function(self, child)
                if child then
                    -- Find and return all children matching the provided value
                    return self._children:findAll(child)
                end
                -- Return all children if no specific child is requested
                return self._children
            end,

            -- Adds a child node to the current node
            add = function(self, child)
                -- If no child is provided, raise an error
                if not child then
                    error("Usage: Classy.Tree.Node:add(child or value)")
                elseif type(child) == "table" and child._className == "Classy.Tree.Node" then
                    -- If the child is a Tree Node, add it directly
                    self._children:add(child)
                else
                    -- Otherwise, wrap the value in a new Tree Node and add it
                    self._children:add(Classy.Tree.Node.new(child))
                end
            end,

            -- Deletes a child node from the current node
            delete = function(self, child)
                if not child then
                    error("Usage: Classy.Tree.Node:delete(child or value)")
                end

                -- Find and remove the child node(s)
                local nodesToDelete = self:get(child)
                for _, node in ipairs(nodesToDelete) do
                    self._children:remove(node)
                end
            end,

            -- Returns the value of the node
            getValue = function(self)
                return self._value:get()
            end,

            -- Sets a new value for the node
            setValue = function(self, value)
                self._value:set(value)
            end,
        },
    },

    -- Creates a new Tree instance with an initial root value
    new = function(rootValue)
        return Classy.createInstance(Classy.Tree.prototype, function(self)
            self._root = Classy.Tree.Node.new(rootValue)  -- Initialize the root node
        end)
    end,

    prototype = {
        -- Constructor initializes the Tree
        constructor = function(self, ...)
            self._className = "Classy.Tree"
        end,

        -- Gets the root node of the Tree
        getRoot = function(self)
            return self._root
        end,

        -- Traverses the tree using a depth-first search (DFS) approach
        depthFirstSearch = function(self, visit)
            local function dfs(node)
                visit(node)
                local children = node:get()
                for _, child in ipairs(children) do
                    dfs(child)
                end
            end
            dfs(self._root)
        end,

        -- Traverses the tree using a breadth-first search (BFS) approach
        breadthFirstSearch = function(self, visit)
            local queue = Classy.Queue.new()
            queue:enqueue(self._root)

            while not queue:isEmpty() do
                local node = queue:dequeue()
                visit(node)
                local children = node:get()
                for _, child in ipairs(children) do
                    queue:enqueue(child)
                end
            end
        end,
    },
}
