-- Unit Tests for Classy Library using luaunit
-- lu is provided as a global by the bundle wrapper

---------------------------------------------------------------------------
-- TestHashtable
---------------------------------------------------------------------------
TestHashtable = {}

function TestHashtable:testPutAndGet()
    local ht = Classy.Hashtable.new()
    ht:put("abc", "ABC")
    ht:put("x", 29)
    ht:put("a", 32)
    lu.assertEquals(ht:get("abc"), "ABC")
    lu.assertEquals(ht:get("x"), 29)
    lu.assertEquals(ht:get("a"), 32)
end

function TestHashtable:testRemove()
    local ht = Classy.Hashtable.new()
    ht:put("abc", "ABC")
    ht:put("x", 29)
    ht:put("a", 32)
    ht:remove("x")
    lu.assertNil(ht:get("x"))
    lu.assertEquals(ht:size(), 2)
end

function TestHashtable:testContainsKey()
    local ht = Classy.Hashtable.new()
    ht:put("key1", "val1")
    lu.assertTrue(ht:containsKey("key1"))
    lu.assertFalse(ht:containsKey("key2"))
end

function TestHashtable:testContainsValue()
    local ht = Classy.Hashtable.new()
    ht:put("key1", 32)
    ht:put("key2", "hello")
    lu.assertTrue(ht:containsValue(32))
    lu.assertTrue(ht:containsValue("hello"))
    lu.assertFalse(ht:containsValue(99))
end

function TestHashtable:testIsEmpty()
    local ht = Classy.Hashtable.new()
    lu.assertTrue(ht:isEmpty())
    ht:put("a", 1)
    lu.assertFalse(ht:isEmpty())
end

function TestHashtable:testCopy()
    local ht = Classy.Hashtable.new()
    ht:put("a", 1)
    ht:put("b", 2)
    local copy = ht:copy()
    lu.assertEquals(copy:get("a"), 1)
    lu.assertEquals(copy:get("b"), 2)
    lu.assertEquals(copy:size(), 2)
end

function TestHashtable:testMerge()
    local ht1 = Classy.Hashtable.new()
    ht1:put("a", 1)
    local ht2 = Classy.Hashtable.new()
    ht2:put("b", 2)
    ht2:put("a", 99)
    ht1:merge(ht2)
    lu.assertEquals(ht1:get("a"), 99)
    lu.assertEquals(ht1:get("b"), 2)
end

function TestHashtable:testGetKeys()
    local ht = Classy.Hashtable.new()
    ht:put("b", 2)
    ht:put("a", 1)
    local keys = ht:getKeys(true)
    lu.assertEquals(keys:length(), 2)
    lu.assertEquals(keys:get(1), "a")
    lu.assertEquals(keys:get(2), "b")
end

function TestHashtable:testGetValues()
    local ht = Classy.Hashtable.new()
    ht:put("a", 1)
    ht:put("b", 2)
    local vals = ht:getValues(true)
    lu.assertEquals(vals:length(), 2)
    lu.assertEquals(vals:get(1), 1)
    lu.assertEquals(vals:get(2), 2)
end

function TestHashtable:testEquals()
    local ht1 = Classy.Hashtable.new()
    ht1:put("a", 1)
    ht1:put("b", 2)
    local ht2 = Classy.Hashtable.new()
    ht2:put("a", 1)
    ht2:put("b", 2)
    lu.assertTrue(ht1:equals(ht2))

    ht2:put("c", 3)
    lu.assertFalse(ht1:equals(ht2))
end

function TestHashtable:testFalseValue()
    local ht = Classy.Hashtable.new()
    ht:put("flag", false)
    lu.assertEquals(ht:get("flag"), false)
    lu.assertEquals(ht:get("flag", "default"), false)
    lu.assertEquals(ht:get("missing", "default"), "default")
end

function TestHashtable:testNonStringKeyError()
    local ht = Classy.Hashtable.new()
    lu.assertErrorMsgContains("Key argument requires a string", function()
        ht:put(123, "val")
    end)
    lu.assertErrorMsgContains("Key argument requires a string", function()
        ht:get(123)
    end)
end

---------------------------------------------------------------------------
-- TestBinaryTree
---------------------------------------------------------------------------
TestBinaryTree = {}

function TestBinaryTree:testInsertAndFind()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)
    tree:insert(2)
    tree:insert(7)
    tree:insert(12)
    tree:insert(20)

    lu.assertEquals(tree:find(10):getValue(), 10)
    lu.assertEquals(tree:find(5):getValue(), 5)
    lu.assertEquals(tree:find(15):getValue(), 15)
    lu.assertEquals(tree:find(2):getValue(), 2)
    lu.assertEquals(tree:find(7):getValue(), 7)
    lu.assertEquals(tree:find(12):getValue(), 12)
    lu.assertEquals(tree:find(20):getValue(), 20)
    lu.assertNil(tree:find(99))
end

function TestBinaryTree:testInOrderTraversal()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)
    tree:insert(2)
    tree:insert(7)
    tree:insert(12)
    tree:insert(20)

    local result = {}
    tree:inOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {2, 5, 7, 10, 12, 15, 20})
    lu.assertEquals(#result, 7)
end

function TestBinaryTree:testPreOrderTraversal()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)
    tree:insert(2)
    tree:insert(7)
    tree:insert(12)
    tree:insert(20)

    local result = {}
    tree:preOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {10, 5, 2, 7, 15, 12, 20})
    lu.assertEquals(#result, 7)
end

function TestBinaryTree:testPostOrderTraversal()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)
    tree:insert(2)
    tree:insert(7)
    tree:insert(12)
    tree:insert(20)

    local result = {}
    tree:postOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {2, 7, 5, 12, 20, 15, 10})
    lu.assertEquals(#result, 7)
end

function TestBinaryTree:testDeleteLeaf()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)
    tree:insert(2)

    tree:delete(2)
    lu.assertNil(tree:find(2))

    local result = {}
    tree:inOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {5, 10, 15})
    lu.assertEquals(#result, 3)
end

function TestBinaryTree:testDeleteOneChild()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)
    tree:insert(2)

    tree:delete(5)
    lu.assertNil(tree:find(5))

    local result = {}
    tree:inOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {2, 10, 15})
    lu.assertEquals(#result, 3)
end

function TestBinaryTree:testDeleteTwoChildren()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)
    tree:insert(2)
    tree:insert(7)
    tree:insert(12)
    tree:insert(20)

    tree:delete(15)
    lu.assertNil(tree:find(15))

    local result = {}
    tree:inOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {2, 5, 7, 10, 12, 20})
    lu.assertEquals(#result, 6)
end

function TestBinaryTree:testDeleteRoot()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:insert(15)

    tree:delete(10)
    lu.assertNil(tree:find(10))

    local result = {}
    tree:inOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {5, 15})
    lu.assertEquals(#result, 2)
end

function TestBinaryTree:testDeleteNonExistent()
    local tree = Classy.BinaryTree.new(10)
    tree:insert(5)
    tree:delete(99)

    local result = {}
    tree:inOrderTraversal(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {5, 10})
end

---------------------------------------------------------------------------
-- TestMatrix
---------------------------------------------------------------------------
TestMatrix = {}

function TestMatrix:testFieldOperations()
    local matrix = Classy.Matrix.new()
    matrix:set(1, 1, "Jimmy")
    matrix:set(1, 2, "Timmy")
    matrix:set(2, 1, "Kimmy")

    lu.assertEquals(matrix:get(1, 1), "Jimmy")
    lu.assertEquals(matrix:get(1, 2), "Timmy")
    lu.assertEquals(matrix:get(2, 1), "Kimmy")
    lu.assertNil(matrix:get(2, 2))

    matrix:clear()
    lu.assertNil(matrix:get(1, 1))
    lu.assertNil(matrix:get(1, 2))
    lu.assertNil(matrix:get(2, 1))
end

function TestMatrix:testAdd()
    local m1 = Classy.Matrix.new(2, 2, 1)
    local m2 = Classy.Matrix.new(2, 2, 2)
    local result = m1:add(m2)
    lu.assertEquals(result._data[1][1], 3)
    lu.assertEquals(result._data[1][2], 3)
    lu.assertEquals(result._data[2][1], 3)
    lu.assertEquals(result._data[2][2], 3)
end

function TestMatrix:testSubtract()
    local m1 = Classy.Matrix.new(2, 2, 5)
    local m2 = Classy.Matrix.new(2, 2, 2)
    local result = m1:subtract(m2)
    lu.assertEquals(result._data[1][1], 3)
    lu.assertEquals(result._data[2][2], 3)
end

function TestMatrix:testMultiplyScalar()
    local m = Classy.Matrix.new(2, 2, 3)
    local result = m:multiply(2)
    lu.assertEquals(result._data[1][1], 6)
    lu.assertEquals(result._data[1][2], 6)
end

function TestMatrix:testMultiplyMatrix()
    local m1 = Classy.Matrix.new(2, 3, 0)
    m1._data = {{1, 2, 3}, {4, 5, 6}}
    local m2 = Classy.Matrix.new(3, 2, 0)
    m2._data = {{7, 8}, {9, 10}, {11, 12}}
    local result = m1:multiply(m2)
    lu.assertEquals(result._data[1][1], 58)
    lu.assertEquals(result._data[1][2], 64)
    lu.assertEquals(result._data[2][1], 139)
    lu.assertEquals(result._data[2][2], 154)
end

function TestMatrix:testTranspose()
    local m = Classy.Matrix.new(2, 3, 0)
    m._data = {{1, 2, 3}, {4, 5, 6}}
    local result = m:transpose()
    lu.assertEquals(result._data[1][1], 1)
    lu.assertEquals(result._data[1][2], 4)
    lu.assertEquals(result._data[2][1], 2)
    lu.assertEquals(result._data[2][2], 5)
    lu.assertEquals(result._data[3][1], 3)
    lu.assertEquals(result._data[3][2], 6)
end

function TestMatrix:testDeterminant1x1()
    local m = Classy.Matrix.new(1, 1, 0)
    m._data = {{42}}
    lu.assertEquals(m:determinant(), 42)
end

function TestMatrix:testDeterminant2x2()
    local m = Classy.Matrix.new(2, 2, 0)
    m._data = {{1, 2}, {3, 4}}
    lu.assertEquals(m:determinant(), -2)
end

function TestMatrix:testDeterminant3x3()
    local m = Classy.Matrix.new(3, 3, 0)
    m._data = {{6, 1, 1}, {4, -2, 5}, {2, 8, 7}}
    lu.assertEquals(m:determinant(), -306)
end

function TestMatrix:testInverse()
    local m = Classy.Matrix.new(2, 2, 0)
    m._data = {{4, 7}, {2, 6}}
    local inv = m:inverse()
    lu.assertAlmostEquals(inv._data[1][1], 0.6, 1e-10)
    lu.assertAlmostEquals(inv._data[1][2], -0.7, 1e-10)
    lu.assertAlmostEquals(inv._data[2][1], -0.2, 1e-10)
    lu.assertAlmostEquals(inv._data[2][2], 0.4, 1e-10)
end

function TestMatrix:testDimensionMismatchAdd()
    local m1 = Classy.Matrix.new(2, 2, 1)
    local m2 = Classy.Matrix.new(3, 3, 1)
    lu.assertErrorMsgContains("same dimensions", function()
        m1:add(m2)
    end)
end

function TestMatrix:testDimensionMismatchMultiply()
    local m1 = Classy.Matrix.new(2, 3, 1)
    local m2 = Classy.Matrix.new(2, 3, 1)
    lu.assertErrorMsgContains("columns in the first matrix", function()
        m1:multiply(m2)
    end)
end

function TestMatrix:testEmptyMatrixGuard()
    local m = Classy.Matrix.new()
    lu.assertErrorMsgContains("empty", function() m:add(m) end)
    lu.assertErrorMsgContains("empty", function() m:subtract(m) end)
    lu.assertErrorMsgContains("empty", function() m:multiply(2) end)
    lu.assertErrorMsgContains("empty", function() m:transpose() end)
end

function TestMatrix:testSingularInverse()
    local m = Classy.Matrix.new(2, 2, 0)
    m._data = {{1, 2}, {2, 4}}
    lu.assertErrorMsgContains("singular", function()
        m:inverse()
    end)
end

function TestMatrix:testToString()
    local m = Classy.Matrix.new(2, 2, 0)
    m._data = {{1, 2}, {3, 4}}
    local s = m:toString()
    lu.assertStrContains(s, "1")
    lu.assertStrContains(s, "4")
end

function TestMatrix:testToStringEmpty()
    local m = Classy.Matrix.new()
    lu.assertEquals(m:toString(), "")
end

---------------------------------------------------------------------------
-- TestDataSet
---------------------------------------------------------------------------
TestDataSet = {}

function TestDataSet:testAddAndGet()
    local ds = Classy.DataSet.new()
    ds:add(5)
    ds:add(6)
    ds:add(7)
    lu.assertEquals(ds:get(1), 5)
    lu.assertEquals(ds:get(2), 6)
    lu.assertEquals(ds:get(3), 7)
    lu.assertEquals(ds:length(), 3)
end

function TestDataSet:testClear()
    local ds = Classy.DataSet.new()
    ds:add(5)
    ds:add(6)
    ds:clear()
    lu.assertNil(ds:get(1))
    lu.assertEquals(ds:length(), 0)
end

function TestDataSet:testNoDuplicates()
    local ds = Classy.DataSet.new()
    lu.assertTrue(ds:add(5))
    lu.assertFalse(ds:add(5))
    lu.assertEquals(ds:length(), 1)
end

function TestDataSet:testFind()
    local ds = Classy.DataSet.new()
    ds:add(10)
    ds:add(20)
    ds:add(30)
    lu.assertEquals(ds:find(20), 2)
    lu.assertNil(ds:find(99))
end

function TestDataSet:testSort()
    local ds = Classy.DataSet.new()
    ds:add(21)
    ds:add(6)
    ds:add(70)
    ds:add(23)
    ds:add(4)
    ds:add(16)
    ds:add(91)
    ds:add(9)
    ds:sort()
    local expected = {4, 6, 9, 16, 21, 23, 70, 91}
    for i, v in ipairs(expected) do
        lu.assertEquals(ds:get(i), v)
    end
    lu.assertEquals(ds:length(), 8)
end

function TestDataSet:testCopyAndEquals()
    local ds = Classy.DataSet.new()
    ds:add(5)
    ds:add(6)
    ds:add(7)
    local copy = ds:copy()
    lu.assertTrue(ds:equals(copy))
    copy:add(8)
    lu.assertFalse(ds:equals(copy))
end

function TestDataSet:testDifference()
    local a = Classy.DataSet.new()
    a:add(5)
    a:add(6)
    a:add(7)
    local b = Classy.DataSet.new()
    b:add(1)
    b:add(6)
    b:add(9)
    local result = a:difference(b)
    lu.assertEquals(result:get(1), 5)
    lu.assertEquals(result:get(2), 7)
    lu.assertEquals(result:get(3), 1)
    lu.assertEquals(result:get(4), 9)
    lu.assertEquals(result:length(), 4)
end

function TestDataSet:testIntersection()
    local a = Classy.DataSet.new()
    a:add(5)
    a:add(6)
    a:add(7)
    local b = Classy.DataSet.new()
    b:add(5)
    b:add(7)
    b:add(9)
    local result = a:intersection(b)
    lu.assertEquals(result:get(1), 5)
    lu.assertEquals(result:get(2), 7)
    lu.assertEquals(result:length(), 2)
end

function TestDataSet:testUnion()
    local a = Classy.DataSet.new()
    a:add(5)
    a:add(6)
    a:add(7)
    local b = Classy.DataSet.new()
    b:add(1)
    b:add(6)
    b:add(9)
    local result = a:union(b)
    lu.assertEquals(result:length(), 5)
    lu.assertEquals(result:get(1), 5)
    lu.assertEquals(result:get(2), 6)
    lu.assertEquals(result:get(3), 7)
    lu.assertEquals(result:get(4), 1)
    lu.assertEquals(result:get(5), 9)
end

---------------------------------------------------------------------------
-- TestList
---------------------------------------------------------------------------
TestList = {}

function TestList:testAddAndGet()
    local list = Classy.List.new()
    list:add(1)
    list:add(8)
    list:add(4)
    lu.assertEquals(list:get(1), 1)
    lu.assertEquals(list:get(2), 8)
    lu.assertEquals(list:get(3), 4)
    lu.assertEquals(list:length(), 3)
end

function TestList:testMap()
    local list1 = Classy.List.new()
    list1:add(1)
    list1:add(8)
    list1:add(4)
    local list2 = Classy.List.new()
    list2:add(5)
    list2:add(6)
    list2:add(7)
    local list3 = Classy.List.new()
    list3:add(6)
    list3:add(0)
    list3:add(2)

    local result = list1:map(function(v1, v2, v3)
        return v1 + v2 - v3
    end, list2, list3)

    lu.assertEquals(result:get(1), 0)
    lu.assertEquals(result:get(2), 14)
    lu.assertEquals(result:get(3), 9)
    lu.assertEquals(result:length(), 3)
end

function TestList:testMerge()
    local list1 = Classy.List.new()
    list1:add(1)
    list1:add(2)
    local list2 = Classy.List.new()
    list2:add(3)
    list2:add(4)
    list1:merge(list2)
    lu.assertEquals(list1:length(), 4)
    lu.assertEquals(list1:get(3), 3)
    lu.assertEquals(list1:get(4), 4)
end

function TestList:testRemove()
    local list = Classy.List.new()
    list:add(10)
    list:add(20)
    list:add(30)
    list:remove(2)
    lu.assertEquals(list:length(), 2)
    lu.assertEquals(list:get(1), 10)
    lu.assertEquals(list:get(2), 30)
end

function TestList:testMergeTypeGuard()
    local list = Classy.List.new()
    list:add(1)
    -- merging a plain number should not crash
    list:merge(42)
    lu.assertEquals(list:length(), 1)
end

---------------------------------------------------------------------------
-- TestLinkedList
---------------------------------------------------------------------------
TestLinkedList = {}

function TestLinkedList:testAddAndTraverse()
    local ll = Classy.LinkedList.new(function(self)
        self:add("This")
        self:add("is")
        self:add("a")
        self:add("test.")
    end)

    lu.assertEquals(ll:first(), "This")
    lu.assertEquals(ll:next(), "is")
    lu.assertEquals(ll:next(), "a")
    lu.assertEquals(ll:next(), "test.")
    lu.assertNil(ll:next())
end

function TestLinkedList:testBackwardTraversal()
    local ll = Classy.LinkedList.new(function(self)
        self:add("This")
        self:add("is")
        self:add("a")
        self:add("test.")
    end)

    lu.assertEquals(ll:last(), "test.")
    lu.assertEquals(ll:previous(), "a")
    lu.assertEquals(ll:previous(), "is")
    lu.assertEquals(ll:previous(), "This")
    lu.assertNil(ll:previous())
end

function TestLinkedList:testRemove()
    local ll = Classy.LinkedList.new(function(self)
        self:add("This")
        self:add("is")
        self:add("a")
        self:add("test.")
    end)

    ll:first()
    ll:next()
    local node = ll:currentNode()
    lu.assertEquals(ll:current(), "is")
    ll:remove(node)

    lu.assertEquals(ll:first(), "This")
    lu.assertEquals(ll:next(), "a")
    lu.assertEquals(ll:next(), "test.")
    lu.assertNil(ll:next())
end

function TestLinkedList:testInsertAfter()
    local ll = Classy.LinkedList.new(function(self)
        self:add("A")
        self:add("C")
    end)

    local firstNode = ll:firstNode()
    ll:insertAfter(firstNode, "B")
    local t = ll:toTable()
    lu.assertEquals(t, {"A", "B", "C"})
    lu.assertEquals(#t, 3)
end

function TestLinkedList:testInsertBefore()
    local ll = Classy.LinkedList.new(function(self)
        self:add("A")
        self:add("C")
    end)

    ll:first()
    local lastNode = ll:next()
    local last = ll:currentNode()
    ll:insertBefore(last, "B")
    local t = ll:toTable()
    lu.assertEquals(t, {"A", "B", "C"})
end

function TestLinkedList:testInsertBeforeNil()
    local ll = Classy.LinkedList.new(function(self)
        self:add("A")
    end)
    ll:insertBefore(nil, "B")
    local t = ll:toTable()
    lu.assertEquals(t, {"A", "B"})
end

function TestLinkedList:testFindFirst()
    local ll = Classy.LinkedList.new(function(self)
        self:add(10)
        self:add(20)
        self:add(30)
    end)
    local node = ll:findFirst(20)
    lu.assertNotNil(node)
    lu.assertEquals(node:get(), 20)
    lu.assertNil(ll:findFirst(99))
end

function TestLinkedList:testFindAll()
    local ll = Classy.LinkedList.new(function(self)
        self:add(10)
        self:add(20)
        self:add(10)
    end)
    local nodes = ll:findAll(10)
    lu.assertEquals(#nodes, 2)
end

function TestLinkedList:testForEach()
    local ll = Classy.LinkedList.new(function(self)
        self:add(1)
        self:add(2)
        self:add(3)
    end)

    local values = {}
    ll:forEach(function(node)
        table.insert(values, node:get())
    end)
    lu.assertEquals(values, {1, 2, 3})
end

function TestLinkedList:testLength()
    local ll = Classy.LinkedList.new(function(self)
        self:add("a")
        self:add("b")
        self:add("c")
    end)
    lu.assertEquals(ll:length(), 3)
end

function TestLinkedList:testLengthEmpty()
    local ll = Classy.LinkedList.new()
    lu.assertEquals(ll:length(), 0)
end

function TestLinkedList:testClear()
    local ll = Classy.LinkedList.new(function(self)
        self:add("a")
        self:add("b")
    end)
    ll:clear()
    lu.assertEquals(ll:length(), 0)
    lu.assertNil(ll:first())
end

function TestLinkedList:testToTable()
    local ll = Classy.LinkedList.new(function(self)
        self:add(10)
        self:add(20)
        self:add(30)
    end)
    lu.assertEquals(ll:toTable(), {10, 20, 30})
end

---------------------------------------------------------------------------
-- TestStack
---------------------------------------------------------------------------
TestStack = {}

function TestStack:testPushAndPop()
    local s = Classy.Stack.new(function(self)
        self:push("7")
        self:push("8")
        self:push("9")
    end)

    lu.assertEquals(s:pop(), "9")
    lu.assertEquals(s:pop(), "8")
    lu.assertEquals(s:pop(), "7")
    lu.assertTrue(s:isEmpty())
end

function TestStack:testPeek()
    local s = Classy.Stack.new(function(self)
        self:push("a")
        self:push("b")
    end)
    lu.assertEquals(s:peek(), "b")
    lu.assertEquals(s:size(), 2)
    -- peek should not remove the element
    lu.assertEquals(s:peek(), "b")
end

function TestStack:testPeekEmpty()
    local s = Classy.Stack.new()
    lu.assertNil(s:peek())
end

function TestStack:testSize()
    local s = Classy.Stack.new(function(self)
        self:push(1)
        self:push(2)
        self:push(3)
    end)
    lu.assertEquals(s:size(), 3)
    s:pop()
    lu.assertEquals(s:size(), 2)
end

function TestStack:testPopEmptyError()
    local s = Classy.Stack.new()
    lu.assertErrorMsgContains("empty stack", function()
        s:pop()
    end)
end

---------------------------------------------------------------------------
-- TestQueue
---------------------------------------------------------------------------
TestQueue = {}

function TestQueue:testEnqueueAndDequeue()
    local q = Classy.Queue.new(function(self)
        self:enqueue("7")
        self:enqueue("8")
        self:enqueue("9")
    end)

    lu.assertEquals(q:dequeue(), "7")
    lu.assertEquals(q:dequeue(), "8")
    lu.assertEquals(q:dequeue(), "9")
    lu.assertTrue(q:isEmpty())
end

function TestQueue:testPeek()
    local q = Classy.Queue.new(function(self)
        self:enqueue("a")
        self:enqueue("b")
    end)
    lu.assertEquals(q:peek(), "a")
    lu.assertEquals(q:size(), 2)
    -- peek should not remove
    lu.assertEquals(q:peek(), "a")
end

function TestQueue:testPeekEmpty()
    local q = Classy.Queue.new()
    lu.assertNil(q:peek())
end

function TestQueue:testSize()
    local q = Classy.Queue.new(function(self)
        self:enqueue(1)
        self:enqueue(2)
    end)
    lu.assertEquals(q:size(), 2)
    q:dequeue()
    lu.assertEquals(q:size(), 1)
end

function TestQueue:testDequeueEmptyError()
    local q = Classy.Queue.new()
    lu.assertErrorMsgContains("empty queue", function()
        q:dequeue()
    end)
end

---------------------------------------------------------------------------
-- TestCollection
---------------------------------------------------------------------------
TestCollection = {}

function TestCollection:testPushRightPopRight()
    local c = Classy.Collection.new()
    c:pushright(1)
    c:pushright(2)
    c:pushright(3)
    lu.assertEquals(c:popright(), 3)
    lu.assertEquals(c:popright(), 2)
    lu.assertEquals(c:popright(), 1)
    lu.assertTrue(c:isEmpty())
end

function TestCollection:testPushLeftPopLeft()
    local c = Classy.Collection.new()
    c:pushleft(1)
    c:pushleft(2)
    c:pushleft(3)
    lu.assertEquals(c:popleft(), 3)
    lu.assertEquals(c:popleft(), 2)
    lu.assertEquals(c:popleft(), 1)
end

function TestCollection:testGet()
    local c = Classy.Collection.new()
    c:pushright(10)
    c:pushright(20)
    lu.assertEquals(c:get(c.first), 10)
    lu.assertEquals(c:get(c.last), 20)
end

function TestCollection:testIsEmpty()
    local c = Classy.Collection.new()
    lu.assertTrue(c:isEmpty())
    c:pushright(1)
    lu.assertFalse(c:isEmpty())
end

function TestCollection:testReset()
    local c = Classy.Collection.new()
    c:pushright(1)
    c:pushright(2)
    c:reset()
    lu.assertTrue(c:isEmpty())
end

function TestCollection:testEquals()
    local c1 = Classy.Collection.new()
    c1:pushright(1)
    c1:pushright(2)
    local c2 = Classy.Collection.new()
    c2:pushright(1)
    c2:pushright(2)
    lu.assertTrue(c1:equals(c2))

    c2:pushright(3)
    lu.assertFalse(c1:equals(c2))
end

function TestCollection:testPopEmptyError()
    local c = Classy.Collection.new()
    lu.assertErrorMsgContains("list is empty", function()
        c:popleft()
    end)
    lu.assertErrorMsgContains("list is empty", function()
        c:popright()
    end)
end

---------------------------------------------------------------------------
-- TestObservable
---------------------------------------------------------------------------
TestObservable = {}

function TestObservable:testGetSet()
    local ob = Classy.Observable.new("Hello")
    lu.assertEquals(ob:get(), "Hello")
    ob:set("World")
    lu.assertEquals(ob:get(), "World")
end

function TestObservable:testSubscribeAndNotify()
    local ob = Classy.Observable.new("Hello")
    local observed = {}
    local func1 = function(v) table.insert(observed, "f1:" .. tostring(v)) end
    local func2 = function(v) table.insert(observed, "f2:" .. tostring(v)) end
    local func3 = function(v) table.insert(observed, "f3:" .. tostring(v)) end

    ob:subscribe(func1)
    ob:subscribe(func2)
    ob:subscribe(func3)
    ob:set("Test")

    lu.assertEquals(observed, {"f1:Test", "f2:Test", "f3:Test"})
end

function TestObservable:testUnsubscribe()
    local ob = Classy.Observable.new("Hello")
    local observed = {}
    local func1 = function(v) table.insert(observed, "f1:" .. tostring(v)) end
    local func2 = function(v) table.insert(observed, "f2:" .. tostring(v)) end

    ob:subscribe(func1)
    ob:subscribe(func2)
    ob:set("A")
    ob:unsubscribe(func2)
    ob:set("B")

    lu.assertEquals(observed, {"f1:A", "f2:A", "f1:B"})
end

function TestObservable:testNoChangeNoNotify()
    local ob = Classy.Observable.new("Hello")
    local count = 0
    ob:subscribe(function() count = count + 1 end)
    ob:set("Hello") -- same value
    lu.assertEquals(count, 0)
end

function TestObservable:testErrorHandlerDoesNotCrash()
    local ob = Classy.Observable.new(1)
    ob:subscribe(function()
        error("test error")
    end)
    -- Should not propagate the error
    ob:set(2)
    lu.assertEquals(ob:get(), 2)
end

---------------------------------------------------------------------------
-- TestVector
---------------------------------------------------------------------------
TestVector = {}

function TestVector:testAdd()
    local v1 = Classy.Vector.new(function(self)
        self:addElement(1)
        self:addElement(2)
        self:addElement(3)
    end)
    local v2 = Classy.Vector.new(function(self)
        self:addElement(4)
        self:addElement(5)
        self:addElement(6)
    end)
    local sum = v1:add(v2)
    lu.assertEquals(sum:getElement(1), 5)
    lu.assertEquals(sum:getElement(2), 7)
    lu.assertEquals(sum:getElement(3), 9)
    lu.assertEquals(sum:dimension(), 3)
end

function TestVector:testSubtract()
    local v1 = Classy.Vector.new(function(self)
        self:addElement(1)
        self:addElement(2)
        self:addElement(3)
    end)
    local v2 = Classy.Vector.new(function(self)
        self:addElement(4)
        self:addElement(5)
        self:addElement(6)
    end)
    local diff = v1:subtract(v2)
    lu.assertEquals(diff:getElement(1), -3)
    lu.assertEquals(diff:getElement(2), -3)
    lu.assertEquals(diff:getElement(3), -3)
end

function TestVector:testDotProduct()
    local v1 = Classy.Vector.new(function(self)
        self:addElement(1)
        self:addElement(2)
        self:addElement(3)
    end)
    local v2 = Classy.Vector.new(function(self)
        self:addElement(4)
        self:addElement(5)
        self:addElement(6)
    end)
    lu.assertEquals(v1:dotProduct(v2), 32)
end

function TestVector:testMagnitude()
    local v = Classy.Vector.new(function(self)
        self:addElement(1)
        self:addElement(2)
        self:addElement(3)
    end)
    lu.assertAlmostEquals(v:magnitude(), 3.7416573867739, 1e-10)
end

function TestVector:testNormalize()
    local v = Classy.Vector.new(function(self)
        self:addElement(1)
        self:addElement(2)
        self:addElement(3)
    end)
    local n = v:normalize()
    lu.assertAlmostEquals(n:getElement(1), 0.26726124191242, 1e-10)
    lu.assertAlmostEquals(n:getElement(2), 0.53452248382485, 1e-10)
    lu.assertAlmostEquals(n:getElement(3), 0.80178372573727, 1e-10)
end

function TestVector:testDimensionMismatch()
    local v1 = Classy.Vector.new(function(self)
        self:addElement(1)
        self:addElement(2)
    end)
    local v2 = Classy.Vector.new(function(self)
        self:addElement(1)
        self:addElement(2)
        self:addElement(3)
    end)
    lu.assertErrorMsgContains("same dimension", function()
        v1:add(v2)
    end)
    lu.assertErrorMsgContains("same dimension", function()
        v1:subtract(v2)
    end)
    lu.assertErrorMsgContains("same dimension", function()
        v1:dotProduct(v2)
    end)
end

function TestVector:testZeroVectorNormalize()
    local v = Classy.Vector.new(function(self)
        self:addElement(0)
        self:addElement(0)
    end)
    lu.assertErrorMsgContains("zero vector", function()
        v:normalize()
    end)
end

---------------------------------------------------------------------------
-- TestTree
---------------------------------------------------------------------------
TestTree = {}

function TestTree:testNewAndRoot()
    local tree = Classy.Tree.new("root")
    lu.assertEquals(tree:getRoot():getValue(), "root")
end

function TestTree:testAddChildren()
    local tree = Classy.Tree.new("root")
    local root = tree:getRoot()
    root:add("child1")
    root:add("child2")

    local values = {}
    root:get():forEach(function(node)
        table.insert(values, node:get():getValue())
    end)
    lu.assertEquals(values, {"child1", "child2"})
end

function TestTree:testDepthFirstSearch()
    local tree = Classy.Tree.new("A")
    local root = tree:getRoot()
    root:add("B")
    root:add("C")

    -- Get B and add children
    local bNode = nil
    root:get():forEach(function(node)
        if node:get():getValue() == "B" then
            bNode = node:get()
        end
    end)
    bNode:add("D")
    bNode:add("E")

    local result = {}
    tree:depthFirstSearch(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {"A", "B", "D", "E", "C"})
    lu.assertEquals(#result, 5)
end

function TestTree:testBreadthFirstSearch()
    local tree = Classy.Tree.new("A")
    local root = tree:getRoot()
    root:add("B")
    root:add("C")

    local bNode = nil
    root:get():forEach(function(node)
        if node:get():getValue() == "B" then
            bNode = node:get()
        end
    end)
    bNode:add("D")
    bNode:add("E")

    local result = {}
    tree:breadthFirstSearch(function(node)
        table.insert(result, node:getValue())
    end)
    lu.assertEquals(result, {"A", "B", "C", "D", "E"})
    lu.assertEquals(#result, 5)
end

function TestTree:testDeleteChild()
    local tree = Classy.Tree.new("root")
    local root = tree:getRoot()
    local childNode = Classy.Tree.Node.new("child1")
    root:add(childNode)
    root:add("child2")

    root:delete(childNode)
    local values = {}
    root:get():forEach(function(node)
        table.insert(values, node:get():getValue())
    end)
    lu.assertEquals(values, {"child2"})
end

---------------------------------------------------------------------------
-- TestMath
---------------------------------------------------------------------------
TestMath = {}

function TestMath:testE()
    lu.assertAlmostEquals(Classy.Math.e(), 2.718281828, 1e-6)
end

function TestMath:testRelu()
    lu.assertEquals(Classy.Math.relu(5), 5)
    lu.assertEquals(Classy.Math.relu(-3), 0)
    lu.assertEquals(Classy.Math.relu(0), 0)
end

function TestMath:testSigmoid()
    lu.assertAlmostEquals(Classy.Math.sigmoid(0), 0.5, 1e-6)
    lu.assertTrue(Classy.Math.sigmoid(10) > 0.99)
    lu.assertTrue(Classy.Math.sigmoid(-10) < 0.01)
end

function TestMath:testRound()
    lu.assertEquals(Classy.Math.round(3.14159, 2), 3.14)
    lu.assertEquals(Classy.Math.round(3.5), 4)
    lu.assertEquals(Classy.Math.round(2.4), 2)
end

---------------------------------------------------------------------------
-- TestField
---------------------------------------------------------------------------
TestField = {}

function TestField:testSetAndGet()
    local m = Classy.Matrix.new()
    m:set(1, 1, "val")
    lu.assertEquals(m:get(1, 1), "val")
end

function TestField:testGetOutOfBounds()
    local m = Classy.Matrix.new()
    lu.assertNil(m:get(5, 5))
end

function TestField:testClear()
    local m = Classy.Matrix.new()
    m:set(1, 1, "val")
    m:clear()
    lu.assertNil(m:get(1, 1))
end

---------------------------------------------------------------------------
-- TestClassyCore
---------------------------------------------------------------------------
TestClassyCore = {}

function TestClassyCore:testIsClass()
    local ht = Classy.Hashtable.new()
    lu.assertEvalToTrue(Classy.isClass(ht))
    lu.assertTrue(Classy.isClass(ht, "Classy.Hashtable"))
    lu.assertFalse(Classy.isClass(ht, "Classy.List"))
    lu.assertFalse(Classy.isClass(nil))
    lu.assertFalse(Classy.isClass("string"))
end

function TestClassyCore:testGetClass()
    local cls = Classy.getClass("Classy.Hashtable")
    lu.assertNotNil(cls)
    lu.assertNotNil(cls.new)
end

function TestClassyCore:testGetClassDeep()
    local cls = Classy.getClass("Classy.LinkedList.Node")
    lu.assertNotNil(cls)
    lu.assertNotNil(cls.new)
end

function TestClassyCore:testGetClassNil()
    lu.assertNil(Classy.getClass(123))
end

function TestClassyCore:testGetClassNonExistent()
    lu.assertNil(Classy.getClass("Classy.NonExistent"))
end

function TestClassyCore:testGetClassName()
    local ht = Classy.Hashtable.new()
    lu.assertEquals(Classy.getClassName(ht), "Classy.Hashtable")
end

function TestClassyCore:testClassFactory()
    local Example = Classy.Class({
        constructor = function(self)
            self._className = "Example"
            self._data = {}
        end,
        add = function(self, value)
            table.insert(self._data, value)
        end,
        get = function(self, index)
            return self._data[index]
        end,
    })

    local ex = Example.new()
    ex:add("Hello")
    ex:add("World")
    lu.assertEquals(ex:get(1), "Hello")
    lu.assertEquals(ex:get(2), "World")
    lu.assertTrue(Classy.isClass(ex, "Example"))
end

---------------------------------------------------------------------------
-- TestInheritance
---------------------------------------------------------------------------
TestInheritance = {}

function TestInheritance:testTestClass()
    local test = Classy.Test.new(function(self)
        self:set(1, "Hello, World!")
    end)
    lu.assertEquals(test:get(1), "Hello, World!")
end

---------------------------------------------------------------------------
-- TestArrayContains
---------------------------------------------------------------------------
TestArrayContains = {}

function TestArrayContains:testContainsTrue()
    local ds = Classy.DataSet.new()
    ds:add(1)
    ds:add(2)
    ds:add(3)
    lu.assertTrue(ds:contains(2))
end

function TestArrayContains:testContainsFalse()
    local ds = Classy.DataSet.new()
    ds:add(1)
    ds:add(2)
    lu.assertFalse(ds:contains(99))
end

function TestArrayContains:testContainsNil()
    local ds = Classy.DataSet.new()
    ds:add(1)
    lu.assertFalse(ds:contains(nil))
end

-- TestAbstract class (needed for TestInheritance)
Classy.TestAbstract = {
    base = function(self)
        self._baseName = "Classy.TestAbstract"
        self._data = {}
    end,

    set = function(self, key, value)
        self._data[key] = value
    end,

    get = function(self, key)
        return self._data[key]
    end,

    clear = function(self)
        self._data = {}
    end
}

-- Test class, inheriting from TestAbstract
Classy.Test = {
    new = function(initializer)
        return Classy.createInstance(Classy.Test.prototype, initializer)
    end,

    prototype = Classy.inheritFrom(Classy.TestAbstract, {
        constructor = function(self)
            if self.base then
                self:base()
                self.base = nil
            end
            self._className = "Classy.Test"
        end
    })
}

---------------------------------------------------------------------------
-- Run tests
---------------------------------------------------------------------------
os.exit(lu.LuaUnit.run())
