local _, L = ...

-- Skip if client locale is not English
if not(GetLocale() == "enUS") then
    return
end

-- English (DEFAULT)
L["OPT_ADDON"] = "CIUI"
L["OPT_TITLE"] = "Clean and Improved UI"
L["OPT_VERSION"] = "version"
L["OPT_DESCRIPTION"] = "This addon improves the standard Blizzard UI."
