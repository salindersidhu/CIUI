local L = ImpHotKeyText

-- Skip if client locale is not English
if not(GetLocale() == "enUS") then
  return
end

-- English (DEFAULT)
L["STR_VERSION"] = "version"
L["STR_BUTTON_DEFAULT"] = "Defaults"
L["STR_TITLE"] = "Improved Hotkey Text"
L["STR_OPTS_DESC"] = "This addon modifies the apparence of hotkey text on the action bars."
