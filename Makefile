# Makefile for Lua Classy Library

# Variables
LUA_VERSION = 5.4.7
LUA_TAR = lua-$(LUA_VERSION).tar.gz
LUA_URL = https://www.lua.org/ftp/$(LUA_TAR)
LUA_SRC_DIR = lua-$(LUA_VERSION)
OUT_DIR = out
OUTFILE = $(OUT_DIR)/classy.bundle.lua
FILES = src/Init.lua src/Array.lua src/BinaryTree.lua src/Collection.lua src/DataSet.lua src/Field.lua src/Hashtable.lua src/List.lua src/LinkedList.lua src/Math.lua src/Matrix.lua src/Observable.lua src/Queue.lua src/Stack.lua src/Tree.lua src/Vector.lua
LUA_BINARY = lua

# Target to perform both Lua installation and bundling
.PHONY: all
all: $(LUA_BINARY)
	@$(MAKE) bundle

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

# Target to clean up Lua source directory and binary
.PHONY: clean-lua
clean-lua:
	rm -rf $(LUA_SRC_DIR) $(LUA_BINARY)

# Target to bundle all source files into a single Lua file
.PHONY: bundle
bundle:
	@echo "Bundling source files into $(OUTFILE)..."
	mkdir -p $(OUT_DIR)
	> $(OUTFILE)
	for file in $(FILES); do \
		echo "Processing $$file..."; \
		cat $$file >> $(OUTFILE); \
		echo "\n\n" >> $(OUTFILE); \
	done
	@echo "Bundling complete."

# Target to clean up the output directory
.PHONY: clean
clean:
	rm -rf $(OUT_DIR)
