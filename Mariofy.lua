local addonName, addon = ...

local frame = CreateFrame("Frame")

local function isMario()
    local playerName = UnitName("player")
    return string.find(string.lower(playerName), "mario") ~= nil or string.find(string.lower(playerName), "samu") ~= nil
end

local function playSound(name)
    PlaySoundFile("Interface\\AddOns\\" .. addonName .. "\\sounds\\".. name .. ".wav", "Master") 
end

local function onKeyPress(self, key)
    if key == "SPACE" and not IsFalling() then
        playSound("jump")
    end
end

local lastDamageTs = 0
local lastMoneyAmount = GetMoney()


frame:SetScript("OnEvent", function(self, event, ...)
    if not isMario() then
        return
    end

    if event == "PLAYER_LEVEL_UP" then        
        playSound("powerup")    
        C_Timer.After(2, function()
            playSound("congrats1")  
        end)
    elseif event == "PLAYER_MONEY" then
        local currentMoney = GetMoney() 
        if currentMoney > lastMoneyAmount then
            playSound("smb3_coin") 
        end
        lastMoneyAmount = currentMoney 
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, spellName, spellID = ...        
        local spellName = C_Spell.GetSpellName( spellID )        
        if unit == "player" and spellName == "Fireball" then
            playSound("fireball")
        end
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellID, spellName, school, amount = CombatLogGetCurrentEventInfo()        
        if subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "RANGE_DAMAGE" then
            if destGUID == UnitGUID("player") and (lastDamageTs == 0 or timestamp - lastDamageTs > 1) then
                lastDamageTs = timestamp
                local rando = math.random(1, 3)
                playSound("hurt" .. rando)
            
            elseif destGUID == UnitGUID("target") then
                playSound("damageTo_" .. UnitCreatureType("target") ) 
            end
        end

    elseif event == "ADDON_LOADED" and ... == addonName then
        self:UnregisterEvent("ADDON_LOADED")

        print("|cFFFF0000Marioify|r loaded")        
        C_Timer.After(1, function()
            playSound("start1")
        end)

        local keyFrame = CreateFrame("Frame", nil, UIParent)
        keyFrame:SetPropagateKeyboardInput(true)
        keyFrame:SetScript("OnKeyDown", onKeyPress)
        keyFrame:EnableKeyboard(true)
    elseif event == "PLAYER_DEAD" then
        playSound("death")
    end


end)

hooksecurefunc("TakeTaxiNode", function()
    if isMario() then
        local rando = math.random(1, 5)
	    playSound("flight" .. rando)
    end
end)

frame:RegisterEvent("PLAYER_MONEY")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_DEAD")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")


