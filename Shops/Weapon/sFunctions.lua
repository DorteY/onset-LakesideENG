--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


WeaponDealerObjectsCached={}
local NPCpositions={
	{206048,193058,1360,180},
	{-181961,-40870,1165,88}
}
AddEvent("OnPackageStart",function()
	local NPC={}
	for _,v in pairs(NPCpositions)do
		v.NPC=CreateNPC(v[1],v[2],v[3],v[4])
		SetNPCHealth(v.NPC,999999999)
		
		SetNPCPropertyValue(v.NPC,"npc:clothing",25)
		
		CreateText3D("Weapondealer\nPress '"..interactKey.."'",18,v[1],v[2],v[3]+120,0,0,0)
		table.insert(WeaponDealerObjectsCached,v.NPC)
	end
end)

AddEvent("OnPlayerJoin",function(player)
    CallRemoteEvent(player,"call:weapondealer",WeaponDealerObjectsCached)
end)

AddRemoteEvent("interact:weapondealer",function(player,object)
	if(GetPlayerPropertyValue(player,"Playtime")>=180)then
		local dealer=GetWDealearByObject(object)
		if(dealer)then
			local x,y,z=GetNPCLocation(dealer.NPC)
			local x2,y2,z2=GetPlayerLocation(player)
			local dist=GetDistance3D(x,y,z,x2,y2,z2)
			if(dist<200)then
				if(GetPlayerPropertyValue(player,"Gunlicense")==1)then
					CallRemoteEvent(player,"open:weaponshopUI")
				else
					CallRemoteEvent(player,"MakeNotification","You haven't a Gunlicense!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			end
		end
	else
		CallRemoteEvent(player,"MakeNotification","You haven't enough play time! (3hours)","linear-gradient(to right, #ff5f6d, #ffc371)")
	end
end)
function GetWDealearByObject(object)
	for _,v in pairs(NPCpositions)do
		if(v.NPC==object)then
			return v
		end
	end
	return nil
end


AddRemoteEvent("buy:weapon",function(player,typ)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(typ==0)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Pistol01))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Pistol01),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Pistol01,prices.shop.weapon.ammo.Pistol01,true,1,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Pistol01!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==1)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Pistol02))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Pistol02),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Pistol02,prices.shop.weapon.ammo.Pistol02,true,1,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Pistol02!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==2)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Pistol04))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Pistol04),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Pistol04,prices.shop.weapon.ammo.Pistol04,true,1,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Pistol04!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==3)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Shotgun01))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Shotgun01),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Shotgun01,prices.shop.weapon.ammo.Shotgun01,true,2,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Shotgun01!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==4)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Shotgun02))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Shotgun02),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Shotgun02,prices.shop.weapon.ammo.Shotgun02,true,2,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Shotgun02!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==5)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.SMG01))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.SMG01),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.SMG01,prices.shop.weapon.ammo.SMG01,true,3,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a SMG01!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==6)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.SMG02))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.SMG02),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.SMG02,prices.shop.weapon.ammo.SMG02,true,3,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a SMG02!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==7)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.SMG03))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.SMG03),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.SMG03,prices.shop.weapon.ammo.SMG03,true,3,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a SMG03!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==8)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Rifle01))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Rifle01),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Rifle01,prices.shop.weapon.ammo.Rifle01,true,3,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Rifle01!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==9)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Rifle02))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Rifle02),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Rifle02,prices.shop.weapon.ammo.Rifle02,true,3,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Rifle02!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==10)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Rifle03))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Rifle03),true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Rifle03!","linear-gradient(to right, #00b09b, #96c93d)")
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Rifle03,prices.shop.weapon.ammo.Rifle03,true,3,true)
			end
		elseif(typ==11)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Rifle05))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Rifle05),true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Rifle05!","linear-gradient(to right, #00b09b, #96c93d)")
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Rifle05,prices.shop.weapon.ammo.Rifle05,true,3,true)
			end
		elseif(typ==12)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Rifle07))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Rifle07),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Rifle07,prices.shop.weapon.ammo.Rifle07,true,3,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Rifle07!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==13)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Sniper01))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Sniper01),true)
				
				SetPlayerWeapon(player,prices.shop.weapon.id.Sniper01,prices.shop.weapon.ammo.Sniper01,true,3,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Siper01!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(typ==18)then
			if(GetPlayerPropertyValue(player,"Money")>=tonumber(prices.shop.weapon.Armor))then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(prices.shop.weapon.Armor),true)
				SetPlayerPropertyValue(player,"Armor",GetPlayerPropertyValue(player,"Armor")+1,true)
				
				CallRemoteEvent(player,"MakeNotification","You bought a Armor!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		end
	end
end)