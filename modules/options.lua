local _, L = ...

-- CREATE FRAMES
local OptionsModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES
OptionsModule:RegisterEvent("ADDON_LOADED")

local function CreateInterfaceOptions()
    -- Create a frame for the interface options
    local opts = CreateFrame("Frame")
    opts.name = L["OPT_ADDON"]

    --[[
        Title Block
        Contains the title, version and description of settings.
    ]]
    local title = opts:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L["OPT_TITLE"])

    local vers = opts:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    vers:SetPoint("TOPLEFT", title:GetStringWidth() + 22, -22)
    vers:SetText(format("%s %s", L["OPT_VERSION"], ADDON_VERSION))

    local desc = opts:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    desc:SetText(L["OPT_DESCRIPTION"])
    desc:SetJustifyH("LEFT")
    desc:SetWidth(592)

    -- Assign frame to interface options menu
    InterfaceOptions_AddCategory(opts)
end

-- EVENT HANDLER
local function EventHandler(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        CreateInterfaceOptions()
    end
end

-- SET FRAME SCRIPTS
OptionsModule:SetScript("OnEvent", EventHandler)
