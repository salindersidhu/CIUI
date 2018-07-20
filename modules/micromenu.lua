local _, L = ...

-- CREATE FRAMES
local MicroMenuModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES
MicroMenuModule:RegisterEvent("ADDON_LOADED")

local function Hook_MoveMicroButtons(a, aT, rT, x, y, stacked)
    if HasOverrideActionBar() or HasVehicleActionBar() then
        MoveMicroButtons(rT, aT, rT, x, y, stacked)
    else
        MoveMicroButtons("BOTTOMLEFT", MicroButtonAndBagsBar, "BOTTOMLEFT", 12, -1, false)
    end
end

-- EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        MoveMicroButtons("BOTTOMLEFT", MicroButtonAndBagsBar, "BOTTOMLEFT", 12, -1, false)
    end
end

-- SET FRAME SCRIPTS
MicroMenuModule:SetScript("OnEvent", EventHandler)

-- HOOK SECURE FUNCTIONS
hooksecurefunc("MoveMicroButtons", Hook_MoveMicroButtons)
