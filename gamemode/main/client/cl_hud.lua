local Hud = {}
local w, h = ScrW(), ScrH()
Hud.Posx, Hud.Posy = w * 0.8, h * 0.86
surface.CreateFont("Choc_RP_Font", {
    font = "Arial",
    extended = false,
    size = 23,
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
    DrawGlowingText(true, name .. ": " .. tostring(math.Round(length % 100 * 100, 2)) .. "%", "Choc_RP_Font", Hud.Posx - x + 35, Hud.Posy - y + 3, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
    x = x or 0
    y = y or 0
    surface.SetMaterial(icon)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(Hud.Posx + nx + 3, Hud.Posy + ny + 3, 24, 24)
end

hook.Add("HUDPaint", "MrRustHud", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    zSetHealth(health, "Health", ply:Health() / ply:GetMaxHealth(), 1.5, 1, Color(255, 0, 0, 255), 0, 0)
    zSetHealth(water, "Thirst", ply:Water() / WaterMax(), 1, -37, Color(24, 24, 255, 255), 1, 37)
    zSetHealth(food, "Hunger", ply:Hunger() / HungerMax(), 1, -76, Color(210, 105, 30, 255), 1, 76)
end)

local hide = {
    ["CHudHealth"] = true,
    ["CHudAmmo"] = true,
    --["CHudWeaponSelection"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudDamageIndicator"] = true,
    ["CHudVoiceStatus"] = true
}

hook.Add("HUDShouldDraw", "rustHide", function(name) if hide[name] then return false end end)