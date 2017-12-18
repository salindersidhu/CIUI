local L = ImpHotKeyText

local function initInterfaceOptions(frame)
	-- Create a frame for the interface options
	local optsFrame = CreateFrame("FRAME")
	optsFrame.name = L["STR_TITLE"]

	-- [Title Block]
	-- Contains the titlem description of settings and default settings button.
	local title = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(L["STR_TITLE"])
	-- Version
	local titleVers = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	titleVers:SetPoint("TOPLEFT", title:GetStringWidth() + 22, -22)
	titleVers:SetText(format("%s %s", L["STR_VERSION"], GetAddOnMetadata("ImpHotkeyText", "Version")))
	-- Description
	local titleDesc = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	titleDesc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	titleDesc:SetText(L["STR_OPTS_DESC"])
	titleDesc:SetJustifyH("LEFT")
	titleDesc:SetWidth(592)
	-- Default button
	local defaultButton = CreateFrame("Button", "resetButton", optsFrame, "OptionsButtonTemplate")
	defaultButton:SetPoint("TOPRIGHT", titleDesc, "BOTTOMRIGHT", 0, -15)
	defaultButton:SetText(L["STR_BUTTON_DEFAULT"])
	defaultButton:SetWidth(100)

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
