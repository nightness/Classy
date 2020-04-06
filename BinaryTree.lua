Classy.BinaryTree = {
    Node = {
        new = function (value)
            return Classy.createInstance(Classy.BinaryTree.Node.prototype, function (self)
                self._value = Classy.Observable.new(value)
            end)
        end,
        prototype = {
            constructor = function(self, ...)
                self._className = "Classy.BinaryTree.Node";
                self._leftChild = nil;
                self._rightChild = nil;
            end,
    
            getChildren = function (self)
                return self._leftChild, self._rightChild
            end,
    
            setChildren = function(self, leftChild, rightChild)
                self:setLeft(leftChild);
                self:setRight(rightChild);
            end,
    
            getLeft = function(self)
                return self._leftChild;
            end,
    
            setLeft = function(self, child)
                if (child == nil or Classy.isClass(child, "Classy.BinaryTree.Node")) then
                    self._leftChild = child;
                else
                    self._leftChild = Classy.BinaryTree.Node.new(child);
                end
            end,
    
            getRight = function(self)
                return self._rightChild;
            end,
    
            setRight = function(self, child)
                if (child == nil or Classy.isClass(child, "Classy.BinaryTree.Node")) then
                    self._rightChild = child;
                else
                    self._rightChild = Classy.BinaryTree.Node.new(child);
                end
            end,
        },
    },
    new = function (rootValue)
        return Classy.createInstance(Classy.BinaryTree.prototype, function (self)
            self._root = Classy.BinaryTree.Node.new(rootValue)
        end)
    end,
    prototype = {
        constructor = function(self, ...)
            self._className = "Classy.BinaryTree";
        end,
        getRoot = function(self)
            return self._root;
        end,
    },
}


