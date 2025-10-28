DeriveGamemode("sandbox")
GM.Name = "Chocolate RolePlay"
function GM:Initialize()
    game.AddAmmoType({
        name = "AK47_AMMO", -- '#BULLET_PLAYER_556MM_ammo'
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE,
        plydmg = 30,
        npcdmg = 30,
        force = 2000,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    })
end

local IncludeDir = IncludeDir or {}
local includes = function(f)
    if string.find(f, "sv_") then
        return SERVER and include(f)
    elseif string.find(f, "cl_") then
        return SERVER and AddCSLuaFile(f) or CLIENT and include(f)
    elseif string.find(f, "sh_") then
        if SERVER then
            AddCSLuaFile(f)
            return include(f)
        else
            return include(f)
        end
    end
end

IncludeDir = function(dir)
    local fol = dir .. '/'
    local files, folders = file.Find(fol .. '*', "LUA")
    for _, f in ipairs(files) do
        includes(fol .. f)
    end

    for _, f in ipairs(folders) do
        IncludeDir(dir .. '/' .. f)
    end
end

IncludeDir("chocrp/gamemode/thirdparty")
IncludeDir("chocrp/gamemode/configs")
IncludeDir("chocrp/gamemode/extra")
IncludeDir("chocrp/gamemode/main")