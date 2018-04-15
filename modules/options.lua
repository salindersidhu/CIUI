local _, L = ...

local function InitInterfaceOptions(frame)
    -- Create a frame for the interface options
    local optsFrame = CreateFrame("Frame", nil, UIParent)
    optsFrame.name = L["OPT_TITLE"]

    --[[
        Title Block
        Contains the title, version and description of settings.
    ]]
    local title = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L["OPT_TITLE"])

    local vers = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	vers:SetPoint("TOPLEFT", title:GetStringWidth() + 22, -22)
    vers:SetText(format("%s %s", L["OPT_VERSION"], ADDON_VERSION))

    local desc = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	desc:SetText(L["OPT_DESCRIPTION"])
	desc:SetJustifyH("LEFT")
	desc:SetWidth(592)

    -- Assign frame to interface options menu
    InterfaceOptions_AddCategory(optsFrame)
end

local function EventHandler(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == ADDON_ID then
        InitInterfaceOptions(self)
    end
end

-- Create a frame and register events
local OptionsFrame = CreateFrame("Frame", nil, UIParent)
OptionsFrame:SetScript("OnEvent", EventHandler)
OptionsFrame:RegisterEvent("ADDON_LOADED")
