--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("level:player",function(player,typ)
	if(typ=="Truck")then
		if(GetPlayerPropertyValue(player,"EXP:Truck")>=level.job[tonumber(GetPlayerPropertyValue(player,"LVL:Truck"))])then
			SetPlayerPropertyValue(player,"LVL:Truck",GetPlayerPropertyValue(player,"LVL:Truck")+1)
			SetPlayerPropertyValue(player,"EXP:Truck",0)
		end
	end
end)

AddCommand("level",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		AddPlayerChat(player,"Truck Level - EXP/EXP: "..GetPlayerPropertyValue(player,"LVL:Truck").." - "..GetPlayerPropertyValue(player,"EXP:Truck").."/"..level.job[tonumber(GetPlayerPropertyValue(player,"LVL:Truck"))])
	end
end)