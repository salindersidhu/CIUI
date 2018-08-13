Module = classes.class()

local numModules = 0

local function isEmpty(a)
    return a == nil or #a == 0
end

local function verifyParam(p, pName, t)
    if isEmpty(p) then
        error("Required parameter '"..pName.."' is not specified!")
    end
    if type(p) ~= t then
        error("Required parameter '"..pName.."' is not of type '"..t.."'!")
    end
end

local function verifyVar(v, vName)
    if isEmpty(v) then
        error("Cannot return value of '"..vName.."' variable is not specified!")
    end
end

function Module:init(name)
    verifyParam(name, "name", "string")
    numModules = numModules + 1

    self.events = {}
    self.id = numModules
    self.name = name
end

function Module:getModuleId()
    return "Module<id:"..self.id..",name:"..self.name..">"
end

function Module:addEvent(event)
    verifyParam(event, "event", "string")
    table.insert(self.events, event)
end

function Module:setEvents(events)
    verifyParam(events, "events", "table")
    self.events = events
end

function Module:getEvents()
    verifyVar(self.events, "self.events")
    return self.events
end

function Module:getEventHandler()
    error("Generic Method. This should be implemented by a subclass of Module!")
end
