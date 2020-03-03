--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


Vehicles={}
local spawnX,spawnY,spawnZ,spawnROT=161098,191541,1370,270

local Carshop=CreatePickup(340,163330,191647,1290)
SetPickupPropertyValue(Carshop,"Carshop",true)

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"Carshop")==true)then
		if(not IsPlayerInVehicle(player))then
			CallRemoteEvent(player,"open:carshopUI")
		end
	end
end)

AddRemoteEvent("buy:vehicle",function(player,id)
	local freeslot=Random(1,99999999)
	
	if(id)then
		if(GetPlayerPropertyValue(player,"Money")>=prices.shop.vehicles[id])then
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.shop.vehicles[id],true)
			
			local query=mariadb_prepare(handler,"INSERT INTO vehicles (ID,VehID,SteamID,Owner,Slot,Fuel,Health,spawnX,spawnY,spawnZ,spawnROT) VALUES (NULL,'?','?','?','?','?','?','?','?','?','?');",
				id,
				tostring(GetPlayerSteamId(player)),
				GetPlayerName(player),
				freeslot,
				100,
				3500,
				spawnX,
				spawnY,
				spawnZ,
				spawnROT
			)
			mariadb_query(handler,query)
			
			Vehicles[GetPlayerName(player)..freeslot]=CreateVehicle(id,spawnX,spawnY,spawnZ,spawnROT)
			SetVehicleLicensePlate(Vehicles[GetPlayerName(player)..freeslot],GetPlayerName(player))
			SetVehicleRespawnParams(Vehicles[GetPlayerName(player)..freeslot],false)
			SetVehiclePropertyValue(Vehicles[GetPlayerName(player)..freeslot],"veh:owner",GetPlayerName(player))
			SetVehiclePropertyValue(Vehicles[GetPlayerName(player)..freeslot],"veh:slot",freeslot)
			SetVehiclePropertyValue(Vehicles[GetPlayerName(player)..freeslot],"veh:fuel",100)
			SetVehiclePropertyValue(Vehicles[GetPlayerName(player)..freeslot],"veh:lock",true,true)
			SetVehiclePropertyValue(Vehicles[GetPlayerName(player)..freeslot],"veh:engine",false,true)
			SetPlayerInVehicle(player,Vehicles[GetPlayerName(player)..freeslot])
			StopVehicleEngine(Vehicles[GetPlayerName(player)..freeslot])
			SetVehicleHealth(Vehicles[GetPlayerName(player)..freeslot],3500)
			
			CallRemoteEvent(player,"MakeNotification","Vehicle successfully bought","linear-gradient(to right, #0593ff, #00f3ff)")
		else
			CallRemoteEvent(player,"MakeNotification","You haven't enough money!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)

AddEvent("database:connected",function()
	mariadb_query(handler,"SELECT * FROM vehicles;",function()
		for i=1,mariadb_get_row_count()do
			local result=mariadb_get_assoc(i)
			if(result)then
				local vehid=result["VehID"]
				local owner=result["Owner"]
				local slot=tonumber(result["Slot"])
				local fuel=tonumber(result["Fuel"])
				local health=result["Health"]
				local x=result["spawnX"]
				local y=result["spawnY"]
				local z=result["spawnZ"]
				local rot=result["spawnROT"]
				
				if(not Vehicles[owner..slot])then
					Vehicles[owner..slot]=CreateVehicle(vehid,x,y,z,rot)
					SetVehicleLicensePlate(Vehicles[owner..slot],owner)
					SetVehicleRespawnParams(Vehicles[owner..slot],false)
					StopVehicleEngine(Vehicles[owner..slot])
					SetVehicleHealth(Vehicles[owner..slot],health)
					
					SetVehiclePropertyValue(Vehicles[owner..slot],"veh:owner",owner)
					SetVehiclePropertyValue(Vehicles[owner..slot],"veh:slot",slot)
					SetVehiclePropertyValue(Vehicles[owner..slot],"veh:fuel",fuel)
					SetVehiclePropertyValue(Vehicles[owner..slot],"veh:lock",true,true)
					SetVehiclePropertyValue(Vehicles[owner..slot],"veh:engine",false,true)
				end
			end
		end
	end)
end)



function GetNearestCar(player)
    local x,y,z=GetPlayerLocation(player)
    for _,v in pairs(GetAllVehicles())do
        local x2,y2,z2=GetVehicleLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
        if(dist<250.0)then
            return v
        end
    end
    return 0
end
function GetNearestCarT(player)
    local x,y,z=GetPlayerLocation(player)
    for _,v in pairs(GetAllVehicles())do
        local x2,y2,z2=GetVehicleLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
        if(dist<350.0)then
            return v
        end
    end
    return 0
end

AddCommand("park",function(player)
	if(IsPlayerInVehicle(player))then
		local veh=GetPlayerVehicle(player)
		if(veh)then
			local owner=GetVehiclePropertyValue(veh,"veh:owner")
			local slot=GetVehiclePropertyValue(veh,"veh:slot")
			local fuel=GetVehiclePropertyValue(veh,"veh:fuel")
			local health=GetVehicleHealth(veh)
			local x,y,z=GetVehicleLocation(veh)
			local rot=GetVehicleHeading(veh)
			
			if(owner==GetPlayerName(player)and slot)then
				if(x and y and z and rot)then
					local query=mariadb_prepare(handler,"UPDATE vehicles SET Fuel='?',Health='?',spawnX='?',spawnY='?',spawnZ='?',spawnROT='?' WHERE Owner='?' AND Slot='?';",
						fuel,
						health,
						x,
						y,
						z,
						rot,
						owner,
						slot
					)
					mariadb_query(handler,query)
					
					CallRemoteEvent(player,"MakeNotification","Vehicle parked!","linear-gradient(to right, #0593ff, #00f3ff)")
				end
			end
		end
	end
end)


AddEvent("OnPlayerEnterVehicle",function(player,veh,seat)
    if(seat==1)then
      	if(GetVehiclePropertyValue(veh,"veh:engine")==true)then
			StartVehicleEngine(veh)
		elseif(GetVehiclePropertyValue(veh,"veh:engine")==false)then
			StopVehicleEngine(veh)
		end
		if(GetVehiclePropertyValue(veh,"veh:fuel")>=100)then
			SetVehiclePropertyValue(veh,"veh:fuel",100)
		end
    end
end)
AddEvent("OnPlayerLeaveVehicle",function(player,veh,seat)
	if(veh)then
		if(seat==1)then
			if(GetVehiclePropertyValue(veh,"veh:engine")==true)then
				StartVehicleEngine(veh)
			elseif(GetVehiclePropertyValue(veh,"veh:engine")==false)then
				StopVehicleEngine(veh)
			end
		end
		if(GetVehicleHealth(veh)==0)then
			StopVehicleEngine(veh)
			if(VehicleFuelTimer[veh])then
				DestroyTimer(VehicleFuelTimer[veh])
				VehicleFuelTimer[veh]=nil
			end
		end
		if(GetVehiclePropertyValue(veh,"veh:fuel")>=100)then
			SetVehiclePropertyValue(veh,"veh:fuel",100)
		end
	end
end)

VehicleFuelTimer={}
AddRemoteEvent("changeenginestate:vehicle",function(player)
	local veh=GetPlayerVehicle(player)
	if(veh)then
		if(veh~=0)then
			if(GetVehiclePropertyValue(veh,"veh:owner")==GetPlayerName(player)or GetVehiclePropertyValue(veh,"veh:owner")==GetPlayerPropertyValue(player,"Faction")or GetVehiclePropertyValue(veh,"veh:owner")=="Everyone")then
				if(GetPlayerVehicleSeat(player)~=1)then
					return
				else
					if(GetVehicleEngineState(veh))then
						StopVehicleEngine(veh)
						SetVehiclePropertyValue(veh,"veh:engine",false,true)
						if(VehicleFuelTimer[veh])then
							DestroyTimer(VehicleFuelTimer[veh])
							VehicleFuelTimer[veh]=nil
						end
					else
						if(GetVehiclePropertyValue(veh,"veh:fuel")and tonumber(GetVehiclePropertyValue(veh,"veh:fuel"))>=1)then
							StartVehicleEngine(veh)
							SetVehiclePropertyValue(veh,"veh:engine",true,true)
							if(GetPlayerPropertyValue(player,"Tutorial")==4)then
								setTutorialQuests(player)
							end
							if(GetVehiclePropertyValue(veh,"veh:owner")and GetVehiclePropertyValue(veh,"veh:slot"))then
								vehFuelFunc(veh)
							end
						end
					end
				end
			end
		end
	end
end)
function vehFuelFunc(veh)
	local rdm=Random(18,30)
	if(veh)then
		VehicleFuelTimer[veh]=CreateTimer(function(veh)
			if(GetVehiclePropertyValue(veh,"veh:fuel")~=0)then
				SetVehiclePropertyValue(veh,"veh:fuel",GetVehiclePropertyValue(veh,"veh:fuel")-1,true)
				
				if(GetVehiclePropertyValue(veh,"veh:fuel")<1)then
					StopVehicleEngine(veh)
					SetVehiclePropertyValue(veh,"veh:engine",false,true)
				end
			end
		end,rdm*1000,veh)
	end
end

AddRemoteEvent("changelightstate:vehicle",function(player)
	local veh=GetPlayerVehicle(player)
	if(veh)then
		if(veh~=0)then
			if(GetVehicleLightState(veh)==true)then
				SetVehicleLightEnabled(veh,false)
			else
				SetVehicleLightEnabled(veh,true)
			end
		end
	end
end)

AddRemoteEvent("changelockstate:vehicle",function(player)
    local nearestCar=GetNearestCar(player)
	if(nearestCar~=0)then
		if(GetVehiclePropertyValue(nearestCar,"veh:owner")==GetPlayerName(player)or GetVehiclePropertyValue(nearestCar,"veh:owner")==GetPlayerPropertyValue(player,"Faction"))then
			if(GetVehiclePropertyValue(nearestCar,"veh:lock")==true)then
				SetVehiclePropertyValue(nearestCar,"veh:lock",false,true)
				CallRemoteEvent(player,"PlayAudioFile","Lock.mp3",0.3)
				CallRemoteEvent(player,"MakeNotification","Vehicle unlocked!","linear-gradient(to right, #ff5f6d, #ffc371)")
				if(GetPlayerPropertyValue(player,"Tutorial")==3)then
					setTutorialQuests(player)
				end
			else
				SetVehiclePropertyValue(nearestCar,"veh:lock",true,true)
				CallRemoteEvent(player,"PlayAudioFile","unLock.mp3",0.3)
				CallRemoteEvent(player,"MakeNotification","Vehicle locked!","linear-gradient(to right, #ff5f6d, #ffc371)")
				if(GetPlayerPropertyValue(player,"Tutorial")==3)then
					setTutorialQuests(player)
				end
			end
		end
	end
end)