-- Unit Tests, but not unit testing (It's a work in progress)... My sloppy version of testing. :P
Classy.UnitTests = {
    Hashtable = function ()
        local hashtable = Classy.Hashtable.new();
        hashtable:put("abc", "ABC")
        hashtable:put("x", 29)
        hashtable:put("a", 32)
        hashtable:remove("x");
        hashtable:forEach(function (key, value)
            print("Hashtable Entry: "..tostring(key).." = "..tostring(value)..", value type = "..type(value));
        end);
        print("Hashtable Count: "..tostring(hashtable:size()));
        print("Hashtable containsValue: 32 == "..tostring(hashtable:containsValue(32)))
        return hashtable:getKeys();
    end,
    Matrix = function ()
        local matrix = Classy.Matrix.new();
        matrix:set(1, 1, "Jimmy")
        matrix:set(1, 2, "Timmy")
        matrix:set(2, 1, "Kimmy")
        print("Matrix Entry: "..tostring(matrix:get(1, 1)));
        print("Matrix Entry: "..tostring(matrix:get(1, 2)));
        print("Matrix Entry: "..tostring(matrix:get(2, 1)));
        print("Matrix Entry: "..tostring(matrix:get(2, 2)));
    end,
    DataSet = function ()
        local dataSet = Classy.DataSet.new();
        dataSet:add(5);
        dataSet:add(6);
        dataSet:add(7);
        dataSet:forEach(function (value, ...)
            print("DataSet Entry: "..tostring(value));
        end);
    end,
    ListMap = function ()
        local list1 = Classy.List.new();
        list1:add(1);
        list1:add(8);
        list1:add(4);
        local list2 = Classy.List.new();
        list2:add(5);
        list2:add(6);
        list2:add(7);
        local list3 = Classy.List.new();
        list3:add(6);
        list3:add(0);
        list3:add(2);
        local resultList = list1:map(function (value1, value2, value3)
            return value1 + value2 - value3
        end, list2, list3);
        resultList:forEach(function (value, ...)
            print("ResultList Entry: "..tostring(value));
        end);
        print("resultList should = { 0, 14, 9 }");
    end,
    DataSetSort = function ()
        local dataSet = Classy.DataSet.new();
        dataSet:add(21);
        dataSet:add(6);
        dataSet:add(70);
        dataSet:add(23);
        dataSet:add(4);
        dataSet:add(16);
        dataSet:add(91);
        dataSet:add(9);
        dataSet:sort();
        dataSet:forEach(function (value)
            print("DataSetSort Entry: "..tostring(value))
        end)
        print("DataSetSort Results: equals {4, 6, 9, 16, 21, 23, 70, 91}")
    end,
    DataSetClone = function ()
        local dataSet = Classy.DataSet.new();
        dataSet:add(5);
        dataSet:add(6);
        dataSet:add(7);
        local copy = dataSet:copy()
        assert(dataSet:equals(copy), "DataSetClone: Failed!")
        print("DataSetClone: Passed!")
    end,
    DataSetEquals = function ()
        local dataSetA = Classy.DataSet.new();
        dataSetA:add(5);
        dataSetA:add(6);
        dataSetA:add(7);
        local dataSetB = Classy.DataSet.new();
        dataSetB:add(5);
        dataSetB:add(6);
        dataSetB:add(7);
        local dataSetC = Classy.DataSet.new();
        dataSetC:add(1);
        dataSetC:add(6);
        dataSetC:add(9);
        assert(dataSetA:equals(dataSetB), "DataSetEquals: Equals test failed!")
        print("DataSetEquals: Equals test passed");
        assert(not dataSetA:equals(dataSetC),"DataSetEquals: Not equals test failed!")
        print("DataSetEquals: Not equals test passed")
    end,
    DataSetDifference = function ()
        local dataSet = Classy.DataSet.new();
        dataSet:add(5);
        dataSet:add(6);
        dataSet:add(7);
        local dataSetB = Classy.DataSet.new();
        dataSetB:add(1);
        dataSetB:add(6);
        dataSetB:add(9);
    
        local results = dataSet:difference(dataSetB);
        assert(results._data)
        results:forEach(function (value, ...)
            print("DataSetDifference Entry: "..tostring(value));
        end);
        print("DataSetDifference Results: equals {1, 5, 7, 9}")
    end,
    DataSetIntersection = function ()
        local dataSet = Classy.DataSet.new();
        dataSet:add(5);
        dataSet:add(6);
        dataSet:add(7);
        local dataSetB = Classy.DataSet.new();
        dataSetB:add(5);
        dataSetB:add(7);
        dataSetB:add(9);
    
        local results = dataSet:intersection(dataSetB);
        results:forEach(function (value, ...)
            print("DataSetIntersection Entry: "..tostring(value));
        end);
        print("DataSetIntersection Results: should equal {5, 7}")
    end,
    DataSetUnion = function ()
        local dataSet = Classy.DataSet.new();
        dataSet:add(5);
        dataSet:add(6);
        dataSet:add(7);
        local dataSetB = Classy.DataSet.new();
        dataSetB:add(1);
        dataSetB:add(6);
        dataSetB:add(9);
    
        local results = dataSet:union(dataSetB);
        results:forEach(function (value, ...)
            print("DataSetUnion Entry: "..tostring(value));
        end);
        print("DataSetUnion Results: should equal {5, 6, 7, 1, 9}")
    end,
    LinkedLists = function ()
        local ll = Classy.LinkedList.new(function (self)
            self:add("This");
            self:add("is");
            self:add("a");
            self:add("test.");
        end);
        print("LinkedList-Init: "..ll:first().." "..ll:next().." "..ll:next().." "..ll:next().." "..ll:next())
        print("LinkedList-Init: "..ll:last().." "..ll:previous().." "..ll:previous().." "..ll:previous().." "..ll:previous())
    
        ll:first(); ll:next();
        local node = ll:currentNode();
        print("LinkedList-SelectedNode: "..ll:current());
        ll:remove(node);
        print("LinkedList-Init: "..ll:first().." "..ll:next().." "..ll:next().." "..ll:next().." "..ll:next())
    end,
    Stack = function () 
        local s = Classy.Stack.new(function (self)
            self:push("7");
            self:push("8");
            self:push("9");
        end);
        print("Stack: "..s:pop()..s:pop()..s:pop());
    end,
    Queue = function ()
        local q = Classy.Queue.new(function (self)
            self:add("7");
            self:add("8");
            self:add("9");
        end);
        print("Queue: "..q:next()..q:next()..q:next());
    end,
    UndoStack = function ()
        local undo = Classy.UndoStack.new();
        undo:add(function ()
            addon.Debug("ABCD!")
        end)
        undo:clear();
        undo:undo();
    end,
    Observable = function ()
        local ob = Classy.Observable.new("Hello"); -- Create an Observable and set its initial value to argument 1
        local func1 = function (value) print("Function #1 - "..tostring(value)) end;
        local func2 = function (value) print("Function #2 - "..tostring(value)) end;
        local func3 = function (value) print("Function #3 - "..tostring(value)) end;
        ob:subscribe(func1);
        ob:subscribe(func2);
        ob:subscribe(func3);
        ob:set("Test");
        ob:unsubscribe(func2);
        ob:set("Bye");
    end,
}
