--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


function isSTATE(player)
	if(GetPlayerPropertyValue(player,"Faction")=="Police")then
		return true
	else
		return false
	end
end
function isEVIL(player)
	if(GetPlayerPropertyValue(player,"Faction")=="Mafia" or GetPlayerPropertyValue(player,"Faction")=="Ballas")then
		return true
	else
		return false
	end
end


AddCommand("invite",function(player,target)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
			if(GetPlayerPropertyValue(player,"Factionrank")>=4)then
				local targetID=GetPlayerFromPartialName(target)
				if(targetID~="" and targetID~=nil)then
					if(targetID)then
						if(GetPlayerPropertyValue(targetID,"Faction")=="Civilian")then
							SetPlayerPropertyValue(targetID,"Faction",GetPlayerPropertyValue(player,"Faction"))
							SetPlayerPropertyValue(targetID,"Factionrank",0)
							
							CallRemoteEvent(player,"MakeNotification","You have invited "..GetPlayerName(targetID).."","linear-gradient(to right, #00b09b, #96c93d)")
						else
							CallRemoteEvent(player,"MakeNotification","The target player is already in a Faction!","linear-gradient(to right, #ff5f6d, #ffc371)")
						end
					end
				else
					CallRemoteEvent(player,"MakeNotification","Enter a target player!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't permissions to invite a player!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	end
end)
AddCommand("uninvite",function(player,target)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
			if(GetPlayerPropertyValue(player,"Factionrank")>=4)then
				local targetID=GetPlayerFromPartialName(target)
				if(targetID~="" and targetID~=nil)then
					if(targetID)then
						if(GetPlayerPropertyValue(targetID,"Factionrank")<=4)then
							if(GetPlayerPropertyValue(targetID,"Faction")==GetPlayerPropertyValue(player,"Faction"))then
								SetPlayerPropertyValue(targetID,"Faction","Civilian")
								SetPlayerPropertyValue(targetID,"Factionrank",0)
								
								CallRemoteEvent(player,"MakeNotification","You have uninvited "..GetPlayerName(targetID).."","linear-gradient(to right, #00b09b, #96c93d)")
							else
								CallRemoteEvent(player,"MakeNotification","The target player is not in your Faction!","linear-gradient(to right, #ff5f6d, #ffc371)")
							end
						end
					end
				else
					CallRemoteEvent(player,"MakeNotification","Enter a target player!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't permissions to uninvite a player!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	end
end)

AddCommand("frespawn",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
			if(GetPlayerPropertyValue(player,"Factionrank")>=2)then
				for _,v in pairs(GetAllVehicles())do
					if(GetVehiclePropertyValue(v,"veh:owner")==GetPlayerPropertyValue(player,"Faction"))then
						SetVehicleRespawnParams(v,true,5*1000)
						Delay(6*1000,function(v)
							SetVehicleRespawnParams(v,false)
						end,v)
					end
				end
				CallRemoteEvent(player,"MakeNotification","Frespawn started! (5Seconds)","linear-gradient(to right, #00b09b, #96c93d)")
			end
		end
	end
end)



--//Depot
FactiondepotPedObjectsCached={}
local factiondepotNPCpositions={
	{97237,121631,6433,0},
	{112016,206998,1512,-180}
}
AddEvent("OnPackageStart",function()
	local NPC={}
	for i,v in pairs(factiondepotNPCpositions)do
		v.NPC=CreateNPC(v[1],v[2],v[3],v[4])
		SetNPCHealth(v.NPC,999999999)
		
		SetNPCPropertyValue(v.NPC,"npc:clothing",14)
		
		CreateText3D("Factiondepot\nPress '"..interactKey.."'",18,v[1],v[2],v[3]+120,0,0,0)
		table.insert(FactiondepotPedObjectsCached,v.NPC)
	end
end)

AddEvent("OnPlayerJoin",function(player)
    CallRemoteEvent(player,"call:factiondepot",FactiondepotPedObjectsCached)
end)

AddRemoteEvent("interact:factiondepot",function(player,object)
    local dealer=GetFactiondepotByObject(object)
	if(dealer)then
		local x,y,z=GetNPCLocation(dealer.NPC)
		local x2,y2,z2=GetPlayerLocation(player)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<150)then
			if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
				loadDepotStats(player)
			end
		end
	end
end)
function GetFactiondepotByObject(object)
	for _,v in pairs(factiondepotNPCpositions)do
		if(v.NPC==object)then
			return v
		end
	end
	return nil
end

function loadDepotStats(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
			mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM factiondepots WHERE Faction='?';",GetPlayerPropertyValue(player,"Faction")),function()
				local result=mariadb_get_assoc(1)
				if(result)then
					Money=result["Money"]
					Weed=result["Weed"]
					Mats=result["Mats"]
					
					CallRemoteEvent(player,"open:depotUI","Faction",Money,Weed,Mats)
				end
			end)
		end
	end
end


AddRemoteEvent("payin_payout:factionitems",function(player,typ,item,amount)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
			mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM factiondepots WHERE Faction='?';",GetPlayerPropertyValue(player,"Faction")),function()
				if(mariadb_get_row_count()>0)then
					if(typ=="pay:in")then
						if(item=="Money" or item=="Mats" or item=="Weed")then
							if(tonumber(GetPlayerPropertyValue(player,item))>=tonumber(amount))then
								SetPlayerPropertyValue(player,item,tonumber(GetPlayerPropertyValue(player,item))-amount)
								
								local result=mariadb_get_assoc(1)
								if(result)then
									local ItemA=result[item]
									ItemA=ItemA+amount
									
									local query=mariadb_prepare(handler,"UPDATE factiondepots SET "..item.."='?' WHERE Faction='?';",
										ItemA,
										GetPlayerPropertyValue(player,"Faction")
									)
									mariadb_query(handler,query)
									
									CallRemoteEvent(player,"MakeNotification","You have put in "..item.." x"..amount,"linear-gradient(to right, #00b09b, #96c93d)")
								end
							else
								CallRemoteEvent(player,"MakeNotification","You haven't "..item.." x"..amount.."!","linear-gradient(to right, #ff5f6d, #ffc371)")
							end
						end
					elseif(typ=="pay:out")then
						if(item=="Money" or item=="Mats" or item=="Weed")then
							local result=mariadb_get_assoc(1)
							if(result)then
								ItemAA=result[item]
								if(ItemAA>=amount)then
									SetPlayerPropertyValue(player,item,tonumber(GetPlayerPropertyValue(player,item))+amount)
									
									ItemAA=ItemAA-amount
									
									local query=mariadb_prepare(handler,"UPDATE factiondepots SET "..item.."='?' WHERE Faction='?';",
										ItemAA,
										GetPlayerPropertyValue(player,"Faction")
									)
									mariadb_query(handler,query)

									CallRemoteEvent(player,"MakeNotification","You have put out "..item.." x"..amount,"linear-gradient(to right, #00b09b, #96c93d)")
								else
									CallRemoteEvent(player,"MakeNotification","That much "..item.." x"..amount.." is no longer in the depot!","linear-gradient(to right, #ff5f6d, #ffc371)")
								end
							end
						end
					end
				end
			end)
		end
	end
end)


--//Weapon shops
FactionweapondepotPedObjectsCached={}
local factionweapondepotNPCpositions={
	{112410,205235,1510,173},
	{97237,121257,6433,0},
}
AddEvent("OnPackageStart",function()
	local NPCC={}
	for i,v in pairs(factionweapondepotNPCpositions)do
		v.NPCC=CreateNPC(v[1],v[2],v[3],v[4])
		SetNPCHealth(v.NPCC,999999999)
		
		SetNPCPropertyValue(v.NPCC,"npc:clothing",14)
		
		CreateText3D("Faction Weapondepot\nPress '"..interactKey.."'",18,v[1],v[2],v[3]+120,0,0,0)
		table.insert(FactionweapondepotPedObjectsCached,v.NPCC)
	end
end)

AddEvent("OnPlayerJoin",function(player)
    CallRemoteEvent(player,"call:factionweapondepot",FactionweapondepotPedObjectsCached)
end)

AddRemoteEvent("interact:factionweapondepot",function(player,object)
    local dealer=GetFactionweapondepotByObject(object)
	if(dealer)then
		local x,y,z=GetNPCLocation(dealer.NPCC)
		local x2,y2,z2=GetPlayerLocation(player)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<150)then
			if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
				CallRemoteEvent(player,"open:weapondepotUI")
			end
		end
	end
end)
function GetFactionweapondepotByObject(object)
	for _,v in pairs(factionweapondepotNPCpositions)do
		if(v.NPCC==object)then
			return v
		end
	end
	return nil
end

AddRemoteEvent("buy:facweapon",function(player,typ)
	if(GetPlayerPropertyValue(player,"Faction")~="Civilian" and isEVIL(player))then
		mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM factiondepots WHERE Faction='?';",GetPlayerPropertyValue(player,"Faction")),function()
			if(mariadb_get_row_count()>0)then
				local result=mariadb_get_assoc(1)
				if(result)then
					local ItemA=tonumber(result["Mats"])
					
					if(typ==1)then
						if(ItemA>=tonumber(prices.faction.shop.weapon.Pistol01))then
							SetPlayerWeapon(player,2,prices.faction.shop.weapon.ammo.Pistol01,true,1,true)
							SetPlayerWeaponStat(player,2,"MagazineSize",25)
							ItemA=ItemA-prices.faction.shop.weapon.Pistol01
						end
					elseif(typ==2)then
						if(ItemA>=tonumber(prices.faction.shop.weapon.Pistol04))then
							SetPlayerWeapon(player,5,prices.faction.shop.weapon.ammo.Pistol04,true,1,true)
							SetPlayerWeaponStat(player,2,"MagazineSize",25)
							ItemA=ItemA-prices.faction.shop.weapon.Pistol04
						end
					elseif(typ==3)then
						if(ItemA>=tonumber(prices.faction.shop.weapon.SMG02))then
							SetPlayerWeapon(player,9,prices.faction.shop.weapon.ammo.SMG02,true,2,true)
							SetPlayerWeaponStat(player,9,"MagazineSize",40)
							ItemA=ItemA-prices.faction.shop.weapon.SMG02
						end
					elseif(typ==4)then
						if(ItemA>=tonumber(prices.faction.shop.weapon.SMG03))then
							SetPlayerWeapon(player,10,prices.faction.shop.weapon.ammo.SMG03,true,2,true)
							SetPlayerWeaponStat(player,10,"MagazineSize",40)
							ItemA=ItemA-prices.faction.shop.weapon.SMG03
						end
					elseif(typ==5)then
						if(ItemA>=tonumber(prices.faction.shop.weapon.Rifle01))then
							SetPlayerWeapon(player,11,prices.faction.shop.weapon.ammo.Rifle01,true,3,true)
							SetPlayerWeaponStat(player,11,"MagazineSize",40)
							ItemA=ItemA-prices.faction.shop.weapon.Rifle01
						end
					elseif(typ==6)then
						if(ItemA>=tonumber(prices.faction.shop.weapon.Rifle04))then
							SetPlayerWeapon(player,15,prices.faction.shop.weapon.ammo.Rifle04,true,3,true)
							SetPlayerWeaponStat(player,15,"MagazineSize",50)
							ItemA=ItemA-prices.faction.shop.weapon.Rifle04
						end
					end
					
					local query=mariadb_prepare(handler,"UPDATE factiondepots SET Mats='?' WHERE Faction='?';",
						ItemA,
						GetPlayerPropertyValue(player,"Faction")
					)
					mariadb_query(handler,query)
				end
			end
		end)
	end
end)