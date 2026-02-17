-- Ensure Classy and BinaryTree exist
Classy = Classy or {}
Classy.BinaryTree = Classy.BinaryTree or {}

-- Definition of the BinaryTree Node
Classy.BinaryTree.Node = {
    -- Create a new BinaryTree Node
    new = function(value)
        return Classy.createInstance(Classy.BinaryTree.Node.prototype, function(self)
            self._value = Classy.Observable.new(value) -- Initialize node value as an observable
        end)
    end,

    prototype = {
        -- Constructor initializes the BinaryTree Node
        constructor = function(self, ...)
            self._className = "Classy.BinaryTree.Node"
            self._leftChild = nil -- Left child node
            self._rightChild = nil -- Right child node
        end,

        -- Get the left and right children of the node
        getChildren = function(self)
            return self._leftChild, self._rightChild
        end,

        -- Set both left and right children of the node
        setChildren = function(self, leftChild, rightChild)
            self:setLeft(leftChild)
            self:setRight(rightChild)
        end,

        -- Get the left child of the node
        getLeft = function(self)
            return self._leftChild
        end,

        -- Set the left child of the node, ensuring it's a BinaryTree Node
        setLeft = function(self, child)
            if (child == nil or Classy.isClass(child, "Classy.BinaryTree.Node")) then
                self._leftChild = child
            else
                self._leftChild = Classy.BinaryTree.Node.new(child)
            end
        end,

        -- Get the right child of the node
        getRight = function(self)
            return self._rightChild
        end,

        -- Set the right child of the node, ensuring it's a BinaryTree Node
        setRight = function(self, child)
            if (child == nil or Classy.isClass(child, "Classy.BinaryTree.Node")) then
                self._rightChild = child
            else
                self._rightChild = Classy.BinaryTree.Node.new(child)
            end
        end,

        -- Get the value of the node
        getValue = function(self)
            return self._value:get()
        end,

        -- Set the value of the node
        setValue = function(self, value)
            self._value:set(value)
        end
    }
}

-- Definition of the BinaryTree
Classy.BinaryTree.new = function(rootValue)
    return Classy.createInstance(Classy.BinaryTree.prototype, function(self)
        self._root = Classy.BinaryTree.Node.new(rootValue) -- Initialize the root node
    end)
end

Classy.BinaryTree.prototype = {
    -- Constructor initializes the BinaryTree
    constructor = function(self, ...)
        self._className = "Classy.BinaryTree"
    end,

    -- Get the root node of the BinaryTree
    getRoot = function(self)
        return self._root
    end,

    -- Insert a value into the BinaryTree (Binary Search Tree insertion)
    insert = function(self, value)
        local function insertRecursively(node, value)
            if node == nil then
                return Classy.BinaryTree.Node.new(value)
            end
            if value < node:getValue() then
                node:setLeft(insertRecursively(node:getLeft(), value))
            else
                node:setRight(insertRecursively(node:getRight(), value))
            end
            return node
        end
        self._root = insertRecursively(self._root, value)
    end,

    -- Find a node with the given value
    find = function(self, value)
        local function findRecursively(node, value)
            if node == nil or node:getValue() == value then
                return node
            end
            if value < node:getValue() then
                return findRecursively(node:getLeft(), value)
            else
                return findRecursively(node:getRight(), value)
            end
        end
        return findRecursively(self._root, value)
    end,

    -- Delete a value from the BinaryTree (Binary Search Tree deletion)
    delete = function(self, value)
        local function findMin(node)
            while node:getLeft() ~= nil do
                node = node:getLeft()
            end
            return node
        end

        local function deleteRecursively(node, value)
            if node == nil then return nil end

            if value < node:getValue() then
                node._leftChild = deleteRecursively(node:getLeft(), value)
                return node
            elseif value > node:getValue() then
                node._rightChild = deleteRecursively(node:getRight(), value)
                return node
            else
                -- Node found
                -- Case 1: Leaf node
                if node:getLeft() == nil and node:getRight() == nil then
                    return nil
                end
                -- Case 2: One child
                if node:getLeft() == nil then
                    return node:getRight()
                end
                if node:getRight() == nil then
                    return node:getLeft()
                end
                -- Case 3: Two children - replace with in-order successor
                local successor = findMin(node:getRight())
                node._value = Classy.Observable.new(successor:getValue())
                node._rightChild = deleteRecursively(node:getRight(), successor:getValue())
                return node
            end
        end

        self._root = deleteRecursively(self._root, value)
    end,

    -- Traversal: In-order (left, root, right)
    inOrderTraversal = function(self, visit)
        local function inOrder(node)
            if node ~= nil then
                inOrder(node:getLeft())
                visit(node)
                inOrder(node:getRight())
            end
        end
        inOrder(self._root)
    end,

    -- Traversal: Pre-order (root, left, right)
    preOrderTraversal = function(self, visit)
        local function preOrder(node)
            if node ~= nil then
                visit(node)
                preOrder(node:getLeft())
                preOrder(node:getRight())
            end
        end
        preOrder(self._root)
    end,

    -- Traversal: Post-order (left, right, root)
    postOrderTraversal = function(self, visit)
        local function postOrder(node)
            if node ~= nil then
                postOrder(node:getLeft())
                postOrder(node:getRight())
                visit(node)
            end
        end
        postOrder(self._root)
    end
}
