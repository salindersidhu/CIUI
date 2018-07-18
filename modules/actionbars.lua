local _, L = ...

-- CREATE FRAMES --
local ActionBarsModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES --
ActionBarsModule:RegisterEvent("ADDON_LOADED")
ActionBarsModule:RegisterEvent("PLAYER_LOGIN")
ActionBarsModule:RegisterEvent("PLAYER_ENTERING_WORLD")
ActionBarsModule:RegisterEvent('UNIT_EXITED_VEHICLE')

local function Hook_ActionButton_UpdateHotkeys(self, bT)
    -- Obtain button text and hotkey
    local name = self:GetName()
    local hotkey = _G[name.."HotKey"]

    -- Determine button type if current button type does not exist
    if not bT then
        if name and not string.match(name, "Stance") then
            bT = string.match(name, "PetAction") and "BONUSACTIONBUTTON" or "ACTIONBUTTON"
        end
    end

    -- Obtain current HotKey binding text if it exists
    local text = bT and GetBindingText(GetBindingKey(bT..self:GetID())) or ""

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

local function Hook_ActionButton_OnUpdate(self, elapsed)
    if self.rangeTimer == TOOLTIP_UPDATE_TIME then
        -- If action is not within range set action bar icon color to red
        if IsActionInRange(self.action) == false then
            self.icon:SetVertexColor(1.0, 0.0, 0.0)
        else
            if IsUsableAction(self.action) then
                -- If action is within range and usable set icon color to white
                self.icon:SetVertexColor(1.0, 1.0, 1.0)
            else
                -- If action is within range and unsable set icon color to grey
                self.icon:SetVertexColor(0.4, 0.4, 0.4)
            end
        end
    end
end

local function ModifyActionBars(isRightMultiBarShowing)
    if (InCombatLockdown() == false) then
        -- Force the MainMenuBar artwork to be the small version
        _, width, height = GetAtlasInfo("hud-MainMenuBar-small")
        MainMenuBar:SetSize(width,height)
        MainMenuBar:SetScale(1.1)
		MainMenuBarArtFrame:SetSize(width,height)
		MainMenuBarArtFrameBackground:SetSize(width, height)
		MainMenuBarArtFrameBackground.BackgroundLarge:Hide()
		MainMenuBarArtFrameBackground.BackgroundSmall:Show()
		MainMenuBarArtFrame.PageNumber:ClearAllPoints()
        MainMenuBarArtFrame.PageNumber:SetPoint("RIGHT", MainMenuBarArtFrameBackground, "RIGHT", -6, -3);

        -- Move the RightMultiBar and make it horizontal
        if (isRightMultiBarShowing) then
            Utils.ModifyFrameFixed(MultiBarBottomRight, 'TOP', MainMenuBar, -142, 85, nil)
            Utils.ModifyFrameFixed(MultiBarBottomRightButton7, 'RIGHT', MultiBarBottomRightButton6, 43, 0, nil)
        
            -- Move talking head frame
            TalkingHeadFrame.ignoreFramePositionManager = true
            TalkingHeadFrame:ClearAllPoints()
            TalkingHeadFrame:SetPoint("BOTTOM", 0, 155)
        end
    end
end

local function MoveBarFrames()
    -- Vehicle exit button
    Utils.ModifyFrame(MainMenuBarVehicleLeaveButton, "CENTER", nil, -280, 70, nil)

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

local function Hook_ChangeMenuBarSizeAndPosition(self, isRightMultiBarShowing)
    ModifyActionBars(isRightMultiBarShowing)
end

local function Hook_ActionButton_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ActionButton_UpdateHotkeys(self, self.buttonType)
    end
end

-- ACTION BAR FRAME EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "ADDON_LOADED" then
        Utils.ModifyFrameFixed(ExtraActionBarFrame, "BOTTOM", UIParent, 0, 192, nil)
    end
    if event == "PLAYER_ENTERING_WORLD" then
        MoveBarFrames()
    end
    if event == "PLAYER_LOGIN" then
        ModifyActionBars(MultiBarBottomRight:IsShown())
    end
end

-- -- SET FRAME SCRIPTS
ActionBarsModule:SetScript("OnEvent", EventHandler)

-- -- HOOK SECURE FUNCTIONS
hooksecurefunc("ActionButton_UpdateHotkeys", Hook_ActionButton_UpdateHotkeys)
hooksecurefunc("ActionButton_OnUpdate", Hook_ActionButton_OnUpdate)
hooksecurefunc('MainMenuBarVehicleLeaveButton_Update', MoveBarFrames)
hooksecurefunc('MultiActionBar_Update', MoveBarFrames)
hooksecurefunc("ActionButton_OnEvent", Hook_ActionButton_OnEvent)
hooksecurefunc(MainMenuBar, "ChangeMenuBarSizeAndPosition", Hook_ChangeMenuBarSizeAndPosition)
