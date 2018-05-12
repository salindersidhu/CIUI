local _, L = ...

-- CREATE FRAMES --
local MapModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES --
MapModule:RegisterEvent("PLAYER_ENTERING_WORLD")

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
    if event == "PLAYER_ENTERING_WORLD" then
        ModifyMinimap()
    end
end

-- SET FRAME SCRIPTS
MapModule:SetScript("OnEvent", EventHandler)
