--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local RentalPedIds
AddRemoteEvent("call:rentalped",function(object)
    RentalPedIds=object
end)

function GetNearestRentalPed()
    local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedNPC())do
        local x2,y2,z2=GetNPCLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<130.0)then
            for _,i in pairs(RentalPedIds)do
				if(v==i)then
					return v
				end
			end
		end
	end
	return 0
end

AddEvent("OnKeyPress",function(key)
    if(key==interactKey)then
        local NearestRentalPed=GetNearestRentalPed()
        if(NearestRentalPed~=0)then
            CallRemoteEvent("interact:rentalped",NearestRentalPed)       
		end
	end
end)

AddRemoteEvent("open:rentalUI",function()
	if(Rental_GUI)then
		Rental_GUI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	Rental_GUI=UIDialog()
	Rental_GUI.setTitle("Vehicles for Rent")
	Rental_GUI.appendTo(UIFramework)
	Rental_GUI.setCanClose(true)
	Rental_GUI.setMovable(false)
	Rental_GUI.onClickClose(function(obj)
		obj.hide()
		disableRentalUiFuncs()
	end)
	
	local text=UIText()
	text.setContent("Here you can rent a vehicle for 1 hour.")
	text.appendTo(Rental_GUI)
	
	local vehicle
	local genderList=UIOptionList()
	genderList.allowMultiselection(false)
	genderList.appendOption(0,"Sedan_Classic ($450)")
	genderList.appendOption(1,"Coupe_01 ($500)")
	genderList.appendTo(Rental_GUI)
	genderList.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			vehicle=tonumber(v)
		end
	end)
	
	local Button1=UIButton()
	Button1.setTitle("Borrow")
	Button1.onClick(function()
		if(vehicle~="" and vehicle~=nil)then
			CallRemoteEvent("rent:vehicle",vehicle)
			Rental_GUI.hide()
			disableRentalUiFuncs()
		end
	end)
	Button1.appendTo(Rental_GUI)
end)


function disableRentalUiFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end