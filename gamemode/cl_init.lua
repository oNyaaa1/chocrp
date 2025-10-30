include("config.lua")
include("shared.lua")
function GM:PostDrawViewModel(vm, ply, weapon)
	if weapon.UseHands or not weapon:IsScripted() then
		local hands = LocalPlayer():GetHands()
		if IsValid(hands) then hands:DrawModel() end
	end
end

timer.Create("OurDoorSounds", 1, 0, function()
	local ply = LocalPlayer()
	if IsValid(ply) then
		if ply.SoundOutDoor == nil then ply.SoundOutDoor = CreateSound(ply, "test/temp/soundscape_test/outdoor.wav") end
		if not ply.SoundOutDoor:IsPlaying() then
			ply.SoundOutDoor:Stop()
			ply.SoundOutDoor:Play()
		end
	end
end)