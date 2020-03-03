--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddEvent("OnPlayerDeath",function(player,killer)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		SetPlayerSpawnLocation(player,211832,158794,1323,90.0)
		SetPlayerRespawnTime(player,10000)
		
		local msg=GetPlayerName(player).." was killed by "..GetPlayerName(killer)
		local query=mariadb_prepare(handler,"INSERT INTO logs VALUES (NULL, NULL, '?');",msg)
		mariadb_async_query(handler,query)
	end
end)

AddEvent("OnPlayerDamage",function(player,dmg,amount)
    local DamageName={
		"Weapon",
		"Explosion",
		"Fire",
		"Fall",
		"Vehicle Collision"
	}
	
	local msg=GetPlayerName(player).."("..player..") took "..amount.." damage of type "..DamageName[dmg]
    local query=mariadb_prepare(handler,"INSERT INTO logs VALUES (NULL, NULL, '?');",msg)
	mariadb_async_query(handler,query)
end)