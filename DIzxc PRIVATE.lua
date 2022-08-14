local vkeys = require 'vkeys' -- все подключают, хз зачем, но вроде легкче работать
-- https://github.com/Yooshyasha/zxcDI/raw/main/update.json https://github.com/Yooshyasha/zxcDI/raw/main/DIzxc%20PRIVATE.lua
script_authors("smish") -- создатель
script_description("send /zxcdi and check player!") -- описание
script_name("zxcDI PRIVATE") -- название
script_version("1.0") -- версия
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/Yooshyasha/zxcDI/main/update.json" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://raw.githubusercontent.com/Yooshyasha/zxcDI/main/DIzxc%20PRIVATE.lua"
        end
    end
end
function main()
	print("script zxcDeadInside actived! used /zxcdi") -- вывод информации в консоль
	if not isSampLoaded() or not isSampfuncsLoaded() then return end -- проверка запуска игры (стырил эту чать кода)
	while not isSampAvailable() do wait(1000) end -- проверка запуска игры (стырил эту чать кода)
	sampRegisterChatCommand("pony", ponyc)
	wait(500)
	sampRegisterChatCommand("zxc", zxcc) -- команда, "переменная" для мунлоадера
	wait(500)
	sampRegisterChatCommand("update", updater)
	wait(500)
	sampRegisterChatCommand("zxcdi", zxcdic)
	wait(500)
	sampRegisterChatCommand("mfuck", mfackc)

	sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633} Loaded! Used: /zxcdi!{d10000} zxcDI 1.0", -1) -- сообщение в чат

	wait(5000)

	sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633} A new version! 1.0 {d10000} Check /pony id! Autoupdate! New memes!", -1)

    if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end

	while true do
		wait(0)
	
	end
end
function zxcc(id) -- та самая переменная для мунлоадера

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

        sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.." "..npc.." NPS "..afk.." AFK and {d10000} Dead Inside!", -1) -- сообщение в чат

        print("{93cfcb}[zxcDI]: {7ad633}User "..id.." "..npc.." NPS "..afk.." AFK and Dead Inside!") -- в консоль
 
    end
end

function ponyc(id)
	if id == "" then
        sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}Used: {d10000}/pony id!", -1 )
    	else

    	local result = sampIsPlayerConnected(id)
    	if not result then
    		sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.."{d10000} no pony! (No connect)", -1)

    	else

    		local result = sampIsPlayerNpc(id)
    		if result then
    			npc = ''

    		else

    			npc = 'no'
    		end

    		local result = sampIsPlayerPaused(id)
    		if result then 
    			afk = ' '

    		else

    			afk = 'no'
    		end
    	end

    		sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.." "..npc.." npc, "..afk.." afk {d10000} no pony!", -1)
			sampAddChatMessage("This is new function!", -1)
    end	
end

function zxcdic(arg)
	sampShowDialog(1000, "{93cfcb}[zxcDI] Used function! Command!", "{93cfcb}Function \n {7ad633}/zxc id - dead inside \n {7ad633}/pony id - player pony? \n /mfuck id 0-1 - player mathafucker?(0 - no, 1 - yes)", "{93cfcb}OK", "{d10000}NO", DIALOG_STYLE_INPUT)
end


function mfackc(id)
	if id == "" then 
		sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}Used /mfuck id!", -1)
	else 
		local result sampIsPlayerConnected(id)

		if not result then 
			sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.." {7ad633}dont matafacker! (No connect)", -1)

		else

			local result = sampIsPlayerNpc(id)
    		if result then
    			npc = ''

    		else

    			npc = 'no'
    		end

    		local result = sampIsPlayerPaused(id)
    		if result then 
    			afk = ' '

    		else

    			afk = 'no'
    		end
    	end
    	if dobro == 1 then
    	sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.." {7ad633}dont matafacker!", -1)
    else 
    	sampAddChatMessage("{93cfcb}[zxcDI]: {7ad633}User "..id.." {d10000}matafacker! He play to SA-MP!", -1)
    end
    end
end