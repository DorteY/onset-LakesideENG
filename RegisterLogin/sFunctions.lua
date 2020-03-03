--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local HungerTimer={}
local ThirstTimer={}
local PaydayTimer={}
AddRemoteEvent("player:register",function(player,username,password,gender)
	mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM userdata WHERE Username='?';",username),function()
		if(mariadb_get_row_count()==0)then
			if(gender=="Male" or gender=="Female")then
				local steamid=tostring(GetPlayerSteamId(player))
				
				AddPlayerChat(player,"Hello and Welcome to Lakeside. Please follow the Tutorial.")
				AddPlayerChat(player,"<span color=\"#c80000FF\">WARNING</>: Please wait 25 seconds after register!")
				
				local query=mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM userdata WHERE SteamID='?';",steamid),function()
					if(mariadb_get_row_count()==0)then
						mariadb_query(handler,"INSERT INTO `userdata` (`SteamID`,`Username`,`Password`,`Gender`,`Health`,`Armor`,`AdminLVL`,`Playtime`,`Money`,`Bankmoney`,`Jobmoney`,`Faction`,`Factionrank`,`hunger`,`thirst`,`spawnX`,`spawnY`,`spawnZ`,`spawnROT`,`Clothing`,`Tutorial`) VALUES ('"..steamid.."','"..username.."','"..password.."','"..gender.."','100','0','0','0','1200','3000','0','Civilian','0','100','100','115070','164073','3029','90','1','1');")
					end
				end)
				local query=mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM inventory WHERE SteamID='?';",steamid),function()
					if(mariadb_get_row_count()==0)then
						mariadb_query(handler,"INSERT INTO `inventory` (`SteamID`,`Username`,`Burger`,`Donut`,`Cola`,`Sprite`,`Fuelcan`,`Repairkit`,`Armor`,`Weed`,`Mats`) VALUES ('"..steamid.."','"..username.."','3','0','5','0','0','0','0','0','0');")
					end
				end)
				local query=mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM level WHERE SteamID='?';",steamid),function()
					if(mariadb_get_row_count()==0)then
						mariadb_query(handler,"INSERT INTO `level` (`SteamID`,`Username`,`TruckLVL`,`TruckEXP`) VALUES ('"..steamid.."','"..username.."','0','0');")
					end
				end)
				local query=mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM licenses WHERE SteamID='?';",steamid),function()
					if(mariadb_get_row_count()==0)then
						mariadb_query(handler,"INSERT INTO `licenses` (`SteamID`,`Username`,`Gun`) VALUES ('"..steamid.."','"..username.."','0');")
					end
				end)
				
				
				SetPlayerName(player,username)
				SetPlayerSpawnLocation(player,116450.6,164016.6,3029,90.0)
				SetPlayerLocation(player,116450.6,164016.6,3029+250)
				SetPlayerHeading(player,0)
				
				Delay(25*1000,function(player)
					SetPlayerSpawnLocation(player,116450.6,164016.6,3029,90.0)
					SetPlayerLocation(player,116450.6,164016.6,3029+250)
					SetPlayerHeading(player,0)
					CallRemoteEvent(player,"MakeNotification","Successfully registered!","linear-gradient(to right, #00b09b, #96c93d)")
				end,player)
				
				
				SetPlayerPropertyValue(player,"Loggedin",1,true)
				SetPlayerHealth(player,100)
				SetPlayerArmor(player,0)
				SetPlayerPropertyValue(player,"AdminLVL",0,true)
				SetPlayerPropertyValue(player,"Playtime",0,true)
				SetPlayerPropertyValue(player,"Money",1200,true)
				SetPlayerPropertyValue(player,"Bankmoney",3000,true)
				SetPlayerPropertyValue(player,"Jobmoney",0,true)
				SetPlayerPropertyValue(player,"Faction","Civilian",true)
				SetPlayerPropertyValue(player,"Factionrank",0,true)
				SetPlayerPropertyValue(player,"hunger",100,true)
				SetPlayerPropertyValue(player,"thirst",100,true)
				SetPlayerPropertyValue(player,"Clothing",1,true)
				SetPlayerPropertyValue(player,"Tutorial",1,true)
				
				SetPlayerPropertyValue(player,"Burger",3,true)
				SetPlayerPropertyValue(player,"Donut",0,true)
				SetPlayerPropertyValue(player,"Cola",5,true)
				SetPlayerPropertyValue(player,"Sprite",0,true)
				SetPlayerPropertyValue(player,"Fuelcan",0,true)
				SetPlayerPropertyValue(player,"Repairkit",0,true)
				SetPlayerPropertyValue(player,"Armor",0,true)
				SetPlayerPropertyValue(player,"Weed",0,true)
				SetPlayerPropertyValue(player,"Mats",0,true)
				
				SetPlayerPropertyValue(player,"LVL:Truck",0,true)
				SetPlayerPropertyValue(player,"EXP:Truck",0,true)
				
				SetPlayerPropertyValue(player,"Gunlicense",0,true)
				
				startTimer(player)
				TutorialQuests(player)
			end
		else
			CallRemoteEvent(player,"open:register_login","Register")
			CallRemoteEvent(player,"MakeNotification","Username already taken!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end)
end)
AddRemoteEvent("player:login",function(player,username,password)
	mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM userdata WHERE Username='?' AND Password='?';",username,password),function()
		if(mariadb_get_row_count()>0)then
			SetPlayerName(player,username)
			
			local result=mariadb_get_assoc(1)
			if(result)then
				AddPlayerChat(player,"<span color=\"#c80000FF\">WARNING</>: Please wait 25 seconds after log in!")
				SetPlayerLocation(player,result['spawnX'],result['spawnY'],result['spawnZ']+250)
				SetPlayerHeading(player,result['spawnROT'])
				
				SetPlayerHealth(player,tonumber(result['Health']))
				SetPlayerArmor(player,tonumber(result['Armor']))
				
				SetPlayerPropertyValue(player,"Loggedin",1,true)
				SetPlayerPropertyValue(player,"AdminLVL",tonumber(result['AdminLVL']),true)
				SetPlayerPropertyValue(player,"Playtime",tonumber(result['Playtime']),true)
				SetPlayerPropertyValue(player,"Money",tonumber(result['Money']),true)
				SetPlayerPropertyValue(player,"Bankmoney",tonumber(result['Bankmoney']),true)
				SetPlayerPropertyValue(player,"Jobmoney",tonumber(result['Jobmoney']),true)
				SetPlayerPropertyValue(player,"Faction",result['Faction'],true)
				SetPlayerPropertyValue(player,"Factionrank",tonumber(result['Factionrank']),true)
				SetPlayerPropertyValue(player,"hunger",tonumber(result['hunger']),true)
				SetPlayerPropertyValue(player,"thirst",tonumber(result['thirst']),true)
				SetPlayerPropertyValue(player,"Clothing",result['Clothing'],true)
				SetPlayerPropertyValue(player,"Tutorial",tonumber(result['Tutorial']),true)
				
				
				Delay(25*1000,function(player)
					SetPlayerLocation(player,result['spawnX'],result['spawnY'],result['spawnZ']+250)
					SetPlayerHeading(player,result['spawnROT'])
					TutorialQuests(player)
					CallRemoteEvent(player,"MakeNotification","Successfully logged in!","linear-gradient(to right, #00b09b, #96c93d)")
				end,player)
				
				--//Start Hunger/Thirst/Payday timer
				startTimer(player)
			end
			
			
			--//Inventory
			mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM inventory WHERE SteamID='?';",tostring(GetPlayerSteamId(player))),function()
				local result=mariadb_get_assoc(1)
				if(result)then
					SetPlayerPropertyValue(player,"Burger",tonumber(result['Burger']),true)
					SetPlayerPropertyValue(player,"Donut",tonumber(result['Donut']),true)
					SetPlayerPropertyValue(player,"Cola",tonumber(result['Cola']),true)
					SetPlayerPropertyValue(player,"Sprite",tonumber(result['Sprite']),true)
					SetPlayerPropertyValue(player,"Fuelcan",tonumber(result['Fuelcan']),true)
					SetPlayerPropertyValue(player,"Repairkit",tonumber(result['Repairkit']),true)
					SetPlayerPropertyValue(player,"Armor",tonumber(result['Armor']),true)
					SetPlayerPropertyValue(player,"Weed",tonumber(result['Weed']),true)
					SetPlayerPropertyValue(player,"Mats",tonumber(result['Mats']),true)
				end
			end)
			
			--//Level
			mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM level WHERE SteamID='?';",tostring(GetPlayerSteamId(player))),function()
				local result=mariadb_get_assoc(1)
				if(result)then
					SetPlayerPropertyValue(player,"LVL:Truck",tonumber(result['TruckLVL']),true)
					SetPlayerPropertyValue(player,"EXP:Truck",tonumber(result['TruckEXP']),true)
				end
			end)
			
			--//Licenses
			mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM licenses WHERE SteamID='?';",tostring(GetPlayerSteamId(player))),function()
				local result=mariadb_get_assoc(1)
				if(result)then
					SetPlayerPropertyValue(player,"Gunlicense",tonumber(result['Gun']),true)
				end
			end)
			
			
			--//Check levelup
			CallRemoteEvent(player,"level:player","Truck")
		else
			CallRemoteEvent(player,"open:register_login","Login")
			CallRemoteEvent(player,"MakeNotification","Wrong username/password!","linear-gradient(to right, #ff5f6d, #ffc371)")
		end
	end)
end)

local function checkRegisteredState(player)
	mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM userdata WHERE SteamID='?'",tostring(GetPlayerSteamId(player))),function()
		if(mariadb_get_row_count()==0)then
			CallRemoteEvent(player,"open:register_login","Register")
		else
			CallRemoteEvent(player,"open:register_login","Login")
		end
	end)
end
AddRemoteEvent("check:registered",checkRegisteredState)

function startTimer(player)
	HungerTimer[player]=CreateTimer(function(player)
		SetPlayerPropertyValue(player,"hunger",GetPlayerPropertyValue(player,"hunger")-1,true)
		if(GetPlayerPropertyValue(player,"hunger")<1)then
			SetPlayerHealth(player,0)
			Delay(1*1000,function(player)
				SetPlayerHealth(player,50)
				SetPlayerPropertyValue(player,"hunger",25)
			end,player)
		end
	end,70*1000,player)
	ThirstTimer[player]=CreateTimer(function(player)
		SetPlayerPropertyValue(player,"thirst",GetPlayerPropertyValue(player,"thirst")-1,true)
		if(GetPlayerPropertyValue(player,"thirst")<1)then
			SetPlayerHealth(player,0)
			Delay(1*1000,function(player)
				SetPlayerHealth(player,50)
				SetPlayerPropertyValue(player,"thirst",40)
			end,player)
		end
	end,55*1000,player)
	PaydayTimer[player]=CreateTimer(function(player)
		SetPlayerPropertyValue(player,"Playtime",GetPlayerPropertyValue(player,"Playtime")+1,true)
		SavePlayerAccount(player)
		if(math.floor(GetPlayerPropertyValue(player,"Playtime")/60)==(GetPlayerPropertyValue(player,"Playtime")/60))then
			local jobmoney=GetPlayerPropertyValue(player,"Jobmoney")
			
			AddPlayerChat(player,"________Payday________")
			AddPlayerChat(player,"<span color=\"#00b400FF\">Jobmoney: +$"..jobmoney.."</>")
			--AddPlayerChat(player,"<span color=\"#b40000FF\">Vehicle tax: -$"..vehPrice.."</>")
			AddPlayerChat(player,"_______________________")
			
			paydayCash=jobmoney
			
			SetPlayerPropertyValue(player,"Bankmoney",GetPlayerPropertyValue(player,"Bankmoney")+paydayCash)
			SetPlayerPropertyValue(player,"Jobmoney",0)
		end
	end,60*1000,player)
end


function SavePlayerAccount(player)
	if(GetPlayerPropertyValue(player,"Loggedin")==nil)then
		return
	end
	if(GetPlayerPropertyValue(player,"Loggedin")==0)then
		return
	end
	
	--//Userdata
	local userquery=mariadb_prepare(handler,"UPDATE userdata SET Health='?',Armor='?',AdminLVL='?',Playtime='?',Money='?',Bankmoney='?',Jobmoney='?',Faction='?',Factionrank='?',hunger='?',thirst='?',Clothing='?',Tutorial='?' WHERE SteamID='?';",
		GetPlayerHealth(player),
		GetPlayerArmor(player),
		GetPlayerPropertyValue(player,"AdminLVL"),
		GetPlayerPropertyValue(player,"Playtime"),
		GetPlayerPropertyValue(player,"Money"),
		GetPlayerPropertyValue(player,"Bankmoney"),
		GetPlayerPropertyValue(player,"Jobmoney"),
		GetPlayerPropertyValue(player,"Faction"),
		GetPlayerPropertyValue(player,"Factionrank"),
		GetPlayerPropertyValue(player,"hunger"),
		GetPlayerPropertyValue(player,"thirst"),
		GetPlayerPropertyValue(player,"Clothing"),
		GetPlayerPropertyValue(player,"Tutorial"),
		tostring(GetPlayerSteamId(player))
	)
	mariadb_query(handler,userquery)
	
	--//Inventory
	local invquery=mariadb_prepare(handler,"UPDATE inventory SET Burger='?',Donut='?',Cola='?',Sprite='?',Fuelcan='?',Repairkit='?',Armor='?',Weed='?',Mats='?' WHERE SteamID='?';",
		GetPlayerPropertyValue(player,"Burger"),
		GetPlayerPropertyValue(player,"Donut"),
		GetPlayerPropertyValue(player,"Cola"),
		GetPlayerPropertyValue(player,"Sprite"),
		GetPlayerPropertyValue(player,"Fuelcan"),
		GetPlayerPropertyValue(player,"Repairkit"),
		GetPlayerPropertyValue(player,"Armor"),
		GetPlayerPropertyValue(player,"Weed"),
		GetPlayerPropertyValue(player,"Mats"),
		tostring(GetPlayerSteamId(player))
	)
	mariadb_query(handler,invquery)
	
	--//Level
	local lvlquery=mariadb_prepare(handler,"UPDATE level SET TruckLVL='?',TruckEXP='?' WHERE SteamID='?';",
		GetPlayerPropertyValue(player,"LVL:Truck"),
		GetPlayerPropertyValue(player,"EXP:Truck"),
		tostring(GetPlayerSteamId(player))
	)
	mariadb_query(handler,lvlquery)
	
	--//Licenses
	local licensequery=mariadb_prepare(handler,"UPDATE licenses SET Gun='?' WHERE SteamID='?';",
		GetPlayerPropertyValue(player,"Gunlicense"),
		tostring(GetPlayerSteamId(player))
	)
	mariadb_query(handler,licensequery)
end


function leaveServer(player)
	KickPlayer(player,"Leave Lakeside :(")
end
AddRemoteEvent("leave:server",leaveServer)


AddEvent("OnPlayerQuit",function(player)
    SavePlayerAccount(player)
	SetPlayerPropertyValue(player,"Loggedin",0)
	
	--//Stop Hunger/Thirst/Payday timer
	if(HungerTimer[player])then
		DestroyTimer(HungerTimer[player])
	end
	if(ThirstTimer[player])then
		DestroyTimer(ThirstTimer[player])
	end
	if(PaydayTimer[player])then
		DestroyTimer(PaydayTimer[player])
	end
end)

local function checkBannedState(player)
	SetPlayerPropertyValue(player,"Loggedin",0)
	mariadb_query(handler,mariadb_prepare(handler,"SELECT * FROM bans WHERE TargetSteamID='?'",tostring(GetPlayerSteamId(player))),function()
		if(mariadb_get_row_count()>0)then
			local result=mariadb_get_assoc(1)
			if(result)then
				print("Kicking "..GetPlayerName(player).." because their account was banned")
				
				KickPlayer(player,"You are banned by "..result['Admin'].."!\nReason: "..result['Reason'])
			end
		end
	end)
end
AddEvent("OnPlayerJoin",checkBannedState)
AddEvent("OnPlayerSteamAuth",checkBannedState)


AddEvent("OnPlayerJoin",function(player)
	SetPlayerSpawnLocation(player,115070,164073,3029,90.0)
	SetPlayerLocation(player,115070,164073,3029+250)
end)