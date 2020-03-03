--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("use:item",function(player,item)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(item==0)then
			if(GetPlayerPropertyValue(player,"Burger")>=1)then
				if(GetPlayerPropertyValue(player,"hunger")<=95)then
					local rdm=math.random(11,18)
					SetPlayerPropertyValue(player,"Burger",GetPlayerPropertyValue(player,"Burger")-1,true)
					SetPlayerPropertyValue(player,"hunger",GetPlayerPropertyValue(player,"hunger")+rdm,true)
					if(GetPlayerPropertyValue(player,"hunger")>=100)then
						SetPlayerPropertyValue(player,"hunger",100)
					end
					SetPlayerAnimation(player,"DRINKING")
					
					CallRemoteEvent(player,"MakeNotification","You eat a Burger!","linear-gradient(to right, #00b09b, #96c93d)")
				else
					CallRemoteEvent(player,"MakeNotification","You have enough hunger!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(item==1)then
			if(GetPlayerPropertyValue(player,"Donut")>=1)then
				if(GetPlayerPropertyValue(player,"hunger")<=95)then
					local rdm=math.random(9,15)
					SetPlayerPropertyValue(player,"Donut",GetPlayerPropertyValue(player,"Donut")-1,true)
					SetPlayerPropertyValue(player,"hunger",GetPlayerPropertyValue(player,"hunger")+rdm,true)
					if(GetPlayerPropertyValue(player,"hunger")>=100)then
						SetPlayerPropertyValue(player,"hunger",100)
					end
					SetPlayerAnimation(player,"DRINKING")
					
					CallRemoteEvent(player,"MakeNotification","You eat a Donut!","linear-gradient(to right, #00b09b, #96c93d)")
				else
					CallRemoteEvent(player,"MakeNotification","You have enough hunger!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(item==2)then
			if(GetPlayerPropertyValue(player,"Cola")>=1)then
				if(GetPlayerPropertyValue(player,"thirst")<=95)then
					local rdm=math.random(6,12)
					SetPlayerPropertyValue(player,"Cola",GetPlayerPropertyValue(player,"Cola")-1,true)
					SetPlayerPropertyValue(player,"thirst",GetPlayerPropertyValue(player,"thirst")+rdm,true)
					if(GetPlayerPropertyValue(player,"thirst")>=100)then
						SetPlayerPropertyValue(player,"thirst",100)
					end
					SetPlayerAnimation(player,"DRINKING")
					
					CallRemoteEvent(player,"MakeNotification","You drink a Cola!","linear-gradient(to right, #00b09b, #96c93d)")
				else
					CallRemoteEvent(player,"MakeNotification","You have enough thirst!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(item==3)then
			if(GetPlayerPropertyValue(player,"Sprite")>=1)then
				if(GetPlayerPropertyValue(player,"thirst")<=95)then
					local rdm=math.random(6,12)
					SetPlayerPropertyValue(player,"Sprite",GetPlayerPropertyValue(player,"Sprite")-1,true)
					SetPlayerPropertyValue(player,"thirst",GetPlayerPropertyValue(player,"thirst")+rdm,true)
					if(GetPlayerPropertyValue(player,"thirst")>=100)then
						SetPlayerPropertyValue(player,"thirst",100)
					end
					SetPlayerAnimation(player,"DRINKING")
					
					CallRemoteEvent(player,"MakeNotification","You drink a Sprite!","linear-gradient(to right, #00b09b, #96c93d)")
				else
					CallRemoteEvent(player,"MakeNotification","You have enough thirst!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(item==5)then
			if(GetPlayerPropertyValue(player,"Fuelcan")>=1)then
				if(IsPlayerInVehicle(player))then
					local veh=GetPlayerVehicle(player)
					if(veh)then
						if(GetVehiclePropertyValue(veh,"veh:fuel")<=90)then
							SetPlayerPropertyValue(player,"Fuelcan",GetPlayerPropertyValue(player,"Fuelcan")-1,true)
							SetVehiclePropertyValue(veh,"veh:fuel",GetVehiclePropertyValue(veh,"veh:fuel")+25,true)
							if(GetVehiclePropertyValue(veh,"veh:fuel")>=100)then
								SetVehiclePropertyValue(veh,"veh:fuel",100)
							end
							
							CallRemoteEvent(player,"MakeNotification","You used a Fuelcan!","linear-gradient(to right, #00b09b, #96c93d)")
						else
							CallRemoteEvent(player,"MakeNotification","This vehicle has enough fuel!","linear-gradient(to right, #ff5f6d, #ffc371)")
						end
					end
				else
					CallRemoteEvent(player,"MakeNotification","You're not in a vehicle!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(item==6)then
			if(GetPlayerPropertyValue(player,"Repairkit")>=1)then
				if(IsPlayerInVehicle(player))then
					local veh=GetPlayerVehicle(player)
					if(veh)then
						SetPlayerPropertyValue(player,"Repairkit",GetPlayerPropertyValue(player,"Repairkit")-1,true)
						Delay(10*1000,function(veh)
							SetVehicleHealth(veh,3500)
						end,veh)
						
						CallRemoteEvent(player,"MakeNotification","You used a Repairkit!","linear-gradient(to right, #00b09b, #96c93d)")
					end
				else
					CallRemoteEvent(player,"MakeNotification","You're not in a vehicle!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				CallRemoteEvent(player,"MakeNotification","You haven't this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(item==7)then
			if(GetPlayerPropertyValue(player,"Armor")>=1)then
				SetPlayerPropertyValue(player,"Armor",GetPlayerPropertyValue(player,"Armor")-1,true)
				SetPlayerArmor(player,100)
				
				CallRemoteEvent(player,"MakeNotification","You used a Armor!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You haven't this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		elseif(item==17)then
			if(GetPlayerPropertyValue(player,"Weed")>=3)then
				SetPlayerPropertyValue(player,"Weed",GetPlayerPropertyValue(player,"Weed")-3,true)
				CallRemoteEvent(player,"play:weed")
				SetPlayerAnimation(player,"SMOKING")
				
				CallRemoteEvent(player,"MakeNotification","You smoking Weed!","linear-gradient(to right, #00b09b, #96c93d)")
			else
				CallRemoteEvent(player,"MakeNotification","You haven't enough Weed! (x3)","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		else
			CallRemoteEvent(player,"MakeNotification","You can't use this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)


AddRemoteEvent("destroy:item",function(player,item)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(item==0)then
			if(GetPlayerPropertyValue(player,"Burger")>=1)then
				SetPlayerPropertyValue(player,"Burger",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(item==1)then
			if(GetPlayerPropertyValue(player,"Donut")>=1)then
				SetPlayerPropertyValue(player,"Donut",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(item==2)then
			if(GetPlayerPropertyValue(player,"Cola")>=1)then
				SetPlayerPropertyValue(player,"Cola",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(item==3)then
			if(GetPlayerPropertyValue(player,"Sprite")>=1)then
				SetPlayerPropertyValue(player,"Sprite",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(item==5)then
			if(GetPlayerPropertyValue(player,"Fuelcan")>=1)then
				SetPlayerPropertyValue(player,"Fuelcan",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(item==6)then
			if(GetPlayerPropertyValue(player,"Repairkit")>=1)then
				SetPlayerPropertyValue(player,"Repairkit",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(item==17)then
			if(GetPlayerPropertyValue(player,"Weed")>=1)then
				SetPlayerPropertyValue(player,"Weed",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		elseif(item==18)then
			if(GetPlayerPropertyValue(player,"Mats")>=1)then
				SetPlayerPropertyValue(player,"Mats",0,true)
				CallRemoteEvent(player,"MakeNotification","Item successfully destroyed!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		else
			CallRemoteEvent(player,"MakeNotification","You can't destroy this item!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end
end)