local meta = FindMetaTable("Player")
function HungerMax()
    return 250
end

function WaterMax()
    return 150
end

function meta:Hunger()
    return self:GetNWFloat("Hunger", 0) > 0 and self:GetNWFloat("Hunger", 0) or 0
end

function meta:Water()
    return self:GetNWFloat("Water", 0) > 0 and self:GetNWFloat("Water", 0)  or 0
end

function meta:SetHunger(at)
    self:SetNWFloat("Hunger", at)
end

function meta:SetWater(at)
    self:SetNWFloat("Water", at)
end