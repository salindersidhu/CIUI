local _, L = ...

-- CREATE FRAMES --
local UnitFramesModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES --
UnitFramesModule:RegisterEvent("PLAYER_ENTERING_WORLD")
UnitFramesModule:RegisterEvent("UNIT_ENTERED_VEHICLE")
UnitFramesModule:RegisterEvent("UNIT_EXITED_VEHICLE")
UnitFramesModule:RegisterEvent("GROUP_ROSTER_UPDATE")

local function AbbreviateNumber(n, delim, strAbbr)
    return string.sub(n, 1, delim).."."..string.sub(n, delim + 1, delim + 1).." "..strAbbr
end

local function GetAbbrNumText(value)
    local numDigits = strlen(value)
    local text = value

    if numDigits >= 10 then
        text = AbbreviateNumber(value, -10, "B")
    elseif numDigits >= 7 then
        text = AbbreviateNumber(value, -7, "M")
    elseif numDigits >= 4 then
        text = AbbreviateNumber(value, -4, "K")
    end

    return text
end

local function Hook_TextStatusBar_UpdateTextStringWithValues(self, text, value, min, max)
    local textDisplay = GetCVar("statusTextDisplay")

    if textDisplay == "BOTH" and not self.showNumeric then
        self.RightText:SetText(GetAbbrNumText(value))
    elseif textDisplay == "NUMERIC" or self.showNumeric then
        text:SetText(GetAbbrNumText(value).." / "..GetAbbrNumText(max))
    end
end

local function Hook_HealthBar_OnValueChanged(self, value, smooth)
    local r, g, b, diff
    local min, max = self:GetMinMaxValues()

    if (not value) or (value < min) or (value > max) then
        return
    end

    -- Set value to range from 0 to 1 in proportation to max/min
    diff = max - min
    value = (diff > 0 and ((value - min) / diff) or 0)

    -- Change health bar from default green to yellow or red depending on value
    r = (value > 0.5 and ((1.0 - value) * 2) or 1.0)
    g = (value > 0.5 and 1.0 or (value * 2))
    b = 0.0

    self:SetStatusBarColor(r, g, b)
end

local function ModifyPlayerFrameGroupIndicator()
    -- Replace "Group" in group indicator text with "G"
    local text = PlayerFrameGroupIndicatorText:GetText()
    text = string.gsub(text, "Group ", "G")
    PlayerFrameGroupIndicatorText:SetText(text)
end

local function ModifyPlayerFrameUI()
    -- Modify Player's name and texture
    Utils.ModifyFont(PlayerName, nil, 11, "OUTLINE")
    PlayerName:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 36)
    PlayerFrameTexture:SetTexture(TEXTURE_UI_FRAME_TARGET)

    -- Update Player's raid group indicator
    Utils.ModifyFont(PlayerFrameGroupIndicatorText, nil, nil, "OUTLINE")
    PlayerFrameGroupIndicatorLeft:SetTexture(nil)
    PlayerFrameGroupIndicatorRight:SetTexture(nil)
    PlayerFrameGroupIndicatorMiddle:SetTexture(nil)

    -- Update Player's health bar
    PlayerFrameHealthBar:SetHeight(18)
    PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -24)
    PlayerFrameHealthBar.LeftText:ClearAllPoints()
    PlayerFrameHealthBar.LeftText:SetPoint("LEFT", PlayerFrameHealthBar, "LEFT", 5, 0)
    PlayerFrameHealthBar.RightText:ClearAllPoints()
    PlayerFrameHealthBar.RightText:SetPoint("RIGHT", PlayerFrameHealthBar, "RIGHT", -5, 0)
    PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, "CENTER", 0, 0)

    -- Update Player's mana bar
    PlayerFrameManaBar:SetHeight(18)
    PlayerFrameManaBar:SetPoint("TOPLEFT", 106, -45)
    PlayerFrameManaBar.LeftText:ClearAllPoints()
    PlayerFrameManaBar.LeftText:SetPoint("LEFT", PlayerFrameManaBar, "LEFT", 5, 0)
    PlayerFrameManaBar.RightText:ClearAllPoints()
    PlayerFrameManaBar.RightText:SetPoint("RIGHT", PlayerFrameManaBar, "RIGHT", -5, 0)
    PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)

    -- Update Player's mana feedback frame
    PlayerFrameManaBar.FeedbackFrame:ClearAllPoints()
    PlayerFrameManaBar.FeedbackFrame:SetHeight(18)
    PlayerFrameManaBar.FeedbackFrame:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)

    -- Update Player's mana pulse frame
    PlayerFrameManaBar.FullPowerFrame.PulseFrame:ClearAllPoints()
    PlayerFrameManaBar.FullPowerFrame.PulseFrame:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "CENTER", -6, -2)

    -- Update Player's mana spike frame big spike glow
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:ClearAllPoints()
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetSize(30, 50)
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", 5, -4)

    -- Update Player's mana spike frame alert spike stay
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:ClearAllPoints()
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetSize(30, 29)
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", -6, -3)
end

local function ModifyTargetFrameUI()
    -- Obtain target's unit classification type
    local targetType = UnitClassification(TargetFrame.unit)

    -- Update Target's name
    TargetFrame.nameBackground:Hide()
    Utils.ModifyFont(TargetFrame.name, nil, 11, "OUTLINE")
    TargetFrame.name:SetPoint("LEFT", TargetFrame, 15, 36)

    -- Update Target's background
    TargetFrameBackground:SetSize(119, 42)
    TargetFrame.Background:SetSize(119, 42)
    TargetFrame.Background:SetPoint("BOTTOMLEFT", TargetFrame, "BOTTOMLEFT", 7, 35)

    -- Update Target's "dead" text
    TargetFrame.deadText:ClearAllPoints()
    TargetFrame.deadText:SetPoint("CENTER", TargetFrame.healthbar, "CENTER", 0, 0)

    -- Update Target's health bar
    TargetFrame.healthbar:ClearAllPoints()
    TargetFrame.healthbar:SetSize(119, 18)
    TargetFrame.healthbar:SetPoint("TOPLEFT", 5, -24)
    TargetFrame.healthbar.LeftText:ClearAllPoints()
    TargetFrame.healthbar.LeftText:SetPoint("LEFT", TargetFrame.healthbar, "LEFT", 5, 0)
    TargetFrame.healthbar.RightText:ClearAllPoints()
    TargetFrame.healthbar.RightText:SetPoint("RIGHT", TargetFrame.healthbar, "RIGHT", -3, 0)
    TargetFrame.healthbar.TextString:SetPoint("CENTER", TargetFrame.healthbar, "CENTER", 0, 0)

    -- Update Target's mana bar
    TargetFrame.manabar:ClearAllPoints()
    TargetFrame.manabar:SetSize(119, 18)
    TargetFrame.manabar:SetPoint("TOPLEFT", 5, -45)
    TargetFrame.manabar.LeftText:ClearAllPoints()
    TargetFrame.manabar.LeftText:SetPoint("LEFT", TargetFrame.manabar, "LEFT", 5, 0)
    TargetFrame.manabar.RightText:ClearAllPoints()
    TargetFrame.manabar.RightText:SetPoint("RIGHT", TargetFrame.manabar, "RIGHT", -5, 0)
    TargetFrame.manabar.TextString:SetPoint("CENTER", TargetFrame.manabar, "CENTER", 0, 0)

    -- Set texture based on target's unit classification type
    if targetType == "minus" then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET)
    elseif targetType == "worldboss" or targetType == "elite" then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET_ELITE)
    elseif targetType == "rareelite"  then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET_RARE_ELITE)
    elseif targetType == "rare" then
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET_RARE)
    else
        TargetFrame.borderTexture:SetTexture(TEXTURE_UI_FRAME_TARGET)
    end

    --  Set threat indicator for the "minus" classification type
    if TargetFrame.threatIndicator and targetType == "minus" then
        TargetFrame.threatIndicator:SetTexture(TEXTURE_UI_FRAME_TARGET_FLASH)
        TargetFrame.threatIndicator:SetTexCoord(0, 0.95, 0, 0.18)
        TargetFrame.threatIndicator:SetWidth(242)
        TargetFrame.threatIndicator:SetHeight(93)
        TargetFrame.threatIndicator:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", -24, 0)
    end

    -- Show quest icon if target is part of a quest
    if TargetFrame.questIcon and UnitIsQuestBoss(TargetFrame.unit) then
        TargetFrame.questIcon:Show()
    else
        TargetFrame.questIcon:Hide()
    end
end

local function ModifyPartyFrameUI()
    for i = 1, 4 do
        _G["PartyMemberFrame"..i]:SetScale(1.6)
    end
end

local function SetPlayerFrameVehicleUI()
    -- Update Player's vehicle health bar
    PlayerFrameHealthBar:SetHeight(12)
    PlayerFrameHealthBar:SetPoint("TOPLEFT", 119, -41)
    PlayerFrameHealthBar.LeftText:ClearAllPoints()
    PlayerFrameHealthBar.LeftText:SetPoint("LEFT", PlayerFrameHealthBar, "LEFT", 0, 0)
    PlayerFrameHealthBar.RightText:ClearAllPoints()
    PlayerFrameHealthBar.RightText:SetPoint("RIGHT", PlayerFrameHealthBar, "RIGHT", 0, 0)
    PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, "CENTER", 0, 0)

    -- Update Player's vehicle mana bar
    PlayerFrameManaBar:SetHeight(12)
    PlayerFrameManaBar:SetPoint("TOPLEFT", 119, -52)
    PlayerFrameManaBar.LeftText:ClearAllPoints()
    PlayerFrameManaBar.LeftText:SetPoint("LEFT", PlayerFrameManaBar, "LEFT", 0, 0)
    PlayerFrameManaBar.RightText:ClearAllPoints()
    PlayerFrameManaBar.RightText:SetPoint("RIGHT", PlayerFrameManaBar, "RIGHT", 0, 0)
    PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)
end

local function ModifyUnitFrameUI()
    -- Modify Party, Player and Target UnitFrames
    ModifyPartyFrameUI()
    ModifyPlayerFrameUI()
    ModifyTargetFrameUI()
end

-- UNIT FRAMES FRAME EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ModifyUnitFrameUI()
        -- Modify UnitFrame positions
        Utils.ModifyFrameFixed(PartyMemberFrame1, "LEFT", nil, 175, 125, nil)
        Utils.ModifyFrameFixed(PlayerFrame, "CENTER", nil, -265, -150, 1.3)
        Utils.ModifyFrameFixed(TargetFrame, "CENTER", nil, 265, -150, 1.3)
    end
    if event == "UNIT_ENTERED_VEHICLE" and UnitVehicleSkin("player") ~= nil then
        -- Modify Player UnitFrame for vehicles
        SetPlayerFrameVehicleUI()
    end
    if event == "UNIT_EXITED_VEHICLE" then
        -- Restore UnitFrame modifications upon vehicle exit
        ModifyUnitFrameUI()
    end
    if event == "GROUP_ROSTER_UPDATE" then
        ModifyPlayerFrameGroupIndicator()
    end
end

-- SET FRAME SCRIPTS
UnitFramesModule:SetScript("OnEvent", EventHandler)

-- HOOK SECURE FUNCTIONS
hooksecurefunc("TargetFrame_CheckDead", ModifyTargetFrameUI)
hooksecurefunc("TargetFrame_Update", ModifyTargetFrameUI)
hooksecurefunc("TargetFrame_CheckFaction", ModifyTargetFrameUI)
hooksecurefunc("TargetFrame_CheckClassification", ModifyTargetFrameUI)
hooksecurefunc("TargetofTarget_Update", ModifyTargetFrameUI)
hooksecurefunc("HealthBar_OnValueChanged", Hook_HealthBar_OnValueChanged)
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", Hook_TextStatusBar_UpdateTextStringWithValues)
