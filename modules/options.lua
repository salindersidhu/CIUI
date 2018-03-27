local addonName, Locale = ...

local function InitInterfaceOptions(frame)
    -- Create a frame for the interface options
    local optsFrame = CreateFrame('Frame', nil, UIParent)
    optsFrame.name = Locale['OPTS_TITLE']

    --[[
        Title Block
        Contains the title, description of settings and restore default button.
    ]]
    local title = optsFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	title:SetPoint('TOPLEFT', 16, -16)
    title:SetText(Locale['OPTS_TITLE'])

    local vers = optsFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
	vers:SetPoint('TOPLEFT', title:GetStringWidth() + 22, -22)
    vers:SetText(format('%s %s',Locale['OPTS_VERSION'],GetAddOnMetadata('CleanExtUI', 'Version')))

    local desc = optsFrame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
	desc:SetPoint('TOPLEFT', title, 'BOTTOMLEFT', 0, -8)
	desc:SetText(Locale['OPTS_DESC'])
	desc:SetJustifyH('LEFT')
	desc:SetWidth(592)

    -- Assign frame to interface options menu
    InterfaceOptions_AddCategory(optsFrame)
end

local function EventHandler(self, event, ...)
    if (event == 'ADDON_LOADED' and arg1 == 'CleanExtUI') then
        InitInterfaceOptions(self)
    end
end

-- Create a frame and register events
local OptionsFrame = CreateFrame('Frame', nil, UIParent)
OptionsFrame:RegisterEvent('ADDON_LOADED')
OptionsFrame:SetScript('OnEvent', EventHandler)
