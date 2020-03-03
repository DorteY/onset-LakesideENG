--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local ScrapyardMarker={
	[1]=CreatePickup(340,162964,185790,1270)
}
for i=1,#ScrapyardMarker do
	SetPickupPropertyValue(ScrapyardMarker[i],"Scrapyard",true)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"Scrapyard")==true)then
		if(IsPlayerInVehicle(player))then
			CallRemoteEvent(player,"open:scrapyardUI")
		else
			CallRemoteEvent(player,"MakeNotification","You're not in a vehicle!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)

AddRemoteEvent("sell:vehicle",function(player)
	if(IsPlayerInVehicle(player))then
		local veh=GetPlayerVehicle(player)
		if(veh)then
			local id=GetVehicleModel(veh)
			local owner=GetVehiclePropertyValue(veh,"veh:owner")
			local slot=GetVehiclePropertyValue(veh,"veh:slot")
			
			if(owner and owner==GetPlayerName(player)and slot and id and id~=0)then
				local price=prices.shop.vehicles[id]
				if(price)then
					SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+price/100*35,true)
					AddPlayerChat(player,"You have selled your car for $"..tonumber(price/100*35))
					if(VehicleFuelTimer[veh])then
						DestroyTimer(VehicleFuelTimer[veh])
						VehicleFuelTimer[veh]=nil
					end
					DestroyVehicle(veh)
					
					local query=mariadb_prepare(handler,"DELETE FROM vehicles WHERE Owner='?' AND Slot='?';",owner,slot)
					mariadb_query(handler,query)
				else
					CallRemoteEvent(player,"MakeNotification","You can't sell this vehicle!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			end
		end
	end
end)