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

MinimapModule = Classes.Class(Module)

function MinimapModule:Init()
    self.super:Init("MiniMap")
end

function MinimapModule:GetEvents()
    return {"ADDON_LOADED"}
end

function MinimapModule:GetEventHandler()
    return function (self, event, ...)
        if event == "ADDON_LOADED" then
            ModifyMinimap()
        end
    end
end
