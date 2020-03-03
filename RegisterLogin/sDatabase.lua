--|| Project: Lakeside RL/RP (Onset) ||--
--||        Developer: DorteY        ||--
--||         Lake-Gaming.com         ||--


handler=false

local DB={
	HOST="127.0.0.1",
	PORT=3306,
	NAME="",
	PASS="",
	USER="",
	LOG="debug",
	CHAR="utf8mb4",
}

AddEvent("OnPackageStart",function()
	mariadb_log(DB.LOG)
	
	handler=mariadb_connect(DB.HOST..':'..DB.PORT,DB.USER,DB.PASS,DB.NAME)
	
	if(handler)then
		print("[MYSQL] Connection to the MySQL database was successfully established!")
		mariadb_set_charset(handler,DB.CHAR)
		
		CallEvent("database:connected")
	else
		print("[MYSQL] Failed to connect to MySQL database! (mariadb_log)")
		ServerExit()
	end
end)

AddEvent("OnPackageStop",function()
	for _,v in pairs(GetAllPlayers())do
		SavePlayerAccount(v)
	end
	print("All accounts have been saved!")
	mariadb_close(handler)
end)


