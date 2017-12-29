local L = CleanExtUI

local ChatFrame = CreateFrame("FRAME", nil, UIParent);

local FONT = "Interface\\AddOns\\CleanExtUI\\Fonts\\tahoma.ttf";

local function UpdateChatUI()
    for i = 1, 11 do
        CHAT_FONT_HEIGHTS[i] = i + 9;
    end

    local button = QuickJoinToastButton or FriendsMicroButton;
    button:HookScript("OnShow", button.Hide);
    button:Hide();
    BNToastFrame:SetClampedToScreen(true);
    BNToastFrame:SetClampRectInsets(-15, 15, 15, -15);

    ChatFontNormal:SetFont(FONT, 15, "THINOUTLINE");
    ChatFontNormal:SetShadowOffset(1, -1);
    ChatFontNormal:SetShadowColor(0, 0, 0, 0.6);

    for i = 1, NUM_CHAT_WINDOWS do
        -- Obtain details on current chat window
        local chatWindowName = _G["ChatFrame"..i]:GetName();
        local name, size, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(i);

        -- Remove screen clamp for current chat window
		_G["ChatFrame"..i]:SetClampRectInsets(0, 0, 0, 0);
		_G["ChatFrame"..i]:SetMinResize(100, 50);
        _G["ChatFrame"..i]:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight());

        -- Modify chat tabs
        local chatTab = _G[chatWindowName.."Tab"];
        local tabFont = chatTab:GetFontString();
        tabFont:SetFont(FONT, 12, "THINOUTLINE");
        tabFont:SetShadowOffset(1, -1);
        tabFont:SetShadowColor(0, 0, 0, 0.6);

        -- Remove background on chat tabs
        _G[chatWindowName.."TabLeft"]:SetTexture(nil);
        _G[chatWindowName.."TabMiddle"]:SetTexture(nil);
        _G[chatWindowName.."TabRight"]:SetTexture(nil);
        _G[chatWindowName.."TabSelectedLeft"]:SetTexture(nil)
        _G[chatWindowName.."TabSelectedMiddle"]:SetTexture(nil)
        _G[chatWindowName.."TabSelectedRight"]:SetTexture(nil)
        chatTab:SetAlpha(1.0);
    end
end

local function UpdateChatStrings()
    CHAT_WHISPER_GET = "W From %s ";
    CHAT_BN_WHISPER_GET = "W From %s ";
    CHAT_WHISPER_INFORM_GET = "W To %s ";
	CHAT_BN_WHISPER_INFORM_GET = "W To %s ";
    CHAT_GUILD_GET = "|Hchannel:GUILD|hG|h %s ";
    CHAT_PARTY_GET = "|Hchannel:PARTY|hP|h %s ";
    CHAT_OFFICER_GET = "|Hchannel:OFFICER|hO|h %s ";
    CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|hPL|h %s ";
end

local function EventHandler(self, event, ...)
    if (event == "ADDON_LOADED") then
        UpdateChatUI();
        UpdateChatStrings();
    end
end

ChatFrame:RegisterEvent("ADDON_LOADED");
ChatFrame:SetScript("OnEvent", EventHandler);
