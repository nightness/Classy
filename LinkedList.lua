--
-- Circularly linked linked list
-- Notes: Could use more comments, some incomplete code, but is otherwise working
--
Classy.LinkedList = {
    LinkedListNode = {
        new = function (value)
            return Classy.createInstance(Classy.LinkedList.Node.prototype, function (self)
                self:set(value);
            end);
        end,
        prototype = {
            constructor = function (self)
                self._className = "Classy.LinkedList.Node"
                self.previousNode = nil;
                self.nextNode = nil;
            end,
            get = function (self)
                return self.value;
            end,
            set = function (self, value)
                self.value = value;
            end,
        },
    },
    new = function (initializer)
        return Classy.createInstance(Classy.LinkedList.prototype, initializer);
    end,
    prototype = {
        constructor = function (self)
            self._className = "Classy.LinkedList"
            self._firstNode = nil;
            self._lastRef = nil;
        end,
        -- Adds a new node with the specified value
        add = function (self, value)
            return self:insertAfter(nil, value);
        end,
        -- Returns the first node that has the specified value
        findFirst = function (self, value)

        end,
        -- Returns all nodes with the specified value
        findAll = function (self, value) 

        end,
        firstNode = function (self)
            if (self._firstNode) then
                self._lastRef = self._firstNode;
                return self._lastRef;
            end
        end,
        lastNode = function (self)
            if (self._firstNode) then
                return self._firstNode.previousNode;
            end
        end,
        first = function (self)
            if (self._firstNode) then
                self._lastRef = self._firstNode;
                return self._lastRef.value;
            end
        end,
        last = function (self)
            if (self._firstNode) then
                self._lastRef = self._firstNode.previousNode;
                return self._lastRef.value;
            end
        end,
        current = function (self)
            if (self._lastRef) then 
                return self._lastRef.value;
            end
        end,
        currentNode = function (self)
            return self._lastRef;
        end,
        next = function (self)
            if (self._lastRef) then
                self._lastRef = self._lastRef.nextNode;
                return self._lastRef.value;
            end
        end,
        previous = function (self)
            if (self._lastRef) then
                self._lastRef = self._lastRef.previousNode;
                return self._lastRef.value;
            end
        end,
        stop = function (self)
            self._lastRef = nil;
        end,
        -- Insert a new value after the refNode
        insertAfter = function (self, refNode, value)
            local node = Classy.LinkedList.Node.new(value);
            if (not refNode) then
                refNode = self:lastNode();
            end

            -- List is empty, add the first node
            if (not refNode) then
                self._firstNode = node;
                node.nextNode = node;
                node.previousNode = node;
                return node;
            end

            -- List is not empty, add an additional node
            if (self:firstNode() == self:lastNode()) then
                self._firstNode.nextNode = node;
                self._firstNode.previousNode = node;
                node.previousNode = self._firstNode;
                node.nextNode = self._firstNode;
            else
                if (refNode == self._firstNode) then
                    self._firstNode = node;
                end
                node.previousNode = refNode;
                node.nextNode = refNode.nextNode;
                refNode.nextNode.previousNode = node;
                refNode.nextNode = node;
            end
            return node;
        end,
        -- Insert a new value before the refNode
        insertBefore = function (self, refNode, value)
            return self:insertAfter(refNode.previousNode, value);
        end,
        -- Remove the specified node
        remove = function (self, node)
            -- Node is a required argument
            if (not node) then return end;

            -- Only one node in the list
            if (node == self:firstNode() and self:firstNode() == self:lastNode()) then
                node.nextNode = nil;
                node.previousNode = nil;
                self._firstNode = nil;
                return;
            end

            -- More than one node in the list
            if (node == self._firstNode) then
                self._firstNode = self._firstNode.nextNode;
            end
            node.previousNode.nextNode = node.nextNode;
            node.nextNode.previousNode = node.previousNode;
            node.previousNode = nil;
            node.nextNode = nil;
        end,
    },
}