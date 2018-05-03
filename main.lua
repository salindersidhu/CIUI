local _, L = ...

-- CONSTANTS
ADDON_NAME = "CleanExtUI"
ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, "Version")

FONT_CHAT = "Interface\\Addons\\CleanExtUI\\media\\Tahoma.ttf"

TEXTURE_UI_FRAME_TARGET = "Interface\\Addons\\CleanExtUI\\media\\UI-TargetingFrame"
TEXTURE_UI_FRAME_TARGET_RARE = "Interface\\Addons\\CleanExtUI\\media\\UI-TargetingFrame-Rare"
TEXTURE_UI_FRAME_TARGET_ELITE = "Interface\\Addons\\CleanExtUI\\media\\UI-TargetingFrame-Elite"
TEXTURE_UI_FRAME_TARGET_RARE_ELITE = "Interface\\Addons\\CleanExtUI\\media\\UI-TargetingFrame-Rare-Elite"

-- UNIVERSAL FRAMES AND FUNCTIONS
Utils = CreateFrame("Frame")
HiddenFrame = CreateFrame("Frame", nil)
HiddenFrame:Hide()

function Utils.ModifyFrame(frame, anchor, parent, x, y, scale)
    -- Clear all previous points
    frame:ClearAllPoints()
    -- Set frame position
    if parent == nil then
        frame:SetPoint(anchor, x, y)
    else
        frame:SetPoint(anchor, parent, x, y)
    end
    -- Set frame scale
    if scale ~= nil then
        frame:SetScale(scale)
    end
end

function Utils.ModifyFrameFixed(frame, anchor, parent, x, y, scale)
    -- Enable the frame to be moved
    frame:SetMovable(true)
    -- Modify frame
    Utils.ModifyFrame(frame, anchor, parent, x, y, scale)
    -- Configure and lock the frame
    frame:SetUserPlaced(true)
    frame:SetMovable(false)
end

function Utils.ModifyUnitFrame(frame, x, y, scale)
    Utils.ModifyFrameFixed(frame, "CENTER", nil, x, y, scale)
end
