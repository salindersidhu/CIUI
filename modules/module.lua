Module = Classes.Class()

local numModules = 1

function Module:Init(name)
    self.id = numModules
    self.name = name

    numModules = numModules + 1
end

function Module:GetModuleId()
    return "Module<"..self.id..","..self.name..">"
end

function Module:GetEvents()
    error("Generic Method. This should be implemented by a subclass of Module!")
end

function Module:GetEventHandler()
    error("Generic Method. This should be implemented by a subclass of Module!")
end
