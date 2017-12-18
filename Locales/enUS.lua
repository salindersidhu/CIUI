local L = ImpHotKeyText

-- Skip if client locale is not English
if not(GetLocale() == "enUS") then
  return
end

-- English (DEFAULT)
L["STRING_BUTTON_DEFAULTS"] = "Defaults"
L["STRING_TITLE"] = "Improved Hotkey Text"
L["STRING_ADDON_DESCRIPTION"] = "This addon modifies the apparence of hotkey text on the action bars."
L["STRING_OPTIONS_DESCRIPTION"] = "These options allows you to change the hotkey modifier prefix and colour."
