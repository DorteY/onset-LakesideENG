--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


--//Weed NPC's
local DealerIds
AddRemoteEvent("call:dealer",function(object)
    DealerIds=object
end)

function GetNearestDealer()
    local x,y,z=GetPlayerLocation()
	for _,v in pairs(GetStreamedNPC())do
        local x2,y2,z2=GetNPCLocation(v)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<150.0)then
            for _,i in pairs(DealerIds)do
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
        local NearestDrugDealer=GetNearestDealer()
        if(NearestDrugDealer~=0)then
            CallRemoteEvent("interact:dealer",NearestDrugDealer)       
		end
	end
end)

local dealeramount
local dealerpriceamount
AddRemoteEvent("open:dealerUI",function(amount,priceamount)
	dealeramount=amount
	dealerpriceamount=priceamount
	
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	local Dealer_GUI=UIDialog()
	Dealer_GUI.setTitle("Dealer")
	Dealer_GUI.appendTo(UIFramework)
	Dealer_GUI.setCanClose(true)
	Dealer_GUI.setMovable(false)
	Dealer_GUI.onClickClose(function(obj)
        obj.destroy()
		SetInputMode(INPUT_GAME)
		SetIgnoreLookInput(false)
		SetIgnoreMoveInput(false)
		ShowMouseCursor(false)
    end)
	
	local text=UIText()
    text.setContent("Weed: x"..dealeramount.." for $"..dealeramount*dealerpriceamount)
    text.appendTo(Dealer_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Buy x"..dealeramount.." Weed ($"..dealeramount*dealerpriceamount..")")
	Button1.onClick(function()
		CallRemoteEvent("buy:dealer:weed",dealeramount,dealerpriceamount*dealeramount)
		Dealer_GUI.destroy()
		SetInputMode(INPUT_GAME)
		SetIgnoreLookInput(false)
		SetIgnoreMoveInput(false)
		ShowMouseCursor(false)
	end)
	Button1.appendTo(Dealer_GUI)
end)