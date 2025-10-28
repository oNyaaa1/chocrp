AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("config.lua")
include("config.lua")
include("shared.lua")
--[[
If you want, I can help you craft:
• A full RP job system
• Inventory, leveling, skills
• A lore-rich scenario document
• Events, quests, NPCs
• UI elements (Derma menus)
Character Identity
Name, job/class, models, health, money… the essential ID card to stop “Default Citizen #32” confusion.

Rules & Roleplay Boundaries
No “I’m an immortal cyborg wizard with 5000 health” unless the lore says so. Structure keeps chaos fun.

Setting & Lore
CityRP, StarWarsRP, HogwartsRP, Purge Night… where are we? Why are we yelling?

Gameplay Systems
Jobs, inventory, property ownership, crafting, skills, hunger, police, medical systems… anything that supports believable actions.

Interactions
Doors locking, items dropping, NPC talky bits, player handcuffing, doctor healing, merchants scamming.

Events or Missions
Quests, robberies, government raids, the mayor trying to survive a street full of angry clowns.

Admin Tools
Because with humans involved, someone will spawn 900 melons and call it art.
Final Thought

A GMod RP scenario is basically society in a sandbox:
Civilized enough to have laws. Chaotic enough that someone will definitely steal the police car and drive it into the fountain.

If you want, I can help you craft:
• A full RP job system
• Inventory, leveling, skills
• A lore-rich scenario document
• Events, quests, NPCs
• UI elements (Derma menus)

What kind of RP are you dreaming up this time? City? Fantasy? Space pirates with questionable snack choices?
]]
for k, v in pairs(file.Find("materials/chocorp/*", "GAME")) do
    resource.AddFile("materials/chocorp/" .. v)
end

function GM:PlayerSpawn(ply)
    ply:Give("choc_hands")
    ply:SetModel("models/player/group01/female_04.mdl")
    ply:SetupHands() -- Create the hands and call GM:PlayerSetHandsModel
end

-- Choose the model for hands according to their player model.
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
    print(tostring(ply:Nick()) .. ": Died Speed: " .. 100 % math.random(10, 50) * 100)
    return speed % math.random(10, 50) * 100
end)