Classy = { }

-- Usage: Classy.NoOp(), could be used to send an "ignore" error handler 
-- Use when you want to supply a function that does nothing as an argument
Classy.NoOp = function() end

--
-- Used to merge tables
--
local function tableMerge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1;
end

local function _copy(object, lookup_table)
    lookup_table = lookup_table or {}
    if type(object) ~= "table" then
        return object
    elseif lookup_table[object] then
        return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for index, value in pairs(object) do
        new_table[_copy(index, lookup_table)] = _copy(value, lookup_table)
    end
    return setmetatable(new_table, getmetatable(object))
end

-- This is used to check if a value is iterable
function Classy.isIterable(val)
    if type(val) == 'table' then return true end
    local mt = getmetatable(val)
    return mt and (mt.__pairs or mt.__ipairs) ~= nil
end

function Classy.clone(object)
    return _copy(object)
end

-- This is used to copy all the objects in src to dest
function Classy.inheritFrom(src, dest)
    for k,v in pairs(src) do
        if type(v) == "table" then
            if type(dest[k] or false) == "table" then
                Classy.inheritFrom(dest[k] or {}, src[k] or {})
            else
                dest[k] = v
            end
        else
            dest[k] = v
        end
    end
    return dest;    
end

--
-- This is the beast that creates instances of a table, creating the feel of a class. I know
-- there are other ways to do this, but this way looks nice and works great. It's the core of Classy.
--
function Classy.createInstance(classProtoType, initializer, existingData)
    local object, lookup_table = _copy(classProtoType);
    if (existingData) then
        object = tableMerge(object, existingData);
    end
    if (initializer and type(initializer) == "function") then
        if (object.constructor and type(object.constructor) == "function") then
            object:constructor(); -- base constructor
        end
        object.constructor = initializer; -- set the constructor
    end
    if (object.constructor and type(object.constructor) == "function") then
        object:constructor(); -- class constructor
        object.constructor = nil; -- single call only
    end
    object.new = nil; -- clear instancing method from the instanced object
    return object;
end

--
-- Checks if the object is a class or if an object is a specific class if className is specified
--
function Classy.isClass(object, className)
    if (not object or (className ~= nil and type(className) ~= "string")) then
        return false;
    end
    if (not className) then
        return (type(object) == "table" and object._className);
    end
    return (type(object) == "table" and object._className == className);
end


local split_str = function (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function Classy.getClass(className)
    if (type(className) ~= "string") then
        return nil;
    end
    if (not className:match(".")) then
        return _G[className];
    end
    local split = split_str(className, ".")
    local result = _G[split[1]];
    for i = 2, #split do
        result = result[split[i]];
    end
    return result;
end

function Classy.getClassName(object)
    if (type(object) == "table" and object._className) then
        return object._className;
    end
end

function Classy.unpack(t, i, n)
    i = i or 1
    n = n or #t
    if i <= n then
        return t[i], Classy.unpack(t, i + 1, n)
    end
end

-- Constructor for a class
function Classy.Class(proto)
    local class = { }
    class.prototype = proto
    class.new = function(initializer, existingData)
        return Classy.createInstance(class.prototype, initializer, existingData)
    end
    return class
end
