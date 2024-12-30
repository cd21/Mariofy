local addonName, addon = ...

local lastDamageTs = 0
local damageSubEvents = {"SWING_DAMAGE", "SPELL_DAMAGE", "RANGE_DAMAGE"}

function addon.handleCombatLogEvent()
    local args = {CombatLogGetCurrentEventInfo()} 
    local subEvent = args[2] 
    local sourceName = args[5]
    local destGUID = args[8]

    local indexShift = ternary(subEvent == damageSubEvents[2], 3, 0)
    local critical = args[18 + indexShift]

    if isDamageSubEvent(subEvent) then
        if destGUID == UnitGUID("player") then
            lastDamageTs = timestamp
            local rando = math.random(1, 3)
            if (critical) then
                    addon.playSound("criticalHitReceived")
                return
            end
            addon.playSound("hurt" .. rando)

        elseif destGUID == UnitGUID("target") and sourceName == UnitName("player") then
            if (critical) then
                    addon.playSound("criticalHit")
                return
            end
            
            addon.playSound("damageTo_" .. UnitCreatureType("target"))
        end
    end
end

function isDamageSubEvent(subEvent)
    return tableContains(damageSubEvents, subEvent)
end

