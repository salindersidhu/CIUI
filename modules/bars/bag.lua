local _, L = ...

-- CREATE FRAMES
local BagModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES
BagModule:RegisterEvent("ADDON_LOADED")

-- EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        MicroButtonAndBagsBar:Hide()
    end
end

-- SET FRAME SCRIPTS
BagModule:SetScript("OnEvent", EventHandler)
