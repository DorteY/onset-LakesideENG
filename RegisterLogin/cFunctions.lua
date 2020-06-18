--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local function openRegisterLoginUI(typ)
	ShowChat(false)
	if(typ=="Register")then
		SetInputMode(INPUT_UI)
		SetIgnoreLookInput(true)
		SetIgnoreMoveInput(true)
		ShowMouseCursor(true)
		local Register_GUI=UIDialog()
		Register_GUI.setTitle("Register")
		Register_GUI.appendTo(UIFramework)
		Register_GUI.setCanClose(false)
		Register_GUI.setMovable(false)
		
		local text=UIText()
		text.setContent([[
			<h3>Welcome to <span style="color: #ff5000;">Lakeside</span> on Onset.</h3><br>
			WARNING: Please dont use your Privat Password!<br>
		]])
		text.appendTo(Register_GUI)
		
		local username=UITextField()
		username.setPlaceholder("Username")
		username.appendTo(Register_GUI)
		
		local password=UITextField()
		password.setPlaceholder("Password")
		password.setHideInput(true)
		password.appendTo(Register_GUI)
		
		local gender
		local genderList=UIOptionList()
		genderList.allowMultiselection(false)
		genderList.appendOption("Male","Male")
		genderList.appendOption("Female","Female")
		genderList.appendTo(Register_GUI)
		genderList.onChange(function(obj)
			for _,v in pairs(obj.getValue())do
				gender=tostring(v)
			end
		end)
		
		local Button1=UIButton()
		Button1.setTitle("register")
		Button1.setType("primary")
		Button1.onClick(function()
			if(username.getValue()~="" and username.getValue()~="none" and username.getValue()~=nil and username.getValue()~="Police" and username.getValue()~="Mafia" and username.getValue()~="Ballas")then
				if(password.getValue()~="" and password.getValue()~=nil)then
					if(gender~="" and gender~=nil)then
						CallRemoteEvent("player:register",username.getValue(),password.getValue(),gender)
						ShowChat(true)
						Register_GUI.destroy()
						disableRegisterLoginFuncs()
					else
						MakeNotification("Select your gender!","linear-gradient(to right, #ff5f6d, #ffc371)")
					end
				else
					MakeNotification("Enter a password!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				MakeNotification("Enter a username!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end)
		Button1.appendTo(Register_GUI)
		
		local Button2=UIButton()
		Button2.setTitle("leave server")
		Button2.setType("secondary")
		Button2.onClick(function()
			CallRemoteEvent("leave:server")
		end)
		Button2.appendTo(Register_GUI)
	elseif(typ=="Login")then
		SetInputMode(INPUT_UI)
		SetIgnoreLookInput(true)
		SetIgnoreMoveInput(true)
		ShowMouseCursor(true)
		local Login_GUI=UIDialog()
		Login_GUI.setTitle("Login")
		Login_GUI.appendTo(UIFramework)
		Login_GUI.setCanClose(false)
		Login_GUI.setMovable(false)
		
		local text=UIText()
		text.setContent([[
			<h3>Welcome back to <span style="color: #ff5000;">Lakeside</span> on Onset.</h3><br>
		]])
		text.appendTo(Login_GUI)
		
		local username=UITextField()
		username.setPlaceholder("Username")
		username.appendTo(Login_GUI)
		
		local password=UITextField()
		password.setPlaceholder("Password")
		password.setHideInput(true)
		password.appendTo(Login_GUI)
		
		local Button1=UIButton()
		Button1.setTitle("log in")
		Button1.setType("primary")
		Button1.onClick(function()
			if(username.getValue()~="")then
				if(password.getValue()~="")then
					CallRemoteEvent("player:login",username.getValue(),password.getValue())
					ShowChat(true)
					Login_GUI.hide()
					disableRegisterLoginFuncs()
				else
					MakeNotification("Enter your password!","linear-gradient(to right, #ff5f6d, #ffc371)")
				end
			else
				MakeNotification("Enter your username!","linear-gradient(to right, #ff5f6d, #ffc371)")
			end
		end)
		Button1.appendTo(Login_GUI)
		
		local Button2=UIButton()
		Button2.setTitle("leave server")
		Button2.setType("secondary")
		Button2.onClick(function()
			CallRemoteEvent("leave:server")
		end)
		Button2.appendTo(Login_GUI)
	end
end
AddRemoteEvent("open:register_login",openRegisterLoginUI)
AddEvent("OnUIFrameworkReady",function()
	CallRemoteEvent("check:registered")
end)


function disableRegisterLoginFuncs()
	SetInputMode(INPUT_GAME)
	SetIgnoreLookInput(false)
	SetIgnoreMoveInput(false)
	ShowMouseCursor(false)
end