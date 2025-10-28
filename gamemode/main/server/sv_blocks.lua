util.AddNetworkString("GrantAccessToPly")
local meta = FindMetaTable("Player")
local CanAccess = {}
local access = {}
function meta:SetAccess(name)
    if not access[name] then
        LoggerDev(Format("Failed to receive %s", name))
        print("List of valid access:")
        for k, v in pairs(access) do
            print(k)
        end

        print("List end!")
        return
    end

    CanAccess[#CanAccess + 1] = {
        Name = name,
        Access = true,
        ID = self:SteamID64()
    }

    net.Start("GrantAccessToPly")
    net.WriteString(Format("You're granted %s!", name))
    net.Send(self)
    LoggerPlayer(self, Format("You're granted %s!", name))
end

function meta:CanAccess(name)
    net.Start("GrantAccessToPly")
    net.WriteString(Format("%s Tried to gain %s!", self:Nick(), name))
    net.Send(self)
    LoggerPlayer(self, Format("%s Tried to gain %s!", self:Nick(), name))
    local IDs = false
    for k, v in pairs(CanAccess) do
        if self:SteamID64() == v.ID then IDs = true end
    end
    return IDs
end

function RegisterAccess(name)
    access[name] = true
end

RegisterAccess("Sweps")
RegisterAccess("Effects")
RegisterAccess("Npc")
RegisterAccess("Prop")
RegisterAccess("Ragdoll")
RegisterAccess("Sent")
RegisterAccess("Vehicle")
hook.Add("PlayerGiveSWEP", "BlockPlayerSWEPs", function(ply, class, spawninfo) return ply:CanAccess("Sweps") end)
hook.Add("PlayerSpawnedEffect", "BlockPlayerSWEPs", function(ply, model, ent) return ply:CanAccess("Effects") end)
hook.Add("PlayerSpawnedNPC", "PlayerSpawnedNPC", function(ply, ent) return ply:CanAccess("Npc") end)
hook.Add("PlayerSpawnedProp", "PlayerSpawnedNPC", function(ply, model, ent) return ply:CanAccess("Prop") end)
hook.Add("PlayerSpawnedRagdoll", "PlayerSpawnedNPC", function(ply, model, ent) return ply:CanAccess("Ragdoll") end)
hook.Add("PlayerSpawnedSENT", "PlayerSpawnedNPC", function(ply, ent) return ply:CanAccess("Sent") end)
hook.Add("PlayerSpawnedVehicle", "PlayerSpawnedNPC", function(ply, ent) return ply:CanAccess("Vehicle") end)