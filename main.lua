local license = ... or {}
repeat task.wait() until game:IsLoaded()
if shared.vape then shared.vape:Uninject() end
license.Key = license.Key or '_key'

if isfolder('catrewrite') and isfolder('catrewrite/profiles') then
	for _, v in listfiles('catrewrite/profiles') do
		if not v:find('commit.txt') then
			local old = v
			v = v:gsub('catrewrite', 'catsix')
			writefile(v, readfile(old))
		end
	end
	delfolder('catrewrite/profiles')
end

local vape
local loadstring = function(...)
	local res, err = loadstring(...)
	if err and vape then
		vape:CreateNotification('Vape', 'Failed to load : '..err, 30, 'alert')
	end
	return res
end
local queue_on_teleport = queue_on_teleport or function() end
local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end
local cloneref = cloneref or function(obj)
	return obj
end
local playersService = cloneref(game:GetService('Players'))
local httpService = cloneref(game:GetService("HttpService"))

local function downloadFile(path, func)
	if not isfile(path) then
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/MaxlaserTech/CatV6/'..readfile('catsix/profiles/commit.txt')..'/'..select(1, path:gsub('catsix/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find('.lua') then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

local function finishLoading()
	vape.Init = nil
	vape:Load()

	local teleportedServers
	vape:Clean(playersService.LocalPlayer.OnTeleport:Connect(function()
		if (not teleportedServers) and (not shared.VapeIndependent) then
			teleportedServers = true
			local teleportScript = [[
				shared.vapereload = true
				if shared.VapeDeveloper then
					loadstring(readfile('catsix/main.lua'), 'main')(_scriptconfig)
				else
					loadstring(game:HttpGet('https://raw.githubusercontent.com/MaxlaserTech/CatV6/'..readfile('catsix/profiles/commit.txt')..'/init.lua', true), 'init')(_scriptconfig)
				end
			]]
			local teleportConfig = httpService:JSONEncode(license)
			teleportConfig = teleportConfig:gsub('":true', "=true"):gsub('{"', '{')
			teleportConfig = teleportConfig:gsub(',"', ','):gsub('":', '=')
			teleportConfig = teleportConfig:gsub('%[', '{'):gsub('%]', '}')
			teleportScript = teleportScript:gsub('_key', tostring(license.Key or '_key'))
			teleportScript = teleportScript:gsub('_scriptconfig', teleportConfig)
			if shared.VapeDeveloper then
				teleportScript = 'shared.VapeDeveloper = true\n'..teleportScript
			end
			if shared.VapeCustomProfile then
				teleportScript = 'shared.VapeCustomProfile = "'..shared.VapeCustomProfile..'"\n'..teleportScript
			end
			vape:Save()
			queue_on_teleport(teleportScript)
		end
	end))

	if not shared.vapereload then
		if getgenv().catrole == 'HWID MISMATCH' then
			vape:CreateNotification('Cat', 'HWID MISMATCH, Go to the script panel to reset hwid', 25, 'alert')
			getgenv().catrole = ''
			task.wait(0.1)
		end
		if not shared.vapereload then
			vape:CreateNotification('Finished Loading', (getgenv().catname and `Authenticated as {getgenv().catname} with {getgenv().catrole}, ` or '').. (vape.VapeButton and 'Press the button in the top right' or 'Press '..table.concat(vape.Keybind, ' + '):upper())..' to open GUI', 5)
			task.delay(0.05 + cloneref(game:GetService('RunService')).PostSimulation:Wait(), function()
				if shared.updated then
					vape:CreateNotification('Cat', `Script has updated from {shared.updated} to {readfile('catrewrite/profiles/commit.txt')}`, 10, 'info')
				end
			end)
		end	
	end
end

if not isfile('catsix/profiles/gui.txt') then
	writefile('catsix/profiles/gui.txt', 'new')
end
local gui = 'new'--readfile('catsix/profiles/gui.txt')

if not isfolder('catsix/assets/'..gui) then
	makefolder('catsix/assets/'..gui)
end
vape = loadstring(downloadFile('catsix/guis/'..gui..'.lua'), 'gui')(license)
shared.vape = vape
_G.vape = vape
getgenv().used_init = true

if hookmetamethod then
	local old; old = hookmetamethod(game, '__namecall', function(self, Remote, ...)
		if not checkcaller() and getnamecallmethod() == 'FireServer' then
			if typeof(Remote) == "Instance" and Remote.Name == 'TabFreezeAnticheat_ClientToServerReport' then
				return
			end
		end
		return old(self, Remote, ...)
	end)
end

if shared.maincat then
	redirect()
	playersService.LocalPlayer:Kick('Your script is outdated, Get new one at discord.gg/catvape')
	return
end

if not shared.VapeIndependent then
	loadstring(downloadFile('catsix/games/universal.lua'), 'universal')(license)
	if isfile('catsix/games/'..game.PlaceId..'.lua') then
		loadstring(readfile('catsix/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(license)
	else
		if not shared.VapeDeveloper then
			local suc, res = pcall(function()
				return game:HttpGet('https://raw.githubusercontent.com/MaxlaserTech/CatV6/'..readfile('catsix/profiles/commit.txt')..'/games/'..game.PlaceId..'.lua', true)
			end)
			if suc and res ~= '404: Not Found' then
				loadstring(downloadFile('catsix/games/'..game.PlaceId..'.lua'), tostring(game.PlaceId))(license)
			end
		end
	end
	loadstring(downloadFile('catsix/libraries/premium.lua'), 'premium')(license)
	finishLoading()
else
	vape.Init = finishLoading
	return vape
end
--[[
	SAINT V1 - AIM ASSIST + SOCD + AUTO FLICK + AUTO MOVEMENT (appended loader)
]]

-- Cleanly disable native modules we are about to replace, so their running loops do not survive as zombies.
for _, name in ipairs({ "AimAssist", "SOCD", "Auto Flick", "Auto Movement" }) do
	local m = vape.Modules[name]
	if m and m.Enabled then
		pcall(function() m:Toggle() end)
	end
end
local vape = shared.vape or _G.vape
if not vape then
	error("saintv4: vape failed to load")
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local Aim = { Enabled = false, Speed = 12, Distance = 30, Strength = 70, Prediction = true, PredTime = 100, TeamCheck = true, Shake = false, ShakeX = 1.5, ShakeY = 1, ShakeSpeed = 8 }
local aimConn, lastTarget, lastSelf, targetVel, selfVel, shakeTime = nil, nil, nil, Vector3.zero, Vector3.zero, 0
local SOCD = { Enabled = false, Mode = "Last Input" }
local socdConn, socdBeginConn, socdEndConn, socdKeys, lastH, lastV = nil, nil, nil, {}, nil, nil
local AutoFlick = { Enabled = false, Mode = "Legit", Speed = 15, Angle = 30, FOV = 200, TeamCheck = true }
local flickConn, flickTarget, flickActive, flickDelay = nil, nil, false, 0
local AutoMove = { Enabled = false, Mode = "Opposite", Distance = 25, Speed = 0.3, TeamCheck = true }
local moveConn, moveTimer, moveDir = nil, 0, nil
local playerA, playerD = false, false
UserInputService.InputBegan:Connect(function(input, g) if g then return end; if input.KeyCode == Enum.KeyCode.A then playerA = true end; if input.KeyCode == Enum.KeyCode.D then playerD = true end end)
UserInputService.InputEnded:Connect(function(input, g) if g then return end; if input.KeyCode == Enum.KeyCode.A then playerA = false end; if input.KeyCode == Enum.KeyCode.D then playerD = false end end)
local function IsEnemy(p) if localPlayer.Team and p.Team then return localPlayer.Team ~= p.Team end; if localPlayer.TeamColor and p.TeamColor then return localPlayer.TeamColor ~= p.TeamColor end; return true end
local function GetTargetPart(char, part) if part == "Head" then local h = char:FindFirstChild("Head"); if h then return h end end; return char:FindFirstChild("HumanoidRootPart") end
local function AimLoop(dt)
	if not Aim.Enabled then return end
	local char = localPlayer.Character
	if not char then return end
	local hum = char:FindFirstChild("Humanoid")
	if not hum or hum.Health <= 0 then lastTarget, lastSelf = nil, nil; return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local pos = root.Position
	if lastSelf then selfVel = (pos - lastSelf) / dt end
	lastSelf = pos
	local camPos = camera.CFrame.Position
	local camDir = camera.CFrame.LookVector
	local best, bestScore = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p == localPlayer then continue end
		if Aim.TeamCheck and not IsEnemy(p) then continue end
		local c = p.Character
		if not c then continue end
		local hrp = c:FindFirstChild("HumanoidRootPart")
		local hum = c:FindFirstChild("Humanoid")
		if not hrp or not hum or hum.Health <= 0 then continue end
		local delta = hrp.Position - camPos
		local dist = delta.Magnitude
		if dist > Aim.Distance then continue end
		local dot = camDir:Dot(delta.Unit)
		if dot <= 0.3 then continue end
		local angle = math.acos(math.clamp(dot, -1, 1))
		local score = angle + (dist / Aim.Distance) * 0.3
		if score < bestScore then bestScore = score; best = hrp end
	end
	if not best then lastTarget = nil; return end
	local tPos = best.Position
	if lastTarget then targetVel = (tPos - lastTarget) / dt end
	lastTarget = tPos
	local aim = tPos
	if Aim.Prediction then aim = tPos + targetVel * (Aim.PredTime/1000) - selfVel * (Aim.PredTime/1000) end
	local dir = (aim - camPos).Unit
	local look = camera.CFrame.LookVector
	local dot = math.clamp(look:Dot(dir), -1, 1)
	local angle = math.acos(dot)
	if angle > 0.002 then
		local maxRot = math.rad(Aim.Speed) * dt
		local rot = math.min(angle * (Aim.Strength/100), maxRot)
		local axis = look:Cross(dir)
		if axis.Magnitude > 0.001 then
			local newLook = CFrame.fromAxisAngle(axis.Unit, rot) * look
			local up = camera.CFrame.UpVector
			if math.abs(newLook:Dot(up)) > 0.9999 then up = camera.CFrame.RightVector:Cross(newLook) end
			camera.CFrame = CFrame.lookAt(camPos, camPos + newLook, up)
		end
	end
	if Aim.Shake then
		shakeTime = shakeTime + dt * Aim.ShakeSpeed
		camera.CFrame = camera.CFrame * CFrame.Angles(math.cos(shakeTime*1.7)*Aim.ShakeY*0.0003, math.sin(shakeTime*2.3)*Aim.ShakeX*0.0003, 0)
	end
end
local function StartAim() if aimConn then aimConn:Disconnect() end; aimConn = RunService.RenderStepped:Connect(function(dt) pcall(AimLoop, dt) end) end
local function StopAim() if aimConn then aimConn:Disconnect(); aimConn = nil end; lastTarget, lastSelf = nil, nil end
local function SOCDLoop()
	if not SOCD.Enabled then return end
	local a = socdKeys[Enum.KeyCode.A] or socdKeys[0x41]; local d = socdKeys[Enum.KeyCode.D] or socdKeys[0x44]
	local w = socdKeys[Enum.KeyCode.W] or socdKeys[0x57]; local s = socdKeys[Enum.KeyCode.S] or socdKeys[0x53]
	if a and d then
		if SOCD.Mode == "Last Input" then
			if lastH == "D" then keyrelease(0x41); keypress(0x44)
			elseif lastH == "A" then keyrelease(0x44); keypress(0x41) end
		else
			if lastH == "D" then keyrelease(0x44); keypress(0x41); lastH = "A"
			else keyrelease(0x41); keypress(0x44); lastH = "D" end
		end
	elseif a then lastH = "A" elseif d then lastH = "D" else lastH = nil end
	if w and s then
		if SOCD.Mode == "Last Input" then
			if lastV == "S" then keyrelease(0x57); keypress(0x53)
			elseif lastV == "W" then keyrelease(0x53); keypress(0x57) end
		else
			if lastV == "S" then keyrelease(0x53); keypress(0x57); lastV = "W"
			else keyrelease(0x57); keypress(0x53); lastV = "S" end
		end
	elseif w then lastV = "W" elseif s then lastV = "S" else lastV = nil end
end
local function StartSOCD() if socdConn then return end; socdBeginConn = UserInputService.InputBegan:Connect(function(i,g) if not g then socdKeys[i.KeyCode]=true end end); socdEndConn = UserInputService.InputEnded:Connect(function(i,g) if not g then socdKeys[i.KeyCode]=nil end end); socdConn = RunService.Heartbeat:Connect(SOCDLoop) end
local function StopSOCD() if socdConn then socdConn:Disconnect(); socdConn=nil end; if socdBeginConn then socdBeginConn:Disconnect(); socdBeginConn=nil end; if socdEndConn then socdEndConn:Disconnect(); socdEndConn=nil end; socdKeys,lastH,lastV={},nil,nil end
local function AutoFlickLoop(dt)
	if not AutoFlick.Enabled then return end
	local mouseDelta = UserInputService:GetMouseDelta()
	if mouseDelta.Magnitude > 15 and not flickActive then flickActive = true; flickDelay = 0.05; flickTarget = nil end
	if flickActive then
		flickDelay = flickDelay - dt
		if flickDelay <= 0 then
			flickActive = false
			local char = localPlayer.Character
			if not char then return end
			local camPos = camera.CFrame.Position
			local camDir = camera.CFrame.LookVector
			local bestTarget = nil
			local bestAngle = math.rad(AutoFlick.Angle)
			local bestDist = AutoFlick.FOV
			for _, p in ipairs(Players:GetPlayers()) do
				if p == localPlayer then continue end
				if AutoFlick.TeamCheck and not IsEnemy(p) then continue end
				local c = p.Character
				if not c then continue end
				local hum = c:FindFirstChild("Humanoid")
				if not hum or hum.Health <= 0 then continue end
				local part = GetTargetPart(c, "Center")
				if not part then continue end
				local delta = part.Position - camPos
				local dist = delta.Magnitude
				if dist > AutoFlick.FOV then continue end
				local dot = camDir:Dot(delta.Unit)
				if dot <= 0.2 then continue end
				local angleToTarget = math.acos(math.clamp(dot, -1, 1))
				if angleToTarget < bestAngle and dist < bestDist then bestAngle = angleToTarget; bestDist = dist; bestTarget = part.Position end
			end
			if bestTarget then
				if AutoFlick.Mode == "Insta" then
					camera.CFrame = CFrame.lookAt(camPos, bestTarget)
				else
					local targetDir = (bestTarget - camPos).Unit
					local currentDir = camera.CFrame.LookVector
					local dot = math.clamp(currentDir:Dot(targetDir), -1, 1)
					local angle = math.acos(dot)
					if angle > 0.001 then
						local maxRot = math.rad(AutoFlick.Speed * 6) * dt
						local rot = math.min(angle, maxRot)
						local axis = currentDir:Cross(targetDir)
						if axis.Magnitude > 0.001 then
							local newLook = CFrame.fromAxisAngle(axis.Unit, rot) * currentDir
							local up = camera.CFrame.UpVector
							if math.abs(newLook:Dot(up)) > 0.9999 then up = camera.CFrame.RightVector:Cross(newLook) end
							camera.CFrame = CFrame.lookAt(camPos, camPos + newLook, up)
						end
					end
				end
			end
		end
	end
end
local function StartAutoFlick() if flickConn then flickConn:Disconnect() end; flickActive = false; flickTarget = nil; flickConn = RunService.RenderStepped:Connect(function(dt) pcall(AutoFlickLoop, dt) end) end
local function StopAutoFlick() if flickConn then flickConn:Disconnect(); flickConn = nil end; flickActive = false; flickTarget = nil end
local function AutoMoveLoop(dt)
	if not AutoMove.Enabled then return end
	if playerA or playerD then if moveDir then keyrelease(moveDir=="A" and 0x41 or 0x44); moveDir = nil end; return end
	local char = localPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local hum = char:FindFirstChild("Humanoid")
	if not hum or hum.Health <= 0 then if moveDir then keyrelease(moveDir=="A" and 0x41 or 0x44); moveDir = nil end; return end
	local myPos = root.Position
	local closest, closestDist = nil, AutoMove.Distance
	for _, p in ipairs(Players:GetPlayers()) do
		if p == localPlayer then continue end
		if AutoMove.TeamCheck and not IsEnemy(p) then continue end
		local c = p.Character
		if not c then continue end
		local hrp = c:FindFirstChild("HumanoidRootPart")
		local hum2 = c:FindFirstChild("Humanoid")
		if not hrp or not hum2 or hum2.Health <= 0 then continue end
		local dist = (hrp.Position - myPos).Magnitude
		if dist < closestDist then closestDist = dist; closest = hrp end
	end
	if not closest then if moveDir then keyrelease(moveDir=="A" and 0x41 or 0x44); moveDir = nil end; return end
	moveTimer = moveTimer + dt
	if moveTimer < AutoMove.Speed then return end
	moveTimer = 0
	local right = root.CFrame.RightVector
	local toEnemy = (closest.Position - myPos).Unit
	local side = right:Dot(toEnemy)
	local newDir
	if AutoMove.Mode == "Same" then
		if side > 0.1 then newDir = "D" elseif side < -0.1 then newDir = "A" end
	else
		if side > 0.1 then newDir = "A" elseif side < -0.1 then newDir = "D" end
	end
	if newDir and newDir ~= moveDir then
		if moveDir then keyrelease(moveDir=="A" and 0x41 or 0x44) end
		keypress(newDir=="A" and 0x41 or 0x44)
		moveDir = newDir
	end
end
local function StartAutoMove() if moveConn then moveConn:Disconnect() end; moveConn = RunService.Heartbeat:Connect(function(dt) pcall(AutoMoveLoop, dt) end) end
local function StopAutoMove() if moveConn then moveConn:Disconnect(); moveConn = nil end; if moveDir then keyrelease(moveDir=="A" and 0x41 or 0x44); moveDir = nil end end
localPlayer.CharacterAdded:Connect(function() StopAim(); if Aim.Enabled then StartAim() end; StopAutoMove(); if AutoMove.Enabled then StartAutoMove() end; playerA, playerD = false, false end)

local aimMod = vape.Categories.Combat:CreateModule({Name = "AimAssist", Tooltip = "Smooth aim with shake", Function = function() end})
aimMod:CreateToggle({Name = "Enabled", Default = false, Function = function(v) Aim.Enabled = v; if v then StartAim() else StopAim() end end})
aimMod:CreateSlider({Name = "Speed", Min = 1, Max = 25, Default = 12, Suffix = " deg/s", Function = function(v) Aim.Speed = v end})
aimMod:CreateSlider({Name = "Distance", Min = 5, Max = 50, Default = 30, Suffix = " studs", Function = function(v) Aim.Distance = v end})
aimMod:CreateSlider({Name = "Strength", Min = 10, Max = 100, Default = 70, Suffix = "%", Function = function(v) Aim.Strength = v end})
aimMod:CreateToggle({Name = "Prediction", Default = true, Function = function(v) Aim.Prediction = v end})
aimMod:CreateToggle({Name = "Team Check", Default = true, Function = function(v) Aim.TeamCheck = v end})
aimMod:CreateToggle({Name = "Shake", Default = false, Function = function(v) Aim.Shake = v end})
aimMod:CreateSlider({Name = "Shake X", Min = 0, Max = 5, Default = 1.5, Function = function(v) Aim.ShakeX = v end})
aimMod:CreateSlider({Name = "Shake Y", Min = 0, Max = 5, Default = 1, Function = function(v) Aim.ShakeY = v end})
local socdMod = vape.Categories.Combat:CreateModule({Name = "SOCD", Tooltip = "Instant direction changes", Function = function() end})
socdMod:CreateToggle({Name = "Enabled", Default = false, Function = function(v) SOCD.Enabled = v; if v then StartSOCD() else StopSOCD() end end})
socdMod:CreateDropdown({Name = "Mode", List = {"Last Input", "Alternate"}, Default = "Last Input", Function = function(v) SOCD.Mode = v end})
local flickMod = vape.Categories.Combat:CreateModule({Name = "Auto Flick", Tooltip = "Flick to enemy after fast mouse movement", Function = function() end})
flickMod:CreateToggle({Name = "Enabled", Default = false, Function = function(v) AutoFlick.Enabled = v; if v then StartAutoFlick() else StopAutoFlick() end end})
flickMod:CreateDropdown({Name = "Mode", List = {"Insta", "Legit"}, Default = "Legit", Function = function(v) AutoFlick.Mode = v end})
flickMod:CreateSlider({Name = "Speed", Min = 5, Max = 50, Default = 15, Suffix = " deg/s", Function = function(v) AutoFlick.Speed = v end})
flickMod:CreateSlider({Name = "Angle", Min = 5, Max = 90, Default = 30, Suffix = " deg", Function = function(v) AutoFlick.Angle = v end})
flickMod:CreateSlider({Name = "FOV", Min = 50, Max = 500, Default = 200, Suffix = " studs", Function = function(v) AutoFlick.FOV = v end})
flickMod:CreateToggle({Name = "Team Check", Default = true, Function = function(v) AutoFlick.TeamCheck = v end})
local moveMod = vape.Categories.Combat:CreateModule({Name = "Auto Movement", Tooltip = "Auto strafe when enemy nearby", Function = function() end})
moveMod:CreateToggle({Name = "Enabled", Default = false, Function = function(v) AutoMove.Enabled = v; if v then StartAutoMove() else StopAutoMove() end end})
moveMod:CreateDropdown({Name = "Mode", List = {"Opposite", "Same"}, Default = "Opposite", Function = function(v) AutoMove.Mode = v end})
moveMod:CreateSlider({Name = "Distance", Min = 5, Max = 30, Default = 25, Suffix = " studs", Function = function(v) AutoMove.Distance = v end})
moveMod:CreateSlider({Name = "Speed", Min = 0.1, Max = 1, Default = 0.3, Suffix = "s", Function = function(v) AutoMove.Speed = v end})
moveMod:CreateToggle({Name = "Team Check", Default = true, Function = function(v) AutoMove.TeamCheck = v end})

print("Saint V1 Loaded - RIGHT SHIFT = GUI")
if vape and vape.Load and not vape.Loaded then vape.Init = nil; vape:Load() end
