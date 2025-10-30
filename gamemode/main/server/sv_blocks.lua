util.AddNetworkString("GrantAccessToPly")
local meta = FindMetaTable("Player")
local CanAccessz = CanAccessz or {}
local access = access or {}
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

    CanAccessz[#CanAccessz + 1] = {
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
    if self:IsAdmin() then
        self.IDs = true
    else
        self.IDs = false
    end

    if self.CD == nil then self.CD = 0 end
    if self.CD <= CurTime() then
        net.Start("GrantAccessToPly")
        net.WriteString(Format("%s Tried to gain %s!", self:Nick(), name))
        net.Send(self)
        LoggerPlayer(self, Format("%s Tried to gain %s!", self:Nick(), name))
        for k, v in pairs(CanAccessz) do
            if self:SteamID64() == v.ID and v.Access == true then
                self.IDs = true
            else
                self.IDs = false
            end
        end

        self.CD = CurTime() + 5
    end
    return self.IDs
end

function meta:RegisterAccess(name)
    access[name] = true
    CanAccessz[#CanAccessz + 1] = {
        Name = name,
        Access = false,
        ID = self:SteamID64()
    }
end

hook.Add("PlayerInitialSpawn", "GiveEmIt", function(pl)
    pl:RegisterAccess("Sweps")
    pl:RegisterAccess("Effects")
    pl:RegisterAccess("Npc")
    pl:RegisterAccess("Prop")
    pl:RegisterAccess("Ragdoll")
    pl:RegisterAccess("Sent")
    pl:RegisterAccess("Vehicle")
    pl:RegisterAccess("Object")
end)

hook.Add("PlayerGiveSWEP", "BlockPlayerSWEPs", function(ply, wep, swep) return ply:CanAccess("Sweps") end)
hook.Add("PlayerSpawnSWEP", "BlockPlayerSWEPs", function(ply, wep, swep) return ply:CanAccess("Sweps") end)
hook.Add("PlayerSpawnObject", "BlockPlayerSWEPs", function(ply, mdl, skin) return ply:CanAccess("Object") end)
hook.Add("PlayerSpawnEffect", "BlockPlayerSWEPs", function(ply, model, ent) return ply:CanAccess("Effects") end)
hook.Add("PlayerSpawnNPC", "PlayerSpawnedNPC", function(ply, ent) return ply:CanAccess("Npc") end)
hook.Add("PlayerSpawnProp", "PlayerSpawnedNPC", function(ply, model, ent) return ply:CanAccess("Prop") end)
hook.Add("PlayerSpawnRagdoll", "PlayerSpawnedNPC", function(ply, model, ent) return ply:CanAccess("Ragdoll") end)
hook.Add("PlayerSpawnSENT", "PlayerSpawnedNPC", function(ply, ent) return ply:CanAccess("Sent") end)
hook.Add("PlayerSpawnVehicle", "PlayerSpawnedNPC", function(ply, ent) return ply:CanAccess("Vehicle") end)