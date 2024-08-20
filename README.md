# Classy Library Documentation

Welcome to the Classy Library! This library provides a collection of data structures and utilities, implemented in Lua, to facilitate complex programming tasks. Below, you'll find detailed documentation on each class, including its instance methods and class-level "static" methods.

## Table of Contents
- [Array](#array)
- [BinaryTree](#binarytree)
- [Collection](#collection)
- [DataSet](#dataset)
- [Field](#field)
- [Hashtable](#hashtable)
- [LinkedList](#linkedlist)
- [Matrix](#matrix)
- [Observable](#observable)
- [Queue](#queue)
- [Stack](#stack)
- [Tree](#tree)

---

## Array

The `Array` class provides methods to work with arrays, including sorting, cloning, and performing operations like map and forEach.

### Instance Methods
- `length(self)` - Returns the number of elements in the array.
- `clone(self)` - Returns a simple copy of the internal array.
- `copy(self)` - Returns a new instance of `Classy.Array` containing a copy of the internal data.
- `equals(self, arrayClass)` - Compares two arrays for equality.
- `sort(self, compareFunction)` - Sorts the array using an optional comparison function.
- `isEmpty(self)` - Returns `true` if the array is empty.
- `contains(self, value)` - Checks if the array contains a specific value.
- `forEach(self, func, errorHandler, ...)` - Iterates over each element, invoking the provided function.
- `map(self, handler, ...)` - Returns a new array with the results of applying the handler function to each element.

---

## BinaryTree

The `BinaryTree` class implements a binary tree structure, supporting basic operations like insertion, searching, and traversals.

### Instance Methods
- `getRoot(self)` - Returns the root node of the binary tree.
- `insert(self, value)` - Inserts a value into the binary tree.
- `find(self, value)` - Finds and returns a node with the specified value.
- `inOrderTraversal(self, visit)` - Performs an in-order traversal of the tree.
- `preOrderTraversal(self, visit)` - Performs a pre-order traversal of the tree.
- `postOrderTraversal(self, visit)` - Performs a post-order traversal of the tree.

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

The `Collection` class provides a double-ended queue (deque) functionality, allowing elements to be added or removed from both ends.

### Instance Methods
- `reset(self)` - Resets the collection to its initial empty state.
- `pushleft(self, value)` - Adds an element to the front of the collection.
- `pushright(self, value)` - Adds an element to the end of the collection.
- `popleft(self)` - Removes and returns the element from the front of the collection.
- `popright(self)` - Removes and returns the element from the end of the collection.
- `isEmpty(self)` - Returns `true` if the collection is empty.

---

## DataSet

The `DataSet` class ensures each value exists only once, supporting set operations like union, intersection, and difference.

### Instance Methods
- `add(self, value)` - Adds a unique value to the dataset.
- `remove(self, value)` - Removes a value from the dataset.
- `get(self, index)` - Retrieves a value by its index.
- `find(self, value)` - Finds the index of a value in the dataset.
- `union(self, dataSet)` - Returns a new `DataSet` containing all unique elements from both datasets.
- `intersection(self, dataSet)` - Returns a new `DataSet` containing elements common to both datasets.
- `difference(self, dataSet)` - Returns a new `DataSet` containing elements unique to each dataset.

---

## Field

The `Field` class is an abstract base class for managing a 2D array of values.

### Instance Methods
- `set(self, x, y, value)` - Sets a value at position `(x, y)` in the 2D array.
- `get(self, x, y)` - Gets a value at position `(x, y)` in the 2D array.
- `clear(self)` - Clears the entire 2D array.

---

## Hashtable

The `Hashtable` class provides a key-value store with unique keys.

### Instance Methods
- `size(self)` - Returns the number of key-value pairs in the hashtable.
- `clear(self)` - Clears all key-value pairs in the hashtable.
- `put(self, key, value)` - Adds or updates a key-value pair in the hashtable.
- `get(self, key, default)` - Retrieves the value associated with a key.
- `remove(self, key)` - Removes a key-value pair from the hashtable by key.
- `containsKey(self, key)` - Checks if a given key exists in the hashtable.
- `containsValue(self, value)` - Checks if a given value exists in the hashtable.
- `getKeys(self, sort)` - Returns a list of all keys in the hashtable, optionally sorted.
- `getValues(self, sort)` - Returns a list of all values in the hashtable, optionally sorted.
- `equals(self, otherHashtable)` - Checks if two hashtables are equal.
- `forEach(self, func, errorHandler, ...)` - Iterates over each key-value pair, applying the given function.

---

## LinkedList

The `LinkedList` class implements a circular doubly-linked list.

### Instance Methods
- `add(self, value)` - Adds a new node with the specified value.
- `insertAfter(self, refNode, value)` - Inserts a new node after the specified reference node.
- `insertBefore(self, refNode, value)` - Inserts a new node before the specified reference node.
- `remove(self, node)` - Removes the specified node from the linked list.
- `findFirst(self, value)` - Returns the first node that has the specified value.
- `findAll(self, value)` - Returns all nodes with the specified value.
- `firstNode(self)` - Returns the first node in the list.
- `lastNode(self)` - Returns the last node in the list.
- `first(self)` - Returns the value of the first node in the list.
- `last(self)` - Returns the value of the last node in the list.
- `current(self)` - Returns the value of the current node in the list.
- `next(self)` - Moves to and returns the value of the next node in the list.
- `previous(self)` - Moves to and returns the value of the previous node in the list.
- `stop(self)` - Stops iteration over the list.

### Node Class
- `get(self)` - Returns the value of the node.
- `set(self, value)` - Sets the value of the node.
- `getChildren(self)` - Returns the left and right children of the node.
- `setChildren(self, leftChild, rightChild)` - Sets the left and right children of the node.

---

## Matrix

The `Matrix` class provides operations for working with matrices, including addition, subtraction, multiplication, transposition, and inversion.

### Instance Methods
- `initialize(self, rows, cols, initialValue)` - Initializes the matrix with a specific size and initial value.
- `add(self, matrix)` - Adds another matrix to the current matrix.
- `subtract(self, matrix)` - Subtracts another matrix from the current matrix.
- `multiply(self, matrixOrScalar)` - Multiplies the current matrix by another matrix or a scalar.
- `transpose(self)` - Transposes the current matrix.
- `determinant(self)` - Calculates the determinant of the matrix (only for square matrices).
- `inverse(self)` - Calculates the inverse of the matrix (only for square matrices).
- `toString(self)` - Returns a string representation of the matrix.

---

## Observable

The `Observable` class allows for observing changes to a value, notifying subscribed listeners when the value changes.

### Instance Methods
- `get(self)` - Returns the current value of the Observable.
- `set(self, value)` - Sets a new value for the Observable and notifies listeners if the value has changed.
- `subscribe(self, func)` - Subscribes a function to the Observable's value changes.
- `unsubscribe(self, func)` - Unsubscribes a function from the Observable's value changes.
- `invokeValueChanged(self, newValue)` - Invokes all subscribed listeners when the value changes.
- `invokeErrorHandler(err)` - Default error handler for listener invocation errors.

---

## Queue

The `Queue` class implements a basic first-in, first-out (FIFO) queue.

### Instance Methods
- `enqueue(self, arg)` - Adds an element to the queue.
- `dequeue(self)` - Removes and returns the next element from the queue.
- `peek(self)` - Peeks at the next element in the queue without removing it.
- `isEmpty(self)` - Returns `true` if the queue is empty.
- `size(self)` - Returns the number of elements in the queue.

---

## Stack

The `Stack` class implements a basic last-in, first-out (LIFO) stack.

### Instance Methods
- `push(self, arg)` - Pushes an element onto the stack.
- `pop(self)` - Pops and returns the top element from the stack.
- `peek(self)` - Peeks at the top element of the stack without removing it.
- `reset(self)` - Resets the stack to its initial empty state.
- `isEmpty(self)` - Returns `true` if the stack is empty.
- `size(self)` - Returns the number of elements in the stack.

---

## Tree

The `Tree` class represents a tree structure where each node can have multiple children.

### Instance Methods
- `getRoot(self)` - Returns the root node of the tree.
- `depthFirstSearch(self, visit)` - Traverses the tree using a depth-first search (DFS) approach.
- `breadthFirstSearch(self, visit)` - Traverses the tree using a breadth-first search (BFS) approach.

### Node Class
- `get(self, child)` - Gets the children of the node, or finds specific children if a value is provided.
- `add(self, child)` - Adds a child node to the current node.
- `delete(self, child)` - Deletes a child node from the current node.
- `getValue(self)` - Returns the value of the node.
- `setValue(self, value)` - Sets a new value for the node.

---

## License

This library is open-source and licensed under the MIT License. Feel free to use, modify, and distribute it as needed.

---

## Contributions

Contributions are welcome! Please fork this repository and submit a pull request with your changes. Be sure to add tests and documentation for any new features or bug fixes.

