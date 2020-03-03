--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local Gate1=CreateObject(254,100210,120410,6284,0,270)

local Gate_MovedState=false
local Gate_MovingState=false

AddCommand("mv",function(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		local x,y,z=GetPlayerLocation(player)
		local dist=GetDistance3D(100210,120410,6284,x,y,z)
		if(dist<600.0)then
			if(GetPlayerPropertyValue(player,"Faction")=="Ballas")then
				if(Gate_MovingState==false)then
					Gate_MovingState=true
					if(Gate_MovedState==false)then
						SetObjectLocation(Gate1,100210,119542,6284)
						Gate_MovedState=true
						Delay(5*1000,function(Gate1)
							Gate_MovingState=false
						end,Gate1)
					else
						SetObjectLocation(Gate1,100210,120410,6284)
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
	{19,94952,120624,6435,-55},
	{19,95506,120624,6435,-55},
	{19,96091,120624,6435,-55},
	{7,99479,120690,6435,0},
	{7,98594,120690,6435,0}
}
AddEvent("OnPackageStart",function()
	local vehicles={}
	for i,v in ipairs(vehicleTable)do
		vehicles[i]=CreateVehicle(v[1],v[2],v[3],v[4],v[5])
		SetVehicleColor(vehicles[i],RGB(130,0,200))
		SetVehicleRespawnParams(vehicles[i],false)
		SetVehicleLicensePlate(vehicles[i],"Ballas")
		StopVehicleEngine(vehicles[i])
		SetVehicleHealth(vehicles[i],3500)
		
		SetVehiclePropertyValue(vehicles[i],"veh:owner","Ballas")
		SetVehiclePropertyValue(vehicles[i],"veh:fuel",100)
		SetVehiclePropertyValue(vehicles[i],"veh:lock",true,true)
		SetVehiclePropertyValue(vehicles[i],"veh:engine",false,true)
	end
end)