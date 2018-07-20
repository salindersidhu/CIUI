local _, L = ...

-- CREATE FRAMES
local MinimapModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES
MinimapModule:RegisterEvent("ADDON_LOADED")

local function Minimap_OnMouseWheel(self, delta)
    if delta > 0 then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut()
    end
end

local function ModifyMinimap()
    -- Hide Minimap zoom buttons
    MinimapZoomIn:Hide()
    MinimapZoomOut:Hide()

    -- Enable zoom in and out with the mouse wheel
    Minimap:EnableMouseWheel(true)
    Minimap:SetScript("OnMouseWheel", Minimap_OnMouseWheel)
end

-- CHAT FRAME EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        ModifyMinimap()
    end
end

-- SET FRAME SCRIPTS
MinimapModule:SetScript("OnEvent", EventHandler)
