--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


AddRemoteEvent("open:scrapyardUI",function()
	if(Scrapyard_GUI)then
		Scrapyard_GUI.destroy()
	end
	ShowMouseCursor(true)
	SetInputMode(INPUT_UI)
	Scrapyard_GUI=UIDialog()
	Scrapyard_GUI.setTitle("Scrapyard")
	Scrapyard_GUI.appendTo(UIFramework)
	Scrapyard_GUI.setCanClose(true)
	Scrapyard_GUI.setMovable(false)
	Scrapyard_GUI.onClickClose(function(obj)
		obj.hide()
		disableScrapyardUIFuncs()
	end)
	
	local text=UIText()
	text.setContent([[
		<h3>Hello, here you can have your car scrapped!</h3><br>
		You get 35% of the purchase price back.
	]])
	text.appendTo(Scrapyard_GUI)
	
	local Button1=UIButton()
	Button1.setTitle("car scrap")
	Button1.setType("secondary")
	Button1.onClick(function()
		CallRemoteEvent("sell:vehicle")
	end)
	Button1.appendTo(Scrapyard_GUI)
end)

function disableScrapyardUIFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end