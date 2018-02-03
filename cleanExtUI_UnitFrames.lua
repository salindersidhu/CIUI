local L=CleanExtUI

local function ModifyFrame(frame,anchor,parent,x,y,scale)
    frame:SetMovable(true);
    frame:ClearAllPoints();
    if (parent==nil) then
        frame:SetPoint(anchor,x,y);
    else
        frame:SetPoint(anchor,parent,x,y);
    end
    if (scale~=nil) then
        frame:SetScale(scale);
    end
    frame:SetUserPlaced(true);
    frame:SetMovable(false);
end

local function updateUnitFrames()
    -- Update position and scale of Player, Target and Focus Frames
    ModifyFrame(PlayerFrame,"CENTER",nil,-265,-150,1.40);
    ModifyFrame(TargetFrame,"CENTER",nil,265,-150,1.40);
    ModifyFrame(FocusFrame,"LEFT",PlayerFrame,-175,-45,1.25);

    -- Update position of the first Party Frame and resize it's children
    ModifyFrame(PartyMemberFrame1,"LEFT",nil,175,125,1.6);
    for i=2,4 do
        _G["PartyMemberFrame"..i]:SetScale(1.6);
    end

    -- Update position and scale of Boss Frames
    for i=1,5 do
        _G["Boss"..i.."TargetFrame"]:SetParent(UIParent);
        _G["Boss"..i.."TargetFrame"]:SetScale(0.95);
        _G["Boss"..i.."TargetFrame"]:SetFrameStrata("BACKGROUND");
    end
    for i=2,5 do
        _G["Boss"..i.."TargetFrame"]:SetPoint("TOPLEFT",_G["Boss"..(i-1).."TargetFrame"],"BOTTOMLEFT",0,15);
    end

    -- Update position and scale of Arena Frames
    for i=1,5 do
        _G["ArenaPrepFrame"..i]:SetScale(1.75);
    end
    ArenaEnemyFrames:SetScale(1.75);
end

local function updatePlayerFrameArt(self)
    PlayerFrameTexture:SetTexture("Interface\\Addons\\CleanExtUI\\Media\\UI-TargetingFrame");
    PlayerName:Hide();
    PlayerFrameGroupIndicatorText:ClearAllPoints();
    PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT",PlayerFrame,"TOP",0,-20);
    PlayerFrameGroupIndicatorLeft:Hide();
    PlayerFrameGroupIndicatorMiddle:Hide();
    PlayerFrameGroupIndicatorRight:Hide();
    PlayerFrameHealthBar:SetPoint("TOPLEFT",106,-24);
    PlayerFrameHealthBar:SetHeight(18);
    PlayerFrameHealthBar.LeftText:ClearAllPoints();
    PlayerFrameHealthBar.LeftText:SetPoint("LEFT",PlayerFrameHealthBar,"LEFT",5,0);	
    PlayerFrameHealthBar.RightText:ClearAllPoints();
    PlayerFrameHealthBar.RightText:SetPoint("RIGHT",PlayerFrameHealthBar,"RIGHT",-5,0);
    PlayerFrameHealthBarText:SetPoint("CENTER",PlayerFrameHealthBar,"CENTER",0,0);
    PlayerFrameManaBar:SetPoint("TOPLEFT",106,-45);
    PlayerFrameManaBar:SetHeight(18);
    PlayerFrameManaBar.LeftText:ClearAllPoints();
    PlayerFrameManaBar.LeftText:SetPoint("LEFT",PlayerFrameManaBar,"LEFT",5,0);
    PlayerFrameManaBar.RightText:ClearAllPoints();
    PlayerFrameManaBar.RightText:SetPoint("RIGHT",PlayerFrameManaBar,"RIGHT",-5,0);
    PlayerFrameManaBarText:SetPoint("CENTER",PlayerFrameManaBar,"CENTER",0,0);
    PlayerFrameManaBar.FeedbackFrame:ClearAllPoints();
    PlayerFrameManaBar.FeedbackFrame:SetPoint("CENTER",PlayerFrameManaBar,"CENTER",0,0);
    PlayerFrameManaBar.FeedbackFrame:SetHeight(18);
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:ClearAllPoints();
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetPoint("CENTER",PlayerFrameManaBar.FullPowerFrame,"RIGHT",-6,-3);
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetSize(30,29);
    PlayerFrameManaBar.FullPowerFrame.PulseFrame:ClearAllPoints();
    PlayerFrameManaBar.FullPowerFrame.PulseFrame:SetPoint("CENTER",PlayerFrameManaBar.FullPowerFrame,"CENTER",-6,-2);
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:ClearAllPoints();
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetPoint("CENTER",PlayerFrameManaBar.FullPowerFrame,"RIGHT",5,-4);
    PlayerFrameManaBar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetSize(30,50);
end

local function updateTargetFrameArt(self,forceNormalTexture)
    local classification=UnitClassification(self.unit);

    self.deadText:ClearAllPoints();
    self.deadText:SetPoint("CENTER",self.healthbar,"CENTER",0,0);
    self.nameBackground:Hide();
    self.Background:SetSize(119,42);

    self.manabar.pauseUpdates=false;
    self.manabar:Show();
    TextStatusBar_UpdateTextString(self.manabar);
    self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");

    self.name:SetPoint("LEFT",self,15,36);
    self.healthbar:SetSize(119,18);
    self.healthbar:ClearAllPoints();
    self.healthbar:SetPoint("TOPLEFT",5,-24);

    self.healthbar.LeftText:ClearAllPoints();
    self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"LEFT",5,0);
    self.healthbar.RightText:ClearAllPoints();
    self.healthbar.RightText:SetPoint("RIGHT",self.healthbar,"RIGHT",-3,0);
    self.healthbar.TextString:SetPoint("CENTER",self.healthbar,"CENTER",0,0);

    self.manabar:ClearAllPoints();
    self.manabar:SetPoint("TOPLEFT",5,-45);
    self.manabar:SetSize(119,18);

    self.manabar.LeftText:ClearAllPoints();
    self.manabar.LeftText:SetPoint("LEFT",self.manabar,"LEFT",5,0);	
    self.manabar.RightText:ClearAllPoints();
    self.manabar.RightText:SetPoint("RIGHT",self.manabar,"RIGHT",-5,0);
    self.manabar.TextString:SetPoint("CENTER",self.manabar,"CENTER",0,0);

    if (forceNormalTexture) then
        self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
    elseif (classification=="minus") then
        self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus");
        self.nameBackground:Hide();
        self.manabar.pauseUpdates=true;
        self.manabar:Hide();
        self.manabar.TextString:Hide();
        self.manabar.LeftText:Hide();
        self.manabar.RightText:Hide();
        forceNormalTexture=true;
    elseif (classification=="worldboss" or classification=="elite") then
        self.borderTexture:SetTexture("Interface\\Addons\\CleanExtUI\\Media\\UI-TargetingFrame-Elite");
    elseif (classification=="rareelite") then
        self.borderTexture:SetTexture("Interface\\Addons\\CleanExtUI\\Media\\UI-TargetingFrame-Rare-Elite");
    elseif (classification=="rare") then
        self.borderTexture:SetTexture("Interface\\Addons\\CleanExtUI\\Media\\UI-TargetingFrame-Rare");
    else
        self.borderTexture:SetTexture("Interface\\Addons\\CleanExtUI\\Media\\UI-TargetingFrame");
        forceNormalTexture=true;
    end

    if (forceNormalTexture) then
        self.haveElite=nil;
        if (classification=="minus") then
            self.Background:SetSize(119,12);
            self.Background:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",7,47);
            self.name:SetPoint("LEFT",self,15,16);
            self.healthbar:ClearAllPoints();
            self.healthbar:SetPoint("LEFT",5,3);
        else
            self.Background:SetSize(119,42);
            self.Background:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",7,35);
        end
        if (self.threatIndicator) then
            if (classification=="minus") then
                self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus-Flash");
                self.threatIndicator:SetTexCoord(0,1,0,1);
                self.threatIndicator:SetWidth(256);
                self.threatIndicator:SetHeight(128);
                self.threatIndicator:SetPoint("TOPLEFT",self,"TOPLEFT",-24,0);
            else
                self.threatIndicator:SetTexCoord(0,0.9453125,0,0.181640625);
                self.threatIndicator:SetWidth(242);
                self.threatIndicator:SetHeight(93);
                self.threatIndicator:SetPoint("TOPLEFT",self,"TOPLEFT",-24,0);
                self.threatNumericIndicator:SetPoint("BOTTOM",PlayerFrame,"TOP",75,-22);
            end
        end
    else
        self.haveElite=true;
        TargetFrameBackground:SetSize(119,42);
        self.Background:SetSize(119,42);
        self.Background:SetPoint("BOTTOMLEFT",self,"BOTTOMLEFT",7,35);
        if (self.threatIndicator) then
            self.threatIndicator:SetTexCoord(0,0.9453125,0.181640625,0.400390625);
            self.threatIndicator:SetWidth(242);
            self.threatIndicator:SetHeight(112);
            self.threatIndicator:SetPoint("TOPLEFT",self,"TOPLEFT",-22,9);
        end
    end
    
    if (self.questIcon) then
        if (UnitIsQuestBoss(self.unit)) then
            self.questIcon:Show();
        else
            self.questIcon:Hide();
        end
    end
end

local function updateUnitFrameText(self,_,value,_,maxValue)
    if (self.RightText and value and maxValue>0 and not self.showPercentage and GetCVar("statusTextDisplay")=="BOTH") then
        local k,m=1e3;
        m=k*k;
        self.RightText:SetText((value>1e3 and value<1e5 and format("%1.3f",value/k)) or (value>=1e5 and value<1e6 and format("%1.0f K",value/k)) or (value>=1e6 and value<1e9 and format("%1.1f M",value/m)) or (value>1e9 and format("%1.1f M",value/m)) or value);
    end
end

local function updateClassColor(statusbar, unit)
    local c;
    if (UnitIsPlayer(unit) and UnitIsConnected(unit) and unit==statusbar.unit and UnitClass(unit)) then
        c=RAID_CLASS_COLORS[select(2,UnitClass(unit))];
        statusbar:SetStatusBarColor(c.r,c.g,c.b);
    end
    if (not UnitIsPlayer("target")) then
        c=RAID_CLASS_COLORS[select(2,UnitClass("target"))];
        if (not UnitPlayerControlled("target") and UnitIsTapDenied("target")) then
            TargetFrameHealthBar:SetStatusBarColor(0.5,0.5,0.5);
        else
            TargetFrameHealthBar:SetStatusBarColor(c.r,c.g,c.b);
            TargetFrameHealthBar.lockColor=true;
        end
    end
    if (not UnitIsPlayer("focus")) then
        c=RAID_CLASS_COLORS[select(2,UnitClass("target"))];
        if (not UnitPlayerControlled("target") and UnitIsTapDenied("target")) then
            FocusFrameHealthBar:SetStatusBarColor(0.5,0.5,0.5);
        else
            FocusFrameHealthBar:SetStatusBarColor(c.r,c.g,c.b);
            FocusFrameHealthBar.lockColor=true;
        end
    end
    if (not UnitIsPlayer("targettarget")) then
        c=RAID_CLASS_COLORS[select(2,UnitClass("targettarget"))];
        if (not UnitPlayerControlled("targettarget" and UnitIsTapDenied("targettarget"))) then
            TargetFrameToTHealthBar:SetStatusBarColor(0.5,0.5,0.5);
        else
            TargetFrameToTHealthBar:SetStatusBarColor(c.r,c.g,c.b);
            TargetFrameToTHealthBar.lockColor=true;
        end
    end
    if (not UnitIsPlayer("focustarget")) then
        c=RAID_CLASS_COLORS[select(2,UnitClass("focustarget"))];
        if (not UnitPlayerControlled("focustarget") and UnitIsTapDenied("focustarget")) then
            FocusFrameToTHealthBar:SetStatusBarColor(0.5,0.5,0.5);
        else
            FocusFrameToTHealthBar:SetStatusBarColor(c.r,c.g,c.b);
            FocusFrameToTHealthBar.lockColor=true;
        end
    end
end

local function EventHandler(self, event, ...)
    if (event=="ADDON_LOADED") then
    end
    if(event=="PLAYER_ENTERING_WORLD") then
        updateUnitFrames();
    end
    if(event=="UNIT_EXITED_VEHICLE" or event=="UNIT_ENTERED_VEHICLE") then
        updateUnitFrames();
    end
end

-- Create a frame to register and bind events
local UnitFrames=CreateFrame("Frame",nil,UIParent);
UnitFrames:RegisterEvent("ADDON_LOADED");
UnitFrames:RegisterEvent("PLAYER_ENTERING_WORLD");
UnitFrames:RegisterEvent("UNIT_EXITED_VEHICLE");
UnitFrames:RegisterEvent("UNIT_ENTERED_VEHICLE");
UnitFrames:RegisterEvent("PLAYER_TARGET_CHANGED");
UnitFrames:RegisterEvent("UNIT_FACTION");
UnitFrames:RegisterEvent("GROUP_ROSTER_UPDATE");
UnitFrames:RegisterEvent("PLAYER_FOCUS_CHANGED");
UnitFrames:SetScript("OnEvent",EventHandler);

-- Hook secure function to update Unitframes
hooksecurefunc("PlayerFrame_ToPlayerArt",updatePlayerFrameArt);
hooksecurefunc("TargetFrame_CheckClassification",updateTargetFrameArt);
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues",updateUnitFrameText);
hooksecurefunc("UnitFrameHealthBar_Update",updateClassColor);
hooksecurefunc("HealthBar_OnValueChanged",function(self)
    updateClassColor(self,self.unit);
end);
