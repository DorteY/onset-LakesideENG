--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddCommand("pos",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=1)then
			local x,y,z=GetPlayerLocation(player)
			local rz=GetPlayerHeading(player)
			AddPlayerChat(player,"Player location: "..x..", "..y..", "..z..", "..rz)
		end
	end
end)
AddCommand("xyz",function(player,x,y,z)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=2)then
			SetPlayerLocation(player,x,y,z)
		end
	end
end)


AddCommand("getid",function(player,target)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=1)then
			local targetID=GetPlayerFromPartialName(target)
			if(targetID)then
				AddPlayerChat(player,"ID from: "..GetPlayerName(targetID).." | "..targetID)
			end
		end
	end
end)

AddCommand("kick",function(player,target,...)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=1)then
			local reason=table.concat({...}," ")
			if(#reason>1)then
				local targetID=GetPlayerFromPartialName(target)
				if(targetID)then
					KickPlayer(targetID,"You were kicked by "..GetPlayerName(player).."!\nReason: "..reason.."\n\nThe kick is not justified? Join our Discord and report it: https://discord.gg/CSwMYtV")
					
					AddPlayerChatAll("Player "..GetPlayerName(targetID).." has been kicked by "..GetPlayerName(player)..". Reason: "..tostring(reason).."")
				end
			end
		end
	end
end)
AddCommand("ban",function(player,target,...)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=2)then
			local reason=table.concat({...}," ")
			if(#reason>1)then
				local rdm=Random(1000000000,9999999999)
				local targetID=GetPlayerFromPartialName(target)
				if(targetID)then
					mariadb_query(handler,"INSERT INTO `bans` (`Admin`,`TargetSteamID`,`Reason`,`Time`) VALUES ('"..GetPlayerName(player).."','"..tostring(GetPlayerSteamId(targetID)).."','"..reason.."("..rdm..")','0');")
					KickPlayer(targetID,"You were banned by "..GetPlayerName(player).."!\nReason: "..reason.."("..rdm..")\n\nThe ban is not justified? Join our Discord and report it: https://discord.gg/CSwMYtV")
					
					AddPlayerChatAll("Player "..GetPlayerName(targetID).." has been banned by "..GetPlayerName(player)..". Reason: "..tostring(reason).."")
				end
			end
		end
	end
end)

AddCommand("tp",function(player,target)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=1)then
			local targetID=GetPlayerFromPartialName(target)
			if(targetID)then
				local x,y,z=GetPlayerLocation(targetID)
				SetPlayerLocation(player,x,y,z)
			end
		end
	end
end)
AddCommand("tphere",function(player,target)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=1)then
			local targetID=GetPlayerFromPartialName(target)
			if(targetID)then
				local x,y,z=GetPlayerLocation(player)
				SetPlayerLocation(targetID,x,y,z)
			end
		end
	end
end)


AddCommand("give",function(player,target,typ,amount)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=2)then
			local targetID=GetPlayerFromPartialName(target)
			if(targetID)then
				if(amount~=nil)then
					if(typ=="Burger" or typ=="Cola" or typ=="Fuelcan" or typ=="Repairkit")then
						SetPlayerPropertyValue(targetID,typ,GetPlayerPropertyValue(targetID,typ)+tonumber(amount),true)
					end
				end
			end
		end
	end
end)

AddCommand("makeleader",function(player,target,typ,typ2)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"AdminLVL")>=2)then
			local targetID=GetPlayerFromPartialName(target)
			if(targetID)then
				if(typ=="Faction")then
					if(typ2=="Civilian")then
						SetPlayerPropertyValue(targetID,typ,typ2)
						SetPlayerPropertyValue(targetID,"Factionrank",0)
					elseif(typ2=="Police")then
						SetPlayerPropertyValue(targetID,typ,typ2)
						SetPlayerPropertyValue(targetID,"Factionrank",5)
					elseif(typ2=="Mafia")then
						SetPlayerPropertyValue(targetID,typ,typ2)
						SetPlayerPropertyValue(targetID,"Factionrank",5)
					elseif(typ2=="Ballas")then
						SetPlayerPropertyValue(targetID,typ,typ2)
						SetPlayerPropertyValue(targetID,"Factionrank",5)
					end
				end
			end
		end
	end
end)

