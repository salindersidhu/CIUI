local _, L = ...

-- CONSTANTS
ADDON_ID = "CleanExtUI"
ADDON_PATH = "Interface\\Addons\\"..ADDON_ID
ADDON_VERSION = GetAddOnMetadata(ADDON_ID, "Version")

CHAT_FONT = ADDON_PATH.."\\media\\Tahoma.ttf"

UI_FRAME_TARGET = ADDON_PATH.."\\media\\UI-TargetingFrame"
UI_FRAME_TARGET_RARE = ADDON_PATH.."\\media\\UI-TargetingFrame-Rare"
UI_FRAME_TARGET_ELITE = ADDON_PATH.."\\media\\UI-TargetingFrame-Elite"
UI_FRAME_TARGET_FLASH = "Interface\\TargetingFrame\\UI-TargetingFrame-Flash"
UI_FRAME_TARGET_RARE_ELITE = ADDON_PATH.."\\media\\UI-TargetingFrame-Rare-Elite"
UI_FRAME_TARGET_MINUS = "Interface\\TargetingFrame\\UI-TargetingFrame-Minus"

UI_FRAME_PLAYER_STATUS = ADDON_PATH.."\\media\\UI-StatusBar"

-- UTILITY FUNCTIONS
Utils = CreateFrame("Frame", nil, UIParent)

function Utils.ModifyFrame(frame, anchor, parent, x, y, scale)
    frame:SetMovable(true)
    frame:ClearAllPoints()
    if parent == nil then
        frame:SetPoint(anchor, x, y)
    else
        frame:SetPoint(anchor, parent, x, y)
    end
    if scale ~= nil then
        frame:SetScale(scale)
    end
    frame:SetMovable(false)
end

function Utils.ModifyUnitFrame(frame, x, y, scale)
    Utils.ModifyFrame(frame, "CENTER", nil, x, y, scale)
end
