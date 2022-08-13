local vkeys = require 'vkeys' -- все подключают, хз зачем, но вроде легкче работать
local inicfg = require 'inicfg'
local dlstatus = require('moonloader').download_status
update_state = false 
local script_vers = 1
local script_vers_text = "1.00"
local update_url = "https://raw.githubusercontent.com/Yooshyasha/zxcDI/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"
local script_url = "https://github.com/Yooshyasha/zxcDI/raw/main/DIzxc%20PRIVATE.lua"
local script_path = thisScript().path
script_name("zxcDI PRIVATE") -- название
script_version("0.2 alfa") -- версия
script_authors("smish") -- создатель
script_description("send /zxc [Player ID] and check player!") -- описание

function main()
	print("script zxcDeadInside actived! used /zxc [Player ID]") -- вывод информации в консоль
	if not isSampLoaded() or not isSampfuncsLoaded() then return end -- проверка запуска игры (стырил эту чать кода)
	while not isSampAvailable() do wait(1000) end -- проверка запуска игры (стырил эту чать кода)

	sampRegisterChatCommand("zxc", zxcc) -- команда, "переменная" для мунлоадера

	sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633} Loaded! Used: /zxc id! Please ID!! {d10000}/zxc iD!!!!!", -1) -- сообщение в чат

	wait(5000)
	sampAddChatMessage("this is version 1.0")
	sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633} A new version! 1.0 {d10000}Autoupdate! New memes!", -1)
	downloadUrlToFile(update_url, update_path, function(id, status) 
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage("{8dd446}Update script to version "..updateIni.info.vers_text.."!" -1)
				update_state = true
			end

		end

	 end)

	while true do
		wait(0)
		if update_state then
				downloadUrlToFile(script_url, script_path, function(id, status) 
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			sampAddChatMessage("script update!" -1)
			thisScript():reload()

			end
	 end)
	break
		end
	end	
end

function zxcc(id) -- та самая переменная для мунлоадера
	if id == "" then
        sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}Used: {d10000}/zxc id!" -1 ) -- я поздно создал эту часть кода,она не рабочая
    end
    local result = sampIsPlayerConnected(id) -- проверка на коннект айдишника
    if not result then -- проверка на коннект айдишника
        sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.." {d10000}no Dead Inside! (No connect)" , -1) -- проверка на коннект айдишника
    else 
        local nick = sampGetPlayerNickname(id) -- узнать ник игрока
        local result = sampIsPlayerNpc(id)-- игрок нпси?
        if result then 
            npc = ' '
        else -- проверка на нпси
            npc = 'no'
        end
        local result = sampIsPlayerPaused(id) -- игрок афк?
        if result then
            afk = ' '
        else -- проверка на афк
            afk = 'no'
        end
        sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.." "..npc.." NPS "..afk.." AFK and {d10000}no Dead Inside!", -1) -- сообщение в чат
        print("{93cfcb}[zxcDI]: {7ad633}User "..id.." "..npc.." NPS "..afk.." AFK and no Dead Inside!") -- в консоль
    end
end
