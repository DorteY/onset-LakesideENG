--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


local whitelist=false

AddEvent("OnPlayerSteamAuth",function(player)
	if(whitelist==true)then
		local steamid=GetPlayerSteamId(player)
		local query=mariadb_prepare(handler,"SELECT * FROM whitelist WHERE SteamID=?;",tostring(steamid))
		
		mariadb_query(handler,query,function(player)
			if(mariadb_get_row_count()==0)then
				KickPlayer(player,"Our Discord: "..datas.discordurl.."")
			end
		end,player)
	end
end)

--//ATM
AtmObjectsCached={}
AtmTable={
	{
		modelid=33,
		location={
			{212950,190500,1250},
			{213419,190723,1250},
			{212908,189890,1250},
			{116650,163194,2980},
			{129240,77945,1500},
			{-15000,-2385,2000},
			{43900,133143,1500},
			{42246,137850,1500},
			{-168797,-39550,1050}
		},
		object={}
	}
}

AddEvent("OnPackageStart",function()
	for _,v in pairs(AtmTable)do
		for i,_ in pairs(v.location)do
			v.object[i]=CreatePickup(v.modelid,v.location[i][1],v.location[i][2],v.location[i][3])
			CreateText3D("ATM\nPress '"..interactKey.."'",18,v.location[i][1],v.location[i][2],v.location[i][3]+200,0,0,0)

			table.insert(AtmObjectsCached,v.object[i])
		end
	end
	CreateObject(494,-168797,-39550,1050)
	
	
	CreateText3D("Carshop",16,163330,191647,1290+100,0,0,0)
	CreateText3D("Delivery Driver job",16,200368,171892,1260+100,0,0,0)
	CreateText3D("Hair shop\nPress '"..interactKey.."'",18,208221,180323,1260+100,0,0,0)
	CreateText3D("Outfit shop\nPress '"..interactKey.."'",18,207575,180323,1260+100,0,0,0)
end)

AddEvent("OnPlayerJoin",function(player)
	CallRemoteEvent(player,"call:atm",AtmObjectsCached)
end)


AddRemoteEvent("interact:atm",function(player,object)
    local atm,atmid=GetAtmByObject(object)
	if(atm)then
		local x,y,z=GetPickupLocation(atm.object[atmid])
		local x2,y2,z2=GetPlayerLocation(player)
        local dist=GetDistance3D(x,y,z,x2,y2,z2)
		if(dist<250)then
			local bank=GetPlayerPropertyValue(player,"Bankmoney")
			local cash=GetPlayerPropertyValue(player,"Money")
			
			CallRemoteEvent(player,"open:atmUI",cash,bank)
		end
	end
end)

function GetAtmByObject(object)
	for k,v in pairs(AtmTable)do
		for i,j in pairs(v.object)do
			if(j==object)then
				return v,i
			end
		end
	end
	return nil
end


function payATM(player,typ,amount)
	if(typ=="in")then
		if(tonumber(amount)<=0)then
			return
		end
		if(tonumber(amount)>GetPlayerPropertyValue(player,"Money"))then
			CallRemoteEvent(player,"MakeNotification","You haven't enough money!","linear-gradient(to right, #ff5f6d, #ffc371)")
		else
			SetPlayerPropertyValue(player,"Bankmoney",GetPlayerPropertyValue(player,"Bankmoney")+tonumber(amount),true)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(amount),true)
			
			CallRemoteEvent(player,"MakeNotification","You paid in $"..amount,"linear-gradient(to right, #00b09b, #96c93d)")
			
			CallRemoteEvent(player,"PlayAudioFile","Cash.ogg",0.3)
			
			if(GetPlayerPropertyValue(player,"Tutorial")==5)then
				setTutorialQuests(player)
			end
		end
    elseif(typ=="out")then
		if(tonumber(amount)<=0)then
			return
		end
		if(tonumber(amount)>GetPlayerPropertyValue(player,"Bankmoney"))then
			CallRemoteEvent(player,"MakeNotification","You haven't enough money in your bank!","linear-gradient(to right, #ff5f6d, #ffc371)")
		else
			SetPlayerPropertyValue(player,"Bankmoney",GetPlayerPropertyValue(player,"Bankmoney")-tonumber(amount),true)
			SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+tonumber(amount),true)
			
			CallRemoteEvent(player,"MakeNotification","You paid out $"..amount,"linear-gradient(to right, #00b09b, #96c93d)")
			
			CallRemoteEvent(player,"PlayAudioFile","Cash.ogg",0.3)
			
			if(GetPlayerPropertyValue(player,"Tutorial")==5)then
				setTutorialQuests(player)
			end
		end
	end
end
AddRemoteEvent("pay:atm",payATM)

AddCommand("pay",function(player,target,amount)
	local targetID=GetPlayerFromPartialName(target)
	if(targetID)then
		if(GetPlayerPropertyValue(player,"Loggedin")==1 and GetPlayerPropertyValue(targetID,"Loggedin")==1)then
			local x,y,z=GetPlayerLocation(player)
			local xx,yy,zz=GetPlayerLocation(targetID)
			local dist=GetDistance3D(xx,yy,zz,x,y,z)
			if(dist<400.0)then
				if(GetPlayerPropertyValue(player,"Money")>=tonumber(amount))then
					SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")-tonumber(amount))
					SetPlayerPropertyValue(targetID,"Money",GetPlayerPropertyValue(targetID,"Money")+tonumber(amount))
				end
			end
		end
	end
end)


function OnPlayerChat(player,msg)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		local x,y,z=GetPlayerLocation(player)
		for _,v in pairs(GetAllPlayers())do
			local x2,y2,z2=GetPlayerLocation(v)
			local dist=GetDistance3D(x,y,z,x2,y2,z2)
			if(dist<500.0)then
				AddPlayerChat(v,"[Local]: "..GetPlayerName(player).."("..player.."): "..msg)
			end
		end
		
	end
end
AddEvent("OnPlayerChat",OnPlayerChat)

AddCommand("t",function(player,...)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(GetPlayerPropertyValue(player,"Faction")~="Civilian")then
			local msg=table.concat({...}," ")
			if(#msg>=1)then
				for _,v in pairs(GetAllPlayers())do
					if(GetPlayerPropertyValue(v,"Loggedin")==1)then
						if(GetPlayerPropertyValue(player,"Faction")==GetPlayerPropertyValue(v,"Faction"))then
							AddPlayerChat(v,"<span color=\"#6bc3c7FF\">[Faction]: "..GetPlayerName(player).."("..player.."):</> "..msg)
						end
					end
				end
			end
		end
	end
end)

local function OnScriptError(message)
	print(message)
end
AddEvent("OnScriptError",OnScriptError)

local function setPlayerSpawn(player,typ)
	if(GetPlayerPropertyValue(player,"Loggedin")==1)then
		if(typ==0)then
			local query=mariadb_prepare(handler,"UPDATE userdata SET spawnX='?',spawnY='?',spawnZ='?',spawnROT='?' WHERE SteamID='?';",
				"116450.6",
				"164016.6",
				"3029",
				"0",
				tostring(GetPlayerSteamId(player))
			)
			mariadb_query(handler,query)
			
			CallRemoteEvent(player,"MakeNotification","Spawnpoint set to Spawn!","linear-gradient(to right, #00b09b, #96c93d)")
		elseif(typ==1)then
			local x,y,z=GetPlayerLocation(player)
			local rot=GetPlayerHeading(player)
			
			local query=mariadb_prepare(handler,"UPDATE userdata SET spawnX='?',spawnY='?',spawnZ='?',spawnROT='?' WHERE SteamID='?';",
				x,
				y,
				z,
				rot,
				tostring(GetPlayerSteamId(player))
			)
			mariadb_query(handler,query)
			
			CallRemoteEvent(player,"MakeNotification","Spawnpoint set to Current position!","linear-gradient(to right, #00b09b, #96c93d)")
		elseif(typ==4)then
			if(GetPlayerPropertyValue(player,"Faction")=="Police")then
				local query=mariadb_prepare(handler,"UPDATE userdata SET spawnX='?',spawnY='?',spawnZ='?',spawnROT='?' WHERE SteamID='?';",
					"170256",
					"192816",
					"1400",
					"0",
					tostring(GetPlayerSteamId(player))
				)
				mariadb_query(handler,query)
				
				CallRemoteEvent(player,"MakeNotification","Spawnpoint set to Faction base!","linear-gradient(to right, #00b09b, #96c93d)")
			elseif(GetPlayerPropertyValue(player,"Faction")=="Mafia")then
				local query=mariadb_prepare(handler,"UPDATE userdata SET spawnX='?',spawnY='?',spawnZ='?',spawnROT='?' WHERE SteamID='?';",
					"108955",
					"206623",
					"1500",
					"-11",
					tostring(GetPlayerSteamId(player))
				)
				mariadb_query(handler,query)
				
				CallRemoteEvent(player,"MakeNotification","Spawnpoint set to Faction base!","linear-gradient(to right, #00b09b, #96c93d)")
			elseif(GetPlayerPropertyValue(player,"Faction")=="Ballas")then
				local query=mariadb_prepare(handler,"UPDATE userdata SET spawnX='?',spawnY='?',spawnZ='?',spawnROT='?' WHERE SteamID='?';",
					"96803",
					"121025",
					"6440",
					"0",
					tostring(GetPlayerSteamId(player))
				)
				mariadb_query(handler,query)
				
				CallRemoteEvent(player,"MakeNotification","Spawnpoint set to Faction base!","linear-gradient(to right, #00b09b, #96c93d)")
			end
		end
	end
end
AddRemoteEvent("set:spawnpoint",setPlayerSpawn)


worldTime=12

local dayTime=0.01
local nightTime=0.05
local morning=5
local evening=20 

function OnPackageStart()
    CreateTimer(function()
		if(worldTime>=24)then
			worldTime=0
		end
		if worldTime<morning or worldTime>evening then
			worldTime=worldTime+nightTime
		else
			worldTime=worldTime+dayTime
		end
		for _,v in pairs(GetAllPlayers()) do
            CallRemoteEvent(v,"setTimeOfClient",worldTime)
		end
    end,1000)
end
AddEvent("OnPackageStart",OnPackageStart)

function OnPlayerSpawn(player)
	CallRemoteEvent(player,"setTimeOfClient",worldTime)
end
AddEvent("OnPlayerSpawn", OnPlayerSpawn)


function GetPlayerFromPartialName(name)
    local name=name and name:gsub("#%x%x%x%x%x%x",""):lower()or nil
    if name then
        for _,v in ipairs(GetAllPlayers())do
            local playerName=GetPlayerName(v):gsub("#%x%x%x%x%x%x",""):lower()
            if(playerName:find(name,1,true))then
                return v
            end
        end
    end
end


--//Tutorial
function TutorialQuests(player)
	if(GetPlayerPropertyValue(player,"Tutorial")==1)then
		--AddPlayerChat(player,"Tutorial 1: Open the Helpmenu (F1)")
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 1: Open the Helpmenu (F1)</>")
	elseif(GetPlayerPropertyValue(player,"Tutorial")==2)then
		CallRemoteEvent(player,"destroy:TutorialWaypoint")
		CallRemoteEvent(player,"create:TutorialWaypoint",116071,164901,2970)
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 2: Rent a car</>")
	elseif(GetPlayerPropertyValue(player,"Tutorial")==3)then
		CallRemoteEvent(player,"destroy:TutorialWaypoint")
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 3: Un/lock your car</>")
	elseif(GetPlayerPropertyValue(player,"Tutorial")==4)then
		CallRemoteEvent(player,"destroy:TutorialWaypoint")
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 4: Start the vehicle engine</>")
	elseif(GetPlayerPropertyValue(player,"Tutorial")==5)then
		CallRemoteEvent(player,"destroy:TutorialWaypoint")
		CallRemoteEvent(player,"create:TutorialWaypoint",116645,163258,3038)
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 5: Pay in/out money</>")
	elseif(GetPlayerPropertyValue(player,"Tutorial")==6)then
		CallRemoteEvent(player,"destroy:TutorialWaypoint")
		CallRemoteEvent(player,"create:TutorialWaypoint",170877,203660,1413)
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 6: Buy a item in a shop</>")
	elseif(GetPlayerPropertyValue(player,"Tutorial")==7)then
		CallRemoteEvent(player,"destroy:TutorialWaypoint")
		CallRemoteEvent(player,"create:TutorialWaypoint",200358,171882,1306)
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 7: Start the Trucker job and get money</>")
	elseif(GetPlayerPropertyValue(player,"Tutorial")==8)then
		CallRemoteEvent(player,"destroy:TutorialWaypoint")
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Tutorial 8: We hope you have fun on Lakeside.</>")
		AddPlayerChat(player,"<span color=\"#ff0000FF\">Our Discord: "..datas.discordurl.."</>")
		SetPlayerPropertyValue(player,"Tutorial",9)
	end
end
AddRemoteEvent("player:tutorial",TutorialQuests)

function setTutorialQuests(player)
	if(GetPlayerPropertyValue(player,"Tutorial")==1)then
		SetPlayerPropertyValue(player,"Tutorial",2)
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+100)
		AddPlayerChat(player,"<span color=\"#55aa00FF\">Tutorial 1 successfully ended! You get $100</>")
		TutorialQuests(player)
	elseif(GetPlayerPropertyValue(player,"Tutorial")==2)then
		SetPlayerPropertyValue(player,"Tutorial",3)
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+300)
		AddPlayerChat(player,"<span color=\"#55aa00FF\">Tutorial 2 successfully ended! You get $300</>")
		TutorialQuests(player)
	elseif(GetPlayerPropertyValue(player,"Tutorial")==3)then
		SetPlayerPropertyValue(player,"Tutorial",4)
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+100)
		AddPlayerChat(player,"<span color=\"#55aa00FF\">Tutorial 3 successfully ended! You get $100</>")
		TutorialQuests(player)
	elseif(GetPlayerPropertyValue(player,"Tutorial")==4)then
		SetPlayerPropertyValue(player,"Tutorial",5)
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+120)
		AddPlayerChat(player,"<span color=\"#55aa00FF\">Tutorial 4 successfully ended! You get $120</>")
		TutorialQuests(player)
	elseif(GetPlayerPropertyValue(player,"Tutorial")==5)then
		SetPlayerPropertyValue(player,"Tutorial",6)
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+100)
		AddPlayerChat(player,"<span color=\"#55aa00FF\">Tutorial 5 successfully ended! You get $100</>")
		TutorialQuests(player)
	elseif(GetPlayerPropertyValue(player,"Tutorial")==6)then
		SetPlayerPropertyValue(player,"Tutorial",7)
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+200)
		AddPlayerChat(player,"<span color=\"#55aa00FF\">Tutorial 6 successfully ended! You get $200</>")
		TutorialQuests(player)
	elseif(GetPlayerPropertyValue(player,"Tutorial")==7)then
		SetPlayerPropertyValue(player,"Tutorial",8)
		SetPlayerPropertyValue(player,"Money",GetPlayerPropertyValue(player,"Money")+100)
		AddPlayerChat(player,"<span color=\"#55aa00FF\">Tutorial 7 successfully ended! You get $100</>")
		TutorialQuests(player)
	end
end
AddRemoteEvent("set:tutorial",setTutorialQuests)