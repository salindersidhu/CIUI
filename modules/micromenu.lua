local function hookmoveMicroButtons(a, aT, rT, x, y, stacked)
    if HasOverrideActionBar() or HasVehicleActionBar() then
        MoveMicroButtons(rT, aT, rT, x, y, stacked)
    else
        MoveMicroButtons("BOTTOMLEFT", MicroButtonAndBagsBar, "BOTTOMLEFT", 12, -1, false)
    end
end

hooksecurefunc("MoveMicroButtons", hookmoveMicroButtons)

MicroMenuModule = classes.class(Module)

function MicroMenuModule:init()
    self.super:init("MicroMenu")
    self:addEvent("PLAYER_ENTERING_WORLD")
end

function MicroMenuModule:eventHandler(event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        MoveMicroButtons("BOTTOMLEFT", MicroButtonAndBagsBar, "BOTTOMLEFT", 12, -1, false)
    end
end
