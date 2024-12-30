local addonName, addon = ...

addon.lastMoneyAmount = GetMoney()

function addon.playSound(name)
    PlaySoundFile("Interface\\AddOns\\" .. addonName .. "\\sounds\\" .. name .. ".wav", "Master")
end
