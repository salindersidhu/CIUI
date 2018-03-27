local _, Locale = ...

-- Skip if client locale is not English
if not(GetLocale() == 'enUS') then
    return
end

-- English (DEFAULT)
Locale['OPTS_VERSION'] = 'version'
Locale['OPTS_TITLE'] = 'Clean Extended UI'
Locale['OPTS_DESC'] = 'This addon improves the standard Blizzard user interface.'
