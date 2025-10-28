-- Config for Chocolate RP
sTub = sTub or {}
sTub.Jobs = {}
sTub.Jobs.Registered = {}
sTub.Jobs.Config = function(self, job, code)
    sTub.Jobs.Registered[#sTub.Jobs.Registered + 1] = {
        [job] = code
    }
end

sTub.Jobs.Config("Citizen", function(ply,job,code)
    return {
        
    }
end)

sTub.Jobs.Config("Robbers", function(ply,job,code)
    return {
        
    }
end)

sTub.Jobs.Config("Police", function(ply,job,code)
    return {

    }
end)