BagModule = Classes.Class(Module)

function BagModule:Init()
    self.super:Init("BagBar")
end

function BagModule:GetEvents()
    return {"ADDON_LOADED"}
end

function BagModule:GetEventHandler()
    return function (self, event, ...)
        if event == "ADDON_LOADED" then
            MicroButtonAndBagsBar:Hide()
        end
    end
end
