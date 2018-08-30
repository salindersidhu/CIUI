Module = classes.class()

local numModules = 0

local function isEmpty(value)
    return value == nil or #value == 0
end

local function isNotType(aParam, aType)
    return type(aParam) ~= aType
end

local function checkParam(aParam, aType)
    if isEmpty(aParam) then
        error("Required parameter is nil or does not exist!")
    end
    if isNotType(aParam, aType) then
        error("Required parameter 'name' is not of type '"..aType.."'!")
    end
end

local function checkVar(aVar)
    if isEmpty(aVar) then
        error("Cannot get value of requested variable, nil or does not exist!")
    end
end

function Module:init(name)
    checkParam(name, "string")
    numModules = numModules + 1
    self.events = {}
    self.id = numModules
    self.name = name
end

function Module:getModuleId()
    return "Module<id:"..self.id..",name:"..self.name..">"
end

function Module:addEvent(event)
    checkParam(event, "string")
    table.insert(self.events, event)
end

function Module:setEvents(events)
    checkParam(events, "table")
    self.events = events
end

function Module:getEvents()
    checkVar(self.events)
    return self.events
end

function Module:getEventHandler()
    return self.eventHandler
end

function Module:eventHandler(self, event, ...)
    error("Generic Method. This should be implemented by a subclass of Module!")
end
