#!/bin/bash

# This script is used to bundle the source code into a single lua file
# for distribution. It is not used in the normal operation of the
# program.

# The output file
OUTFILE=out/classy.bundle.lua

# The source files
# FILES="src/Init.lua src/Array.lua src/BinaryTree.lua src/Collection.lua src/DataSet.lua src/Field.lua src/Hashtable.lua src/List.lua src/LinkedList.lua src/Math.lua src/Matrix.lua src/Observable.lua src/Queue.lua src/Stack.lua src/Tree.lua src/Vector.lua"
FILES="src/Init.lua src/Array.lua src/BinaryTree.lua src/Collection.lua src/DataSet.lua src/Field.lua src/List.lua src/Hashtable.lua src/LinkedList.lua src/Math.lua src/Matrix.lua src/Observable.lua src/Queue.lua src/Stack.lua src/Tree.lua src/Vector.lua src/UnitTests.lua"

# Create output folder if it doesn't exist
mkdir -p out

# Clear the output file if it exists
> $OUTFILE

# Concatenate the files with two newlines after each
for file in $FILES; do
    cat "$file" >> "$OUTFILE"
    echo -e "\n\n" >> "$OUTFILE"
done
