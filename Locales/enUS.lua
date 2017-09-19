local L = ImpHotKeyText

-- Skip if client locale is not English
if not(GetLocale() == "enUS") then
  return
end

-- English (DEFAULT)
L["STRING_TITLE"] = "Improved Hotkey Text"
L["STRING_OPTIONS_DESCRIPTION"] = "These options allow you to modify the apparence of hotkey text on the action bars."
