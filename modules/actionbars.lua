local _, L = ...

-- CREATE FRAMES --
local ActionBarsModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES --
ActionBarsModule:RegisterEvent("ADDON_LOADED")
ActionBarsModule:RegisterEvent("PLAYER_LOGIN")
ActionBarsModule:RegisterEvent("PLAYER_ENTERING_WORLD")
ActionBarsModule:RegisterEvent('UNIT_EXITED_VEHICLE')

local function UpdateHotKeyText(self, bType)
    -- Obtain button text and hotkey
    local name = self:GetName()
    local hotkey = _G[name.."HotKey"]

    -- Determine button type if current button type does not exist
    if not bType then
        if name and not string.match(name, "Stance") then
            if string.match(name, "PetAction") then
                bType = "BONUSACTIONBUTTON"
            else
                bType = "ACTIONBUTTON"
            end
        end
    end

    -- Obtain current HotKey binding text if it exists
    local text = bType and GetBindingText(GetBindingKey(bType..self:GetID())) or ""

    -- Modify HotKey text if text exists
    if text and text ~= "" then
        -- Remove hypens
        text = string.gsub(text, "%-", "")
        -- change common key text
        text = string.gsub(text, KEY_SPACE, "_")
        text = string.gsub(text, KEY_HOME, "Hm")
        text = string.gsub(text, KEY_PAGEUP, "PU")
        text = string.gsub(text, KEY_DELETE, "Del")
        text = string.gsub(text, KEY_INSERT, "Ins")
        text = string.gsub(text, KEY_PAGEDOWN, "PD")
        text = string.gsub(text, KEY_NUMLOCK, "NuL")
        -- change common key modifer text
        text = string.gsub(text, ALT_KEY_TEXT, "A")
        text = string.gsub(text, CTRL_KEY_TEXT, "C")
        text = string.gsub(text, SHIFT_KEY_TEXT, "S")
        -- change mouse button text
        text = string.gsub(text, KEY_BUTTON1, "LM")
        text = string.gsub(text, KEY_BUTTON2, "RM")
        text = string.gsub(text, KEY_BUTTON3, "MM")
        text = string.gsub(text, KEY_MOUSEWHEELUP, "MU")
        text = string.gsub(text, KEY_MOUSEWHEELDOWN, "MD")
        for i = 1, 30 do
            text = string.gsub(text, _G["KEY_BUTTON"..i], "M"..i)
        end
        -- Change Num pad key text
        text = string.gsub(text, KEY_NUMPADPLUS, "Nu+")
        text = string.gsub(text, KEY_NUMPADMINUS, "Nu-")
        text = string.gsub(text, KEY_NUMPADDIVIDE, "Nu/")
        text = string.gsub(text, KEY_NUMPADDECIMAL, "Nu.")
        text = string.gsub(text, KEY_NUMPADMULTIPLY, "Nu*")
        for i = 1, 9 do
            text = string.gsub(text, _G["KEY_NUMPAD"..i], "Nu"..i)
        end
        -- Update HotKey text
        hotkey:SetText(text)
    end
end

local function UpdateActionRange(self, elapsed)
    if self.rangeTimer == TOOLTIP_UPDATE_TIME then
        if IsActionInRange(self.action) == false then
            self.icon:SetVertexColor(1.0, 0.0, 0.0)
        else
            local canUse, amountMana = IsUsableAction(self.action)
            if canUse then
                self.icon:SetVertexColor(1.0, 1.0, 1.0)
            elseif amountMana then
                self.icon:SetVertexColor(0.5, 0.5, 1.0)
            else
                self.icon:SetVertexColor(0.4, 0.4, 0.4)
            end
        end
    end
end

local function UpdateExperienceBars()
    for _, bar in next, {
        HonorWatchBar.StatusBar,
        ArtifactWatchBar.StatusBar,
        ReputationWatchBar.StatusBar,
    } do
        bar.XPBarTexture0:Hide()
        bar.XPBarTexture1:Hide()
        bar.XPBarTexture2:Hide()
        bar.XPBarTexture3:Hide()
        bar.WatchBarTexture0:Hide()
        bar.WatchBarTexture1:Hide()
        bar.WatchBarTexture2:Hide()
        bar.WatchBarTexture3:Hide()
    end
end

local function ResizeMainBar()
    for _, texture in next, {
        StanceBarLeft,
        StanceBarRight,
        StanceBarMiddle,
        MainMenuBarTexture2,
        MainMenuBarTexture3,
        MainMenuBarPageNumber,
    } do
        texture:SetParent(HiddenFrame)
    end

    for _, bar in next, {
        MainMenuBar,
        MainMenuExpBar,
        MainMenuBarArtFrame,
        MainMenuBarMaxLevelBar,
        HonorWatchBar,
        HonorWatchBar.StatusBar,
        ArtifactWatchBar,
        ArtifactWatchBar.StatusBar,
        ReputationWatchBar,
        ReputationWatchBar.StatusBar,
    } do
        bar:SetWidth(512)
    end

    for i = 0, 1 do
        _G["SlidingActionBarTexture"..i]:SetParent(HiddenFrame)
    end

    for i = 10, 19 do
        _G["MainMenuXPBarDiv"..i]:SetParent(HiddenFrame)
    end

    Utils.ModifyFrameFixed(MainMenuBar, 'BOTTOM', nil, 0, 10, 1.1)

	ReputationWatchBar.StatusBar.WatchBarTexture0:SetWidth(128)
	ReputationWatchBar.StatusBar.WatchBarTexture1:SetWidth(128)
	ReputationWatchBar.StatusBar.WatchBarTexture2:SetWidth(128)
	ReputationWatchBar.StatusBar.WatchBarTexture3:SetWidth(128)

	ArtifactWatchBar.StatusBar.WatchBarTexture0:SetWidth(128)
	ArtifactWatchBar.StatusBar.WatchBarTexture1:SetWidth(128)
	ArtifactWatchBar.StatusBar.WatchBarTexture2:SetWidth(128)
	ArtifactWatchBar.StatusBar.WatchBarTexture3:SetWidth(128)

	HonorWatchBar.StatusBar.WatchBarTexture0:SetWidth(128)
	HonorWatchBar.StatusBar.WatchBarTexture1:SetWidth(128)
	HonorWatchBar.StatusBar.WatchBarTexture2:SetWidth(128)
	HonorWatchBar.StatusBar.WatchBarTexture3:SetWidth(128)

	ReputationWatchBar.StatusBar.XPBarTexture0:SetWidth(128)
	ReputationWatchBar.StatusBar.XPBarTexture1:SetWidth(128)
	ReputationWatchBar.StatusBar.XPBarTexture2:SetWidth(128)
	ReputationWatchBar.StatusBar.XPBarTexture3:SetWidth(128)

	ArtifactWatchBar.StatusBar.XPBarTexture0:SetWidth(128)
	ArtifactWatchBar.StatusBar.XPBarTexture1:SetWidth(128)
	ArtifactWatchBar.StatusBar.XPBarTexture2:SetWidth(128)
	ArtifactWatchBar.StatusBar.XPBarTexture3:SetWidth(128)

	HonorWatchBar.StatusBar.XPBarTexture0:SetWidth(128)
	HonorWatchBar.StatusBar.XPBarTexture1:SetWidth(128)
	HonorWatchBar.StatusBar.XPBarTexture2:SetWidth(128)
    HonorWatchBar.StatusBar.XPBarTexture3:SetWidth(128)
    
	MainMenuBar:ClearAllPoints()
	MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, -1)
	MainMenuBar.SetPoint = function() end
	
	MainMenuBarTexture0:ClearAllPoints()
	MainMenuBarTexture0:SetPoint("RIGHT", MainMenuBar, "CENTER", 0, -4)
	MainMenuBarTexture0.SetPoint = function() end
	
	MainMenuBarTexture1:ClearAllPoints()
	MainMenuBarTexture1:SetPoint("LEFT", MainMenuBar, "CENTER", 0, -4)
    MainMenuBarTexture1.SetPoint = function() end

	MainMenuBarLeftEndCap:ClearAllPoints()
	MainMenuBarLeftEndCap:SetPoint("BOTTOMRIGHT", MainMenuBar, "BOTTOMLEFT", 31, 0)
    MainMenuBarLeftEndCap.SetPoint = function() end
    
    ActionBarUpButton:ClearAllPoints()
    ActionBarUpButton:SetPoint("CENTER", MainMenuBarArtFrame, "TOPLEFT", 521, -22)
    ActionBarUpButton.SetPoint = function() end

    ActionBarDownButton:ClearAllPoints()
    ActionBarDownButton:SetPoint("CENTER", MainMenuBarArtFrame, "TOPLEFT", 521, -42)
    ActionBarDownButton.SetPoint = function() end
	
	MainMenuBarRightEndCap:ClearAllPoints()
	MainMenuBarRightEndCap:SetPoint("BOTTOMLEFT", MainMenuBar, "BOTTOMRIGHT", -31, 0)
    MainMenuBarRightEndCap.SetPoint = function() end
end

local function MoveBarFrames()
	MultiBarBottomLeft:ClearAllPoints()
	MultiBarBottomLeft:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", 0, 32)

	MultiBarBottomRight:ClearAllPoints()
	MultiBarBottomRight:SetPoint("BOTTOM", MultiBarBottomLeft, "TOP", 0, 5)

	MultiBarRight:ClearAllPoints()
	MultiBarRight:SetPoint("RIGHT", WorldFrame, "RIGHT", 0, 0)

	-- Stance Bar
	StanceBarFrame:ClearAllPoints();
	if MultiBarBottomRight:IsShown() then	
		StanceBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomRight, "TOPLEFT", -10, 5)
	elseif MultiBarBottomLeft:IsShown() then
		StanceBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "TOPLEFT", -10, 5)
	else
		StanceBarFrame:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", 0, 32)
	end

	-- Possess Bar
	PossessBarFrame:ClearAllPoints()
	if MultiBarBottomRight:IsShown() then	
		PossessBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomRight, "TOPLEFT", -10, 5)
	elseif MultiBarBottomLeft:IsShown() then
		PossessBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomLeft, "TOPLEFT", -10, 5)
	else
		PossessBarFrame:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", 0, 32)
	end

	-- Pet Bar
	PetActionBarFrame:ClearAllPoints()
	if MultiBarBottomRight:IsShown() then	
		PetActionBarFrame:SetPoint("BOTTOMRIGHT", MultiBarBottomRight, "TOPRIGHT", 100, 5)
	elseif MultiBarBottomLeft:IsShown() then
		PetActionBarFrame:SetPoint("BOTTOMRIGHT", MultiBarBottomLeft, "TOPRIGHT", 100, 5)
	else
		PetActionBarFrame:SetPoint("BOTTOMRIGHT", MainMenuBar, "TOPRIGHT", 100, 11)
    end
    PetActionBarFrame:SetScale(0.8)
end

local function MoveTalkingHead()
    if (InCombatLockdown() == false and MultiBarBottomRight:IsShown()) then
        TalkingHeadFrame.ignoreFramePositionManager = true
        TalkingHeadFrame:ClearAllPoints()
        TalkingHeadFrame:SetPoint("BOTTOM", 0, 155)
    end
end

-- ACTION BAR FRAME EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        Utils.ModifyFrameFixed(MainMenuBarBackpackButton, 'BOTTOMRIGHT', UIParent, -1, -300, nil)
        Utils.ModifyFrameFixed(ExtraActionBarFrame, "BOTTOM", UIParent, 0, 192, nil)
    end
    if event == "PLAYER_LOGIN" then
        ResizeMainBar()
        UpdateExperienceBars()
    end
    if event == "PLAYER_ENTERING_WORLD" then
        MoveBarFrames()
        MoveTalkingHead()
    end
end

-- SET FRAME SCRIPTS
ActionBarsModule:SetScript("OnEvent", EventHandler)

-- HOOK SECURE FUNCTIONS
hooksecurefunc("ActionButton_UpdateHotkeys", UpdateHotKeyText)
hooksecurefunc("ActionButton_OnUpdate", UpdateActionRange)
hooksecurefunc("MainMenuBar_UpdateExperienceBars", UpdateExperienceBars)
hooksecurefunc('MainMenuBarVehicleLeaveButton_Update', MoveBarFrames)
hooksecurefunc('MultiActionBar_Update', MoveBarFrames)
hooksecurefunc("ActionButton_OnEvent", function(self, event, ...)
    if event=="PLAYER_ENTERING_WORLD" then
        ActionButton_UpdateHotkeys(self, self.buttonType)
    end
end)
