local Hud = {}
local h = ScrH()
Hud.Posx, Hud.Posy = 10, h * 0.86
surface.CreateFont("Choc_RP_Font", {
    font = "Arial",
    extended = false,
    size = 23,
    weight = 1500,
    bold = true,
})

surface.CreateFont("Choc_RP_Dead", {
    font = "Arial",
    extended = false,
    size = 100,
    weight = 1500,
    bold = true,
})

surface.CreateFont("Choc_RP_Deadsmoll", {
    font = "Arial",
    extended = false,
    size = 50,
    weight = 1500,
    bold = true,
})

local health = Material("chocorp/hospital.png", "noclamp smooth")
local water = Material("chocorp/water.png", "noclamp smooth")
local food = Material("chocorp/hunger.png", "noclamp smooth")
local function zSetHealth(icon, name, length, x, y, col, nx, ny)
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    local lgnth = 300
    surface.SetDrawColor(255, 255, 255, 128)
    surface.DrawOutlinedRect(Hud.Posx - x - 2, Hud.Posy - y - 2, lgnth * length + 6, 36, 3)
    draw.RoundedBox(4, Hud.Posx - x, Hud.Posy - y, lgnth, 32, Color(255, 255, 255, 255))
    draw.RoundedBox(4, Hud.Posx - x, Hud.Posy - y, lgnth * length, 32, col)
    draw.DrawText(name .. ": " .. tostring(math.Round(length % 100 * 100, 2)) .. "%", "Choc_RP_Font", Hud.Posx - x + 35, Hud.Posy - y + 3, Color(21, 21, 21), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
    x = x or 0
    y = y or 0
    surface.SetMaterial(icon)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(Hud.Posx + nx + 3, Hud.Posy + ny + 3, 24, 24)
end

hook.Add("HUDPaint", "MrRustHud", function()
    local ply = LocalPlayer()
    if ply:Health() <= 0 then
        draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0))
        draw.DrawText("You're Dead", "Choc_RP_Dead", ScrW() / 2 / 1.5, ScrH() / 2 / 1.2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
        draw.DrawText("Press any key to continue!", "Choc_RP_Deadsmoll", ScrW() / 2 / 1.5, ScrH() / 2 / 0.9, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
        return
    end

    if not IsValid(ply) then return end
    zSetHealth(health, "Health", ply:Health() / ply:GetMaxHealth(), 1.5, 1, Color(255, 0, 0, 255), 0, 0)
    zSetHealth(water, "Thirst", ply:Water() / WaterMax(), 1, -37, Color(24, 24, 255, 255), 1, 37)
    zSetHealth(food, "Hunger", ply:Hunger() / HungerMax(), 1, -76, Color(210, 105, 30, 255), 1, 76)
end)

local hide = {
    ["CHudHealth"] = true,
    ["CHudAmmo"] = true,
    --["CHudWeaponSelection"] = true, -- To be remade or nah??
    ["CHudDeathNotice"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudDamageIndicator"] = true,
    ["CHudVoiceStatus"] = true
}

hook.Add("HUDShouldDraw", "rustHide", function(name) if hide[name] then return false end end)
function GM:AddDeathNotice() -- Disables the death hud
end