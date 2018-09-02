local function actionButtonUpdateHotkeys(self, bT)
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

local function actionButtonOnUpdate(self, elapsed)
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

local function modifyActionBars(isShown)
    if (InCombatLockdown() == false) then
        -- Force the MainMenuBar artwork to be the small version
        _, width, height = GetAtlasInfo("hud-MainMenuBar-small")

        MainMenuBar:SetMovable(true)
        MainMenuBar:SetSize(width,height)
        MainMenuBar:SetMovable(false)

        MainMenuBarArtFrame:SetMovable(true)
        MainMenuBarArtFrame:SetSize(width,height)
        MainMenuBarArtFrame:SetMovable(false)

        MainMenuBarArtFrameBackground:SetMovable(true)
        MainMenuBarArtFrameBackground:SetSize(width, height)
        MainMenuBarArtFrameBackground:SetMovable(false)
        
        MainMenuBarArtFrameBackground.BackgroundLarge:Hide()
        MainMenuBarArtFrameBackground.BackgroundSmall:Show()
        MainMenuBarArtFrame.PageNumber:ClearAllPoints()
        MainMenuBarArtFrame.PageNumber:SetPoint("RIGHT", MainMenuBarArtFrameBackground, "RIGHT", -6, -3);

        -- Move the RightMultiBar and make it horizontal
        if (isShown) then
            ModifyFrameFixed(MultiBarBottomRight, "TOP", MainMenuBar, -142, 85, nil)

            ModifyFrameFixed(MultiBarBottomRightButton7, "RIGHT", MultiBarBottomRightButton6, 43, 0, nil)

            -- Move talking head frame
            TalkingHeadFrame.ignoreFramePositionManager = true
            TalkingHeadFrame:ClearAllPoints()
            TalkingHeadFrame:SetPoint("BOTTOM", 0, 155)
        end
        ModifyFrameFixed(MultiBarBottomLeft, "TOP", MainMenuBar, -16, 43, nil)
   end
end

local function moveVehicleButton()
    -- Move vehicle exit button
    ModifyFrameFixed(MainMenuBarVehicleLeaveButton, "CENTER", nil, -300, 70, nil)
end

local function moveBarFrames()
    -- Move Pet and Stance Frames
    if InCombatLockdown() == false then
        if MultiBarBottomRight:IsShown() then
            ModifyFrameFixed(StanceBarFrame, "TOPLEFT", MainMenuBar, -4, 118, nil)
            ModifyFrameFixed(PetActionButton1, "TOP", MainMenuBar, -189, 120, nil)
        elseif MultiBarBottomLeft:IsShown() then
            ModifyFrameFixed(StanceBarFrame, "TOPLEFT", MainMenuBar, -4, 75, nil)
            ModifyFrameFixed(PetActionButton1, "TOP", MainMenuBar, -189, 76, nil)
        else
            ModifyFrameFixed(StanceBarFrame, "TOPLEFT", MainMenuBar, 0, 31, nil)
            ModifyFrameFixed(PetActionButton1, "TOP", MainMenuBar, -189, 31, nil)
        end
    end
end

local function hookChangeMenuBarSizeAndPosition(self, isShown)
    modifyActionBars(isShown)
end

local function actionButtonOnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ActionButton_UpdateHotkeys(self, self.buttonType)
    end
end

hooksecurefunc("ActionButton_UpdateHotkeys", actionButtonUpdateHotkeys)
hooksecurefunc("ActionButton_OnUpdate", actionButtonOnUpdate)
hooksecurefunc("ActionButton_OnEvent", actionButtonOnEvent)
hooksecurefunc("MultiActionBar_Update", moveBarFrames)
hooksecurefunc("MainMenuBarVehicleLeaveButton_Update", moveVehicleButton)
hooksecurefunc(MainMenuBar, "ChangeMenuBarSizeAndPosition", hookChangeMenuBarSizeAndPosition)

ActionBarModule = classes.class(Module)

function ActionBarModule:init()
    self.super:init("ActionBar")
    self:setEvents({
        "ADDON_LOADED",
        "PLAYER_LOGIN",
        "PLAYER_TALENT_UPDATE",
        "PLAYER_ENTERING_WORLD",
        "UNIT_ENTERED_VEHICLE",
        "UNIT_EXITED_VEHICLE",
        "ACTIVE_TALENT_GROUP_CHANGED"
    })
end

function ActionBarModule:eventHandler(event, ...)
    if event == "ADDON_LOADED" then
        ModifyFrameFixed(ExtraActionBarFrame, "BOTTOM", UIParent, 0, 192, nil)
    end
    if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" or event == "PLAYER_TALENT_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
        modifyActionBars(MultiBarBottomRight:IsShown())
    end
end
