--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local TankstationsMarker={
	[1]=CreatePickup(340,42949,137142,1525),
	[2]=CreatePickup(340,42518,137142,1525),
	[3]=CreatePickup(340,42518,136749,1525),
	[4]=CreatePickup(340,42949,136765,1525),
	
	[5]=CreatePickup(340,127836,78404,1525),
	[6]=CreatePickup(340,127470,78404,1525),
	[7]=CreatePickup(340,127052,78404,1525),
	[8]=CreatePickup(340,126683,78404,1525),
	[9]=CreatePickup(340,126230,78404,1525),
	[10]=CreatePickup(340,125860,78404,1525),
	
	[11]=CreatePickup(340,170098,205587,1350),
	[12]=CreatePickup(340,170620,205587,1350),
	[13]=CreatePickup(340,170098,206099,1350),
	[14]=CreatePickup(340,170620,206099,1350),
	
	[15]=CreatePickup(340,-17153,-2170,1990),
	[16]=CreatePickup(340,-16816,-3191,1990),
	[17]=CreatePickup(340,-17166,-3324,1990),
	[18]=CreatePickup(340,-17532,-2289,1990),
	
	[19]=CreatePickup(340,-169020,-37101,1070),
	[20]=CreatePickup(340,-168670,-37101,1070),
	[21]=CreatePickup(340,-168200,-37101,1070),
	[22]=CreatePickup(340,-167842,-37101,1070)
}
for i=1,#TankstationsMarker do
	SetPickupPropertyValue(TankstationsMarker[i],"Tankstation",true)
end

local function openTankstationUI(player,Marker)
	if(GetPickupPropertyValue(Marker,"Tankstation")==true)then
		if(IsPlayerInVehicle(player))then
			local veh=GetPlayerVehicle(player)
			if(veh)then
				local seat=GetPlayerVehicleSeat(player)
				if(seat==1)then
					local cash=GetPlayerPropertyValue(player,"Money")
					CallRemoteEvent(player,"open:tankstationUI",cash,prices.vehliter,GetVehiclePropertyValue(veh,"veh:fuel"))
				end
			end
		else
			CallRemoteEvent(player,"MakeNotification","You're not in a vehicle!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end
AddEvent("OnPlayerPickupHit",openTankstationUI)


AddRemoteEvent("tank:vehicle",function(player,typ,liters)
	local veh=GetPlayerVehicle(player)
	if(veh)then
		if(IsPlayerInVehicle(player))then
			local seat=GetPlayerVehicleSeat(player)
			if(seat==1)then
				if(typ=="full")then
					if(GetPlayerPropertyValue(player,"Money")>=100*prices.vehliter)then
						SetVehiclePropertyValue(veh,"veh:fuel",100,true)
						SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-100*prices.vehliter,true)
						if(GetVehiclePropertyValue(veh,"veh:fuel")>=100)then
							SetVehiclePropertyValue(veh,"veh:fuel",100,true)
						end
					end
				elseif(typ=="liters")then
					if(GetPlayerPropertyValue(player,"Money")>=liters*prices.vehliter)then
						SetVehiclePropertyValue(veh,"veh:fuel",GetVehiclePropertyValue(veh,"veh:fuel")+liters,true)
						SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-liters*prices.vehliter,true)
						if(GetVehiclePropertyValue(veh,"veh:fuel")>=100)then
							SetVehiclePropertyValue(veh,"veh:fuel",100,true)
						end
					end
				end
			end
		end
	end
end)

AddEvent("OnPlayerLeaveVehicle",function(player,veh,seat)
    if(seat==1)then
		local owner=GetVehiclePropertyValue(veh,"veh:owner")
		local slot=GetVehiclePropertyValue(veh,"veh:slot")
		local fuel=GetVehiclePropertyValue(veh,"veh:fuel")
		local health=GetVehicleHealth(veh)
		if(owner and slot)then
			local query=mariadb_prepare(handler,"UPDATE vehicles SET Fuel='?',Health='?' WHERE Owner='?' AND Slot='?';",fuel,health,owner,slot)
			mariadb_query(handler,query)
		end
    end
end)