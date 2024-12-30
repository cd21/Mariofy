local addonName, addon = ...

addon.frame = CreateFrame("Frame")

local function isMario()
    local playerName = UnitName("player")
    return string.find(string.lower(playerName), "mario") ~= nil or string.find(string.lower(playerName), "samu") ~= nil
end

addon.isMario = isMario

addon.frame:SetScript("OnEvent", function(self, event, ...)
    if addon.isMario() then
        return
    end

    if event == "PLAYER_LEVEL_UP" then        
        addon.playSound("powerup")    
        C_Timer.After(2, function()
            addon.playSound("congrats1")  
        end)
    elseif event == "PLAYER_MONEY" then
        local currentMoney = GetMoney() 
        if currentMoney > addon.lastMoneyAmount then
            addon.playSound("smb3_coin") 
        end
        addon.lastMoneyAmount = currentMoney 
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, spellName, spellID = ...        
        local spellName = C_Spell.GetSpellName(spellID)        
        if unit == "player" and spellName == "Fireball" then
            addon.playSound("fireball")
        end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        addon.handleCombatLogEvent()
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

hooksecurefunc("TakeTaxiNode", function()
    if addon.isMario() then
        local rando = math.random(1, 5)
        addon.playSound("flight" .. rando)
    end
end)