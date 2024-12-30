local addonName, addon = ...

hooksecurefunc("TakeTaxiNode", function()
    if addon.isMario() then
        local rando = math.random(1, 5)
        addon.playSound("flight" .. rando)
    end
end)