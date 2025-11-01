AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("config.lua")
include("config.lua")
include("shared.lua")
for k, v in pairs(file.Find("materials/chocorp/*", "GAME")) do
    resource.AddFile("materials/chocorp/" .. v)
end

timer.Create("HeartBeatSystem", 1, 0, function()
    for k, ply in pairs(player.GetAll()) do
        if ply.SoundHB == nil then ply.SoundHB = CreateSound(ply, "player/heartbeat1.wav") end
        if not ply.SoundHB:IsPlaying() then
            ply.SoundHB:Play()
        end
    end
end)

function GM:PlayerSpawn(ply)
    ply:EmitSound("vo/npc/male01/hellodrfm01.wav")
    ply:SetupHands()
end

function GM:PlayerSetHandsModel(ply, ent)
    local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
    local info = player_manager.TranslatePlayerHands(simplemodel)
    if info then
        ent:SetModel(info.model)
        ent:SetSkin(info.skin)
        ent:SetBodyGroups(info.body)
    end
end

hook.Add("GetFallDamage", "RealisticDamage", function(ply, speed)
    LoggerDev(tostring(ply:Nick()) .. ": Died Speed: " .. 100 % math.random(10, 50) * 100)
    return speed % math.random(10, 50) * 100
end)

hook.Add("CanPlayerSuicide", "SuicideTrick", function(ply)
    LoggerDev(tostring(ply:Nick()) .. " Tried to suicide!")
    return false
end)