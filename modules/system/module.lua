Module = classes.class()

local numModules = 0

function Module:init(name)
    if Utils.isEmpty(name) then
        error("Required parameter 'name' is not specified!")
    end
    if Utils.isNotType(name, "string") then
        error("Required parameter 'name' is not of type 'string'!")
    end
    numModules = numModules + 1

    self.events = {}
    self.id = numModules
    self.name = name
end

function Module:getModuleId()
    return "Module<id:"..self.id..",name:"..self.name..">"
end

function Module:addEvent(event)
    if Utils.isEmpty(event) then
        error("Required parameter 'event' is not specified!")
    end
    if Utils.isNotType(event, "string") then
        error("Required parameter 'event' is not of type 'string'!")
    end
    table.insert(self.events, event)
end

function Module:setEvents(events)
    if Utils.isEmpty(events) then
        error("Required parameter 'events' is not specified!")
    end
    if Utils.isNotType(events, "table") then
        error("Required parameter 'events' is not of type 'table'!")
    end
    self.events = events
end

function Module:getEvents()
    if Utils.isEmpty(self.events) then
        error("Cannot return value of 'self.events' variable is not specified!")
    end
    return self.events
end

function Module:getEventHandler()
    error("Generic Method. This should be implemented by a subclass of Module!")
end
