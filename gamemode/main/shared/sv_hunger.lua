timer.Create("HungerSystem", 120, 0, function()
    for k, v in pairs(player.GetAll()) do
        v:SetWater(v:Water() - math.random(5, 10))
        v:SetHunger(v:Hunger() - math.random(5, 10))
        LoggerDev(v:Nick() .. " Hunger: " .. v:Hunger())
        LoggerDev(v:Nick() .. " Water: " .. v:Water())
        if v:Alive() and v:Health() > 0 then
            if v:Water() <= 0 and v:Hunger() <= 0 then
                v:SetHealth(v:Health() - 5)
                if v:Health() <= 0 and v:Alive() then v:Kill() end
            end
        end
    end
end)