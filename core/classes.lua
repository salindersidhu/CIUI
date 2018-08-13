--[[--
classes.lua

Enables simple OOP constructs using prototypes and metatables. Original code
by Paul Moore, adapted from https://gist.github.com/paulmoore/1429475

Copyright (c) 2018 Salinder Sidhu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
    
The above copyright notice and this permission notice shall be included in 
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

classes = {}

-- Baseclass of all class objects.
classes.Object = {}
classes.Object.class = classes.Object

-- Nullary constructor.
function classes.Object:init(...)
end

-- Baseclass alloc method.
-- @param roottable The 'root' of the inheritance tree.
-- @return The instance with the allocated inheritance tree.
function classes.Object.alloc(roottable)
    return setmetatable({}, {__index = classes.Object, __newindex = roottable})
end

-- Baseclass new method.
-- @return A new instance of this baseclass.
function classes.Object.new(...)
    return classes.Object.alloc({}):init(...)
end

-- Create a new class.
-- @param baseclass The Baseclass of this class.
-- @return A new class reference.
function classes.class(baseclass)
    local classdef = {}
    baseclass = baseclass or classes.Object
    setmetatable(classdef, {__index = baseclass})
    classdef.class = classdef

    -- Recursivly allocate the inheritance tree of the instance.
    -- @param roottable The 'root' of the inheritance tree.
    -- @return The instance with the allocated inheritance tree.
    function classdef.alloc(roottable)
        local instance = {super = baseclass.alloc(roottable)}
        setmetatable(instance, {__index = classdef, __newindex = roottable})
        return instance
    end

    -- Construct a new instance from this class definition.
    -- @return A new instance of this class.
    function classdef.new(...)
        local instance = {}
        instance.super = baseclass.alloc(instance)
        setmetatable(instance, {__index = classdef})
        instance:init(...)
        return instance
    end

    return classdef
end
