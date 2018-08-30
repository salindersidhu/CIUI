BagBarModule = classes.class(Module)

function BagBarModule:init()
    self.super:init("BagBar")
    self:addEvent("ADDON_LOADED")
end

function BagBarModule:eventHandler(event, ...)
    if event == "ADDON_LOADED" then
        MicroButtonAndBagsBar:Hide()
    end
end
