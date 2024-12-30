local addonName, addon = ...

function addon.handleHealthEvent()
    local health = UnitHealth("player")
    local maxHealth = UnitHealthMax("player")
    if (health / maxHealth) < 0.25 then
        addon.onLowHealth()
    end
end

function addon.onLowHealth()
    addon.playSound("lowHP")
end