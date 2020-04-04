SLASH_BENUI1 = "/benui"
SlashCmdList["BENUI"] = function(msg)
   BenAddonFrame:Show()
end 

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", BenVariableHandler)

function BenVariablesLoad(self)
    if BenRaidCheck == nil then
        BenRaidCheck = true;
        print("benraidnil")
    end
    if BenFollowCheck == nil then
        BenFollowCheck = true;
    else
        BenAddonFrame:Hide()
    end
end

function BenVariableHandler(self, event, arg1, ...)
    if (event == "ADDON_LOADED" and arg1 == "BenAddon") then
        BenVariablesLoad();
        BenRaidFrameCheck:SetChecked(BenRaidCheck)
        BenFollowWhisperCheck:SetChecked(BenFollowCheck)
    elseif (event == "PLAYER_LOGOUT") then
        BenRaidCheck = BenRaidFrameCheck:GetChecked()
        BenFollowCheck = BenFollowWhisperCheck:GetChecked()
    end
    
end

function BenRaidOnLoad(self)
    local BenRaid_EventFrame = CreateFrame("Frame");
    BenRaid_EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
    BenRaid_EventFrame:SetScript("OnEvent", BenRaidHideHandler)
end

function BenRaidHideHandler(self, event, ...)
    if (event == "GROUP_ROSTER_UPDATE" and BenRaidFrameCheck:GetChecked()) then
        CompactRaidFrameManager:Hide()
    end
end

function benFollowFrame(self)
    local Ben_FollowFrame = CreateFrame("Frame")
    Ben_FollowFrame:RegisterEvent("AUTOFOLLOW_BEGIN")
    Ben_FollowFrame:RegisterEvent("AUTOFOLLOW_END")
    Ben_FollowFrame:SetScript("OnEvent", benFollowHandler);
end

function benFollowHandler(self, event, ...)
    if (event == "AUTOFOLLOW_BEGIN" and BenFollowWhisperCheck:GetChecked()) then
        benName = ...
        SendChatMessage("I am now following you " .. benName .. "!", WHISPER, nil, benName)
    end 
    if (event == "AUTOFOLLOW_END" and BenFollowWhisperCheck:GetChecked()) then
        SendChatMessage("I have stopped following you " .. benName .. "!", WHISPER, nil, benName)
    end
end