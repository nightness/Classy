-- Unit Tests for Classy Library
Classy.UnitTests = {
    
    -- Tests the functionality of the Hashtable class
    Hashtable = function ()
        local hashtable = Classy.Hashtable.new()

        -- Adding entries to the hashtable
        hashtable:put("abc", "ABC")
        hashtable:put("x", 29)
        hashtable:put("a", 32)

        -- Removing an entry from the hashtable
        hashtable:remove("x")

        -- Iterate through the hashtable and print entries
        hashtable:forEach(function (key, value)
            print("Hashtable Entry: "..tostring(key).." = "..tostring(value)..", value type = "..type(value))
        end)

        -- Print the size of the hashtable
        print("Hashtable Count: "..tostring(hashtable:size()))

        -- Check if a specific value exists
        print("Hashtable containsValue: 32 == "..tostring(hashtable:containsValue(32)))

        -- Return the keys of the hashtable for further assertions
        return hashtable:getKeys()
    end,

    -- Tests the basic functionality of the Matrix class
    Matrix = function ()
        local matrix = Classy.Matrix.new()

        -- Set values in the matrix
        matrix:set(1, 1, "Jimmy")
        matrix:set(1, 2, "Timmy")
        matrix:set(2, 1, "Kimmy")

        -- Retrieve and print matrix values
        print("Matrix Entry [1, 1]: "..tostring(matrix:get(1, 1)))
        print("Matrix Entry [1, 2]: "..tostring(matrix:get(1, 2)))
        print("Matrix Entry [2, 1]: "..tostring(matrix:get(2, 1)))

        -- Test retrieval of a non-existent entry
        print("Matrix Entry [2, 2]: "..tostring(matrix:get(2, 2)))
    end,

    -- Tests the basic functionality of the DataSet class
    DataSet = function ()
        local dataSet = Classy.DataSet.new()

        -- Adding values to the dataset
        dataSet:add(5)
        dataSet:add(6)
        dataSet:add(7)

        -- Iterate through the dataset and print entries
        dataSet:forEach(function (value, ...)
            print("DataSet Entry: "..tostring(value))
        end)
    end,

    -- Tests the map function of the List class
    ListMap = function ()
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
        local resultList = list1:map(function (value1, value2, value3)
            return value1 + value2 - value3
        end, list2, list3)

        -- Print the result list
        resultList:forEach(function (value, ...)
            print("ResultList Entry: "..tostring(value))
        end)

        print("resultList should equal { 0, 14, 9 }")
    end,

    -- Tests the sorting functionality of the DataSet class
    DataSetSort = function ()
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

        -- Iterate and print sorted dataset
        dataSet:forEach(function (value)
            print("DataSetSort Entry: "..tostring(value))
        end)

        print("DataSetSort Results: equals {4, 6, 9, 16, 21, 23, 70, 91}")
    end,

    -- Tests the copy and clone functionality of the DataSet class
    DataSetClone = function ()
        local dataSet = Classy.DataSet.new()

        -- Adding values to the dataset
        dataSet:add(5)
        dataSet:add(6)
        dataSet:add(7)

        -- Cloning the dataset
        local copy = dataSet:copy()

        -- Assert that the original and the clone are equal
        assert(dataSet:equals(copy), "DataSetClone: Failed!")
        print("DataSetClone: Passed!")
    end,

    -- Tests the equals method of the DataSet class
    DataSetEquals = function ()
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
        assert(dataSetA:equals(dataSetB), "DataSetEquals: Equals test failed!")
        print("DataSetEquals: Equals test passed")

        -- Assert inequality between datasets
        assert(not dataSetA:equals(dataSetC), "DataSetEquals: Not equals test failed!")
        print("DataSetEquals: Not equals test passed")
    end,

    -- Tests the difference method of the DataSet class
    DataSetDifference = function ()
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

        -- Assert that results are valid
        assert(results._data, "DataSetDifference: Results are invalid!")

        -- Print the difference
        results:forEach(function (value, ...)
            print("DataSetDifference Entry: "..tostring(value))
        end)

        print("DataSetDifference Results: equals {1, 5, 7, 9}")
    end,

    -- Tests the intersection method of the DataSet class
    DataSetIntersection = function ()
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

        -- Print the intersection
        results:forEach(function (value, ...)
            print("DataSetIntersection Entry: "..tostring(value))
        end)

        print("DataSetIntersection Results: should equal {5, 7}")
    end,

    -- Tests the union method of the DataSet class
    DataSetUnion = function ()
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

        -- Print the union
        results:forEach(function (value, ...)
            print("DataSetUnion Entry: "..tostring(value))
        end)

        print("DataSetUnion Results: should equal {5, 6, 7, 1, 9}")
    end,

    -- Tests basic operations on a linked list
    LinkedLists = function ()
        -- Initialize the linked list with some elements
        local ll = Classy.LinkedList.new(function (self)
            self:add("This")
            self:add("is")
            self:add("a")
            self:add("test.")
        end)

        -- Forward traversal through the list
        print("LinkedList-Init: "..ll:first().." "..ll:next().." "..ll:next().." "..ll:next().." "..ll:next())

        -- Backward traversal through the list
        print("LinkedList-Init: "..ll:last().." "..ll:previous().." "..ll:previous().." "..ll:previous().." "..ll:previous())

        -- Removing a node
        ll:first(); ll:next()
        local node = ll:currentNode()
        print("LinkedList-SelectedNode: "..ll:current())
        ll:remove(node)
        print("LinkedList-Init: "..ll:first().." "..ll:next().." "..ll:next().." "..ll:next().." "..ll:next())
    end,

    -- Tests basic stack operations
    Stack = function ()
        -- Initialize the stack with some elements
        local s = Classy.Stack.new(function (self)
            self:push("7")
            self:push("8")
            self:push("9")
        end)

        -- Pop elements from the stack and print them
        print("Stack: "..s:pop().." "..s:pop().." "..s:pop())
    end,

    -- Tests basic queue operations
    Queue = function ()
        -- Initialize the queue with some elements
        local q = Classy.Queue.new(function (self)
            self:add("7")
            self:add("8")
            self:add("9")
        end)

        -- Dequeue elements from the queue and print them
        print("Queue: "..q:next().." "..q:next().." "..q:next())
    end,

    -- Tests the Observable class
    Observable = function ()
        -- Create an Observable and set its initial value
        local ob = Classy.Observable.new("Hello")

        -- Define some observer functions
        local func1 = function (value) print("Observable: Function #1 - "..tostring(value)) end
        local func2 = function (value) print("Observable: Function #2 - "..tostring(value)) end
        local func3 = function (value) print("Observable: Function #3 - "..tostring(value)) end

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
    end,
}
