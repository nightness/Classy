Classy.Tree = {
    Node = {
        new = function (value)
            return Classy.createInstance(Classy.Tree.Node.prototype, function (self)
                self._value = Classy.Observable.new(value)
            end)
        end,
        prototype = {
            constructor = function(self, ...)
                self._className = "Classy.Tree.Node";
                self._children = Classy.LinkedList.new()
            end,
    
            get = function (self, child)
                if (child) then
                    return self._children.findAll(child)
                end
                return self._children
            end,
    
            add = function(self, child)
                -- if child is not in a Tree, then wrap value provided in a TreeNode first
                if (not child) then
                    error("Usage: Classy.Tree.Node:add(child or value)");
                elseif (type(child) == "table" and child._className == "Classy.Tree.Node") then
                    self._children:add(child)
                else
                    self._children:add(Classy.Tree.Node.new(child))
                end
            end,
    
            delete = function(self, child)
    
            end,
        },
    },
    new = function (rootValue)
        return Classy.createInstance(Classy.Tree.prototype, function (self)
            self._root = Classy.Tree.Node.new(rootValue)
        end)
    end,
    prototype = {
        constructor = function(self, ...)
            self._className = "Classy.Tree";
        end,
        getRoot = function(self)
            return self._root;
        end,        
    },
}

