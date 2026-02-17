# Makefile for Lua Classy Library

# Variables
LUA_VERSION = 5.4.7
LUA_TAR = lua-$(LUA_VERSION).tar.gz
LUA_URL = https://www.lua.org/ftp/$(LUA_TAR)
LUA_SRC_DIR = lua-$(LUA_VERSION)
OUT_DIR = out
OUTFILE = $(OUT_DIR)/classy.bundle.lua
OUTFILE_TESTS = $(OUT_DIR)/classy.bundle.tests.lua
OUTFILE_NEURAL = $(OUT_DIR)/neural-network.lua
FILES = src/Init.lua src/Array.lua src/BinaryTree.lua src/Collection.lua src/DataSet.lua src/Field.lua src/Hashtable.lua src/List.lua src/LinkedList.lua src/Math.lua src/Matrix.lua src/Observable.lua src/Queue.lua src/Stack.lua src/Tree.lua src/Vector.lua
LUAUNIT = src/luaunit.lua
UNIT_TESTS = src/UnitTests.lua
NEURAL_NETWORK = src/NeuralNetwork/NeuralNetwork.lua
LUA_BINARY = lua

# Default target
.PHONY: default
default: bundle bundle-with-tests bundle-neural

# Target to bundle all source files into a single Lua file without tests
.PHONY: bundle
bundle:
	@echo "Bundling source files into $(OUTFILE)..."
	mkdir -p $(OUT_DIR)
	> $(OUTFILE)
	for file in $(FILES); do \
		cat $$file >> $(OUTFILE); \
		echo "\n\n" >> $(OUTFILE); \
	done
	@echo "Bundling complete.\n"

# Target to bundle all source files into a single Lua file with tests
.PHONY: bundle-with-tests
bundle-with-tests:
	@echo "Bundling source files and UnitTests.lua into $(OUTFILE_TESTS)..."
	mkdir -p $(OUT_DIR)
	> $(OUTFILE_TESTS)
	for file in $(FILES); do \
		cat $$file >> $(OUTFILE_TESTS); \
		echo "\n\n" >> $(OUTFILE_TESTS); \
	done
	# Append luaunit.lua wrapped so it sets a global
	echo "\n-- luaunit start\nlocal function _load_luaunit()\n" >> $(OUTFILE_TESTS)
	cat $(LUAUNIT) >> $(OUTFILE_TESTS)
	echo "\nend\nlu = _load_luaunit()\n-- luaunit end\n\n" >> $(OUTFILE_TESTS)
	# Append UnitTests.lua
	echo "Appending UnitTests.lua..."
	cat $(UNIT_TESTS) >> $(OUTFILE_TESTS)
	echo "\n\n" >> $(OUTFILE_TESTS)
	@echo "Bundling with UnitTests.lua complete.\n"

# Target to bundle all source files with NeuralNetwork.lua
.PHONY: bundle-neural
bundle-neural: bundle
	@echo "Bundling source files and NeuralNetwork.lua into $(OUTFILE_NEURAL)..."
	cp $(OUTFILE) $(OUTFILE_NEURAL)
	cat $(NEURAL_NETWORK) >> $(OUTFILE_NEURAL)
	@echo "Bundling of NeuralNetwork.lua complete.\n"

# Target to build Lua only if the binary doesn't exist
$(LUA_BINARY):
	@if [ ! -f $(LUA_BINARY) ]; then \
		echo "Building Lua from source..."; \
		curl -L $(LUA_URL) | tar -xz; \
		cd $(LUA_SRC_DIR) && make all test && cp src/lua ../$(LUA_BINARY); \
		cd .. && rm -rf $(LUA_SRC_DIR); \
		echo "Lua binary is ready."; \
	else \
		echo "Lua binary already exists, skipping build."; \
	fi

# Perform both Lua installation and bundling
.PHONY: all
all: $(LUA_BINARY) bundle bundle-with-tests

# Target to clean up Lua source directory and binary
.PHONY: clean-lua
clean-lua:
	rm -rf $(LUA_SRC_DIR) $(LUA_BINARY)

# Target to clean up the output directory
.PHONY: clean
clean:
	rm -rf $(OUT_DIR)

# Target to clean all
.PHONY: clean-all
clean-all: clean clean-lua

