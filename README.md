# Classy Library Documentation

Classy library provides a class-like interface and collection of data structure classes and utilities, implemented in Lua, to facilitate complex programming tasks. Below, you'll find detailed documentation on each class, including its instance methods and class-level "static" methods.

## Setup

### Using the Makefile

This section provides a concise guide to using the Makefile to build and bundle the Lua Classy Library.

#### Prerequisites

- **GNU Make** and **Curl** should be installed on your system.

### Makefile Overview

The Makefile automates:
- **Building the Lua interpreter** from source.
- **Creating bundled Lua files**:
  - `classy.bundle.lua` (library only).
  - `classy.bundle.tests.lua` (library + luaunit + unit tests).
  - `neural-network.lua` (library + NeuralNetwork).
- **Cleaning up** build artifacts and bundled files.

### Targets

#### `default`

Builds all bundles.

- **Usage**: `make`

#### `all`

Builds all bundles and Lua.

- **Usage**: `make all`

#### `bundle`

Creates `classy.bundle.lua` by bundling all source files without tests.

- **Usage**: `make bundle`

#### `bundle-with-tests`

Creates `classy.bundle.tests.lua` by bundling all source files with luaunit and `UnitTests.lua` appended.

- **Usage**: `make bundle-with-tests`

#### `bundle-neural`

Creates `neural-network.lua` by bundling `classy.bundle.lua` with `src/NeuralNetwork/NeuralNetwork.lua`.

- **Usage**: `make bundle-neural`

#### `clean-lua`

Removes the Lua binary and source directory.

- **Usage**: `make clean-lua`

#### `clean`

Removes the output directory and bundled files.

- **Usage**: `make clean`

#### `clean-all`

Cleans both the bundled files and lua binary.

- **Usage**: `make clean-all`

### Usage Summary

1. **Build all bundles**: Run `make`.
2. **Build Lua**: Run `make lua`.
3. **Build Lua and all bundles**: Run `make all`.
4. **Clean bundled files**: Run `make clean`.
5. **Clean Lua build**: Run `make clean-lua`.
6. **Clean all files**: Run `make clean-all`.

## Testing

Tests use the [luaunit](https://github.com/bluebird75/luaunit) framework. To build and run:

```bash
make bundle-with-tests
lua out/classy.bundle.tests.lua
```

Add `-v` for verbose output showing each individual test result:

```bash
lua out/classy.bundle.tests.lua -v
```

The test suite contains 116 tests across 15 test suites covering all classes, error conditions, and edge cases.

## Core Utilities

### Classy.Class(proto)

Factory function for creating new classes from a prototype table. Returns a class table with a `new()` constructor.

```lua
local MyClass = Classy.Class({
    constructor = function(self)
        self._className = "MyClass"
        self._data = {}
    end,
    add = function(self, value)
        table.insert(self._data, value)
    end,
    get = function(self, index)
        return self._data[index]
    end
})

local obj = MyClass.new()
obj:add("Hello")
print(obj:get(1))  -- Output: Hello
```

### Classy.createInstance(prototype, initializer, existingData)

Creates an instance from a prototype table. This is the core instantiation mechanism used by all Classy classes.

### Classy.inheritFrom(src, dest)

Copies all fields from `src` into `dest`, recursively merging nested tables. Used to implement prototype inheritance.

### Classy.isClass(object, className)

Checks if an object is a Classy instance. If `className` is provided, checks if the object is an instance of that specific class. Returns the class name (truthy) when called without `className`, or `true`/`false` when called with one.

```lua
local ht = Classy.Hashtable.new()
Classy.isClass(ht)                    -- "Classy.Hashtable" (truthy)
Classy.isClass(ht, "Classy.Hashtable") -- true
Classy.isClass(ht, "Classy.List")      -- false
```

### Classy.getClass(className)

Returns the class table for a given dot-separated class name string by looking it up in the global scope.

```lua
local cls = Classy.getClass("Classy.LinkedList.Node")
local node = cls.new("value")
```

### Classy.getClassName(object)

Returns the `_className` string of a Classy instance, or `nil` if the object is not a Classy instance.

### Classy.clone(object)

Creates a deep copy of a table, preserving metatables and handling circular references.

### Classy.isIterable(val)

Returns `true` if the value is a table or has `__pairs`/`__ipairs` metamethods.

### Classy.NoOp

A function that does nothing. Useful as a no-op error handler argument.

## Classes
- [Array](#array)
- [BinaryTree](#binarytree)
- [Collection](#collection)
- [DataSet](#dataset)
- [Field](#field)
- [Hashtable](#hashtable)
- [LinkedList](#linkedlist)
- [List](#list)
- [Math](#math)
- [Matrix](#matrix)
- [NeuralNetwork](#neuralnetwork)
- [Observable](#observable)
- [Queue](#queue)
- [Stack](#stack)
- [Tree](#tree)
- [Vector](#vector)

---

## Array

The `Array` class is an abstract base prototype inherited by `DataSet` and `List`. It provides common array operations.

### Instance Methods
- `length(self)` - Returns the number of elements in the array.
- `clone(self)` - Returns a plain Lua table copy of the internal array.
- `copy(self)` - Returns a new Classy instance of the same type containing a copy of the data.
- `equals(self, arrayClass)` - Compares two arrays for equality (same elements, same length).
- `sort(self, compareFunction)` - Sorts the array using an optional comparison function.
- `isEmpty(self)` - Returns `true` if the array is empty.
- `contains(self, value)` - Returns `true` if the array contains the value, `false` otherwise.
- `forEach(self, func, errorHandler, ...)` - Iterates over each element, invoking the provided function.
- `map(self, handler, ...)` - Returns a new array with the results of applying the handler function to each element.

---

## BinaryTree

The `BinaryTree` class implements a binary search tree (BST), supporting insertion, searching, deletion, and traversals.

### Class Methods
- `Classy.BinaryTree.new(rootValue)` - Creates a new BinaryTree with the given root value.

### Instance Methods
- `getRoot(self)` - Returns the root node of the binary tree.
- `insert(self, value)` - Inserts a value into the binary tree.
- `find(self, value)` - Finds and returns a node with the specified value, or `nil` if not found.
- `delete(self, value)` - Deletes the node with the specified value. Handles leaf nodes, nodes with one child, and nodes with two children (replaces with in-order successor).
- `inOrderTraversal(self, visit)` - Performs an in-order traversal (left, root, right).
- `preOrderTraversal(self, visit)` - Performs a pre-order traversal (root, left, right).
- `postOrderTraversal(self, visit)` - Performs a post-order traversal (left, right, root).

### Node Class
- `getChildren(self)` - Returns the left and right children of the node.
- `setChildren(self, leftChild, rightChild)` - Sets the left and right children of the node.
- `getLeft(self)` - Returns the left child of the node.
- `setLeft(self, child)` - Sets the left child of the node.
- `getRight(self)` - Returns the right child of the node.
- `setRight(self, child)` - Sets the right child of the node.
- `getValue(self)` - Returns the value of the node.
- `setValue(self, value)` - Sets the value of the node.

---

## Collection

The `Collection` class provides a double-ended queue (deque) functionality, allowing elements to be added or removed from both ends. It is used internally by `Stack` and `Queue`.

### Instance Methods
- `reset(self)` - Resets the collection to its initial empty state.
- `pushleft(self, value)` - Adds an element to the front of the collection.
- `pushright(self, value)` - Adds an element to the end of the collection.
- `popleft(self)` - Removes and returns the element from the front. Errors if empty.
- `popright(self)` - Removes and returns the element from the end. Errors if empty.
- `get(self, index)` - Returns the value at the given internal index.
- `isEmpty(self)` - Returns `true` if the collection is empty.
- `equals(self, otherCollection)` - Compares two collections for equality by contents and size.

---

## DataSet

The `DataSet` class ensures each value exists only once, supporting set operations like union, intersection, and difference. Inherits from `Array`.

### Instance Methods
- `add(self, value)` - Adds a unique value to the dataset. Returns `true` if added, `false` if duplicate.
- `remove(self, value)` - Removes a value from the dataset.
- `get(self, index)` - Retrieves a value by its index.
- `find(self, value)` - Finds the index of a value in the dataset, or `nil` if not found.
- `union(self, dataSet)` - Returns a new `DataSet` containing all unique elements from both datasets.
- `intersection(self, dataSet)` - Returns a new `DataSet` containing elements common to both datasets.
- `difference(self, dataSet)` - Returns a new `DataSet` containing elements unique to each dataset (symmetric difference).
- `clear(self)` - Removes all values from the dataset.

---

## Field

The `Field` class is an abstract base class for managing a 2D array of values. It serves as a base class for `Matrix`.

### Instance Methods
- `set(self, x, y, value)` - Sets a value at position `(x, y)` in the 2D array.
- `get(self, x, y)` - Gets a value at position `(x, y)` in the 2D array. Returns `nil` if unset.
- `clear(self)` - Clears the entire 2D array.

---

## Hashtable

The `Hashtable` class provides a key-value store with string keys.

### Instance Methods
- `size(self)` - Returns the number of key-value pairs in the hashtable.
- `clear(self)` - Clears all key-value pairs in the hashtable.
- `put(self, key, value)` - Adds or updates a key-value pair. Key must be a string.
- `get(self, key, default)` - Retrieves the value associated with a key. Returns `default` if the key is not found. Correctly returns falsy values like `false`.
- `remove(self, key)` - Removes a key-value pair from the hashtable by key.
- `containsKey(self, key)` - Checks if a given key exists in the hashtable.
- `containsValue(self, value)` - Checks if a given value exists in the hashtable.
- `isEmpty(self)` - Returns `true` if the hashtable has no entries.
- `copy(self)` - Returns a new hashtable that is a deep copy of this one.
- `merge(self, hashtable)` - Merges another hashtable into this one, overwriting existing keys.
- `getKeys(self, sort)` - Returns a `Classy.List` of all keys, optionally sorted.
- `getValues(self, sort)` - Returns a `Classy.List` of all values, optionally sorted.
- `equals(self, otherHashtable)` - Checks if two hashtables have the same key-value pairs.
- `forEach(self, func, errorHandler, ...)` - Iterates over each key-value pair, applying the given function.

---

## LinkedList

The `LinkedList` class implements a circular doubly-linked list.

### Class Methods
- `Classy.LinkedList.new(initializer)` - Creates a new LinkedList, optionally calling the initializer function.

### Instance Methods
- `add(self, value)` - Adds a new node with the specified value at the end.
- `insertAfter(self, refNode, value)` - Inserts a new node after the specified reference node. If `refNode` is `nil`, inserts at the end.
- `insertBefore(self, refNode, value)` - Inserts a new node before the specified reference node. If `refNode` is `nil`, inserts at the end.
- `remove(self, node)` - Removes the specified node from the linked list.
- `findFirst(self, value)` - Returns the first node that has the specified value, or `nil`.
- `findAll(self, value)` - Returns a table of all nodes with the specified value.
- `forEach(self, callback)` - Iterates over all nodes, calling `callback(node)` for each.
- `length(self)` - Returns the number of nodes in the list by traversal.
- `clear(self)` - Removes all nodes from the list.
- `toTable(self)` - Returns a plain Lua array of all node values.
- `firstNode(self)` - Returns the first node in the list.
- `lastNode(self)` - Returns the last node in the list.
- `first(self)` - Returns the value of the first node and starts forward iteration.
- `last(self)` - Returns the value of the last node and starts backward iteration.
- `current(self)` - Returns the value of the current iteration node.
- `currentNode(self)` - Returns the current iteration node.
- `next(self)` - Moves to and returns the value of the next node, or `nil` at the end.
- `previous(self)` - Moves to and returns the value of the previous node, or `nil` at the start.
- `stop(self)` - Stops iteration by clearing the current reference.

### Node Class
- `get(self)` - Returns the value of the node.
- `set(self, value)` - Sets the value of the node.

---

## List

The `List` class is an ordered list that allows duplicate values. Inherits from `Array`.

### Instance Methods
- `add(self, value)` - Appends a value to the list.
- `get(self, index)` - Returns the value at the given index, or the entire internal table if no index is provided.
- `remove(self, index)` - Removes the element at the given index.
- `merge(self, list)` - Appends all elements from another list (or any object with a `forEach` method).

Inherited from Array: `length`, `clone`, `copy`, `equals`, `sort`, `isEmpty`, `contains`, `forEach`, `map`.

---

## Math

The `Classy.Math` table provides mathematical utility functions. It inherits all standard Lua `math` functions and adds:

### Functions
- `Classy.Math.e()` - Returns Euler's number (2.71828...).
- `Classy.Math.relu(number)` - ReLU activation function. Returns `max(0, number)`.
- `Classy.Math.sigmoid(number)` - Sigmoid activation function. Returns `1 / (1 + e^(-number))`.
- `Classy.Math.round(num, n)` - Rounds `num` to `n` decimal places (default 0).

All standard `math` library functions (e.g., `math.sin`, `math.floor`, `math.sqrt`) are also available as `Classy.Math.sin`, etc.

---

## Matrix

The `Matrix` class provides operations for working with matrices, including addition, subtraction, multiplication, transposition, and inversion. Inherits from `Field`.

### Class Methods
- `Classy.Matrix.new(rows, cols, initialValue)` - Creates a new matrix, optionally initialized with dimensions and a fill value.

### Instance Methods
- `initialize(self, rows, cols, initialValue)` - Initializes the matrix with a specific size and initial value.
- `add(self, matrix)` - Adds another matrix to the current matrix. Matrices must have the same dimensions.
- `subtract(self, matrix)` - Subtracts another matrix from the current matrix. Matrices must have the same dimensions.
- `multiply(self, matrixOrScalar)` - Multiplies the current matrix by another matrix or a scalar.
- `transpose(self)` - Transposes the current matrix.
- `determinant(self)` - Calculates the determinant of the matrix (square matrices only). Supports 1x1, 2x2, and NxN via cofactor expansion.
- `getSubMatrix(self, row, col)` - Returns the sub-matrix after removing a specific row and column.
- `inverse(self)` - Calculates the inverse of the matrix (square, non-singular matrices only).
- `toString(self)` - Returns a string representation of the matrix.

Inherited from Field: `set`, `get`, `clear`.

---

## NeuralNetwork

The `NeuralNetwork` module provides a basic feedforward neural network with backpropagation.

### Neuron Class
- `Classy.NeuralNetwork.Neuron.new()` - Creates a new Neuron.
- `addConnection(self, neuron)` - Adds a connection to another neuron with a random weight.
- `activate(self, inputs)` - Computes the neuron's output using sigmoid activation.
- `adjustWeights(self, err)` - Adjusts weights based on the error signal and learning rate.
- `computeDelta(self)` - Computes the sigmoid derivative for backpropagation.
- `getOutput(self)` - Returns the neuron's current output.

### Layer Class
- `Classy.NeuralNetwork.Layer.new(neuronCount)` - Creates a new Layer with the specified number of neurons.
- `Classy.NeuralNetwork.Layer.join(inputLayer, outputLayer)` - Connects all neurons in the input layer to all neurons in the output layer.
- `join(self, outputLayer)` - Instance method to connect this layer to an output layer.
- `forwardPropagate(self, inputs)` - Feeds inputs through all neurons and returns outputs.
- `backwardPropagate(self, errors)` - Adjusts weights based on error signals and returns deltas.

### Network Class
- `Classy.NeuralNetwork.create(numInputs, numOutputs, hiddenLayers)` - Creates a fully connected network. `hiddenLayers` is a table of neuron counts, e.g., `{3, 3}`.
- `forwardPropagate(self, inputs)` - Feeds inputs through all layers.
- `backwardPropagate(self, desiredOutputs)` - Performs backpropagation from desired outputs.
- `getOutputs(self)` - Returns the network's output values.
- `setInputs(self, ...)` - Sets the input values.
- `computeCostDifference(self, desiredOutputs)` - Computes the error between actual and desired outputs.

### Example Usage

```lua
-- Create a 2-input, 1-output network with two hidden layers of 3 neurons each
local nn = Classy.NeuralNetwork.create(2, 1, {3, 3})

-- Train on XOR data
local trainingData = {
    {{0, 0}, {0}},
    {{0, 1}, {1}},
    {{1, 0}, {1}},
    {{1, 1}, {0}}
}

for epoch = 1, 10000 do
    for _, data in ipairs(trainingData) do
        nn:forwardPropagate(data[1])
        nn:backwardPropagate(data[2])
    end
end

-- Test
nn:forwardPropagate({1, 0})
print(nn:getOutputs()[1])  -- Should be close to 1
```

---

## Observable

The `Observable` class allows for observing changes to a value, notifying subscribed listeners when the value changes.

### Instance Methods
- `get(self)` - Returns the current value of the Observable.
- `set(self, value)` - Sets a new value for the Observable and notifies listeners if the value has changed.
- `subscribe(self, func)` - Subscribes a function to the Observable's value changes.
- `unsubscribe(self, func)` - Unsubscribes a function from the Observable's value changes.
- `invokeValueChanged(self, newValue)` - Invokes all subscribed listeners when the value changes.
- `invokeErrorHandler(self, err)` - Default error handler for listener invocation errors. Prints the error message.

---

## Queue

The `Queue` class implements a basic first-in, first-out (FIFO) queue.

### Instance Methods
- `enqueue(self, arg)` - Adds an element to the queue.
- `dequeue(self)` - Removes and returns the next element from the queue. Errors if empty.
- `peek(self)` - Returns the next element in the queue without removing it, or `nil` if empty.
- `isEmpty(self)` - Returns `true` if the queue is empty.
- `size(self)` - Returns the number of elements in the queue.

---

## Stack

The `Stack` class implements a basic last-in, first-out (LIFO) stack.

### Instance Methods
- `push(self, arg)` - Pushes an element onto the stack.
- `pop(self)` - Pops and returns the top element from the stack. Errors if empty.
- `peek(self)` - Returns the top element of the stack without removing it, or `nil` if empty.
- `reset(self)` - Resets the stack to its initial empty state.
- `isEmpty(self)` - Returns `true` if the stack is empty.
- `size(self)` - Returns the number of elements in the stack.

---

## Tree

The `Tree` class represents a general tree structure where each node can have multiple children (stored as a LinkedList).

### Class Methods
- `Classy.Tree.new(rootValue)` - Creates a new Tree with the given root value.

### Instance Methods
- `getRoot(self)` - Returns the root node of the tree.
- `depthFirstSearch(self, visit)` - Traverses the tree using a depth-first search (DFS) approach.
- `breadthFirstSearch(self, visit)` - Traverses the tree using a breadth-first search (BFS) approach.

### Node Class
- `get(self, child)` - Gets the children LinkedList, or finds specific children if a value is provided.
- `add(self, child)` - Adds a child node (or value) to the current node.
- `delete(self, child)` - Deletes a child node from the current node.
- `getValue(self)` - Returns the value of the node (stored as an Observable).
- `setValue(self, value)` - Sets a new value for the node.

---

## Vector

The `Vector` class represents a mathematical vector and provides methods for common vector operations such as addition, subtraction, dot product, scalar multiplication, and normalization.

### Instance Methods

- `dimension(self)` - Returns the dimension (length) of the vector.
- `add(self, other)` - Adds another vector to this vector. The vectors must have the same dimension.
- `subtract(self, other)` - Subtracts another vector from this vector. The vectors must have the same dimension.
- `multiplyByScalar(self, scalar)` - Multiplies this vector by a scalar value.
- `dotProduct(self, other)` - Computes the dot product of this vector and another vector. The vectors must have the same dimension.
- `magnitude(self)` - Computes the magnitude (length) of the vector.
- `normalize(self)` - Normalizes the vector, making it a unit vector. Errors on zero vectors.
- `addElement(self, value)` - Appends an element to the vector.
- `getElement(self, index)` - Retrieves the value at a specific index.
- `toString(self)` - Converts the vector to a string for easy printing and debugging.

### Example Usage

```lua
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

-- Add the vectors
local sum = vec1:add(vec2)
print("Sum: " .. sum:toString())  -- Output: Sum: {5, 7, 9}

-- Subtract the vectors
local difference = vec1:subtract(vec2)
print("Difference: " .. difference:toString())  -- Output: Difference: {-3, -3, -3}

-- Dot product of the vectors
local dot = vec1:dotProduct(vec2)
print("Dot Product: " .. dot)  -- Output: Dot Product: 32

-- Magnitude of a vector
local magnitude = vec1:magnitude()
print("Magnitude of vec1: " .. magnitude)  -- Output: Magnitude of vec1: 3.7416573867739

-- Normalize the vector
local normalizedVec = vec1:normalize()
print("Normalized vec1: " .. normalizedVec:toString())  -- Output: Normalized vec1: {0.26726124191242, 0.53452248382485, 0.80178372573727}
```

---

## License

This library is open-source and licensed under the MIT License. Feel free to use, modify, and distribute it as needed.

---

## Contributions

Contributions are welcome! Please fork this repository and submit a pull request with your changes. Be sure to add tests and documentation for any new features or bug fixes.
