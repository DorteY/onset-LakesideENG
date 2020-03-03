--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local Gate1=CreateObject(247,110190,202717,1387)
local Gate2=CreateObject(247,109890,202717,1387)

local Gate_MovedState=false
local Gate_MovingState=false

AddCommand("mv",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		local x,y,z=GetPlayerLocation(player)
		local dist=GetDistance3D(110190,202717,1387,x,y,z)
		if(dist<600.0)then
			if(GetPlayerPropertyValue(player,"Faction")=="Mafia")then
				if(Gate_MovingState==false)then
					Gate_MovingState=true
					if(Gate_MovedState==false)then
						SetObjectLocation(Gate1,110360,202717,1387)
						SetObjectLocation(Gate2,109700,202717,1387)
						Gate_MovedState=true
						Delay(5*1000,function(Gate1)
							Gate_MovingState=false
						end,Gate1)
					else
						SetObjectLocation(Gate1,110190,202717,1387)
						SetObjectLocation(Gate2,109890,202717,1387)
						Gate_MovedState=false
						Delay(5*1000,function(Gate1)
							Gate_MovingState=false
						end,Gate1)
					end
				end
			end
		end
	end
end)




local vehicleTable={
	{19,111271,205820,1480,-90},
	{19,110870,205820,1480,-90},
	{19,110450,205820,1480,-90},
	{7,108591,205860,1480,-90},
	{7,108591,206600,1480,-90},
}
AddEvent("OnPackageStart",function()
	local vehicles={}
	for i,v in ipairs(vehicleTable)do
		vehicles[i]=CreateVehicle(v[1],v[2],v[3],v[4],v[5])
		SetVehicleColor(vehicles[i],RGB(25,25,25))
		SetVehicleRespawnParams(vehicles[i],false)
		SetVehicleLicensePlate(vehicles[i],"MAFIA")
		StopVehicleEngine(vehicles[i])
		SetVehicleHealth(vehicles[i],3500)
		
		SetVehiclePropertyValue(vehicles[i],"veh:owner","Mafia")
		SetVehiclePropertyValue(vehicles[i],"veh:fuel",100)
		SetVehiclePropertyValue(vehicles[i],"veh:lock",true,true)
		SetVehiclePropertyValue(vehicles[i],"veh:engine",false,true)
	end
end)