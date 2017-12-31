local L=CleanExtUI

local function initInterfaceOptions(frame)
	-- Create a frame for the interface options
	local optsFrame=CreateFrame("Frame",nil,UIParent);
	optsFrame.name=L["STR_TITLE"];

	--[[
		Title Block
		Contains the titlem description of settings and default settings button.
	--]]
	local title=optsFrame:CreateFontString(nil,"ARTWORK","GameFontNormalLarge");
	title:SetPoint("TOPLEFT",16,-16);
	title:SetText(L["STR_TITLE"]);
	-- Version
	local titleVers=optsFrame:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	titleVers:SetPoint("TOPLEFT", title:GetStringWidth()+22,-22);
	titleVers:SetText(format("%s %s",L["STR_VERSION"],GetAddOnMetadata("CleanExtUI","Version")));
	-- Description
	local titleDesc=optsFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight");
	titleDesc:SetPoint("TOPLEFT",title,"BOTTOMLEFT",0,-8);
	titleDesc:SetText(L["STR_OPTS_DESC"]);
	titleDesc:SetJustifyH("LEFT");
	titleDesc:SetWidth(592);

	-- Assign frame to interface options menu
	InterfaceOptions_AddCategory(optsFrame);
end

local function EventHandler(self, event, arg1)
	if (event=="ADDON_LOADED" and arg1=="CleanExtUI") then
		initInterfaceOptions(self);
	end
end

local frame=CreateFrame("Frame",nil,UIParent);
frame:RegisterEvent("ADDON_LOADED");
frame:SetScript("OnEvent", EventHandler);
