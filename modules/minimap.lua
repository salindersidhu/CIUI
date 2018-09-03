MinimapModule = classes.class(Module)

local function mapOnMouseWheel(self, delta)
    if delta > 0 then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut()
    end
end

local function modifymap()
    -- Hide Minimap zoom buttons
    MinimapZoomIn:Hide()
    MinimapZoomOut:Hide()

    -- Enable zoom in and out with the mouse wheel
    Minimap:EnableMouseWheel(true)
    Minimap:SetScript("OnMouseWheel", mapOnMouseWheel)
end

function MinimapModule:init()
    self.super:init()
    self:addEvent("ADDON_LOADED")
end

function MinimapModule:eventHandler(event, ...)
    if event == "ADDON_LOADED" then
        modifymap()
    end
end
