--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local burgeramount
local donutamount
local colaamount
local spriteamount
local fuelcanamount
local weedamount
local matsamount
AddRemoteEvent("open:trunkUI",function(burger,donut,cola,sprite,fuelcan,weed,mats)
	burgeramount=burger
	donutamount=donut
	colaamount=cola
	spriteamount=sprite
	fuelcanamount=fuelcan
	weedamount=weed
	matsamount=mats
	
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	local Trunk_GUI=UIDialog()
	Trunk_GUI.setTitle("Trunk")
	Trunk_GUI.appendTo(UIFramework)
	Trunk_GUI.setCanClose(true)
	Trunk_GUI.setMovable(false)
	Trunk_GUI.onClickClose(function(obj)
        obj.destroy()
		SetInputMode(INPUT_GAME)
		SetIgnoreLookInput(false)
		SetIgnoreMoveInput(false)
		ShowMouseCursor(false)
    end)
	
	local text=UIText()
	text.setContent("Your Inventory:")
	text.appendTo(Trunk_GUI)
	
	local item
	local itemList=UIOptionList()
	itemList.allowMultiselection(false)
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Burger"))>=1)then
		itemList.appendOption("Burger","Burger (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Burger"))..")")
	end
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Donut"))>=1)then
		itemList.appendOption("Donut","Donut (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Donut"))..")")
	end
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Cola"))>=1)then
		itemList.appendOption("Cola","Cola (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Cola"))..")")
	end
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Sprite"))>=1)then
		itemList.appendOption("Sprite","Sprite (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Sprite"))..")")
	end
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Fuelcan"))>=1)then
		itemList.appendOption("Fuelcan","Fuelcan (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Fuelcan"))..")")
	end
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Weed"))>=1)then
		itemList.appendOption("Weed","Weed (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Weed"))..")")
	end
	if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Mats"))>=1)then
		itemList.appendOption("MatsMats","Mats (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Mats"))..")")
	end
	itemList.appendTo(Trunk_GUI)
	itemList.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			item=tostring(v)
		end
	end)
	
	local amount=UITextField()
	amount.setPlaceholder("Amount")
	amount.appendTo(Trunk_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("Deposit")
	Button1.onClick(function()
		if(amount.getValue()~="" and amount.getValue()~=nil)then
			CallRemoteEvent("payin_payout:vehicleitems","pay:in",item,amount.getValue())
		end
	end)
	Button1.appendTo(Trunk_GUI)
	
	--
	
	local text2=UIText()
	text2.setContent("Vehicle Inventory:")
	text2.appendTo(Trunk_GUI)
	
	local itemm
	local itemListt=UIOptionList()
	itemListt.allowMultiselection(false)
	if(burgeramount>=1)then
		itemListt.appendOption("Burger","Burger (x"..burgeramount..")")
	end
	if(donutamount>=1)then
		itemListt.appendOption("Donut","Donut (x"..donutamount..")")
	end
	if(colaamount>=1)then
		itemListt.appendOption("Cola","Cola (x"..colaamount..")")
	end
	if(spriteamount>=1)then
		itemListt.appendOption("Sprite","Sprite (x"..spriteamount..")")
	end
	if(fuelcanamount>=1)then
		itemListt.appendOption("Fuelcan","Fuelcan (x"..fuelcanamount..")")
	end
	if(weedamount>=1)then
		itemListt.appendOption("Weed","Weed (x"..weedamount..")")
	end
	if(matsamount>=1)then
		itemListt.appendOption("Mats","Mats (x"..matsamount..")")
	end
	itemListt.appendTo(Trunk_GUI)
	itemListt.onChange(function(obj)
		for _,v in pairs(obj.getValue())do
			itemm=tostring(v)
		end
	end)
	
	local amountt=UITextField()
	amountt.setPlaceholder("Amount")
	amountt.appendTo(Trunk_GUI)
	
	local Button2=UIButton()
	Button2.setTitle("Withdraw")
	Button2.onClick(function()
		if(amountt.getValue()~="" and amountt.getValue()~=nil)then
			CallRemoteEvent("payin_payout:vehicleitems","pay:out",itemm,amountt.getValue())
		end
	end)
	Button2.appendTo(Trunk_GUI)
end)