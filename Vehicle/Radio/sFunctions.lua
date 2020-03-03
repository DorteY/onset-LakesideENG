--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--
--||        From: Frederic2ec        ||--


AddRemoteEvent("radio:getplayersinvehicle",function(player,radioStatus,volume,channel)
    local vehicle=GetPlayerVehicle(player)
	if(vehicle)then
		local nbSeats=GetVehicleNumberOfSeats(vehicle)
		local passengers={}
		for i=1,nbSeats do 
			passengers[i]=GetVehiclePassenger(vehicle,i)
		end
		if(GetPlayerVehicleSeat(player)==1)then
			for _,v in pairs(passengers)do
				if(v~=0)then
					if(volume~=nil)then
						CallRemoteEvent(v,"radio:setvolume",vehicle,volume)
					elseif(channel~=nil)then
						CallRemoteEvent(v,"radio:setchannel",vehicle,channel)
					else
						if(radioStatus==0)then
							CallRemoteEvent(v,"radio:turnonradio",vehicle)
						else
							CallRemoteEvent(v,"radio:turnoffradio",vehicle)
						end
					end
				end
			end
		end
    end
end)

