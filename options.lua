local L = ImpHotKeyText

local function initInterfaceOptions(frame)
	-- Create a frame for the interface options
	local optsFrame = CreateFrame("FRAME")
	optsFrame.name = L["STRING_TITLE"]

	-- Title
	local title = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(L["STRING_TITLE"])
	-- Title version
	local titleVers = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	titleVers:SetPoint("TOPLEFT", title:GetStringWidth() + 22, -22)
	titleVers:SetText(format("version %s", GetAddOnMetadata("ImpHotkeyText", "Version")))
	-- Title description
	local titleDesc = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	titleDesc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	titleDesc:SetText(L["STRING_OPTIONS_DESCRIPTION"])
	titleDesc:SetJustifyH("LEFT")
	titleDesc:SetWidth(592)

	-- Assign frame to interface options menu
	InterfaceOptions_AddCategory(optsFrame)
end

local function eventHandler(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "ImpHotkeyText" then
		initInterfaceOptions(self)
	end
end

local frame = CreateFrame("FRAME")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", eventHandler)
