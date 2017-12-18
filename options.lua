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
	titleDesc:SetText(L["STRING_ADDON_DESCRIPTION"])
	titleDesc:SetJustifyH("LEFT")
	titleDesc:SetWidth(592)

	-- Enable checkbox
	local chkEnable = CreateFrame("CheckButton", "chkEnable", optsFrame, "ChatConfigCheckButtonTemplate")
	chkEnable:SetPoint("TOPLEFT", titleDesc, "BOTTOMLEFT", -2, -15)
	_G[chkEnable:GetName().."Text"]:SetText(" Enable")
	chkEnable:SetWidth(30)
	chkEnable:SetHeight(30)
	chkEnable:SetChecked(true)

	-- Restore default configuration button
	local resetButton = CreateFrame("Button", "resetButton", optsFrame, "OptionsButtonTemplate")
	resetButton:SetPoint("TOPRIGHT", titleDesc, "BOTTOMRIGHT", 0, -15)
	resetButton:SetText(L["STRING_BUTTON_DEFAULTS"])
	resetButton:SetWidth(100)

	-- Option description
	local optsDesc = optsFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	optsDesc:SetPoint("TOPLEFT", chkEnable, "BOTTOMLEFT", 0, -8)
	optsDesc:SetText(L["STRING_OPTIONS_DESCRIPTION"])
	optsDesc:SetJustifyH("LEFT")
	optsDesc:SetWidth(592)

	--
	local d = CreateFrame("Frame", "drop", optsFrame, "UIDropDownMenuTemplate")
	d:SetPoint("TOPLEFT", 0, -55)

	-- 
	local editHotkey = CreateFrame("EditBox", "editHotkey", optsFrame, "InputBoxTemplate")
	editHotkey:SetPoint("TOPLEFT", optsDesc, "BOTTOMLEFT", 5, -50)
	editHotkey:SetSize(60, 25)
	editHotkey:SetAutoFocus(false)
	editHotkey:SetText("S")
	editHotkey:SetCursorPosition(0)

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
