local L=CleanExtUI

local FONT="Interface\\AddOns\\CleanExtUI\\Media\\tahoma.ttf";

local function UpdateChatUI()
    -- Additional font sizes (10 - 20 pt)
    for i=1,11 do
        CHAT_FONT_HEIGHTS[i]=i+9;
    end

    -- Hide social button and toast
    local button=QuickJoinToastButton or FriendsMicroButton;
    button:HookScript("OnShow",button.Hide);
    button:Hide();
    BNToastFrame:SetClampedToScreen(true);
    BNToastFrame:SetClampRectInsets(-15,15,15,-15);

    -- Modify edit box font
    ChatFontNormal:SetFont(FONT,15,"THINOUTLINE");
    ChatFontNormal:SetShadowOffset(1,-1);
    ChatFontNormal:SetShadowColor(0,0,0,0.6);

    -- Apply modifications to each chat window
    for i=1,NUM_CHAT_WINDOWS do
        -- Obtain details on current chat window
        local chatWindowName=_G["ChatFrame"..i]:GetName();
        local name,size,r,g,b,alpha,shown,locked,docked,uninteractable=GetChatWindowInfo(i);
    
        -- Remove screen clamp for current chat window
		_G["ChatFrame"..i]:SetClampRectInsets(0,0,0,0);
		_G["ChatFrame"..i]:SetMinResize(100,50);
        _G["ChatFrame"..i]:SetMaxResize(UIParent:GetWidth(),UIParent:GetHeight());

        -- Modify chat tabs
        local chatTab=_G[chatWindowName.."Tab"];
        local tabFont=chatTab:GetFontString();
        tabFont:SetFont(FONT,12,"THINOUTLINE");
        tabFont:SetShadowOffset(1,-1);
        tabFont:SetShadowColor(0,0,0,0.6);
    
        -- Remove background on chat tabs
        _G[chatWindowName.."TabLeft"]:SetTexture(nil);
        _G[chatWindowName.."TabMiddle"]:SetTexture(nil);
        _G[chatWindowName.."TabRight"]:SetTexture(nil);
        _G[chatWindowName.."TabSelectedLeft"]:SetTexture(nil);
        _G[chatWindowName.."TabSelectedMiddle"]:SetTexture(nil);
        _G[chatWindowName.."TabSelectedRight"]:SetTexture(nil);
        chatTab:SetAlpha(1.0);
    
        -- Remove border around the edit box
        _G[chatWindowName.."EditBoxLeft"]:Hide();
        _G[chatWindowName.."EditBoxMid"]:Hide();
        _G[chatWindowName.."EditBoxRight"]:Hide();

        -- Modify edit box position
        _G[chatWindowName.."EditBox"]:SetAltArrowKeyMode(false);
        _G[chatWindowName.."EditBox"]:ClearAllPoints();
        -- Fix positioning for Combat Log tab
		if (chatWindowName=="ChatFrame2") then
			_G[chatWindowName.."EditBox"]:SetPoint("BOTTOM",_G["ChatFrame"..i],"TOP",0,44);
		else
        	_G[chatWindowName.."EditBox"]:SetPoint("BOTTOM",_G["ChatFrame"..i],"TOP",0,22);
		end
        _G[chatWindowName.."EditBox"]:SetPoint("LEFT",_G["ChatFrame"..i],-5,0);
        _G[chatWindowName.."EditBox"]:SetPoint("RIGHT",_G["ChatFrame"..i],10,0);

        -- Modify chat text
		_G["ChatFrame"..i]:SetFont(FONT,14,"THINOUTLINE");
		_G["ChatFrame"..i]:SetShadowOffset(1,-1);
		_G["ChatFrame"..i]:SetShadowColor(0,0,0,0.6);
    end
end

local function UpdateChatStrings()
    -- Player communication
    CHAT_SAY_GET="%s: ";
    CHAT_YELL_GET="%s: ";
    CHAT_WHISPER_GET="[W From] %s: ";
    CHAT_BN_WHISPER_GET="[W From] %s: ";
    CHAT_WHISPER_INFORM_GET="[W To] %s: ";
    CHAT_BN_WHISPER_INFORM_GET="[W To] %s: ";

    -- Chat channels
    CHAT_GUILD_GET="|Hchannel:GUILD|h[G]|h %s: ";
    CHAT_PARTY_GET="|Hchannel:PARTY|h[P]|h %s: ";
    CHAT_OFFICER_GET="|Hchannel:OFFICER|h[O]|h %s: ";
    CHAT_PARTY_GUIDE_GET="|Hchannel:PARTY|h[PG]|h %s: ";
    CHAT_PARTY_LEADER_GET="|Hchannel:PARTY|h[PL]|h %s: ";
	CHAT_INSTANCE_CHAT_GET="|Hchannel:Battleground|h[I]|h %s: ";
	CHAT_INSTANCE_CHAT_LEADER_GET="|Hchannel:Battleground|h[IL]|h %s: ";
end

local function EventHandler(self, event, ...)
    if (event=="ADDON_LOADED") then
        UpdateChatUI();
        UpdateChatStrings();
    end
end

local chatFrame = CreateFrame("Frame",nil,UIParent);
chatFrame:RegisterEvent("ADDON_LOADED");
chatFrame:SetScript("OnEvent", EventHandler);
