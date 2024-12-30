local addonName, addon = ...

addon.frame = CreateFrame("Frame")

addon.frame:SetScript("OnEvent", function(self, event, ...)
    if not addon.isMario() then
        return
    end

    if event == "PLAYER_LEVEL_UP" then        
        addon.playSound("powerup")    
        C_Timer.After(2, function()
            addon.playSound("congrats1")  
        end)

    elseif event == "CHAT_MSG_ADDON" then
        addon.handleAddonMessage(...)
    end

    elseif event == "PLAYER_MONEY" then
        addon.handleMoney()

    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, spellName, spellID = ...        
        local spellName = C_Spell.GetSpellName(spellID)        

        if unit == "player" and spellName == "Fireball" then
            addon.playSound("fireball")
        end

    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        addon.handleCombatLogEvent()

    elseif event == "UNIT_HEALTH" then
        addon.handleHealthEvent()

    elseif event == "ADDON_LOADED" and ... == addonName then
        self:UnregisterEvent("ADDON_LOADED")

        print("|cFFFF0000Marioify|r loaded")        
        C_Timer.After(1, function()
            addon.playSound("start1")
        end)

        local keyFrame = CreateFrame("Frame", nil, UIParent)
        keyFrame:SetPropagateKeyboardInput(true)
        keyFrame:SetScript("OnKeyDown", addon.onKeyPress)
        keyFrame:EnableKeyboard(true)
        
    elseif event == "PLAYER_DEAD" then
        addon.playSound("death")
    end
end)

addon.frame:RegisterEvent("PLAYER_MONEY")
addon.frame:RegisterEvent("PLAYER_LEVEL_UP")
addon.frame:RegisterEvent("ADDON_LOADED")
addon.frame:RegisterEvent("PLAYER_DEAD")
addon.frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
addon.frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
addon.frame:RegisterEvent("UNIT_HEALTH")                    
addon.frame:RegisterEvent("UNIT_POWER")                     
addon.frame:RegisterEvent("PLAYER_REGEN_DISABLED")   
addon.frame:RegisterEvent("CHAT_MSG_ADDON")

addon.prefix = "Mariofy"
C_ChatInfo.RegisterAddonMessagePrefix(prefix)