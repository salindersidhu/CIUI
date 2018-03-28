local _, L = ...

-- Skip if client locale is not English
if not(GetLocale() == 'enUS') then
    return
end

-- English (DEFAULT)
L['OPT_TITLE'] = 'Clean Extended UI'
L['OPT_VERSION'] = 'version'
L['OPT_DESCRIPTION'] = 'This addon improves the standard Blizzard UI.'
