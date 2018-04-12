local _, L = ...

-- Basic Constants
ADDON_ID = 'CleanExtUI'
ADDON_PATH = 'Interface\\Addons\\'..ADDON_ID
ADDON_VERSION = GetAddOnMetadata(ADDON_ID, 'Version')

-- Fonts
CHAT_FONT = ADDON_PATH..'\\media\\Tahoma.ttf'

-- UI Textures
UI_FRAME_TARGET = ADDON_PATH..'\\media\\UI-TargetingFrame'
UI_FRAME_TARGET_RARE = ADDON_PATH..'\\media\\UI-TargetingFrame-Rare'
UI_FRAME_TARGET_ELITE = ADDON_PATH..'\\media\\UI-TargetingFrame-Elite'
UI_FRAME_TARGET_FLASH = 'Interface\\TargetingFrame\\UI-TargetingFrame-Flash'
UI_FRAME_TARGET_RARE_ELITE = ADDON_PATH..'\\media\\UI-TargetingFrame-Rare-Elite'

UI_FRAME_PLAYER_STATUS = ADDON_PATH..'\\media\\UI-StatusBar'

