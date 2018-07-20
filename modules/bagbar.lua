local _, L = ...

-- CREATE FRAMES
local BagBarModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES
BagBarModule:RegisterEvent("ADDON_LOADED")

-- EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        MicroButtonAndBagsBar:Hide()
        --Utils.ModifyFrameFixed(MainMenuBarBackpackButton, 'BOTTOMRIGHT', UIParent, -1, -300, nil)
    end
end

-- SET FRAME SCRIPTS
BagBarModule:SetScript("OnEvent", EventHandler)
