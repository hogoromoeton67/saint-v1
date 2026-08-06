-- Saint v1 | Init Bootstrap — Rewritten
-- Author: hogoromoeton67 | Clean pass by Axiom

local license = ... or {}

-- ── Boot Guard ──────────────────────────────────────────────────────────────
repeat task.wait() until game:IsLoaded()
if shared.vape then shared.vape:Uninject() end
license.Key = license.Key or '_key'

-- ── Profile Migration: catrewrite → catsix ──────────────────────────────────
if isfolder('catrewrite') and isfolder('catrewrite/profiles') then
    for _, path in listfiles('catrewrite/profiles') do
        if not path:find('commit.txt') then
            writefile(path:gsub('catrewrite', 'catsix'), readfile(path))
        end
    end
    delfolder('catrewrite/profiles')
end

-- ── Polyfills ────────────────────────────────────────────────────────────────
local queue_on_teleport = queue_on_teleport or function() end
local cloneref          = cloneref or function(o) return o end
local isfile            = isfile or function(path)
    local ok, data = pcall(readfile, path)
    return ok and data ~= nil and data ~= ''
end

-- ── Services ─────────────────────────────────────────────────────────────────
local Players     = cloneref(game:GetService('Players'))
local HttpService = cloneref(game:GetService('HttpService'))
local RunService  = cloneref(game:GetService('RunService'))

-- ── Constants ────────────────────────────────────────────────────────────────
local REMOTE_ROOT = 'https://raw.githubusercontent.com/hogoromoeton67/saint-v1/main/'
local CACHE_ROOT  = 'catsix/'
local WATERMARK   = '--This watermark is used to delete the file if its cached, '
                 .. 'remove it to make the file persist after vape updates.\n'

-- ── State ────────────────────────────────────────────────────────────────────
local vape

-- ── Loadstring Wrapper ───────────────────────────────────────────────────────
-- Save native before shadowing — original code called itself recursively here.
local native_loadstring = loadstring
local function loadstring(src, chunkname)
    local fn, err = native_loadstring(src, chunkname)
    if err and vape then
        vape:CreateNotification('SAINT', 'Failed to load: ' .. tostring(err), 30, 'alert')
    end
    return fn
end

-- ── File Fetcher ─────────────────────────────────────────────────────────────
local function downloadFile(path, readFn)
    if not isfile(path) then
        local remotePath = path:gsub(CACHE_ROOT, '')
        local ok, data   = pcall(game.HttpGet, game, REMOTE_ROOT .. remotePath, true)

        if not ok or data == '404: Not Found' then
            error(('[saint] fetch failed — %s: %s'):format(remotePath, tostring(data)))
        end

        -- %.lua is correct — plain .lua is a pattern wildcard in find()
        if path:find('%.lua$') then
            data = WATERMARK .. data
        end

        writefile(path, data)
    end

    return (readFn or readfile)(path)
end

-- ── Teleport Script Builder ───────────────────────────────────────────────────
local function buildTeleportScript()
    local body = [[
        shared.vapereload = true
        if shared.VapeDeveloper then
            loadstring(readfile('catsix/main.lua'), 'main')(_scriptconfig)
        else
            loadstring(game:HttpGet('https://raw.githubusercontent.com/hogoromoeton67/saint-v1/main/init.lua', true), 'init')(_scriptconfig)
        end
    ]]

    -- JSONEncode → Luau table literal (executor queue_on_teleport expects it)
    local cfg = HttpService:JSONEncode(license)
        :gsub('":true', '=true')
        :gsub('{"',     '{')
        :gsub(',"',     ',')
        :gsub('":', '=')
        :gsub('%[',     '{')
        :gsub('%]',     '}')

    body = body
        :gsub('_key',          tostring(license.Key or '_key'))
        :gsub('_scriptconfig', cfg)

    if shared.VapeDeveloper    then
        body = 'shared.VapeDeveloper = true\n' .. body
    end
    if shared.VapeCustomProfile then
        body = ('shared.VapeCustomProfile = "%s"\n'):format(shared.VapeCustomProfile) .. body
    end

    return body
end

-- ── Load Notifications ───────────────────────────────────────────────────────
local function fireLoadNotifications()
    local env = getgenv()

    if env.catrole == 'HWID MISMATCH' then
        vape:CreateNotification(
            'SAINT',
            'HWID MISMATCH — go to the script panel to reset HWID',
            25, 'alert'
        )
        env.catrole = ''
        task.wait(0.1)
    end

    if not shared.vapereload then
        local authStr = env.catname
            and ('Authenticated as %s with %s, '):format(env.catname, env.catrole)
            or  ''

        local openStr = vape.VapeButton
            and 'Press the button in the top right'
            or  ('Press %s to open GUI'):format(table.concat(vape.Keybind, ' + '):upper())

        vape:CreateNotification('Finished Loading', authStr .. openStr, 5)

        task.delay(0.05 + RunService.PostSimulation:Wait(), function()
            if shared.updated then
                vape:CreateNotification(
                    'SAINT',
                    ('Script updated from %s to main'):format(shared.updated),
                    10, 'info'
                )
            end
        end)
    end
end

-- ── Finish Loading ────────────────────────────────────────────────────────────
local function finishLoading()
    vape.Init = nil
    vape:Load()

    local teleportFired = false
    vape:Clean(Players.LocalPlayer.OnTeleport:Connect(function()
        if teleportFired or shared.VapeIndependent then return end
        teleportFired = true
        vape:Save()
        queue_on_teleport(buildTeleportScript())
    end))

    if not shared.vapereload then
        fireLoadNotifications()
    end
end

-- ── Anticheat Hook ────────────────────────────────────────────────────────────
-- Drops FireServer calls targeting TabFreezeAnticheat_ClientToServerReport.
if hookmetamethod then
    local original
    original = hookmetamethod(game, '__namecall', function(self, ...)
        if not checkcaller() and getnamecallmethod() == 'FireServer' then
            if typeof(self) == 'Instance'
            and self.Name == 'TabFreezeAnticheat_ClientToServerReport' then
                return
            end
        end
        return original(self, ...)
    end)
end

-- ── Outdated Script Guard ─────────────────────────────────────────────────────
if shared.maincat then
    redirect()
    Players.LocalPlayer:Kick('Script outdated — get the new one at discord.gg/catvape')
    return
end

-- ── GUI Bootstrap ─────────────────────────────────────────────────────────────
do
    if not isfile('catsix/profiles/gui.txt') then
        writefile('catsix/profiles/gui.txt', 'new')
    end

    local guiVariant = 'new' -- readfile('catsix/profiles/gui.txt')
    local assetsDir  = CACHE_ROOT .. 'assets/' .. guiVariant

    if not isfolder(assetsDir) then
        makefolder(assetsDir)
    end

    vape = loadstring(
        downloadFile(CACHE_ROOT .. 'guis/' .. guiVariant .. '.lua'),
        'gui'
    )(license)

    shared.vape         = vape
    _G.vape             = vape
    getgenv().used_init = true
end

-- ── Game Module Loader ────────────────────────────────────────────────────────
if not shared.VapeIndependent then
    loadstring(downloadFile(CACHE_ROOT .. 'games/universal.lua'), 'universal')(license)

    local gamePath = ('%sgames/%s.lua'):format(CACHE_ROOT, game.PlaceId)

    if isfile(gamePath) then
        loadstring(readfile(gamePath), tostring(game.PlaceId))(license)
    elseif not shared.VapeDeveloper then
        local ok, data = pcall(
            game.HttpGet, game,
            REMOTE_ROOT .. 'games/' .. game.PlaceId .. '.lua',
            true
        )
        if ok and data ~= '404: Not Found' then
            loadstring(downloadFile(gamePath), tostring(game.PlaceId))(license)
        end
    end

    loadstring(downloadFile(CACHE_ROOT .. 'libraries/premium.lua'), 'premium')(license)
    finishLoading()
else
    vape.Init = finishLoading
    return vape
end
