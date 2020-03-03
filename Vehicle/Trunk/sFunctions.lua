--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("open_close:trunk",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(not IsPlayerInVehicle(player))then
			local veh=GetNearestCarT(player)
			if(veh)then
				local owner=GetVehiclePropertyValue(veh,"veh:owner")
				local slot=GetVehiclePropertyValue(veh,"veh:slot")
				
				if(owner==GetPlayerName(player)or isSTATE(player)and slot)then
					if(GetVehiclePropertyValue(veh,"veh:lock")==false)then
						if(GetVehicleTrunkRatio(veh)==65)then
							SetVehicleTrunkRatio(veh,0)
						else
							SetVehicleTrunkRatio(veh,65)
						end
					end
				end
			end
		end
	end
end)

AddRemoteEvent("interact:trunk",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		local veh=GetNearestCarT(player)
		if(veh)then
			if(GetVehicleTrunkRatio(veh)==65)then
				local owner=GetVehiclePropertyValue(veh,"veh:owner")
				local slot=GetVehiclePropertyValue(veh,"veh:slot")
				
				if(owner and slot)then
					mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM vehicles WHERE Owner='?' AND Slot='?';",owner,slot),function()
						if(mariadb_get_row_count()>0)then
							local result=mariadb_get_assoc(1)
							if(result)then
								CallRemoteEvent(player,"open:trunkUI",tonumber(result["Burger"]),tonumber(result["Donut"]),tonumber(result["Cola"]),tonumber(result["Sprite"]),tonumber(result["Fuelcan"]),tonumber(result["Weed"]),tonumber(result["Mats"]))
							end
						else
							CallRemoteEvent(player,"MakeNotification","This Vehicle hasn't a Trunk!","linear-gradient(to right, #ff5f6d, #ffc371)")
						end
					end)
				end
			end
		end
	end
end)

AddRemoteEvent("payin_payout:vehicleitems",function(player,typ,item,amount)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		local veh=GetNearestCarT(player)
		if(veh)then
			if(GetVehicleTrunkRatio(veh)==65)then
				local owner=GetVehiclePropertyValue(veh,"veh:owner")
				local slot=GetVehiclePropertyValue(veh,"veh:slot")
				
				if(owner and slot)then
					mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM vehicles WHERE Owner='?' AND Slot='?';",owner,slot),function()
						if(typ=="pay:in")then
							if(item=="Burger" or item=="Donut" or item=="Cola" or item=="Sprite" or item=="Fuelcan" or item=="Weed" or item=="Mats")then
								if(tonumber(GetPlayerPropertyValue(player,item))>=tonumber(amount))then
									SetPlayerPropertyValue(player,item,tonumber(GetPlayerPropertyValue(player,item))-tonumber(amount))
									
									local result=mariadb_get_assoc(1)
									if(result)then
										local ItemA=result[item]
										ItemA=ItemA+tonumber(amount)
										
										local query=mariadb_prepare(handler,"UPDATE vehicles SET "..item.."='?' WHERE Owner='?' AND Slot='?';",
											ItemA,
											owner,
											slot
										)
										mariadb_query(handler,query)
										
										CallRemoteEvent(player,"MakeNotification","You deposited "..item.." x"..amount,"linear-gradient(to right, #00b09b, #96c93d)")
									end
								else
									CallRemoteEvent(player,"MakeNotification","You haven't "..item.." x"..amount.."!","linear-gradient(to right, #ff5f6d, #ffc371)")
								end
							end
						elseif(typ=="pay:out")then
							if(item=="Burger" or item=="Donut" or item=="Cola" or item=="Sprite" or item=="Fuelcan" or item=="Weed" or item=="Mats")then
								local result=mariadb_get_assoc(1)
								if(result)then
									ItemAA=result[item]
									if(ItemAA>=amount)then
										if(item=="Burger")then
											if(GetPlayerPropertyValue(player,"Burger")+amount>30)then
												return CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Burger!","linear-gradient(to right, #ff5f6d, #ffc371)")
											end
										end
										if(item=="Donut")then
											if(GetPlayerPropertyValue(player,"Donut")+amount>30)then
												return CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Donut!","linear-gradient(to right, #ff5f6d, #ffc371)")
											end
										end
										if(item=="Cola")then
											if(GetPlayerPropertyValue(player,"Cola")+amount>30)then
												return CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Cola!","linear-gradient(to right, #ff5f6d, #ffc371)")
											end
										end
										if(item=="Sprite")then
											if(GetPlayerPropertyValue(player,"Sprite")+amount>30)then
												return CallRemoteEvent(player,"MakeNotification","You cannot own more than x30 Sprite!","linear-gradient(to right, #ff5f6d, #ffc371)")
											end
										end
										if(item=="Fuelcan")then
											if(GetPlayerPropertyValue(player,"Fuelcan")+amount>2)then
												return CallRemoteEvent(player,"MakeNotification","You cannot own more than x2 Fuelcan!","linear-gradient(to right, #ff5f6d, #ffc371)")
											end
										end
										
										SetPlayerPropertyValue(player,item,tonumber(GetPlayerPropertyValue(player,item))+tonumber(amount))
										
										ItemAA=ItemAA-tonumber(amount)
										
										local query=mariadb_prepare(handler,"UPDATE vehicles SET "..item.."='?' WHERE Owner='?' AND Slot='?';",
											ItemAA,
											owner,
											slot
										)
										mariadb_query(handler,query)
										
										CallRemoteEvent(player,"MakeNotification","You have taken out "..item.." x"..amount,"linear-gradient(to right, #00b09b, #96c93d)")
									else
										CallRemoteEvent(player,"MakeNotification","That much "..item.." x"..amount.." is no longer in the trunk!","linear-gradient(to right, #ff5f6d, #ffc371)")
									end
								end
							end
						end
					end)
				end
			end
		end
	end
end)










