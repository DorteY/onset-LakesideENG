--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local PayNSprayMarker={
	[1]=CreatePickup(340,120652,82601,1200),
	[2]=CreatePickup(340,120652,83122,1200),
	[3]=CreatePickup(340,187487,212282,1240),
	[4]=CreatePickup(340,187487,212790,1240),
	[5]=CreatePickup(340,175795,159235,4790),
	[6]=CreatePickup(340,176109,158363,4790),
	[7]=CreatePickup(340,39274,138089,1520)
}
for i=1,#PayNSprayMarker do
	SetPickupPropertyValue(PayNSprayMarker[i],"PayNSpray",true)
end

AddEvent("OnPlayerPickupHit",function(player,Marker)
	if(GetPickupPropertyValue(Marker,"PayNSpray")==true)then
		if(IsPlayerInVehicle(player))then
			local veh=GetPlayerVehicle(player)
			if(veh)then
				local seat=GetPlayerVehicleSeat(player)
				if(seat==1)then
					if(GetPlayerPropertyValue(player,"Money")>=prices.pnsrepair)then
						SetVehicleHealth(veh,3500)
						for i=1,8 do
							SetVehicleDamage(veh,i,0.0)
						end
						SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-prices.pnsrepair,true)
						CallRemoteEvent(player,"MakeNotification","Vehicle successfully repaired!","linear-gradient(to right, #00b09b, #96c93d)")
					else
						CallRemoteEvent(player,"MakeNotification","You haven't enough money!","linear-gradient(to right, #ff5f6d, #ffc371)")
					end
				end
			end
		else
			CallRemoteEvent(player,"MakeNotification","You're not in a vehicle!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)