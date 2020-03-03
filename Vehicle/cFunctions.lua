--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local state=false
AddRemoteEvent("open:carshopUI",function()
	if(Carshop_GUI)then
		Carshop_GUI.destroy()
	end
	state=true
	if(state==true)then
		ShowMouseCursor(true)
		SetInputMode(INPUT_UI)
		Carshop_GUI=UIDialog()
		Carshop_GUI.setTitle("Carshop")
		Carshop_GUI.appendTo(UIFramework)
		Carshop_GUI.setCanClose(true)
		Carshop_GUI.setMovable(false)
		Carshop_GUI.onClickClose(function(obj)
			obj.hide()
			disableCarshopUIFuncs()
			state=false
		end)
		
		local text=UIText()
		text.setContent("Here you can buy a vehicle of your choice.")
		text.appendTo(Carshop_GUI)
		
		local vehicle
		local vehicleList=UIOptionList()
		vehicleList.allowMultiselection(false)
		vehicleList.appendOption(6,"Nascar_01 ($"..prices.shop.vehicles[6]..")")
		vehicleList.appendOption(12,"Rally_01 ($"..prices.shop.vehicles[12]..")")
		vehicleList.appendOption(4,"Sedan_02 ($"..prices.shop.vehicles[4]..")")
		vehicleList.appendOption(5,"Sedan_03 ($"..prices.shop.vehicles[5]..")")
		vehicleList.appendOption(11,"Coupe_01 ($"..prices.shop.vehicles[11]..")")
		vehicleList.appendOption(25,"Sedan_Classic ($"..prices.shop.vehicles[25]..")")
		vehicleList.appendOption(7,"Truck_01 ($"..prices.shop.vehicles[7]..")")
		vehicleList.appendTo(Carshop_GUI)
		vehicleList.onChange(function(obj)
			for _,v in pairs(obj.getValue())do
				vehicle=tonumber(v)
			end
		end)
		
		local Button1=UIButton()
		Button1.setTitle("Buy")
		Button1.onClick(function()
			CallRemoteEvent("buy:vehicle",vehicle)
			Carshop_GUI.hide()
			disableCarshopUIFuncs()
			state=false
		end)
		Button1.appendTo(Carshop_GUI)
	end
end)


function disableCarshopUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end

AddEvent("OnKeyPress",function(key)
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		if(key=="U")then
			CallRemoteEvent("changelockstate:vehicle")
		end
		if(key=="K")then
			if(IsPlayerInVehicle())then
				CallRemoteEvent("changeenginestate:vehicle")
			else
				CallRemoteEvent("open_close:trunk")
			end
		end
		if(key=="P")then
			CallRemoteEvent("interact:trunk")
		end
		if(key=="L")then
			CallRemoteEvent("changelightstate:vehicle")
		end
	end
end)

function OnPlayerStartEnterVehicle(veh)
    if(GetVehiclePropertyValue(veh,"veh:lock")==true)then
        return false
    end
end
AddEvent("OnPlayerStartEnterVehicle",OnPlayerStartEnterVehicle)

function OnPlayerStartExitVehicle(veh)
    if(GetVehiclePropertyValue(veh,"veh:lock")==true)then
        return false
    end
end
AddEvent("OnPlayerStartExitVehicle",OnPlayerStartExitVehicle)




function getNearestVehicle()
    local x,y,z=GetPlayerLocation()
    for _,v in pairs(GetStreamedVehicles())do
        local x2,y2,z2=GetVehicleLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<300.0)then
			return v
		end
    end
    return 0
end