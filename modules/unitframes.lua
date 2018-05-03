local _, L = ...

-- CREATE FRAMES --
local UnitFramesModule = CreateFrame("Frame")

-- REGISTER EVENTS TO FRAMES --
UnitFramesModule:RegisterEvent("PLAYER_ENTERING_WORLD")
UnitFramesModule:RegisterEvent("UNIT_EXITED_VEHICLE")
UnitFramesModule:RegisterEvent("UNIT_ENTERED_VEHICLE")

local function ModifyPlayerFrameArt()
    -- Update player name and set player frame texture
    PlayerName:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 36)
    PlayerFrameTexture:SetTexture(UI_FRAME_TARGET)

    -- Update player health bar
    PlayerFrameHealthBar:SetHeight(18)
    PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -24)
    PlayerFrameHealthBar.LeftText:ClearAllPoints()
    PlayerFrameHealthBar.RightText:ClearAllPoints()
    PlayerFrameHealthBar.LeftText:SetPoint("LEFT", PlayerFrameHealthBar, "LEFT", 5, 0)	
    PlayerFrameHealthBar.RightText:SetPoint("RIGHT", PlayerFrameHealthBar, "RIGHT", -5, 0)
    PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, "CENTER", 0, 0)

    -- Update player mana bar
    PlayerFrameManaBar:SetHeight(18)
    PlayerFrameManaBar:SetPoint("TOPLEFT", 106, -45)
    PlayerFrameManaBar.LeftText:ClearAllPoints()
    PlayerFrameManaBar.RightText:ClearAllPoints()
    PlayerFrameManaBar.LeftText:SetPoint("LEFT", PlayerFrameManaBar, "LEFT", 5, 0)
    PlayerFrameManaBar.RightText:SetPoint("RIGHT", PlayerFrameManaBar, "RIGHT", -5, 0)
    PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)

    -- Update player mana feedback frame
    PlayerFrameManaBar.FeedbackFrame:ClearAllPoints()
    PlayerFrameManaBar.FeedbackFrame:SetHeight(18)
    PlayerFrameManaBar.FeedbackFrame:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)

    -- Update player mana pulse frame
    PlayerFrameManaBar.FullPowerFrame.PulseFrame:ClearAllPoints()
    PlayerFrameManaBar.FullPowerFrame.PulseFrame:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "CENTER", -6, -2)

    -- Update player mana spike frame big spike glow
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:ClearAllPoints()
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetSize(30, 50)
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", 5, -4)

    -- Update player mana spike frame alert spike stay
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:ClearAllPoints()
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetSize(30, 29)
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetPoint("CENTER", PlayerFrameManaBar.FullPowerFrame, "RIGHT", -6, -3)
end

local function ModifyTargetFrameArt()
    local classification = UnitClassification(TargetFrame.unit)

    -- Update target frame
    TargetFrameBackground:SetSize(119, 42)
    TargetFrame.Background:SetPoint("BOTTOMLEFT", TargetFrame, "BOTTOMLEFT", 7, 35)
    TargetFrame.nameBackground:Hide()
    TargetFrame.Background:SetSize(119, 42)
    TargetFrame.name:SetPoint("LEFT", TargetFrame, 15, 36)
    TargetFrame.deadText:ClearAllPoints()
    TargetFrame.deadText:SetPoint("CENTER", TargetFrame.healthbar, "CENTER", 0, 0)

    -- Update target health bar
    TargetFrame.healthbar:ClearAllPoints()
	TargetFrame.healthbar:SetSize(119, 18)
	TargetFrame.healthbar:SetPoint("TOPLEFT", 5, -24)
	TargetFrame.healthbar.LeftText:ClearAllPoints()
    TargetFrame.healthbar.RightText:ClearAllPoints()
    TargetFrame.healthbar.LeftText:SetPoint("LEFT", TargetFrame.healthbar, "LEFT", 5, 0)
	TargetFrame.healthbar.RightText:SetPoint("RIGHT", TargetFrame.healthbar, "RIGHT", -3, 0)
	TargetFrame.healthbar.TextString:SetPoint("CENTER", TargetFrame.healthbar, "CENTER", 0, 0)

    -- Update target mana bar
	TargetFrame.manabar.pauseUpdates = false;
	TargetFrame.manabar:Show()
	TextStatusBar_UpdateTextString(TargetFrame.manabar)
    TargetFrame.manabar:ClearAllPoints()
    TargetFrame.manabar:SetSize(119, 18)
    TargetFrame.manabar:SetPoint("TOPLEFT", 5, -45)
    TargetFrame.manabar.LeftText:ClearAllPoints()
    TargetFrame.manabar.RightText:ClearAllPoints()
	TargetFrame.manabar.LeftText:SetPoint("LEFT", TargetFrame.manabar, "LEFT", 5, 0)
	TargetFrame.manabar.RightText:SetPoint("RIGHT", TargetFrame.manabar, "RIGHT", -5, 0)
	TargetFrame.manabar.TextString:SetPoint("CENTER", TargetFrame.manabar, "CENTER", 0, 0)

    -- Update target frame texture
    if classification == "minus" then
        TargetFrame.borderTexture:SetTexture(UI_FRAME_TARGET_MINUS)
        TargetFrame.nameBackground:Hide()
        TargetFrame.manabar.pauseUpdates = true
        TargetFrame.manabar:Hide()
        TargetFrame.manabar.TextString:Hide()
        TargetFrame.manabar.LeftText:Hide()
        TargetFrame.manabar.RightText:Hide()
    elseif classification == "worldboss" or classification == "elite" then
        TargetFrame.borderTexture:SetTexture(UI_FRAME_TARGET_ELITE)
    elseif classification == "rareelite"  then
        TargetFrame.borderTexture:SetTexture(UI_FRAME_TARGET_RARE_ELITE)
    elseif classification == "rare" then
        TargetFrame.borderTexture:SetTexture(UI_FRAME_TARGET_RARE)
    else
        TargetFrame.borderTexture:SetTexture(UI_FRAME_TARGET)
    end

    -- Show quest icon if target is part of a quest
	if TargetFrame.questIcon then
		if UnitIsQuestBoss(TargetFrame.unit) then
			TargetFrame.questIcon:Show()
		else
			TargetFrame.questIcon:Hide()
		end
	end
end

local function ModifyPartyMemmberFrames()
    local _, _, flags = PlayerFrameHealthBarTextLeft:GetFont()
    Utils.ModifyFrame(PartyMemberFrame1, "LEFT", nil, 175, 125, 1.6)

    for i = 2, 4 do
        _G["PartyMemberFrame"..i]:SetScale(1.6)
    end
end

local function AbbreviateLargeNumber(value)
    local numDigits = strlen(value)
    local retStr = value
    if numDigits >= 10 then
        retStr = string.sub(value, 1, -10).."."..string.sub(value, -9, -9).." G"
    elseif numDigits >= 7 then
        retStr = string.sub(value, 1, -7).."."..string.sub(value, -6, -6).." M"
    elseif numDigits >= 4 then
        retStr = string.sub(value, 1, -4).."."..string.sub(value, -3, -3).." K"
    end
    return retStr
end

function ModifyUnitFrameText(self, text, value, min, max)
    local textDisplay = GetCVar("statusTextDisplay")

    if textDisplay == "BOTH" then
        self.RightText:SetText(AbbreviateLargeNumber(value))
    elseif textDisplay == "NUMERIC" or self.showNumeric then


        text:SetText(AbbreviateLargeNumber(value).." / "..AbbreviateLargeNumber(max))


    end
end

local function HealthBarOnValueChanged(self, value, smooth)
    if not value then
        return
    end

    local r, g, b
    local min, max = self:GetMinMaxValues()

    if ((value < min) or (value > max)) then
        return
    end

    -- Set value to range from 0 to 1 in proportation to max/min
    if (max - min) > 0 then
        value = (value - min) / (max - min)
    else
        value = 0 
    end

    if value > 0.5 then
        -- If value is > 50% change health bar from green to yellow
        r = (1.0 - value) * 2
        g = 1.0
    else
        -- If value is < 50% change health bar from yellow to red
        r = 1.0
        g = value * 2
    end

    self:SetStatusBarColor(r, g, 0.0)
end

-- UNIT FRAMES FRAME EVENT HANDLER
local function EventHandler(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ModifyPlayerFrameArt()
        ModifyTargetFrameArt()
        Utils.ModifyUnitFrame(PlayerFrame, -265, -150, 1.3)
        Utils.ModifyUnitFrame(TargetFrame, 265, -150, 1.3)
        ModifyPartyMemmberFrames()
    end
end

-- SET FRAME SCRIPTS
UnitFramesModule:SetScript("OnEvent", EventHandler)

-- HOOK SECURE FUNCTIONS
hooksecurefunc("HealthBar_OnValueChanged", HealthBarOnValueChanged)
hooksecurefunc("TargetFrame_CheckDead", ModifyTargetFrameArt)
hooksecurefunc("TargetFrame_Update", ModifyTargetFrameArt)
hooksecurefunc("TargetFrame_CheckFaction", ModifyTargetFrameArt)
hooksecurefunc("TargetFrame_CheckClassification", ModifyTargetFrameArt)
hooksecurefunc("TargetofTarget_Update", ModifyTargetFrameArt)
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", ModifyUnitFrameText)
