local function assertEqual(actual, expected, message)
    if actual ~= expected then
        print("Test Failed: " .. message .. " | Expected: " .. tostring(expected) .. " but got: " .. tostring(actual))
        return false
    end
    return true
end

local function assert(condition, message)
    if not condition then
        print("Test Failed: " .. message)
        return false
    end
    return true
end

-- TestAbstract class
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

-- Unit Tests for Classy Library
Classy.UnitTests = {

    -- Tests the functionality of the Hashtable class
    Hashtable = function()
        local success = true
        local hashtable = Classy.Hashtable.new()

        -- Adding entries to the hashtable
        hashtable:put("abc", "ABC")
        hashtable:put("x", 29)
        hashtable:put("a", 32)

        -- Removing an entry from the hashtable
        hashtable:remove("x")

        -- Assertions for Hashtable contents
        success = success and assertEqual(hashtable:get("abc"), "ABC", "Hashtable should contain 'abc' = 'ABC'")
        success = success and assertEqual(hashtable:get("x"), nil, "Hashtable should not contain 'x' after removal")
        success = success and assertEqual(hashtable:get("a"), 32, "Hashtable should contain 'a' = 32")

        -- Check the size of the hashtable
        success = success and assertEqual(hashtable:size(), 2, "Hashtable size should be 2 after removal")

        -- Check if a specific value exists
        success = success and assert(hashtable:containsValue(32), "Hashtable should contain value 32")

        -- Final result report
        if success then
            print("Hashtable Unit Test Passed: All checks are successful!")
        else
            print("Hashtable Unit Test Failed: Some checks did not pass.")
        end
    end,

    BinaryTree = function()
        local success = true

        -- Initialize a BinaryTree with root value 10
        local tree = Classy.BinaryTree.new(10)

        -- Insert values into the BinaryTree
        tree:insert(5)
        tree:insert(15)
        tree:insert(2)
        tree:insert(7)
        tree:insert(12)
        tree:insert(20)

        -- Assertions for finding nodes
        success = success and assertEqual(tree:find(10):getValue(), 10, "BinaryTree: Root node should have value 10")
        success = success and assertEqual(tree:find(5):getValue(), 5, "BinaryTree: Node with value 5 should be found")
        success = success and
                      assertEqual(tree:find(15):getValue(), 15, "BinaryTree: Node with value 15 should be found")
        success = success and assertEqual(tree:find(2):getValue(), 2, "BinaryTree: Node with value 2 should be found")
        success = success and assertEqual(tree:find(7):getValue(), 7, "BinaryTree: Node with value 7 should be found")
        success = success and
                      assertEqual(tree:find(12):getValue(), 12, "BinaryTree: Node with value 12 should be found")
        success = success and
                      assertEqual(tree:find(20):getValue(), 20, "BinaryTree: Node with value 20 should be found")
        success = success and assertEqual(tree:find(99), nil, "BinaryTree: Node with value 99 should not be found")

        -- In-order traversal should return values in sorted order
        local inOrderResult = {}
        tree:inOrderTraversal(function(node)
            table.insert(inOrderResult, node:getValue())
        end)
        local expectedInOrder = {2, 5, 7, 10, 12, 15, 20}
        for i, expectedValue in ipairs(expectedInOrder) do
            success = success and assertEqual(inOrderResult[i], expectedValue,
                "BinaryTree: In-order traversal value at index " .. i .. " should be " .. expectedValue)
        end

        -- Pre-order traversal should return values in root-left-right order
        local preOrderResult = {}
        tree:preOrderTraversal(function(node)
            table.insert(preOrderResult, node:getValue())
        end)
        local expectedPreOrder = {10, 5, 2, 7, 15, 12, 20}
        for i, expectedValue in ipairs(expectedPreOrder) do
            success = success and assertEqual(preOrderResult[i], expectedValue,
                "BinaryTree: Pre-order traversal value at index " .. i .. " should be " .. expectedValue)
        end

        -- Post-order traversal should return values in left-right-root order
        local postOrderResult = {}
        tree:postOrderTraversal(function(node)
            table.insert(postOrderResult, node:getValue())
        end)
        local expectedPostOrder = {2, 7, 5, 12, 20, 15, 10}
        for i, expectedValue in ipairs(expectedPostOrder) do
            success = success and assertEqual(postOrderResult[i], expectedValue,
                "BinaryTree: Post-order traversal value at index " .. i .. " should be " .. expectedValue)
        end

        -- Final result report
        if success then
            print("BinaryTree Unit Test Passed: All checks are successful!")
        else
            print("BinaryTree Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the basic functionality of the Matrix class
    Matrix = function()
        local success = true
        local matrix = Classy.Matrix.new()

        -- Set values in the matrix
        matrix:set(1, 1, "Jimmy")
        matrix:set(1, 2, "Timmy")
        matrix:set(2, 1, "Kimmy")

        -- Assertions for matrix entries
        success = success and assertEqual(matrix:get(1, 1), "Jimmy", "Matrix entry [1, 1] should be 'Jimmy'")
        success = success and assertEqual(matrix:get(1, 2), "Timmy", "Matrix entry [1, 2] should be 'Timmy'")
        success = success and assertEqual(matrix:get(2, 1), "Kimmy", "Matrix entry [2, 1] should be 'Kimmy'")

        -- Test retrieval of a non-existent entry
        success = success and assertEqual(matrix:get(2, 2), nil, "Matrix entry [2, 2] should be nil")

        -- Clear the matrix and check for empty entries
        matrix:clear()
        success = success and assertEqual(matrix:get(1, 1), nil, "Matrix entry [1, 1] should be nil after clear")
        success = success and assertEqual(matrix:get(1, 2), nil, "Matrix entry [1, 2] should be nil after clear")
        success = success and assertEqual(matrix:get(2, 1), nil, "Matrix entry [2, 1] should be nil after clear")

        -- Final result report
        if success then
            print("Matrix Unit Test Passed: All checks are successful!")
        else
            print("Matrix Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the basic functionality of the DataSet class
    DataSet = function()
        local success = true
        local dataSet = Classy.DataSet.new()

        -- Adding values to the dataset
        dataSet:add(5)
        dataSet:add(6)
        dataSet:add(7)

        -- Assertions for DataSet contents
        success = success and assertEqual(dataSet:get(1), 5, "DataSet first entry should be 5")
        success = success and assertEqual(dataSet:get(2), 6, "DataSet second entry should be 6")
        success = success and assertEqual(dataSet:get(3), 7, "DataSet third entry should be 7")

        -- Clear the dataset and check for empty entries
        dataSet:clear()
        success = success and assertEqual(dataSet:get(1), nil, "DataSet first entry should be nil after clear")
        success = success and assertEqual(dataSet:get(2), nil, "DataSet second entry should be nil after clear")
        success = success and assertEqual(dataSet:get(3), nil, "DataSet third entry should be nil after clear")

        -- Final result report
        if success then
            print("DataSet Unit Test Passed: All checks are successful!")
        else
            print("DataSet Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the map function of the List class
    ListMap = function()
        local success = true

        -- Creating and populating lists
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

        -- Apply a map function across the lists
        local resultList = list1:map(function(value1, value2, value3)
            return value1 + value2 - value3
        end, list2, list3)

        -- Assertions for the map result
        success = success and assertEqual(resultList:get(1), 0, "ListMap first entry should be 0")
        success = success and assertEqual(resultList:get(2), 14, "ListMap second entry should be 14")
        success = success and assertEqual(resultList:get(3), 9, "ListMap third entry should be 9")

        -- Final result report
        if success then
            print("ListMap Unit Test Passed: All checks are successful!")
        else
            print("ListMap Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the sorting functionality of the DataSet class
    DataSetSort = function()
        local success = true
        local dataSet = Classy.DataSet.new()

        -- Adding values to the dataset
        dataSet:add(21)
        dataSet:add(6)
        dataSet:add(70)
        dataSet:add(23)
        dataSet:add(4)
        dataSet:add(16)
        dataSet:add(91)
        dataSet:add(9)

        -- Sort the dataset
        dataSet:sort()

        -- Assertions for sorted DataSet
        local expectedOrder = {4, 6, 9, 16, 21, 23, 70, 91}
        for i, expectedValue in ipairs(expectedOrder) do
            success = success and
                          assertEqual(dataSet:get(i), expectedValue,
                    "DataSetSort entry at index " .. i .. " should be " .. expectedValue)
        end

        -- Final result report
        if success then
            print("DataSetSort Unit Test Passed: All checks are successful!")
        else
            print("DataSetSort Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the copy and clone functionality of the DataSet class
    DataSetClone = function()
        local success = true
        local dataSet = Classy.DataSet.new()

        -- Adding values to the dataset
        dataSet:add(5)
        dataSet:add(6)
        dataSet:add(7)

        -- Cloning the dataset
        local copy = dataSet:copy()

        -- Assert that the original and the clone are equal
        success = success and
                      assert(dataSet:equals(copy), "DataSetClone: Cloned dataset should be equal to the original")

        -- Modify the clone and check for inequality
        copy:add(8)
        success = success and
                      assert(not dataSet:equals(copy), "DataSetClone: Modified clone should not be equal to original")

        -- Final result report
        if success then
            print("DataSetClone Unit Test Passed: All checks are successful!")
        else
            print("DataSetClone Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the equals method of the DataSet class
    DataSetEquals = function()
        local success = true

        local dataSetA = Classy.DataSet.new()
        dataSetA:add(5)
        dataSetA:add(6)
        dataSetA:add(7)

        local dataSetB = Classy.DataSet.new()
        dataSetB:add(5)
        dataSetB:add(6)
        dataSetB:add(7)

        local dataSetC = Classy.DataSet.new()
        dataSetC:add(1)
        dataSetC:add(6)
        dataSetC:add(9)

        -- Assert equality between datasets
        success = success and assert(dataSetA:equals(dataSetB), "DataSetEquals: Datasets A and B should be equal")
        success = success and
                      assert(not dataSetA:equals(dataSetC), "DataSetEquals: Datasets A and C should not be equal")

        -- Final result report
        if success then
            print("DataSetEquals Unit Test Passed: All checks are successful!")
        else
            print("DataSetEquals Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the difference method of the DataSet class
    DataSetDifference = function()
        local success = true

        local dataSetA = Classy.DataSet.new()
        dataSetA:add(5)
        dataSetA:add(6)
        dataSetA:add(7)

        local dataSetB = Classy.DataSet.new()
        dataSetB:add(1)
        dataSetB:add(6)
        dataSetB:add(9)

        -- Compute the difference between two datasets
        local results = dataSetA:difference(dataSetB)

        -- Assertions for DataSet difference
        local expectedDifference = {5, 7}
        for i, expectedValue in ipairs(expectedDifference) do
            success = success and
                          assertEqual(results:get(i), expectedValue,
                    "DataSetDifference entry at index " .. i .. " should be " .. expectedValue)
        end

        -- Final result report
        if success then
            print("DataSetDifference Unit Test Passed: All checks are successful!")
        else
            print("DataSetDifference Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the intersection method of the DataSet class
    DataSetIntersection = function()
        local success = true

        local dataSetA = Classy.DataSet.new()
        dataSetA:add(5)
        dataSetA:add(6)
        dataSetA:add(7)

        local dataSetB = Classy.DataSet.new()
        dataSetB:add(5)
        dataSetB:add(7)
        dataSetB:add(9)

        -- Compute the intersection of two datasets
        local results = dataSetA:intersection(dataSetB)

        -- Assertions for DataSet intersection
        local expectedIntersection = {5, 7}
        for i, expectedValue in ipairs(expectedIntersection) do
            success = success and
                          assertEqual(results:get(i), expectedValue,
                    "DataSetIntersection entry at index " .. i .. " should be " .. expectedValue)
        end

        -- Final result report
        if success then
            print("DataSetIntersection Unit Test Passed: All checks are successful!")
        else
            print("DataSetIntersection Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the union method of the DataSet class
    DataSetUnion = function()
        local success = true

        local dataSetA = Classy.DataSet.new()
        dataSetA:add(5)
        dataSetA:add(6)
        dataSetA:add(7)

        local dataSetB = Classy.DataSet.new()
        dataSetB:add(1)
        dataSetB:add(6)
        dataSetB:add(9)

        -- Compute the union of two datasets
        local results = dataSetA:union(dataSetB)

        -- Assertions for DataSet union
        local expectedUnion = {5, 6, 7, 1, 9}
        for i, expectedValue in ipairs(expectedUnion) do
            success = success and
                          assertEqual(results:get(i), expectedValue,
                    "DataSetUnion entry at index " .. i .. " should be " .. expectedValue)
        end

        -- Final result report
        if success then
            print("DataSetUnion Unit Test Passed: All checks are successful!")
        else
            print("DataSetUnion Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests basic operations on a linked list
    LinkedLists = function()
        local success = true

        -- Initialize the linked list with some elements
        local ll = Classy.LinkedList.new(function(self)
            self:add("This")
            self:add("is")
            self:add("a")
            self:add("test.")
        end)

        -- Forward traversal through the list
        success = success and assertEqual(ll:first(), "This", "First node should be 'This'")
        success = success and assertEqual(ll:next(), "is", "Second node should be 'is'")
        success = success and assertEqual(ll:next(), "a", "Third node should be 'a'")
        success = success and assertEqual(ll:next(), "test.", "Fourth node should be 'test.'")
        success = success and assertEqual(ll:next(), nil, "There should be no fifth node, expected nil")

        -- Backward traversal through the list
        success = success and assertEqual(ll:last(), "test.", "Last node should be 'test.'")
        success = success and assertEqual(ll:previous(), "a", "Second last node should be 'a'")
        success = success and assertEqual(ll:previous(), "is", "Third last node should be 'is'")
        success = success and assertEqual(ll:previous(), "This", "Fourth last node should be 'This'")
        success = success and
                      assertEqual(ll:previous(), nil, "There should be no more nodes to traverse backward, expected nil")

        -- Removing a node and verifying the list
        ll:first() -- Reset to the first node
        ll:next() -- Move to the second node ("is")
        local nodeToRemove = ll:currentNode()
        local nodeValue = ll:current()
        success = success and assertEqual(nodeValue, "is", "The node to be removed should have value 'is'")
        ll:remove(nodeToRemove)

        -- Verify list after removal
        success = success and assertEqual(ll:first(), "This", "First node should still be 'This' after removal")
        success = success and assertEqual(ll:next(), "a", "Second node should now be 'a' after removal of 'is'")
        success = success and
                      assertEqual(ll:next(), "test.", "Third node should still be 'test.' after removal of 'is'")
        success = success and assertEqual(ll:next(), nil, "There should be no more nodes after 'test.', expected nil")

        -- Final result report
        if success then
            print("LinkedList Unit Test Passed: All checks are successful!")
        else
            print("LinkedList Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests basic stack operations
    Stack = function()
        local success = true

        -- Initialize the stack with some elements
        local s = Classy.Stack.new(function(self)
            self:push("7")
            self:push("8")
            self:push("9")
        end)

        -- Assertions for stack operations
        success = success and assertEqual(s:pop(), "9", "Stack pop should return '9'")
        success = success and assertEqual(s:pop(), "8", "Stack pop should return '8'")
        success = success and assertEqual(s:pop(), "7", "Stack pop should return '7'")

        -- Check that the stack is empty after all elements are popped
        success = success and assert(s:isEmpty(), "Stack should be empty after popping all elements")

        -- Final result report
        if success then
            print("Stack Unit Test Passed: All checks are successful!")
        else
            print("Stack Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests basic queue operations
    Queue = function()
        local success = true

        -- Initialize the queue with some elements using enqueue
        local q = Classy.Queue.new(function(self)
            self:enqueue("7")
            self:enqueue("8")
            self:enqueue("9")
        end)

        -- Dequeue elements from the queue and assert their order
        success = success and assertEqual(q:dequeue(), "7", "Queue dequeue should return '7'")
        success = success and assertEqual(q:dequeue(), "8", "Queue dequeue should return '8'")
        success = success and assertEqual(q:dequeue(), "9", "Queue dequeue should return '9'")

        -- Check that the queue is empty after all elements are dequeued
        success = success and assert(q:isEmpty(), "Queue should be empty after dequeuing all elements")

        if success then
            print("Queue Unit Test Passed: All checks are successful!")
        else
            print("Queue Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the Observable class
    Observable = function()
        local success = true

        -- Create an Observable and set its initial value
        local ob = Classy.Observable.new("Hello")

        -- Define some observer functions
        local observedValues = {}
        local func1 = function(value)
            table.insert(observedValues, "Function #1 - " .. tostring(value))
        end
        local func2 = function(value)
            table.insert(observedValues, "Function #2 - " .. tostring(value))
        end
        local func3 = function(value)
            table.insert(observedValues, "Function #3 - " .. tostring(value))
        end

        -- Subscribe functions to the Observable
        ob:subscribe(func1)
        ob:subscribe(func2)
        ob:subscribe(func3)

        -- Change the Observable's value and notify observers
        ob:set("Test")

        -- Unsubscribe one function
        ob:unsubscribe(func2)

        -- Change the Observable's value again and notify remaining observers
        ob:set("Bye")

        -- Assertions for Observable notifications
        local expectedNotifications = {"Function #1 - Test", "Function #2 - Test", "Function #3 - Test",
                                       "Function #1 - Bye", "Function #3 - Bye"}
        for i, expectedValue in ipairs(expectedNotifications) do
            success = success and
                          assertEqual(observedValues[i], expectedValue,
                    "Observable notification " .. i .. " should be '" .. expectedValue .. "'")
        end

        -- Final result report
        if success then
            print("Observable Unit Test Passed: All checks are successful!")
        else
            print("Observable Unit Test Failed: Some checks did not pass.")
        end
    end,

    -- Tests the Vector class
    Vector = function()
        local success = true

        -- Create two vectors
        local vec1 = Classy.Vector.new(function(self)
            self:addElement(1)
            self:addElement(2)
            self:addElement(3)
        end)

        local vec2 = Classy.Vector.new(function(self)
            self:addElement(4)
            self:addElement(5)
            self:addElement(6)
        end)

        -- Test addition
        local sum = vec1:add(vec2)
        success = success and assertEqual(sum:getElement(1), 5, "Vector addition first element should be 5")
        success = success and assertEqual(sum:getElement(2), 7, "Vector addition second element should be 7")
        success = success and assertEqual(sum:getElement(3), 9, "Vector addition third element should be 9")

        -- Test subtraction
        local difference = vec1:subtract(vec2)
        success = success and assertEqual(difference:getElement(1), -3, "Vector subtraction first element should be -3")
        success = success and
                      assertEqual(difference:getElement(2), -3, "Vector subtraction second element should be -3")
        success = success and assertEqual(difference:getElement(3), -3, "Vector subtraction third element should be -3")

        -- Test dot product
        local dot = vec1:dotProduct(vec2)
        success = success and assertEqual(dot, 32, "Vector dot product should be 32")

        -- Test magnitude
        local magnitude = vec1:magnitude()
        success = success and
                      assert(math.abs(magnitude - 3.7416573867739) < 1e-10,
                "Vector magnitude calculation should be close to 3.7416573867739")

        -- Test normalization
        local normalizedVec = vec1:normalize()
        success = success and assert(math.abs(normalizedVec:getElement(1) - 0.26726124191242) < 1e-10,
            "Vector normalization first element should be close to 0.26726124191242")
        success = success and assert(math.abs(normalizedVec:getElement(2) - 0.53452248382485) < 1e-10,
            "Vector normalization second element should be close to 0.53452248382485")
        success = success and assert(math.abs(normalizedVec:getElement(3) - 0.80178372573727) < 1e-10,
            "Vector normalization third element should be close to 0.80178372573727")

        -- Final result report
        if success then
            print("Vector Unit Test Passed: All checks are successful!")
        else
            print("Vector Unit Test Failed: Some checks did not pass.")
        end
    end,
    TestClass = function()
        local success = true

        -- Create a new instance of the Test class
        local test = Classy.Test.new(function(self)
            self:set(1, "Hello, World!")
        end)
        success = success and
                      assertEqual(test:get(1), "Hello, World!", "Test class should store and retrieve data correctly")

        -- Final result report
        if success then
            print("TestClass Unit Test Passed: All checks are successful!")
        else
            print("TestClass Unit Test Failed: Some checks did not pass.")
        end
    end,
    ExampleClass = function()
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
            set = function(self, index, value)
                self._data[index] = value
            end,
            clear = function(self)
                self._data = {}
            end
        })

        local example = Example.new()
        example:add("Hello")
        example:add("World")
        example:add("!")

        local success = true
        success = success and assertEqual(example:get(1), "Hello", "Example class should store and retrieve data correctly")
        success = success and assertEqual(example:get(2), "World", "Example class should store and retrieve data correctly")
        success = success and assertEqual(example:get(3), "!", "Example class should store and retrieve data correctly")

        if success then
            print("ExampleClass Unit Test Passed: All checks are successful!")
        else
            print("ExampleClass Unit Test Failed: Some checks did not pass.")
        end
    end
}

-- Test Runner Function
function runUnitTests()
    local tests = Classy.UnitTests
    local failures = 0

    -- Run each unit test by calling each function in Classy.UnitTests
    for testName, testFunc in pairs(tests) do
        print("\nRunning Test: " .. testName)
        local success, err = pcall(testFunc)
        if success then
            -- print(testName .. " Passed")
        else
            failures = failures + 1
            print(testName .. " Failed: " .. tostring(err))
        end
    end

    -- All tests completed
    print("\nCompleted Unit Testing: " .. (failures > 0 and "Some tests failed." or "All tests passed."))
end

-- Run the unit tests
runUnitTests()
