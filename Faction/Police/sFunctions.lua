--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local DutyMarker={
	[1]=CreatePickup(340,170104,193769,1350)
}
for i=1,#DutyMarker do
	SetPickupPropertyValue(DutyMarker[i],"Duty:Police",true)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(not IsPlayerInVehicle(player))then
		if(GetPlayerPropertyValue(player,"Faction")=="Police")then
			if(GetPickupPropertyValue(Marker,"Duty:Police")==true)then
				CallRemoteEvent(player,"open:police_dutyUI")
			end
		end
	end
end)

AddRemoteEvent("go:police_duty",function(player,typ)
	if(typ==0)then
		SetPlayerPropertyValue(player,"test:clothing",13)
		
		if(GetPlayerPropertyValue(player,"Factionrank")==0)then
			SetPlayerWeapon(player,21,50,true,1,true)
			SetPlayerWeapon(player,2,60,true,2,true)
		elseif(GetPlayerPropertyValue(player,"Factionrank")==1)then
			SetPlayerWeapon(player,21,80,true,1,true)
			SetPlayerWeapon(player,5,90,true,2,true)
			SetPlayerWeapon(player,7,40,true,3,true)
		elseif(GetPlayerPropertyValue(player,"Factionrank")==2)then
			SetPlayerWeapon(player,21,80,true,1,true)
			SetPlayerWeapon(player,5,90,true,2,true)
			SetPlayerWeapon(player,8,120,true,3,true)
		elseif(GetPlayerPropertyValue(player,"Factionrank")>=3)then
			SetPlayerWeapon(player,21,80,true,1,true)
			SetPlayerWeapon(player,5,90,true,2,true)
			SetPlayerWeapon(player,11,220,true,3,true)
		end
		
		CallRemoteEvent(player,"MakeNotification","You're now On duty!","linear-gradient(to right, #0593ff, #00f3ff)")
	elseif(typ==1)then
		SetPlayerPropertyValue(player,"test:clothing",GetPlayerPropertyValue(player,"Clothing"))
		
		SetPlayerWeapon(player,1,0,true,1,true)
		SetPlayerWeapon(player,1,0,true,2,true)
		SetPlayerWeapon(player,1,0,true,3,true)
		
		CallRemoteEvent(player,"MakeNotification","You're now Off duty!","linear-gradient(to right, #0593ff, #00f3ff)")
	end
end)



local vehicleTable={
	{3,169586,192262,1300,180},
	{3,169586,191864,1300,180},
	{3,169586,191466,1300,180},
	{3,169586,191057,1300,180},
}
AddEvent("OnPackageStart",function()
	local vehicles={}
	for i,v in ipairs(vehicleTable)do
		vehicles[i]=CreateVehicle(v[1],v[2],v[3],v[4],v[5])
		SetVehicleColor(vehicles[i],RGB(0,0,0))
		SetVehicleRespawnParams(vehicles[i],false)
		StopVehicleEngine(vehicles[i])
		SetVehicleHealth(vehicles[i],3500)
		
		SetVehiclePropertyValue(vehicles[i],"veh:owner","Police")
		SetVehiclePropertyValue(vehicles[i],"veh:fuel",100)
		SetVehiclePropertyValue(vehicles[i],"veh:lock",true,true)
		SetVehiclePropertyValue(vehicles[i],"veh:engine",false,true)
	end
end)