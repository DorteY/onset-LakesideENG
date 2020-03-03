--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddEvent("OnKeyPress",function(key)
	if(GetPlayerPropertyValue(GetPlayerId(),"Loggedin")==1)then
		if(key=="I")then
			ShowMouseCursor(true)
			SetInputMode(INPUT_UI)
			Inventory_GUI=UIDialog()
			Inventory_GUI.setTitle("Inventory")
			Inventory_GUI.appendTo(UIFramework)
			Inventory_GUI.setCanClose(true)
			Inventory_GUI.setMovable(false)
			Inventory_GUI.onClickClose(function(obj)
				obj.destroy()
				disableInventoeyUIFuncs()
			end)
			
			local text=UIText()
			text.setContent("Here you can see your own items")
			text.appendTo(Inventory_GUI)
			
			local item
			local inventoryItemList=UIOptionList()
			inventoryItemList.allowMultiselection(false)
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Burger"))>=1)then
				inventoryItemList.appendOption(0,"Burger (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Burger"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Donut"))>=1)then
				inventoryItemList.appendOption(1,"Donut (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Donut"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Cola"))>=1)then
				inventoryItemList.appendOption(2,"Cola (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Cola"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Sprite"))>=1)then
				inventoryItemList.appendOption(3,"Sprite (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Sprite"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Fuelcan"))>=1)then
				inventoryItemList.appendOption(5,"Fuelcan (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Fuelcan"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Repairkit"))>=1)then
				inventoryItemList.appendOption(6,"Repairkit (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Repairkit"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Armor"))>=1)then
				inventoryItemList.appendOption(7,"Armor (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Armor"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Weed"))>=1)then
				inventoryItemList.appendOption(17,"Weed (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Weed"))..")")
			end
			if(tonumber(GetPlayerPropertyValue(GetPlayerId(),"Mats"))>=1)then
				inventoryItemList.appendOption(18,"Mats (x"..tonumber(GetPlayerPropertyValue(GetPlayerId(),"Mats"))..")")
			end
			inventoryItemList.appendTo(Inventory_GUI)
			inventoryItemList.onChange(function(obj)
				for _,v in pairs(obj.getValue())do
					item=tonumber(v)
				end
			end)
			
			local Button1=UIButton()
			Button1.setTitle("Use selected item")
			Button1.onClick(function()
				CallRemoteEvent("use:item",item)
			end)
			Button1.appendTo(Inventory_GUI)
			
			local Button2=UIButton()
			Button2.setTitle("Destroy selected item")
			Button2.setType("secondary")
			Button2.onClick(function()
				CallRemoteEvent("destroy:item",item)
			end)
			Button2.appendTo(Inventory_GUI)
		end
    end
end)

function disableInventoeyUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end



local State=false
AddRemoteEvent("play:weed",function()
	if(State==false)then
		State=true
		Delay(3*1000,function()
			SetCameraShakeRotation(0.0,0.0,1.0,10.0,0.0,0.0)
			SetCameraShakeFOV(5.0,5.0)
			PlayCameraShake(100000.0,2.0,1.0,1.1)
		end)
		Delay(60*1000,function()
			StopCameraShake(false)
			State=false
		end)
	end
end)

AddRemoteEvent("play:cocaine",function()
	if(State==false)then
		State=true
		Delay(1*1000,function()
			SetCameraShakeRotation(0.0,0.0,1.0,10.0,0.0,0.0)
			SetCameraShakeFOV(5.0,5.0)
			PlayCameraShake(100000.0,2.0,1.0,1.1)
			SetPostEffect("ImageEffects","VignetteIntensity",1.0)
			SetPostEffect("Chromatic","Intensity",5.0)
			SetPostEffect("Chromatic","StartOffset",0.1)
			SetPostEffect("MotionBlur","Amount",0.05)
			SetPostEffect("MotionWhiteBalanceBlur","Temp",7000)
		end)
		Delay(60*1000,function()
			SetPostEffect("ImageEffects","VignetteIntensity",0.25)
			SetPostEffect("Chromatic","Intensity",0.0)
			SetPostEffect("Chromatic","StartOffset",0.0)
			SetPostEffect("MotionBlur","Amount",0.0)
			SetPostEffect("MotionWhiteBalanceBlur","Temp",6500)
			StopCameraShake(false)
			State=false
		end)
	end
end)