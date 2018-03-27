local _, L = ...

-- Skip if client locale is not English
if not(GetLocale() == 'enUS') then
    return
end

-- English (DEFAULT)
L['OPTS_VERSION'] = 'version'
L['OPTS_TITLE'] = 'Clean Extended UI'
L['OPTS_DESC'] = 'This addon improves the standard Blizzard user interface.'
