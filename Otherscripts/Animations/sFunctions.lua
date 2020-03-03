--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("start_stop:animation",function(player,typ,anim)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(not IsPlayerInVehicle(player))then
			if(anim~=nil)then
				if(typ=="start")then
					SetPlayerAnimation(player,"STOP")
					SetPlayerAnimation(player,anim)
				elseif(typ=="stop")then
					SetPlayerAnimation(player,"STOP")
				end
			end
		else
			CallRemoteEvent(player,"MakeNotification","You can't start a Animation because you're in a vehicle!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)