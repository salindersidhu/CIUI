ActionBarModule = classes.class(Module)

local function actionButtonOnUpdate(self)
    -- If action is not within range set action bar icon color to red
    if IsActionInRange(self.action) == false then
        self.icon:SetVertexColor(1.0, 0.0, 0.0)
    else
        -- If action is within range and usable set icon color to white
        self.icon:SetVertexColor(1.0, 1.0, 1.0)
    end
end

local function modifyActionBars(isShown)
    if (InCombatLockdown() == false) then
        -- Force the MainMenuBar artwork to be the small version
        local MainMenuBarDims = C_Texture.GetAtlasInfo("hud-MainMenuBar-small")
        width = MainMenuBarDims['width']
        height = MainMenuBarDims['height']

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
            Utils.ModifyFrameFixed(MultiBarBottomRight, "TOP", MainMenuBar, -142, 85, nil)

            Utils.ModifyFrameFixed(MultiBarBottomRightButton7, "RIGHT", MultiBarBottomRightButton6, 43, 0, nil)

            -- Move talking head frame
            TalkingHeadFrame.ignoreFramePositionManager = true
            TalkingHeadFrame:ClearAllPoints()
            TalkingHeadFrame:SetPoint("BOTTOM", 0, 155)
        end
        Utils.ModifyFrameFixed(MultiBarBottomLeft, "TOP", MainMenuBar, -16, 43, nil)
   end
end

local function moveVehicleButton()
    -- Move vehicle exit button
    Utils.ModifyFrameFixed(MainMenuBarVehicleLeaveButton, "CENTER", nil, -300, 70, nil)
end

local function moveBarFrames()
    -- Move Pet and Stance Frames
    if InCombatLockdown() == false then
        if MultiBarBottomRight:IsShown() then
            Utils.ModifyFrameFixed(StanceBarFrame, "TOPLEFT", MainMenuBar, -4, 118, nil)
            Utils.ModifyFrameFixed(PetActionButton1, "TOP", MainMenuBar, -189, 120, nil)
        elseif MultiBarBottomLeft:IsShown() then
            Utils.ModifyFrameFixed(StanceBarFrame, "TOPLEFT", MainMenuBar, -4, 75, nil)
            Utils.ModifyFrameFixed(PetActionButton1, "TOP", MainMenuBar, -189, 76, nil)
        else
            Utils.ModifyFrameFixed(StanceBarFrame, "TOPLEFT", MainMenuBar, 0, 31, nil)
            Utils.ModifyFrameFixed(PetActionButton1, "TOP", MainMenuBar, -189, 31, nil)
        end
    end
end

local function hookChangeMenuBarSizeAndPosition(self, isShown)
    modifyActionBars(isShown)
end

hooksecurefunc("ActionButton_UpdateRangeIndicator", actionButtonOnUpdate)
hooksecurefunc("MultiActionBar_Update", moveBarFrames)
hooksecurefunc("MainMenuBarVehicleLeaveButton_Update", moveVehicleButton)
hooksecurefunc(MainMenuBar, "ChangeMenuBarSizeAndPosition", hookChangeMenuBarSizeAndPosition)

function ActionBarModule:init()
    self.super:init()
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
        Utils.ModifyFrameFixed(ExtraActionBarFrame, "BOTTOM", UIParent, 0, 192, nil)
    end
    if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" or event == "PLAYER_TALENT_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
        modifyActionBars(MultiBarBottomRight:IsShown())
    end
end
