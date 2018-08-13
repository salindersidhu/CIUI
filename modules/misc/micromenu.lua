local function Hook_MoveMicroButtons(a, aT, rT, x, y, stacked)
    if HasOverrideActionBar() or HasVehicleActionBar() then
        MoveMicroButtons(rT, aT, rT, x, y, stacked)
    else
        MoveMicroButtons("BOTTOMLEFT", MicroButtonAndBagsBar, "BOTTOMLEFT", 12, -1, false)
    end
end

hooksecurefunc("MoveMicroButtons", Hook_MoveMicroButtons)

MicroMenuModule = Classes.Class(Module)

function MicroMenuModule:Init()
    self.super:Init("MicroMenu")
end

function MicroMenuModule:GetEvents()
    return {"PLAYER_ENTERING_WORLD"}
end

function MicroMenuModule:GetEventHandler()
    return function (self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            MoveMicroButtons("BOTTOMLEFT", MicroButtonAndBagsBar, "BOTTOMLEFT", 12, -1, false)
        end
    end
end
