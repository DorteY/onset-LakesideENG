--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local limit=150
local GarbageJobMarker={
	[1]=CreatePickup(340,159992,184795,1360)
}
local GarbageDeliver={
	[1]=CreatePickup(340,160478,182220,1270)
}
for i=1,#GarbageJobMarker do
	SetPickupPropertyValue(GarbageJobMarker[i],"JobGarbage",true)
end
for i=1,#GarbageDeliver do
	SetPickupPropertyValue(GarbageDeliver[i],"JobGarbage:deliver",true)
	SetPickupScale(GarbageDeliver[i],3,3,1)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"JobGarbage")==true)then
		if(not IsPlayerInVehicle(player))then
			CallRemoteEvent(player,"open:garbageJobUI")
		end
	end
end)
AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"JobGarbage:deliver")==true)then
		if(IsPlayerInVehicle(player))then
			local veh=GetPlayerVehicle(player)
			if(veh)then
				local seat=GetPlayerVehicleSeat(player)
				if(seat==1)then
					if(GetVehiclePropertyValue(veh,"veh:garbagejob")==true)then
						if(GetVehiclePropertyValue(veh,"veh:owner")==GetPlayerName(player))then
							if(GetVehiclePropertyValue(veh,"TempTrash")>=1)then
								CallRemoteEvent(player,"MakeNotification","JOB: Trash delivered! You get ($"..GetVehiclePropertyValue(veh,"TempTrash")*22 ..")","linear-gradient(to right, #00b09b, #96c93d)")
								
								SetPlayerPropertyValue(player,"Jobmoney",GetVehiclePropertyValue(veh,"TempTrash")+GetVehiclePropertyValue(veh,"TempTrash")*22)
								SetVehiclePropertyValue(veh,"TempTrash",0)
							else
								CallRemoteEvent(player,"MakeNotification","JOB: The Truck is empty!","linear-gradient(to right, #ff5f6d, #ffc371)")
							end
						end
					end
				end
			end
		end
	end
end)


local rdmDeliveryPostions={
	{163460,214805,1310-40},
	{162878,212115,1310-40},
	{159132,211984,1310-40},
	{155991,215511,1310-40},
	{159141,219203,1310-40},
	{162223,221794,1310-40},
	{158336,222946,1310-40},
	{165311,221842,1310-40},
}
local JobVehicles={}
local JobMarker={}
local JobTimer={}
local JobObject={}
local rdm
local rdm2
AddRemoteEvent("start:job:garbage",function(player)
	if(not JobVehicles[player])then
		JobVehicles[player]=CreateVehicle(9,161112,183341,1300,0)
		SetVehicleColor(JobVehicles[player],RGB(90,0,0))
		SetVehicleLicensePlate(JobVehicles[player],"Gargabe Job")
		SetVehicleRespawnParams(JobVehicles[player],false)
		SetVehiclePropertyValue(JobVehicles[player],"veh:owner",GetPlayerName(player))
		SetVehiclePropertyValue(JobVehicles[player],"veh:fuel",100)
		SetVehiclePropertyValue(JobVehicles[player],"veh:lock",true,true)
		SetVehiclePropertyValue(JobVehicles[player],"veh:engine",false,true)
		SetVehiclePropertyValue(JobVehicles[player],"veh:garbagejob",true,true)
		SetPlayerInVehicle(player,JobVehicles[player])
		StopVehicleEngine(JobVehicles[player])
		SetVehicleHealth(JobVehicles[player],3500)
		
		SetVehiclePropertyValue(JobVehicles[player],"TempTrash",0)
		
		if(GetVehiclePropertyValue(JobVehicles[player],"veh:garbagejob")==true)then
			JobObject[player]=nil
			local rnd=math.random(1,#rdmDeliveryPostions)
			local x,y,z=rdmDeliveryPostions[rnd][1],rdmDeliveryPostions[rnd][2],rdmDeliveryPostions[rnd][3]
			if(x and y and z)then
				JobMarker[player]=CreatePickup(340,x,y,z)
				CallRemoteEvent(player,"create:GarbageWaypoint",x,y,z)
				CallRemoteEvent(player,"create:GarbageWaypointDeliver",160478,182220,1270)
				
				SetPickupPropertyValue(JobMarker[player],"deliver:garbagejob",true)
				SetPickupPropertyValue(JobMarker[player],"deliver:garbagejob:owner",GetPlayerName(player))
				SetPickupVisibility(JobMarker[player],player,true)
			end
		end
	end
end)

local rdm
AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"deliver:garbagejob")==true)then
		if(GetPickupPropertyValue(Marker,"deliver:garbagejob:owner")==GetPlayerName(player))then
			if(not IsPlayerInVehicle(player))then
				if(JobMarker[player])then
					DestroyPickup(JobMarker[player])
					CallRemoteEvent(player,"destroy:GarbageWaypoint")
				end
				JobObject[player]=1
				CallRemoteEvent(player,"MakeNotification","JOB: Go back to the Truck and Press '"..interactKey.."'","linear-gradient(to right, #00b09b, #96c93d)")
			end
		end
	end
end)

AddEvent("OnPlayerEnterVehicle",function(player,veh,seat)
    if(seat==1)then
		if(GetVehiclePropertyValue(veh,"veh:garbagejob")==true)then
			if(GetVehiclePropertyValue(veh,"veh:owner")==GetPlayerName(player))then
				if(JobTimer[player])then
					DestroyTimer(JobTimer[player])
					JobTimer[player]=nil
				end
			end
		end
	end
end)
AddEvent("OnPlayerLeaveVehicle",function(player,veh,seat)
    if(seat==1)then
		if(GetVehiclePropertyValue(veh,"veh:garbagejob")==true)then
			if(GetVehiclePropertyValue(veh,"veh:owner")==GetPlayerName(player))then
				if(not JobTimer[player])then
					JobTimer[player]=CreateTimer(function(player)
						if(JobMarker[player])then
							DestroyPickup(JobMarker[player])
							JobMarker[player]=nil
						end
						if(JobVehicles[player])then
							DestroyVehicle(JobVehicles[player])
							JobVehicles[player]=nil
						end
						JobTimer[player]=nil
						CallRemoteEvent(player,"destroy:GarbageWaypoint")
						CallRemoteEvent(player,"destroy:GarbageWaypointDeliver")
						CallRemoteEvent(player,"MakeNotification","JOB: Truck was destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
					end,2*60*1000,player)
				end
			end
		end
    end
end)

AddEvent("OnPlayerQuit",function(player)
	if(JobVehicles[player])then
		DestroyVehicle(JobVehicles[player])
		JobVehicles[player]=nil
	end
	if(JobMarker[player])then
		DestroyPickup(JobMarker[player])
		JobMarker[player]=nil
	end
	if(JobTimer[player])then
		DestroyTimer(JobTimer[player])
		JobTimer[player]=nil
	end
	if(JobObject[player])then
		DestroyTimer(JobObject[player])
		JobObject[player]=nil
	end
end)


AddRemoteEvent("interact:garbage",function(player,object)
	local veh=GetGarbageByObject(object)
	if(veh)then
		local x,y,z=GetVehicleLocation(veh)
		local x2,y2,z2=GetPlayerLocation(player)
		local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<350)then
			if(GetVehicleModel(veh)==9)then
				if(GetVehiclePropertyValue(veh,"veh:garbagejob")==true)then
					if(GetVehiclePropertyValue(veh,"veh:owner")==GetPlayerName(player))then
						if(JobObject[player])then
							if(GetVehiclePropertyValue(veh,"TempTrash")<=limit)then
								rdm=math.random(2,4)
								SetVehiclePropertyValue(veh,"TempTrash",GetVehiclePropertyValue(veh,"TempTrash")+rdm)
								
								CallRemoteEvent(player,"MakeNotification","JOB: Trash collected! (x"..rdm.."kg) ("..GetVehiclePropertyValue(veh,"TempTrash").."/"..limit..")","linear-gradient(to right, #00b09b, #96c93d)")
								
								JobObject[player]=nil
								local rnd=math.random(1,#rdmDeliveryPostions)
								local x,y,z=rdmDeliveryPostions[rnd][1],rdmDeliveryPostions[rnd][2],rdmDeliveryPostions[rnd][3]
								if(x and y and z)then
									JobMarker[player]=CreatePickup(340,x,y,z)
									CallRemoteEvent(player,"create:GarbageWaypoint",x,y,z)
									
									SetPickupPropertyValue(JobMarker[player],"deliver:garbagejob",true)
									SetPickupPropertyValue(JobMarker[player],"deliver:garbagejob:owner",GetPlayerName(player))
									SetPickupVisibility(JobMarker[player],player,true)
								end
								
								if(GetVehiclePropertyValue(veh,"TempTrash")>=limit)then
									SetVehiclePropertyValue(veh,"TempTrash",limit)
									CallRemoteEvent(player,"MakeNotification","JOB: The Vehicle is full!","linear-gradient(to right, #00b09b, #96c93d)")
								end
							else
								CallRemoteEvent(player,"MakeNotification","JOB: The Vehicle is full! ("..limit.." slots)","linear-gradient(to right, #ff5f6d, #ffc371)")
							end
						else
							CallRemoteEvent(player,"MakeNotification","JOB: You haven't a trash bag!","linear-gradient(to right, #ff5f6d, #ffc371)")
						end
					end
				end
			end
		end
	end
end)
function GetGarbageByObject(object)
	for _,v in pairs(GetAllVehicles())do
		if(v==object)then
			return v
		end
	end
	return nil
end