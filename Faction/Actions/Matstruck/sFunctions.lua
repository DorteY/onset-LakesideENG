--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local MatstruckMarker={
	[1]=CreatePickup(340,11857,136650,1520)
}
for i=1,#MatstruckMarker do
	SetPickupPropertyValue(MatstruckMarker[i],"Action:Matstruck",true)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"Action:Matstruck")==true)then
		if(not IsPlayerInVehicle(player))then
			if(isEVIL(player))then
				CallRemoteEvent(player,"open:matstruckUI")
			end
		end
	end
end)

local MTdeliverPositions={
	["Police"]={170982,190092,1280},
	["Mafia"]={111892,205251,1470},
	["Ballas"]={97883,119520,6400},
}

local Matstruck
local MatstruckDeliver
local MatstruckDelay
AddRemoteEvent("action:matstruck",function(player)
	if(isEVIL(player))then
		if(not Matstruck)then
			if(not MatstruckDelay)then
				if(GetPlayerPropertyValue(player,"Money")>=5000)then
					Matstruck=CreateVehicle(17,13221,137756,1560,90)
					SetVehicleLicensePlate(Matstruck,"MATSTRUCK")
					SetVehicleRespawnParams(Matstruck,false)
					SetVehiclePropertyValue(Matstruck,"veh:owner","Everyone")
					SetVehiclePropertyValue(Matstruck,"veh:fuel",100)
					SetVehiclePropertyValue(Matstruck,"veh:lock",false,true)
					SetVehiclePropertyValue(Matstruck,"veh:engine",false,true)
					SetVehiclePropertyValue(Matstruck,"veh:matstruck",true,true)
					StopVehicleEngine(Matstruck)
					MatstruckDelay=1
					
					Delay(30*60*1000,function()
						if(MatstruckDeliver)then
							DestroyPickup(MatstruckDeliver)
							MatstruckDeliver=nil
							MatstruckDelay=nil
						end
						CallRemoteEvent(player,"destroy:MatstruckWaypoint")
						if(Matstruck)then
							AddPlayerChatAll("<span color=\"#c80000FF\">BREAKING NEWS</>: The Matstruck was destroyed because time!")
							DestroyVehicle(Matstruck)
							Matstruck=nil
						end
					end)
					
					AddPlayerChatAll("<span color=\"#c80000FF\">BREAKING NEWS</>: A Matstruck was started!")
					
					SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-5000,true)
				end
			end
		end
	end
end)

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"deliver:matstruck")==true)then
		if(IsPlayerInVehicle(player))then
			local veh=GetPlayerVehicle(player)
			if(veh)then
				if(isEVIL(player)or isSTATE(player))then
					if(GetVehiclePropertyValue(veh,"veh:matstruck")==true)then
						if(MatstruckDeliver)then
							DestroyPickup(MatstruckDeliver)
							MatstruckDeliver=nil
						end
						CallRemoteEvent(player,"destroy:MatstruckWaypoint")
						if(Matstruck)then
							DestroyVehicle(Matstruck)
							Matstruck=nil
						end
						
						mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM factiondepots WHERE Faction='?';",GetPlayerPropertyValue(player,"Faction")),function()
							if(mariadb_get_row_count()>0)then
								local result=mariadb_get_assoc(1)
								if(result)then
									local rdm=math.random(600,1400)
									
									local ItemA=result["Mats"]
									ItemA=ItemA+rdm
									
									local query=mariadb_prepare(handler,"UPDATE factiondepots SET Mats='?' WHERE Faction='?';",
										ItemA,
										GetPlayerPropertyValue(player,"Faction")
									)
									mariadb_query(handler,query)
									
									CallRemoteEvent(player,"MakeNotification","Matstruck successfully delivered! (x"..rdm..")","linear-gradient(to right, #00b09b, #96c93d)")
									
									AddPlayerChatAll("<span color=\"#c80000FF\">BREAKING NEWS</>: Matstruck successfully delivered!")
								end
							end
						end)
					end
				end
			end
		end
	end
end)

AddEvent("OnPlayerEnterVehicle",function(player,veh,seat)
    if(seat==1)then
		if(isEVIL(player)or isSTATE(player))then
			if(GetVehiclePropertyValue(veh,"veh:matstruck")==true)then
				local faction=GetPlayerPropertyValue(player,"Faction")
				local x,y,z=MTdeliverPositions[faction][1],MTdeliverPositions[faction][2],MTdeliverPositions[faction][3]
				if(x and y and z)then
					if(MatstruckDeliver)then
						DestroyPickup(MatstruckDeliver)
						MatstruckDeliver=nil
					end
					MatstruckDeliver=CreatePickup(340,x,y,z)
					SetPickupScale(MatstruckDeliver,3,3,1)
					CallRemoteEvent(player,"create:MatstruckWaypoint",x,y,z)
					SetPickupPropertyValue(MatstruckDeliver,"deliver:matstruck",true)
				end
			end
		end
    end
end)
AddEvent("OnPlayerLeaveVehicle",function(player,veh,seat)
    if(seat==1)then
		if(isEVIL(player)or isSTATE(player))then
			if(GetVehiclePropertyValue(veh,"veh:matstruck")==true)then
				CallRemoteEvent(player,"destroy:MatstruckWaypoint")
				if(MatstruckDeliver)then
					DestroyPickup(MatstruckDeliver)
					MatstruckDeliver=nil
				end
			end
		end
	end
end)