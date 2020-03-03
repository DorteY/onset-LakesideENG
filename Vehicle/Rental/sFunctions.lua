--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


RentalPedObjectsCached={}
local shopNPCpositions={
	{116076,164896,3030,7},
	{212141,161829,1310,76}
}
AddEvent("OnPackageStart",function()
	local NPC={}
	for i,v in pairs(shopNPCpositions)do
		v.NPC=CreateNPC(v[1],v[2],v[3],v[4])
		SetNPCHealth(v.NPC,999999999)
		
		SetNPCPropertyValue(v.NPC,"npc:clothing",15)
		
		CreateText3D("Rental\nPress '"..interactKey.."'",18,v[1],v[2],v[3]+120,0,0,0)
		table.insert(RentalPedObjectsCached,v.NPC)
	end
end)

AddEvent("OnPlayerJoin",function(player)
    CallRemoteEvent(player,"call:rentalped",RentalPedObjectsCached)
end)

AddRemoteEvent("interact:rentalped",function(player,object)
    local dealer=GetRentalPedByObject(object)
	if(dealer)then
		local x,y,z=GetNPCLocation(dealer.NPC)
		local x2,y2,z2=GetPlayerLocation(player)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<130)then
			CallRemoteEvent(player,"open:rentalUI")
		end
	end
end)
function GetRentalPedByObject(object)
	for _,v in pairs(shopNPCpositions)do
		if(v.NPC==object)then
			return v
		end
	end
	return nil
end


local RentVehicles={}
AddRemoteEvent("rent:vehicle",function(player,vehicle)
	local x,y,z=GetPlayerLocation(player)
	local dist=GetDistance3D(116530.5,164953.9,3030,x,y,z)
    if(dist<1600.0)then
        spawnX,spawnY,spawnZ,spawnROT=116530.5,164953.9,3030,20
	else
		spawnX,spawnY,spawnZ,spawnROT=212059,162419,1310,90
    end
	
	if(RentVehicles[player]==nil)then
		if(vehicle==0)then
			if(GetPlayerPropertyValue(player,"Money")>=450)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-450,true)
				RentVehicles[player]=CreateVehicle(25,spawnX,spawnY,spawnZ,spawnROT)
				SetPlayerInVehicle(player,RentVehicles[player])
				SetVehicleColor(RentVehicles[player],RGB(255,255,255))
				SetVehicleRespawnParams(RentVehicles[player],false)
				SetVehicleHealth(RentVehicles[player],5000)
				StopVehicleEngine(RentVehicles[player])
				
				Delay(60*60*1000,function(player)
					if(VehicleFuelTimer[RentVehicles[player]])then
						DestroyTimer(VehicleFuelTimer[RentVehicles[player]])
						VehicleFuelTimer[RentVehicles[player]]=nil
					end
					if(RentVehicles[player])then
						DestroyVehicle(RentVehicles[player])
						RentVehicles[player]=nil
					end
				end,player)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==2)then
					setTutorialQuests(player)
				end
				
				SetVehiclePropertyValue(RentVehicles[player],"veh:owner",GetPlayerName(player))
				SetVehiclePropertyValue(RentVehicles[player],"veh:fuel",100)
				SetVehiclePropertyValue(RentVehicles[player],"veh:engine",false)
				CallRemoteEvent(player,"MakeNotification","vehicle loaned","linear-gradient(to right, #0593ff, #00f3ff)")
			else
				CallRemoteEvent(player,"MakeNotification","You haven't enough money!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(vehicle==1)then
			if(GetPlayerPropertyValue(player,"Money")>=500)then
				SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-500,true)
				RentVehicles[player]=CreateVehicle(11,spawnX,spawnY,spawnZ,spawnROT)
				SetPlayerInVehicle(player,RentVehicles[player])
				SetVehicleColor(RentVehicles[player],RGB(255,255,255))
				SetVehicleRespawnParams(RentVehicles[player],false)
				SetVehicleHealth(RentVehicles[player],5000)
				StopVehicleEngine(RentVehicles[player])
				
				Delay(60*60*1000,function(player)
					if(VehicleFuelTimer[RentVehicles[player]])then
						DestroyTimer(VehicleFuelTimer[RentVehicles[player]])
						VehicleFuelTimer[RentVehicles[player]]=nil
					end
					if(RentVehicles[player])then
						DestroyVehicle(RentVehicles[player])
						RentVehicles[player]=nil
					end
				end,player)
				
				if(GetPlayerPropertyValue(player,"Tutorial")==2)then
					setTutorialQuests(player)
				end
				
				SetVehiclePropertyValue(RentVehicles[player],"veh:owner",GetPlayerName(player))
				SetVehiclePropertyValue(RentVehicles[player],"veh:fuel",100)
				SetVehiclePropertyValue(RentVehicles[player],"veh:engine",false)
				CallRemoteEvent(player,"MakeNotification","vehicle loaned","linear-gradient(to right, #0593ff, #00f3ff)")
			else
				CallRemoteEvent(player,"MakeNotification","You haven't enough money!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end
	else
		CallRemoteEvent(player,"MakeNotification","You have already a rent car!","linear-gradient(to right, #ff5f6d, #ffc371)")
	end
end)

AddEvent("OnPlayerQuit",function(player)
	if(VehicleFuelTimer[RentVehicles[player]])then
		DestroyTimer(VehicleFuelTimer[RentVehicles[player]])
		VehicleFuelTimer[RentVehicles[player]]=nil
	end
	if(RentVehicles[player])then
		DestroyVehicle(RentVehicles[player])
		RentVehicles[player]=nil
	end
end)