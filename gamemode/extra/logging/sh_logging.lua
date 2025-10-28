local Dev = 1
function Logger(msg)
    MsgC(Color(63, 163, 191), "[", Color(31, 119, 163), "Chocolate RolePlay", Color(63, 163, 191), "] ", Color(200, 200, 200), msg .. "\n")
end

function LoggerErr(msg)
    MsgC(Color(63, 163, 191), "[", Color(31, 119, 163), "Chocolate RolePlay", Color(63, 163, 191), "] ", Color(240, 0, 0), msg .. "\n")
end

function LoggerAdmin(msg)
    MsgC(Color(63, 163, 191), "[", Color(31, 119, 163), "Chocolate RolePlay", Color(63, 163, 191), "] ", Color(240, 0, 0), "[ADMIN]", Color(200, 200, 200), " " .. msg .. "\n")
end

function LoggerPlayer(ply, msg)
    MsgC(Color(63, 163, 191), "[", Color(31, 119, 163), "Chocolate RolePlay", Color(63, 163, 191), "] ", Color(200, 200, 200), "Player ", Color(150, 220, 150), ply:GetName(), Color(180, 180, 255), " (" .. ply:SteamID() .. ") ", Color(200, 200, 200), msg .. "\n")
end

function LoggerDev(msg)
    if Dev == 0 then return end
    MsgC(Color(63, 163, 191), "[", Color(31, 119, 163), "[Dev] Logs", Color(63, 163, 191), "] ", Color(150, 220, 150), "Console: ", Color(200, 200, 200), msg .. "\n")
end

Logger("---------------------------------")
Logger("Chocolate RolePlay Open Alpha 1.0")
Logger("---------------------------------")