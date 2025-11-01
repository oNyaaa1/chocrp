util.AddNetworkString("CRP_SelectJob")
function ValidJob(name)
    local validJobs = false
    for k, v in pairs(sTub.Jobs.Registered) do
        for job, tbl in pairs(v) do
            if job == name then validJobs = true end
        end
    end
    return validJobs
end

net.Receive("CRP_SelectJob", function(len, ply)
    local job = net.ReadString()
    local valid_Job = ValidJob(job)
    if not valid_Job then return end
    ply:GiveJob(job)
    net.Start("GrantAccessToPly")
    net.WriteString(Format("%s you've been made %s", ply:Nick(), job))
    net.Send(ply)
end)