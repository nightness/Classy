-- Ensure Classy and LinkedList exist
Classy = Classy or {}
Classy.LinkedList = Classy.LinkedList or {}

-- Define the Node class for LinkedList
Classy.LinkedList.Node = Classy.LinkedList.Node or {
    new = function(value)
        return Classy.createInstance(Classy.LinkedList.Node.prototype, function(self)
            self:set(value)
        end)
    end,
    prototype = {
        constructor = function(self, ...)
            self._className = "Classy.LinkedList.Node"
            self.previousNode = nil
            self.nextNode = nil
        end,
        get = function(self)
            return self.value
        end,
        set = function(self, value)
            self.value = value
        end
    }
}

-- Define the LinkedList class
Classy.LinkedList.new = function(initializer)
    return Classy.createInstance(Classy.LinkedList.prototype, initializer)
end

Classy.LinkedList.prototype = {
    constructor = function(self, ...)
        self._className = "Classy.LinkedList"
        self._firstNode = nil
        self._lastRef = nil
    end,
    
    add = function(self, value)
        return self:insertAfter(nil, value)
    end,

    findFirst = function(self, value)
        local node = self:firstNode()
        while node do
            if node:get() == value then
                return node
            end
            node = node.nextNode
            if node == self._firstNode then
                break
            end
        end
        return nil
    end,

    findAll = function(self, value)
        local nodes = {}
        local node = self:firstNode()
        while node do
            if node:get() == value then
                table.insert(nodes, node)
            end
            node = node.nextNode
            if node == self._firstNode then
                break
            end
        end
        return nodes
    end,

    firstNode = function(self)
        if self._firstNode then
            self._lastRef = self._firstNode
            return self._lastRef
        end
    end,

    lastNode = function(self)
        if self._firstNode then
            return self._firstNode.previousNode
        end
    end,

    first = function(self)
        if self._firstNode then
            self._lastRef = self._firstNode
            return self._lastRef:get()
        end
    end,

    last = function(self)
        if self._firstNode then
            self._lastRef = self._firstNode.previousNode
            return self._lastRef:get()
        end
    end,

    current = function(self)
        if self._lastRef then 
            return self._lastRef:get()
        end
    end,

    currentNode = function(self)
        return self._lastRef
    end,

    next = function(self)
        if self._lastRef and self._lastRef.nextNode ~= self._firstNode then
            self._lastRef = self._lastRef.nextNode
            return self._lastRef:get()
        end
        self._lastRef = nil
        return nil
    end,

    previous = function(self)
        if self._lastRef and self._lastRef ~= self._firstNode then
            self._lastRef = self._lastRef.previousNode
            return self._lastRef:get()
        end
        self._lastRef = nil
        return nil
    end,

    stop = function(self)
        self._lastRef = nil
    end,

    forEach = function(self, callback)
        local node = self._firstNode
        if not node then return end
        repeat
            callback(node)
            node = node.nextNode
        until node == self._firstNode
    end,

    insertAfter = function(self, refNode, value)
        local node = Classy.LinkedList.Node.new(value)
        
        -- If the list is empty, initialize it with the new node
        if not self._firstNode then
            node.nextNode = node
            node.previousNode = node
            self._firstNode = node
            return node
        end
        
        -- If no reference node is provided, insert at the end (after the last node)
        if not refNode then
            refNode = self:lastNode()
        end

        -- Insert node after the reference node
        node.previousNode = refNode
        node.nextNode = refNode.nextNode
        refNode.nextNode.previousNode = node
        refNode.nextNode = node

        -- If the reference node was the last node, update the first node reference
        if refNode == self._firstNode.previousNode then
            self._firstNode.previousNode = node
        end

        return node
    end,

    length = function(self)
        local count = 0
        self:forEach(function() count = count + 1 end)
        return count
    end,

    clear = function(self)
        self._firstNode = nil
        self._lastRef = nil
    end,

    toTable = function(self)
        local result = {}
        self:forEach(function(node)
            table.insert(result, node:get())
        end)
        return result
    end,

    insertBefore = function(self, refNode, value)
        if not refNode then return self:insertAfter(nil, value) end
        return self:insertAfter(refNode.previousNode, value)
    end,

    remove = function(self, node)
        if not node then return end

        -- Handle case where the list has only one node
        if node == self._firstNode and node.nextNode == node then
            self._firstNode = nil
            return
        end

        -- Update the links to bypass the node
        node.previousNode.nextNode = node.nextNode
        node.nextNode.previousNode = node.previousNode

        -- If removing the first node, update the first node reference
        if node == self._firstNode then
            self._firstNode = node.nextNode
        end

        -- Clear the node's references
        node.previousNode = nil
        node.nextNode = nil
    end,
}
