--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local TruckJobMarker={
	[1]=CreatePickup(340,200368,171892,1260)
}
for i=1,#TruckJobMarker do
	SetPickupPropertyValue(TruckJobMarker[i],"JobLKW",true)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"JobLKW")==true)then
		if(not IsPlayerInVehicle(player))then
			local lvl=GetPlayerPropertyValue(player,"LVL:Truck")
			local exp=GetPlayerPropertyValue(player,"EXP:Truck")
			local expp=level.job[GetPlayerPropertyValue(player,"LVL:Truck")]
			if(lvl and exp and expp)then
				CallRemoteEvent(player,"open:lkwJobUI",lvl,exp,expp)
			end
		end
	end
end)


local rdmDeliveryPostions={
	{140022,207711,1200},
	{93751,213690,2900},
	{148236,213040,1200},
	{76870,184889,500},
	{212014,192804,1280},
	{216796,154039,1280},
}
local JobVehicles={}
local JobMarker={}
local VehID
local rdm
local rdm2
AddRemoteEvent("start:job:trucker",function(player,typ)
	if(not JobVehicles[player])then
		if(typ==0)then
			VehID=22
		elseif(typ==1)then
			VehID=24
		elseif(typ==2)then
			VehID=17
		end
		JobVehicles[player]=CreateVehicle(VehID,201464,172076,1310,180)
		SetVehicleColor(JobVehicles[player],RGB(0,0,0))
		SetVehicleLicensePlate(JobVehicles[player],"Trucker Job")
		SetVehicleRespawnParams(JobVehicles[player],false)
		SetVehiclePropertyValue(JobVehicles[player],"veh:owner",GetPlayerName(player))
		SetVehiclePropertyValue(JobVehicles[player],"veh:fuel",100)
		SetVehiclePropertyValue(JobVehicles[player],"veh:lock",true,true)
		SetVehiclePropertyValue(JobVehicles[player],"veh:engine",false,true)
		SetVehiclePropertyValue(JobVehicles[player],"veh:truckjob",true,true)
		SetPlayerInVehicle(player,JobVehicles[player])
		StopVehicleEngine(JobVehicles[player])
		SetVehicleHealth(JobVehicles[player],3500)
		
		SetPlayerPropertyValue(player,"TempTYP",typ)
		
		if(GetVehiclePropertyValue(JobVehicles[player],"veh:truckjob")==true)then
			local rnd=math.random(1,#rdmDeliveryPostions)
			local x,y,z=rdmDeliveryPostions[rnd][1],rdmDeliveryPostions[rnd][2],rdmDeliveryPostions[rnd][3]
			if(x and y and z)then
				JobMarker[player]=CreatePickup(340,x,y,z)
				CallRemoteEvent(player,"create:TruckerWaypoint",x,y,z)
				
				SetPickupPropertyValue(JobMarker[player],"deliver:truckjob",true)
				SetPickupPropertyValue(JobMarker[player],"deliver:truckjob:owner",GetPlayerName(player))
				SetPickupVisibility(JobMarker[player],player,true)
			end
		end
	end
end)

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"deliver:truckjob")==true)then
		if(GetPickupPropertyValue(Marker,"deliver:truckjob:owner")==GetPlayerName(player))then
			if(IsPlayerInVehicle(player))then
				if(GetPlayerPropertyValue(player,"TempTYP")==0)then
					rdm=math.random(85,185)
					rdm2=math.random(1,3)
				elseif(GetPlayerPropertyValue(player,"TempTYP")==1)then
					rdm=math.random(220,355)
					rdm2=math.random(2,6)
				elseif(GetPlayerPropertyValue(player,"TempTYP")==2)then
					rdm=math.random(370,650)
					rdm2=math.random(3,9)
				end
				CallRemoteEvent(player,"MakeNotification","JOB: Box delivered! You get $"..rdm,"linear-gradient(to right, #00b09b, #96c93d)")
				if(JobMarker[player])then
					DestroyPickup(JobMarker[player])
					CallRemoteEvent(player,"destroy:TruckerWaypoint")
				end
				local rnd=math.random(1,#rdmDeliveryPostions)
				local x,y,z=rdmDeliveryPostions[rnd][1],rdmDeliveryPostions[rnd][2],rdmDeliveryPostions[rnd][3]
				if(x and y and z)then
					JobMarker[player]=CreatePickup(340,x,y,z)
					CallRemoteEvent(player,"create:TruckerWaypoint",x,y,z)
					
					SetPickupPropertyValue(JobMarker[player],"deliver:truckjob",true)
					SetPickupPropertyValue(JobMarker[player],"deliver:truckjob:owner",GetPlayerName(player))
					SetPickupVisibility(JobMarker[player],player,true)
					
					if(GetPlayerPropertyValue(player,"Tutorial")==7)then
						setTutorialQuests(player)
					end
					
					SetPlayerPropertyValue(player,"Jobmoney",GetPlayerPropertyValue(player,"Jobmoney")+rdm,true)
					SetPlayerPropertyValue(player,"EXP:Truck",GetPlayerPropertyValue(player,"EXP:Truck")+rdm2,true)
					CallRemoteEvent(player,"level:player","Truck")
				end
			end
		end
	end
end)

AddEvent("OnPlayerLeaveVehicle",function(player,veh,seat)
    if(seat==1)then
		if(GetVehiclePropertyValue(veh,"veh:truckjob")==true)then
			if(GetVehiclePropertyValue(veh,"veh:owner")==GetPlayerName(player))then
				if(JobMarker[player])then
					DestroyPickup(JobMarker[player])
					JobMarker[player]=nil
				end
				CallRemoteEvent(player,"destroy:TruckerWaypoint")
				if(JobVehicles[player])then
					DestroyVehicle(JobVehicles[player])
					JobVehicles[player]=nil
				end
				SetPlayerPropertyValue(player,"TempTYP",nil)
				SetPlayerLocation(player,200165,171914,1320+250)
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
end)