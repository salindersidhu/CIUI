local UI_TARGET_FRAME = "Interface\\Addons\\CIUI\\media\\UI-TargetingFrame"

local function healthBarOnValueChanged(self, value, smooth)
    local min, max = self:GetMinMaxValues()

    if (not value) or (value < min) or (value > max) then
        return
    end

    -- Set value to range from 0 to 1 in proportation to max/min
    diff = max - min
    value = diff > 0 and ((value - min) / diff) or 0

    -- Change health bar from default green to yellow or red depending on value
    if value > 0.5 then
        self:SetStatusBarColor((1 - value) * 2, 1, 0)
    else
        self:SetStatusBarColor(1, value * 2, 0)
    end
end

local function modifyVehicleUI()
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

local function modifyGroupIndicator()
    -- Replace "Group" in group indicator text with "G"
    local text = PlayerFrameGroupIndicatorText:GetText()
    text = string.gsub(text, "Group ", "G")
    PlayerFrameGroupIndicatorText:SetText(text)
end

local function modifyPlayerFrameUI()
    -- Modify Player's name and texture
    Utils.modifyFont(PlayerName, nil, 11, "OUTLINE")
    PlayerName:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 36)
    PlayerFrameTexture:SetTexture(UI_TARGET_FRAME)

    -- Update Player's raid group indicator
    Utils.modifyFont(PlayerFrameGroupIndicatorText, nil, nil, "OUTLINE")
    PlayerFrameGroupIndicatorLeft:SetTexture(nil)
    PlayerFrameGroupIndicatorRight:SetTexture(nil)
    PlayerFrameGroupIndicatorMiddle:SetTexture(nil)
    PlayerFrameGroupIndicator:ClearAllPoints()
    PlayerFrameGroupIndicator:SetPoint("CENTER", PlayerFrame, "CENTER", 50, 47)
    PlayerFrameGroupIndicatorText:ClearAllPoints()
    PlayerFrameGroupIndicatorText:SetPoint("CENTER", PlayerFrameGroupIndicator, "CENTER", 0, 0)

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

hooksecurefunc("HealthBar_OnValueChanged", healthBarOnValueChanged)
hooksecurefunc("PlayerFrame_Update", modifyPlayerFrameUI)

PlayerFrameModule = classes.class(Module)

function PlayerFrameModule:init()
    self.super:init("PlayerFrame")
    self:setEvents({
        "PLAYER_ENTERING_WORLD",
        "UNIT_ENTERED_VEHICLE",
        "UNIT_EXITED_VEHICLE",
        "GROUP_ROSTER_UPDATE"
    })
end

function PlayerFrameModule:getEventHandler()
    return function (self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            modifyPlayerFrameUI()
            -- Modify PlayerFrame position
            Utils.modifyFrameFixed(PlayerFrame, "CENTER", nil, -265, -150, 1.3)
        end
        if event == "UNIT_ENTERED_VEHICLE" and UnitVehicleSkin("player") ~= nil then
            -- Modify Player UnitFrame for vehicles
            modifyVehicleUI()
        end
        if event == "UNIT_EXITED_VEHICLE" and ... == "player" then
            -- Restore UnitFrame modifications upon vehicle exit
            modifyPlayerFrameUI()
        end
        if event == "GROUP_ROSTER_UPDATE" then
            -- Modify Group Indicator text when group roster is updated
            modifyGroupIndicator()
        end
    end
end
