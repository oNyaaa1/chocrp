-- Config for Chocolate RP
sTub = sTub or {}
sTub.Jobs = {}
sTub.Jobs.Registered = {}
sTub.Jobs.Config = function(job, code)
    sTub.Jobs.Registered[#sTub.Jobs.Registered + 1] = {
        [job] = code
    }
end

sTub.Jobs.Config("Citizen", function(ply, job, code)
    return {
        color = Color(245, 245, 0),
        VIP = false,
        VIP_LIST = {"STEAMID_HERE"},
        model = {"models/player/Group01/Female_01.mdl", "models/player/Group01/Female_02.mdl", "models/player/Group01/Female_03.mdl", "models/player/Group01/Female_04.mdl", "models/player/Group01/Female_06.mdl", "models/player/group01/male_01.mdl", "models/player/Group01/Male_02.mdl", "models/player/Group01/male_03.mdl", "models/player/Group01/Male_04.mdl", "models/player/Group01/Male_05.mdl", "models/player/Group01/Male_06.mdl", "models/player/Group01/Male_07.mdl", "models/player/Group01/Male_08.mdl", "models/player/Group01/Male_09.mdl"},
        JobType = "Citizen",
        description = [[The Classic roleplay citizen life!]],
        weaponz = {"choc_hands"},
        command = "citizen",
        max = 0,
        salary = 0,
        admin = 0,
    }
end)

sTub.Jobs.Config("Robbers", function(ply, job, code)
    return {
        color = Color(255, 0, 0),
        VIP = false,
        VIP_LIST = {"STEAMID_HERE"},
        model = {"models/player/Group01/Female_01.mdl", "models/player/Group01/Female_02.mdl", "models/player/Group01/Female_03.mdl", "models/player/Group01/Female_04.mdl", "models/player/Group01/Female_06.mdl", "models/player/group01/male_01.mdl", "models/player/Group01/Male_02.mdl", "models/player/Group01/male_03.mdl", "models/player/Group01/Male_04.mdl", "models/player/Group01/Male_05.mdl", "models/player/Group01/Male_06.mdl", "models/player/Group01/Male_07.mdl", "models/player/Group01/Male_08.mdl", "models/player/Group01/Male_09.mdl"},
        JobType = "Citizen",
        description = [[The Classic roleplay citizen life!]],
        weaponz = {"choc_hands"},
        command = "citizen",
        max = 0,
        salary = 0,
        admin = 0,
    }
end)

sTub.Jobs.Config("Police", function(ply, job, code)
    return {
        color = Color(30, 0, 255),
        VIP = false,
        VIP_LIST = {"STEAMID_HERE"},
        model = {"models/player/Group01/Female_01.mdl", "models/player/Group01/Female_02.mdl", "models/player/Group01/Female_03.mdl", "models/player/Group01/Female_04.mdl", "models/player/Group01/Female_06.mdl", "models/player/group01/male_01.mdl", "models/player/Group01/Male_02.mdl", "models/player/Group01/male_03.mdl", "models/player/Group01/Male_04.mdl", "models/player/Group01/Male_05.mdl", "models/player/Group01/Male_06.mdl", "models/player/Group01/Male_07.mdl", "models/player/Group01/Male_08.mdl", "models/player/Group01/Male_09.mdl"},
        JobType = "Citizen",
        description = [[The Classic roleplay citizen life!]],
        weaponz = {"choc_hands"},
        command = "citizen",
        max = 0,
        salary = 0,
        admin = 0,
    }
end)

sTub.Jobs.Config("VIP - Citizen", function(ply, job, code)
    return {
        color = Color(0, 255, 247),
        VIP = true,
        VIP_LIST = {"STEAMID_HERE"},
        model = {"models/player/Group01/Female_01.mdl", "models/player/Group01/Female_02.mdl", "models/player/Group01/Female_03.mdl", "models/player/Group01/Female_04.mdl", "models/player/Group01/Female_06.mdl", "models/player/group01/male_01.mdl", "models/player/Group01/Male_02.mdl", "models/player/Group01/male_03.mdl", "models/player/Group01/Male_04.mdl", "models/player/Group01/Male_05.mdl", "models/player/Group01/Male_06.mdl", "models/player/Group01/Male_07.mdl", "models/player/Group01/Male_08.mdl", "models/player/Group01/Male_09.mdl"},
        JobType = "Citizen",
        description = [[The Classic roleplay citizen life!]],
        weaponz = {"choc_hands"},
        command = "citizen",
        max = 0,
        salary = 0,
        admin = 0,
    }
end)

local meta = FindMetaTable("Player")
function IsValidJob(name)
    local torf = false
    local atbl = {}
    for k, v in pairs(sTub.Jobs.Registered) do
        if not istable(v) then continue end
        for job, tbl in pairs(v) do
            print(name, job)
            if job == name then
                atbl = tbl
                torf = true
            end
        end
    end
    return {atbl(), torf}
end

function meta:SetJob(name)
    local job = IsValidJob(name)
    if not job[2] then return end
    for k, v in pairs(job[1]) do
        if k == "model" then self:SetModel(table.Random(v)) end
        if k == "weaponz" then
            for _, split in pairs(v) do
                LoggerDev(Format("Giving Nick: %s Class: %s Weapon: %s", self:Nick(), name, split))
                self:Give(split)
            end
        end
    end

    self:SetNWString("JobType", name)
end

function meta:GiveJob(name)
    self:SetJob(name)
end

hook.Add("PlayerSpawn", "functionGiveJob", function(pl) pl:GiveJob("Citizen") end)