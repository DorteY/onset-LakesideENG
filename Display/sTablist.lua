--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: Talos         ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("update:scoreboard",function(player)
	local PlayerTable={}
	
	for _,v in ipairs(GetAllPlayers())do
		if(GetPlayerPropertyValue(v,"Loggedin")==1)then
			PlayerTable[v]={
				GetPlayerName(v),
				math.floor(GetPlayerPropertyValue(v,"Playtime")/60)..":"..(GetPlayerPropertyValue(v,"Playtime")-math.floor(GetPlayerPropertyValue(v,"Playtime")/60)*60),
				GetPlayerPropertyValue(v,"Faction"),
				GetPlayerPing(v)
			}
		end
	end	
	CallRemoteEvent(player,"update:scoreboard",GetServerName(),GetPlayerCount(),GetMaxPlayers(),PlayerTable)
end)