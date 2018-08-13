Classes = {}

Classes.Object = {}
Classes.Object.class = Classes.Object

function Classes.Object:Init(...)
end

function Classes.Object.Alloc(table)
    return setmetatable({}, {__index = Classes.Object, __newindex = table})
end

function Classes.Object.New(...)
    return Classes.Object.Alloc({}):Init(...)
end

function Classes.Class(base)
    local def = {}
    base = base or Classes.Object
    setmetatable(def, {__index = base})
    def.class = def

    function def.Alloc(table)
        local inst = {super = base.Alloc(table)}
        setmetatable(inst, {__index = def, __newindex = table})
        return inst
    end

    function def.New(...)
        local inst = {}
        inst.super = base.Alloc(inst)
        setmetatable(inst, {__index = def})
        inst:Init(...)
        return inst
    end

    return def
end
