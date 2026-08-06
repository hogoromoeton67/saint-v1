local mainapi = {
	Categories = {},
	GUIColor = {
		Hue = 0.46,
		Sat = 0.96,
		Value = 0.52
	},
	HeldKeybinds = {},
	Keybind = {'RightShift'},
	Loaded = false,
	Libraries = {},
	Modules = {},
    Place = game.PlaceId == 6872265039 and game.PlaceId or game.GameId,
	Profile = 'default',
	Profiles = {},
	RainbowSpeed = {Value = 1},
	RainbowUpdateSpeed = {Value = 40},
	RainbowTable = setmetatable({}, {__mode = "v"}),
	Scale = {Value = 1},
	ThreadFix = setthreadidentity and true or false,
	ToggleNotifications = {},
	Version = '4.18',	
	Windows = {}
}

local cloneref = cloneref or function(obj)
	return obj
end
local tweenService = cloneref(game:GetService('TweenService'))
local inputService = cloneref(game:GetService('UserInputService'))
local textService = cloneref(game:GetService('TextService'))
local guiService = cloneref(game:GetService('GuiService'))
local runService = cloneref(game:GetService('RunService'))
local httpService = cloneref(game:GetService('HttpService'))

local fontsize = Instance.new('GetTextBoundsParams')
fontsize.Width = math.huge
local notifications
local assetfunction = getcustomasset
local getcustomasset
local clickgui
local scaledgui
local toolblur
local tooltip
local scale
local gui

local color = {}
local tween = {
	tweens = {},
	tweenstwo = {}
}
local uipallet = {
	Main = Color3.fromRGB(26, 25, 26),
	Text = Color3.fromRGB(200, 200, 200),
	Font = Font.fromEnum(Enum.Font.Arial),
	FontSemiBold = Font.fromEnum(Enum.Font.Arial, Enum.FontWeight.SemiBold),
	Tween = TweenInfo.new(0.16, Enum.EasingStyle.Linear)
}

local getcustomassets = {
	['newvape/assets/new/add.png'] = 'rbxassetid://14368300605',
	['newvape/assets/new/alert.png'] = 'rbxassetid://14368301329',
	['newvape/assets/new/allowedicon.png'] = 'rbxassetid://14368302000',
	['newvape/assets/new/allowedtab.png'] = 'rbxassetid://14368302875',
	['newvape/assets/new/arrowmodule.png'] = 'rbxassetid://14473354880',
	['newvape/assets/new/back.png'] = 'rbxassetid://14368303894',
	['newvape/assets/new/bind.png'] = 'rbxassetid://14368304734',
	['newvape/assets/new/bindbkg.png'] = 'rbxassetid://14368305655',
	['newvape/assets/new/blatanticon.png'] = 'rbxassetid://14368306745',
	['newvape/assets/new/blockedicon.png'] = 'rbxassetid://14385669108',
	['newvape/assets/new/blockedtab.png'] = 'rbxassetid://14385672881',
	['newvape/assets/new/blur.png'] = 'rbxassetid://14898786664',
	['newvape/assets/new/blurnotif.png'] = 'rbxassetid://16738720137',
	['newvape/assets/new/close.png'] = 'rbxassetid://14368309446',
	['newvape/assets/new/closemini.png'] = 'rbxassetid://14368310467',
	['newvape/assets/new/colorpreview.png'] = 'rbxassetid://14368311578',
	['newvape/assets/new/combaticon.png'] = 'rbxassetid://14368312652',
	['newvape/assets/new/customsettings.png'] = 'rbxassetid://14403726449',
	['newvape/assets/new/discord.png'] = '',
	['newvape/assets/new/dots.png'] = 'rbxassetid://14368314459',
	['newvape/assets/new/edit.png'] = 'rbxassetid://14368315443',
	['newvape/assets/new/expandicon.png'] = 'rbxassetid://14368353032',
	['newvape/assets/new/expandright.png'] = 'rbxassetid://14368316544',
	['newvape/assets/new/expandup.png'] = 'rbxassetid://14368317595',
	['newvape/assets/new/friendstab.png'] = 'rbxassetid://14397462778',
	['newvape/assets/new/guisettings.png'] = 'rbxassetid://14368318994',
	['newvape/assets/new/guislider.png'] = 'rbxassetid://14368320020',
	['newvape/assets/new/guisliderrain.png'] = 'rbxassetid://14368321228',
	['newvape/assets/new/guiv4.png'] = 'rbxassetid://14368322199',
	['newvape/assets/new/guivape.png'] = 'rbxassetid://14657521312',
	['newvape/assets/new/info.png'] = 'rbxassetid://14368324807',
	['newvape/assets/new/inventoryicon.png'] = 'rbxassetid://14928011633',
	['newvape/assets/new/legit.png'] = 'rbxassetid://14425650534',
	['newvape/assets/new/legittab.png'] = 'rbxassetid://14426740825',
	['newvape/assets/new/miniicon.png'] = 'rbxassetid://14368326029',
	['newvape/assets/new/notification.png'] = 'rbxassetid://16738721069',
	['newvape/assets/new/overlaysicon.png'] = 'rbxassetid://14368339581',
	['newvape/assets/new/overlaystab.png'] = 'rbxassetid://14397380433',
	['newvape/assets/new/pin.png'] = 'rbxassetid://14368342301',
	['newvape/assets/new/profilesicon.png'] = 'rbxassetid://14397465323',
	['newvape/assets/new/radaricon.png'] = 'rbxassetid://14368343291',
	['newvape/assets/new/rainbow_1.png'] = 'rbxassetid://14368344374',
	['newvape/assets/new/rainbow_2.png'] = 'rbxassetid://14368345149',
	['newvape/assets/new/rainbow_3.png'] = 'rbxassetid://14368345840',
	['newvape/assets/new/rainbow_4.png'] = 'rbxassetid://14368346696',
	['newvape/assets/new/range.png'] = 'rbxassetid://14368347435',
	['newvape/assets/new/rangearrow.png'] = 'rbxassetid://14368348640',
	['newvape/assets/new/rendericon.png'] = 'rbxassetid://14368350193',
	['newvape/assets/new/rendertab.png'] = 'rbxassetid://14397373458',
	['newvape/assets/new/search.png'] = 'rbxassetid://14425646684',
	['newvape/assets/new/targetinfoicon.png'] = 'rbxassetid://14368354234',
	['newvape/assets/new/targetnpc1.png'] = 'rbxassetid://14497400332',
	['newvape/assets/new/targetnpc2.png'] = 'rbxassetid://14497402744',
	['newvape/assets/new/targetplayers1.png'] = 'rbxassetid://14497396015',
	['newvape/assets/new/targetplayers2.png'] = 'rbxassetid://14497397862',
	['newvape/assets/new/targetstab.png'] = 'rbxassetid://14497393895',
	['newvape/assets/new/textguiicon.png'] = 'rbxassetid://14368355456',
	['newvape/assets/new/textv4.png'] = 'rbxassetid://14368357095',
	['newvape/assets/new/textvape.png'] = 'rbxassetid://14368358200',
	['newvape/assets/new/utilityicon.png'] = 'rbxassetid://14368359107',
	['newvape/assets/new/vape.png'] = 'rbxassetid://14373395239',
	['newvape/assets/new/warning.png'] = 'rbxassetid://14368361552',
	['newvape/assets/new/worldicon.png'] = 'rbxassetid://14368362492'
}

local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end

local function safecall(func, ...)
	local args = {...}
	xpcall(function()
		func(unpack(args))
	end, function(err)
		warn("[AEROV4] GUI Error: "..err)
	end)
end

local getfontsize = function(text, size, font)
	fontsize.Text = text
	fontsize.Size = size
	if typeof(font) == 'Font' then
		fontsize.Font = font
	end
	local ok, result = pcall(function()
		return textService:GetTextBoundsAsync(fontsize)
	end)
	return ok and result or Vector2.new(#text * (size or 14) * 0.6, size or 14)
end

local function addBlur(parent, notif)
	local blur = Instance.new('ImageLabel')
	blur.Name = 'Blur'
	blur.Size = UDim2.new(1, 89, 1, 52)
	blur.Position = UDim2.fromOffset(-48, -31)
	blur.BackgroundTransparency = 1
	blur.Image = getcustomasset('newvape/assets/new/'..(notif and 'blurnotif' or 'blur')..'.png')
	blur.ScaleType = Enum.ScaleType.Slice
	blur.SliceCenter = Rect.new(52, 31, 261, 502)
	blur.Parent = parent

	return blur
end

local function addCorner(parent, radius)
	local corner = Instance.new('UICorner')
	corner.CornerRadius = radius or UDim.new(0, 5)
	corner.Parent = parent

	return corner
end

local function addCloseButton(parent, offset)
	local close = Instance.new('ImageButton')
	close.Name = 'Close'
	close.Size = UDim2.fromOffset(24, 24)
	close.Position = UDim2.new(1, -35, 0, offset or 9)
	close.BackgroundColor3 = Color3.new(1, 1, 1)
	close.BackgroundTransparency = 1
	close.AutoButtonColor = false
	close.Image = getcustomasset('newvape/assets/new/close.png')
	close.ImageColor3 = color.Light(uipallet.Text, 0.2)
	close.ImageTransparency = 0.5
	close.Parent = parent
	addCorner(close, UDim.new(1, 0))

	close.MouseEnter:Connect(function()
		close.ImageTransparency = 0.3
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 0.6
		})
	end)
	close.MouseLeave:Connect(function()
		close.ImageTransparency = 0.5
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 1
		})
	end)

	return close
end

local function addMaid(object)
    object.Connections = {}
    function object:Clean(callback)
        if typeof(callback) == 'Instance' then
            table.insert(self.Connections, {
                Disconnect = function()
                    callback:ClearAllChildren()
                    callback:Destroy()
                end
            })
        elseif type(callback) == 'function' then
            table.insert(self.Connections, {
                Disconnect = callback
            })
        else
            table.insert(self.Connections, callback)
        end
    end
end
addMaid(mainapi)

local function addTooltip(gui, text)
	if not text then return end

	local function tooltipMoved(x, y)
		local right = x + 16 + tooltip.Size.X.Offset > (scale.Scale * 1920)
		tooltip.Position = UDim2.fromOffset(
			(right and x - (tooltip.Size.X.Offset * scale.Scale) - 16 or x + 16) / scale.Scale,
			((y + 11) - (tooltip.Size.Y.Offset / 2)) / scale.Scale
		)
		tooltip.Visible = toolblur.Visible
	end

	gui.MouseEnter:Connect(function(x, y)
		local tooltipSize = getfontsize(text, tooltip.TextSize, uipallet.Font)
		tooltip.Size = UDim2.fromOffset(tooltipSize.X + 10, tooltipSize.Y + 10)
		tooltip.Text = text
		tooltipMoved(x, y)
	end)
	gui.MouseMoved:Connect(tooltipMoved)
	gui.MouseLeave:Connect(function()
		tooltip.Visible = false
	end)
end

local function checkKeybinds(compare, target, key)
	if type(target) == 'table' then
		if table.find(target, key) then
			for i, v in target do
				if not table.find(compare, v) then
					return false
				end
			end
			return true
		end
	end

	return false
end

local function createDownloader(text)
	if mainapi.Loaded ~= true then
		local downloader = mainapi.Downloader
		if not downloader then
			downloader = Instance.new('TextLabel')
			downloader.Size = UDim2.new(1, 0, 0, 40)
			downloader.BackgroundTransparency = 1
			downloader.TextStrokeTransparency = 0
			downloader.TextSize = 20
			downloader.TextColor3 = Color3.new(1, 1, 1)
			downloader.FontFace = uipallet.Font
			downloader.Parent = mainapi.gui
			mainapi.Downloader = downloader
		end
		downloader.Text = 'Downloading '..text
	end
end

local mobileEditorOpen = false
local mobileEditorBG = nil
local mobileButtons = {}
local mobileCloseBtn = nil
local mobileEditorLabels = {}
local addMobileButton 
local persistentRecentNames = {}
local activeRefreshResults = nil 
local mobileButtonTransparency = 0
local mobileButtonBgColor = nil
local mobileButtonActiveColor = nil
local mobileBtnTweens = {}

local function getMobileTextColor(bg)
	local lum = 0.299 * bg.R + 0.587 * bg.G + 0.114 * bg.B
	return lum > 0.5 and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
end

local function formatModuleName(name)
	if #name <= 7 then return name end
	for i = math.ceil(#name / 2), 2, -1 do
		if name:sub(i, i):match('%u') then
			return name:sub(1, i - 1) .. '\n' .. name:sub(i)
		end
	end
	local m = math.ceil(#name / 2)
	return name:sub(1, m) .. '\n' .. name:sub(m + 1)
end

local function updateMobileButtonColor(btn, enabled, animate)
	local vapeColor = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	local bg = enabled and (mobileButtonActiveColor or vapeColor) or (mobileButtonBgColor or color.Dark(uipallet.Main, -0.08))
	local textCol = mobileButtonTransparency > 0.7 and Color3.new(1, 1, 1) or getMobileTextColor(bg)
	if animate and btn and btn.Parent then
		if mobileBtnTweens[btn] then
			mobileBtnTweens[btn]:Cancel()
			mobileBtnTweens[btn] = nil
		end
		mobileBtnTweens[btn] = tweenService:Create(btn, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundColor3 = bg,
			BackgroundTransparency = mobileButtonTransparency,
			TextColor3 = textCol
		})
		mobileBtnTweens[btn]:Play()
		mobileBtnTweens[btn].Completed:Once(function()
			mobileBtnTweens[btn] = nil
		end)
	else
		btn.BackgroundColor3 = bg
		btn.BackgroundTransparency = mobileButtonTransparency
		btn.TextColor3 = textCol
	end
end

local function setResizeHandlesVisible(data, visible)
	if data.resizeFrame then
		data.resizeFrame.Visible = visible
	end
end

local function closeMobileEditor()
	if mobileEditorBG then
		mobileEditorBG:Destroy()
		mobileEditorBG = nil
	end
	if mobileCloseBtn then
		mobileCloseBtn:Destroy()
		mobileCloseBtn = nil
	end
	for _, lbl in mobileEditorLabels do
		if lbl and lbl.Parent then lbl:Destroy() end
	end
	table.clear(mobileEditorLabels)
	for _, data in mobileButtons do
		data.editorMode = false
		setResizeHandlesVisible(data, false)
		if data.closePanel then
			data.closePanel()
		end
	end
	mobileEditorOpen = false
	activeRefreshResults = nil
	for _, data in mobileButtons do
		if data.button and data.button.Parent then
			data.button.Visible = not clickgui.Visible
		end
	end
end

local function openMobileEditor()
	if mobileEditorOpen then return end
	mobileEditorOpen = true
	clickgui.Visible = false
	for _, data in mobileButtons do
		if data.button and data.button.Parent then
			data.button.Visible = true
		end
	end
	mobileEditorBG = Instance.new('TextButton')
	mobileEditorBG.Name = 'MobileEditor'
	mobileEditorBG.Size = UDim2.fromScale(1, 1)
	mobileEditorBG.BackgroundColor3 = Color3.new(0, 0, 0)
	mobileEditorBG.BackgroundTransparency = 0.5
	mobileEditorBG.BorderSizePixel = 0
	mobileEditorBG.AutoButtonColor = false
	mobileEditorBG.Text = ''
	mobileEditorBG.ZIndex = 10
	mobileEditorBG.Parent = mainapi.gui
	local editorLabel = Instance.new('TextLabel')
	editorLabel.Size = UDim2.fromOffset(250, 20)
	editorLabel.Position = UDim2.fromOffset(14, 12)
	editorLabel.BackgroundTransparency = 1
	editorLabel.Text = 'MOBILE BIND EDITOR'
	editorLabel.TextColor3 = Color3.new(1, 1, 1)
	editorLabel.TextTransparency = 0.3
	editorLabel.TextSize = 12
	editorLabel.TextXAlignment = Enum.TextXAlignment.Left
	editorLabel.FontFace = uipallet.FontSemiBold
	editorLabel.ZIndex = 20
	editorLabel.Parent = mainapi.gui
	table.insert(mobileEditorLabels, editorLabel)
	local hintLabel = Instance.new('TextLabel')
	hintLabel.Size = UDim2.fromOffset(450, 16)
	hintLabel.Position = UDim2.fromOffset(14, 29)
	hintLabel.BackgroundTransparency = 1
	hintLabel.Text = 'Drag to move buttons  •  Corner handles to resize buttons •  Double tap for settings'
	hintLabel.TextColor3 = Color3.new(1, 1, 1)
	hintLabel.TextTransparency = 0.55
	hintLabel.TextSize = 10
	hintLabel.TextXAlignment = Enum.TextXAlignment.Left
	hintLabel.FontFace = uipallet.Font
	hintLabel.ZIndex = 20
	hintLabel.Parent = mainapi.gui
	table.insert(mobileEditorLabels, hintLabel)

	mobileCloseBtn = Instance.new('TextButton')
	mobileCloseBtn.Name = 'MobileEditorClose'
	mobileCloseBtn.Size = UDim2.fromOffset(44, 44)
	mobileCloseBtn.AnchorPoint = Vector2.new(1, 0)
	mobileCloseBtn.Position = UDim2.new(1, -12, 0, 12)
	mobileCloseBtn.BackgroundTransparency = 1
	mobileCloseBtn.BorderSizePixel = 0
	mobileCloseBtn.AutoButtonColor = false
	mobileCloseBtn.Text = ''
	mobileCloseBtn.ZIndex = 25
	mobileCloseBtn.Parent = mainapi.gui

	local xL1 = Instance.new('Frame')
	xL1.AnchorPoint = Vector2.new(0.5, 0.5)
	xL1.Size = UDim2.fromOffset(22, 3)
	xL1.Position = UDim2.fromScale(0.5, 0.5)
	xL1.BackgroundColor3 = Color3.new(1, 1, 1)
	xL1.BorderSizePixel = 0
	xL1.Rotation = 45
	xL1.ZIndex = 26
	xL1.Parent = mobileCloseBtn
	addCorner(xL1, UDim.new(1, 0))
	local xL2 = xL1:Clone()
	xL2.Rotation = -45
	xL2.Parent = mobileCloseBtn

	local function setXCol(c) xL1.BackgroundColor3 = c xL2.BackgroundColor3 = c end
	mobileCloseBtn.MouseEnter:Connect(function() setXCol(Color3.fromRGB(255, 80, 80)) end)
	mobileCloseBtn.MouseLeave:Connect(function() setXCol(Color3.new(1,1,1)) end)
	mobileCloseBtn.MouseButton1Click:Connect(function() closeMobileEditor() end)

	local PANEL_W = 224
	local MAX_RECENTS = 5
	local recentModules = {}
	local recentBtns = {}
	local searchPanelVisible = false
	local vapeCol = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)

	for _, name in persistentRecentNames do
		if mainapi.Modules[name] then
			table.insert(recentModules, mainapi.Modules[name])
		end
	end

	local plusBtn = Instance.new('TextButton')
	plusBtn.Name = 'MobileAddBtn'
	plusBtn.Size = UDim2.fromOffset(36, 36)
	plusBtn.AnchorPoint = Vector2.new(1, 0.5)
	plusBtn.Position = UDim2.new(1, -6, 0.5, -20)
	plusBtn.BackgroundTransparency = 1
	plusBtn.BorderSizePixel = 0
	plusBtn.AutoButtonColor = false
	plusBtn.Text = ''
	plusBtn.ZIndex = 25
	plusBtn.Parent = mainapi.gui
	table.insert(mobileEditorLabels, plusBtn)

	local plusH = Instance.new('Frame')
	plusH.AnchorPoint = Vector2.new(0.5, 0.5)
	plusH.Size = UDim2.fromOffset(14, 3)
	plusH.Position = UDim2.fromScale(0.5, 0.5)
	plusH.BackgroundColor3 = vapeCol
	plusH.BorderSizePixel = 0
	plusH.ZIndex = 26
	plusH.Parent = plusBtn
	addCorner(plusH, UDim.new(1, 0))

	local plusV = Instance.new('Frame')
	plusV.AnchorPoint = Vector2.new(0.5, 0.5)
	plusV.Size = UDim2.fromOffset(3, 14)
	plusV.Position = UDim2.fromScale(0.5, 0.5)
	plusV.BackgroundColor3 = vapeCol
	plusV.BorderSizePixel = 0
	plusV.ZIndex = 26
	plusV.Parent = plusBtn
	addCorner(plusV, UDim.new(1, 0))

	local function setPlusCol(c)
		plusH.BackgroundColor3 = c
		plusV.BackgroundColor3 = c
	end
	local function setPlusOpen(open)
		tween:Tween(plusH, uipallet.Tween, {Rotation = open and 45 or 0})
		tween:Tween(plusV, uipallet.Tween, {Rotation = open and 45 or 0})
	end

	local settingsBtn = Instance.new('TextButton')
	settingsBtn.Name = 'MobileSettingsBtn'
	settingsBtn.Size = UDim2.fromOffset(36, 36)
	settingsBtn.AnchorPoint = Vector2.new(1, 0.5)
	settingsBtn.Position = UDim2.new(1, -6, 0.5, 20)
	settingsBtn.BackgroundTransparency = 1
	settingsBtn.BorderSizePixel = 0
	settingsBtn.AutoButtonColor = false
	settingsBtn.Text = ''
	settingsBtn.ZIndex = 25
	settingsBtn.Parent = mainapi.gui
	table.insert(mobileEditorLabels, settingsBtn)

	local gearImg = Instance.new('ImageLabel')
	gearImg.AnchorPoint = Vector2.new(0.5, 0.5)
	gearImg.Size = UDim2.fromOffset(20, 20)
	gearImg.Position = UDim2.fromScale(0.5, 0.5)
	gearImg.BackgroundTransparency = 1
	gearImg.Image = getcustomasset('newvape/assets/new/guisettings.png')
	gearImg.ImageColor3 = vapeCol
	gearImg.ZIndex = 26
	gearImg.Parent = settingsBtn

	local function setGearCol(c)
		gearImg.ImageColor3 = c
	end

	local settingsPanelVisible = false
	local SETTINGS_PANEL_W = 200
	local SETTINGS_PANEL_H = 200
	local settingsPanel = Instance.new('Frame')
	settingsPanel.Name = 'MobileEditorSettingsPanel'
	settingsPanel.Size = UDim2.fromOffset(SETTINGS_PANEL_W, SETTINGS_PANEL_H)
	settingsPanel.AnchorPoint = Vector2.new(1, 0.5)
	settingsPanel.Position = UDim2.new(1, SETTINGS_PANEL_W, 0.5, 20)
	settingsPanel.BackgroundColor3 = uipallet.Main
	settingsPanel.BackgroundTransparency = 0
	settingsPanel.BorderSizePixel = 0
	settingsPanel.ZIndex = 19
	settingsPanel.ClipsDescendants = true
	settingsPanel.Parent = mainapi.gui
	addCorner(settingsPanel, UDim.new(0, 8))
	addBlur(settingsPanel)
	local settingsPanelStroke = Instance.new('UIStroke')
	settingsPanelStroke.Color = color.Light(uipallet.Main, 0.10)
	settingsPanelStroke.Thickness = 1
	settingsPanelStroke.Parent = settingsPanel
	table.insert(mobileEditorLabels, settingsPanel)

	local settingsHeaderLabel = Instance.new('TextLabel')
	settingsHeaderLabel.Size = UDim2.new(1, -10, 0, 22)
	settingsHeaderLabel.Position = UDim2.fromOffset(10, 8)
	settingsHeaderLabel.BackgroundTransparency = 1
	settingsHeaderLabel.Text = 'BUTTON SETTINGS'
	settingsHeaderLabel.TextColor3 = vapeCol
	settingsHeaderLabel.TextSize = 12
	settingsHeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
	settingsHeaderLabel.FontFace = uipallet.FontSemiBold
	settingsHeaderLabel.ZIndex = 21
	settingsHeaderLabel.Parent = settingsPanel

	local settingsDiv = Instance.new('Frame')
	settingsDiv.Size = UDim2.new(1, -16, 0, 1)
	settingsDiv.Position = UDim2.fromOffset(8, 32)
	settingsDiv.BackgroundColor3 = color.Light(uipallet.Main, 0.10)
	settingsDiv.BorderSizePixel = 0
	settingsDiv.ZIndex = 21
	settingsDiv.Parent = settingsPanel

	local opacityLabel = Instance.new('TextLabel')
	opacityLabel.Size = UDim2.new(1, -16, 0, 18)
	opacityLabel.Position = UDim2.fromOffset(10, 40)
	opacityLabel.BackgroundTransparency = 1
	opacityLabel.Text = 'Opacity  ' .. math.floor((1 - mobileButtonTransparency) * 100) .. '%'
	opacityLabel.TextColor3 = uipallet.Text
	opacityLabel.TextSize = 12
	opacityLabel.TextXAlignment = Enum.TextXAlignment.Left
	opacityLabel.FontFace = uipallet.FontSemiBold
	opacityLabel.ZIndex = 21
	opacityLabel.Parent = settingsPanel

	local sliderTrack = Instance.new('Frame')
	sliderTrack.Size = UDim2.new(1, -16, 0, 6)
	sliderTrack.Position = UDim2.fromOffset(8, 62)
	sliderTrack.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
	sliderTrack.BorderSizePixel = 0
	sliderTrack.ZIndex = 21
	sliderTrack.Parent = settingsPanel
	addCorner(sliderTrack, UDim.new(1, 0))

	local sliderFill = Instance.new('Frame')
	sliderFill.Size = UDim2.new(1 - mobileButtonTransparency, 0, 1, 0)
	sliderFill.BackgroundColor3 = vapeCol
	sliderFill.BorderSizePixel = 0
	sliderFill.ZIndex = 22
	sliderFill.Parent = sliderTrack
	addCorner(sliderFill, UDim.new(1, 0))

	local sliderKnob = Instance.new('Frame')
	sliderKnob.Size = UDim2.fromOffset(14, 14)
	sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
	sliderKnob.Position = UDim2.new(1 - mobileButtonTransparency, 0, 0.5, 0)
	sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
	sliderKnob.BorderSizePixel = 0
	sliderKnob.ZIndex = 23
	sliderKnob.Parent = sliderTrack
	addCorner(sliderKnob, UDim.new(1, 0))

	local sliderDragging = false
	local function updateSlider(inputX)
		local trackPos = sliderTrack.AbsolutePosition.X
		local trackSize = sliderTrack.AbsoluteSize.X
		local ratio = math.clamp((inputX - trackPos) / trackSize, 0, 1)
		mobileButtonTransparency = 1 - ratio
		sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
		sliderKnob.Position = UDim2.new(ratio, 0, 0.5, 0)
		opacityLabel.Text = 'Opacity  ' .. math.floor(ratio * 100) .. '%'
		for _, d in mobileButtons do
			if d.button and d.button.Parent then
				updateMobileButtonColor(d.button, d.module.Enabled)
			end
		end
	end

	sliderTrack.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = true
			updateSlider(inp.Position.X)
		end
	end)
	sliderTrack.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = false
		end
	end)
	inputService.InputChanged:Connect(function(inp)
		if not sliderDragging then return end
		if not sliderTrack.Parent then sliderDragging = false return end
		if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
			updateSlider(inp.Position.X)
		end
	end)

	local bgColorLabel = Instance.new('TextLabel')
	bgColorLabel.Size = UDim2.new(1, -16, 0, 16)
	bgColorLabel.Position = UDim2.fromOffset(10, 82)
	bgColorLabel.BackgroundTransparency = 1
	bgColorLabel.Text = 'Background'
	bgColorLabel.TextColor3 = color.Dark(uipallet.Text, 0.25)
	bgColorLabel.TextSize = 11
	bgColorLabel.TextXAlignment = Enum.TextXAlignment.Left
	bgColorLabel.FontFace = uipallet.FontSemiBold
	bgColorLabel.ZIndex = 21
	bgColorLabel.Parent = settingsPanel

	local activeColorLabel = Instance.new('TextLabel')
	activeColorLabel.Size = UDim2.new(1, -16, 0, 16)
	activeColorLabel.Position = UDim2.fromOffset(10, 140)
	activeColorLabel.BackgroundTransparency = 1
	activeColorLabel.Text = 'Active'
	activeColorLabel.TextColor3 = color.Dark(uipallet.Text, 0.25)
	activeColorLabel.TextSize = 11
	activeColorLabel.TextXAlignment = Enum.TextXAlignment.Left
	activeColorLabel.FontFace = uipallet.FontSemiBold
	activeColorLabel.ZIndex = 21
	activeColorLabel.Parent = settingsPanel

	local BG_SWATCHES = {
		{col = nil,                         label = 'Def'},
		{col = Color3.new(0, 0, 0),         label = ''},
		{col = Color3.fromRGB(28, 28, 36),  label = ''},
		{col = Color3.fromRGB(20, 38, 20),  label = ''},
		{col = Color3.fromRGB(38, 18, 18),  label = ''},
		{col = Color3.fromRGB(18, 18, 48),  label = ''},
	}
	local ACT_SWATCHES = {
		{col = nil,                          label = 'Def'},
		{col = Color3.fromRGB(255, 80, 80),  label = ''},
		{col = Color3.fromRGB(80, 220, 80),  label = ''},
		{col = Color3.fromRGB(80, 140, 255), label = ''},
		{col = Color3.fromRGB(255, 200, 60), label = ''},
		{col = Color3.fromRGB(220, 80, 220), label = ''},
	}

	local function makeSwatches(list, yPos, getCurrent, setCurrent)
		local sw_size = 22
		local sw_gap = 4
		local swatchEntries = {}

		local function colorsMatch(a, b)
			if a == nil and b == nil then return true end
			if a == nil or b == nil then return false end
			return math.abs(a.R - b.R) < 0.002 and math.abs(a.G - b.G) < 0.002 and math.abs(a.B - b.B) < 0.002
		end

		local function refreshBorders()
			local cur = getCurrent()
			for _, entry in swatchEntries do
				local selected = colorsMatch(cur, entry.col)
				entry.border.BackgroundColor3 = selected and Color3.new(1, 1, 1) or color.Light(uipallet.Main, 0.12)
			end
		end

		local borderPad = 3
		for idx, sw in list do
			local bgCol = sw.col or color.Dark(uipallet.Main, -0.08)
			local totalSize = sw_size + borderPad * 2
			local border = Instance.new('Frame')
			border.Size = UDim2.fromOffset(totalSize, totalSize)
			border.Position = UDim2.fromOffset(8 + (idx - 1) * (sw_size + sw_gap + borderPad * 2), yPos - borderPad)
			border.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
			border.BorderSizePixel = 0
			border.ZIndex = 22
			border.Parent = settingsPanel
			addCorner(border, UDim.new(0, 6))
			local s = Instance.new('TextButton')
			s.Size = UDim2.fromOffset(sw_size, sw_size)
			s.Position = UDim2.fromOffset(borderPad, borderPad)
			s.BackgroundColor3 = bgCol
			s.BorderSizePixel = 0
			s.AutoButtonColor = false
			s.Text = sw.label or ''
			s.TextColor3 = Color3.fromRGB(160, 160, 160)
			s.TextSize = 9
			s.FontFace = uipallet.FontSemiBold
			s.ZIndex = 23
			s.Parent = border
			addCorner(s, UDim.new(0, 4))
			table.insert(swatchEntries, {border = border, col = sw.col, btn = s})
			s.MouseButton1Click:Connect(function()
				setCurrent(sw.col)
				refreshBorders()
				for _, d in mobileButtons do
					if d.button and d.button.Parent then
						updateMobileButtonColor(d.button, d.module.Enabled)
					end
				end
			end)
			s.MouseEnter:Connect(function()
				if not colorsMatch(getCurrent(), sw.col) then
					tween:Tween(s, uipallet.Tween, {BackgroundColor3 = color.Light(bgCol, 0.1)})
				end
			end)
			s.MouseLeave:Connect(function()
				if not colorsMatch(getCurrent(), sw.col) then
					tween:Tween(s, uipallet.Tween, {BackgroundColor3 = bgCol})
				end
			end)
		end
		refreshBorders()
	end

	makeSwatches(BG_SWATCHES, 100,
		function() return mobileButtonBgColor end,
		function(c) mobileButtonBgColor = c end
	)
	makeSwatches(ACT_SWATCHES, 158,
		function() return mobileButtonActiveColor end,
		function(c) mobileButtonActiveColor = c end
	)

	local function hideSettingsPanel()
		if not settingsPanelVisible then return end
		settingsPanelVisible = false
		setGearCol(vapeCol)
		tween:Tween(settingsPanel, TweenInfo.new(0.28, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Position = UDim2.new(1, SETTINGS_PANEL_W, 0.5, 20)
		})
	end
	local function showSettingsPanel()
		if settingsPanelVisible then return end
		settingsPanelVisible = true
		setGearCol(Color3.new(1, 1, 1))
		tween:Tween(settingsPanel, TweenInfo.new(0.32, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Position = UDim2.new(1, -54, 0.5, 20)
		})
	end

	local function setArrowCol(c) setPlusCol(c) end
	local function setArrowOpen(open) setPlusOpen(open) end

	plusBtn.MouseEnter:Connect(function() setPlusCol(Color3.new(1, 1, 1)) end)
	plusBtn.MouseLeave:Connect(function() setPlusCol(searchPanelVisible and Color3.new(1, 1, 1) or vapeCol) end)
	settingsBtn.MouseEnter:Connect(function() setGearCol(Color3.new(1, 1, 1)) end)
	settingsBtn.MouseLeave:Connect(function() setGearCol(settingsPanelVisible and Color3.new(1, 1, 1) or vapeCol) end)
	local PANEL_H = 320
	local searchPanel = Instance.new('Frame')
	searchPanel.Name = 'MobileEditorSearchPanel'
	searchPanel.Size = UDim2.fromOffset(PANEL_W, PANEL_H)
	searchPanel.AnchorPoint = Vector2.new(1, 0.5)
	searchPanel.Position = UDim2.new(1, PANEL_W, 0.5, 0)
	searchPanel.BackgroundColor3 = uipallet.Main
	searchPanel.BackgroundTransparency = 0
	searchPanel.BorderSizePixel = 0
	searchPanel.ZIndex = 19
	searchPanel.ClipsDescendants = true
	searchPanel.Parent = mainapi.gui
	addCorner(searchPanel, UDim.new(0, 8))
	addBlur(searchPanel)
	local panelStroke = Instance.new('UIStroke')
	panelStroke.Color = color.Light(uipallet.Main, 0.10)
	panelStroke.Thickness = 1
	panelStroke.Parent = searchPanel
	table.insert(mobileEditorLabels, searchPanel)

	local function updateSidebarSize() end 

	local function rebuildRecents()
		table.clear(recentBtns)
	end

	local function addToRecents(mod)
		for i, m in recentModules do
			if m == mod then table.remove(recentModules, i) break end
		end
		table.insert(recentModules, 1, mod)
		if #recentModules > MAX_RECENTS then table.remove(recentModules) end
		table.clear(persistentRecentNames)
		for _, m in recentModules do
			table.insert(persistentRecentNames, m.Name)
		end
		rebuildRecents()
	end

	local function hideSearchPanel()
		if not searchPanelVisible then return end
		searchPanelVisible = false
		setArrowOpen(false)
		setArrowCol(vapeCol)
		tween:Tween(searchPanel, TweenInfo.new(0.28, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Position = UDim2.new(1, PANEL_W, 0.5, 0)
		})
	end

	local function showSearchPanel()
		if searchPanelVisible then return end
		searchPanelVisible = true
		setArrowOpen(true)
		setArrowCol(Color3.new(1,1,1))
		tween:Tween(searchPanel, TweenInfo.new(0.32, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Position = UDim2.new(1, -54, 0.5, 0)
		})
	end

	plusBtn.MouseButton1Click:Connect(function()
		if settingsPanelVisible then hideSettingsPanel() end
		if searchPanelVisible then hideSearchPanel() else showSearchPanel() end
	end)
	settingsBtn.MouseButton1Click:Connect(function()
		if searchPanelVisible then hideSearchPanel() end
		if settingsPanelVisible then hideSettingsPanel() else showSettingsPanel() end
	end)

	local searchLabel = Instance.new('TextLabel')
	searchLabel.Size = UDim2.new(1, -10, 0, 22)
	searchLabel.Position = UDim2.fromOffset(10, 8)
	searchLabel.BackgroundTransparency = 1
	searchLabel.Text = 'ADD FEATURE'
	searchLabel.TextColor3 = vapeCol
	searchLabel.TextTransparency = 0
	searchLabel.TextSize = 12
	searchLabel.TextXAlignment = Enum.TextXAlignment.Left
	searchLabel.FontFace = uipallet.FontSemiBold
	searchLabel.ZIndex = 21
	searchLabel.Parent = searchPanel
	local headerDiv = Instance.new('Frame')
	headerDiv.Size = UDim2.new(1, -16, 0, 1)
	headerDiv.Position = UDim2.fromOffset(8, 32)
	headerDiv.BackgroundColor3 = color.Light(uipallet.Main, 0.10)
	headerDiv.BorderSizePixel = 0
	headerDiv.ZIndex = 21
	headerDiv.Parent = searchPanel

	local searchBox = Instance.new('TextBox')
	searchBox.Size = UDim2.new(1, -16, 0, 34)
	searchBox.Position = UDim2.fromOffset(8, 40)
	searchBox.BackgroundColor3 = color.Light(uipallet.Main, 0.09)
	searchBox.BackgroundTransparency = 0
	searchBox.BorderSizePixel = 0
	searchBox.Text = ''
	searchBox.PlaceholderText = 'Search features...'
	searchBox.PlaceholderColor3 = color.Dark(uipallet.Text, 0.38)
	searchBox.TextColor3 = uipallet.Text
	searchBox.TextSize = 14
	searchBox.FontFace = uipallet.Font
	searchBox.ClearTextOnFocus = false
	searchBox.ZIndex = 21
	searchBox.Parent = searchPanel
	addCorner(searchBox, UDim.new(0, 6))
	local searchBoxStroke = Instance.new('UIStroke')
	searchBoxStroke.Color = color.Light(uipallet.Main, 0.14)
	searchBoxStroke.Thickness = 1
	searchBoxStroke.Parent = searchBox
	local sbIcon = Instance.new('ImageLabel')
	sbIcon.Size = UDim2.fromOffset(14, 14)
	sbIcon.Position = UDim2.new(1, -22, 0.5, -7)
	sbIcon.BackgroundTransparency = 1
	sbIcon.Image = getcustomasset('newvape/assets/new/search.png')
	sbIcon.ImageColor3 = color.Dark(uipallet.Text, 0.35)
	sbIcon.ZIndex = 22
	sbIcon.Parent = searchPanel

	local searchResultsFrame = Instance.new('ScrollingFrame')
	searchResultsFrame.Size = UDim2.new(1, -16, 0, PANEL_H - 40 - 34 - 16)
	searchResultsFrame.Position = UDim2.fromOffset(8, 82)
	searchResultsFrame.BackgroundTransparency = 1
	searchResultsFrame.BorderSizePixel = 0
	searchResultsFrame.ScrollBarThickness = 3
	searchResultsFrame.ScrollBarImageTransparency = 0.5
	searchResultsFrame.CanvasSize = UDim2.new()
	searchResultsFrame.ZIndex = 21
	searchResultsFrame.Parent = searchPanel

	local resultsLayout = Instance.new('UIListLayout')
	resultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	resultsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	resultsLayout.Padding = UDim.new(0, 4)
	resultsLayout.Parent = searchResultsFrame

	local function refreshResults(query)
		for _, child in searchResultsFrame:GetChildren() do
			if child:IsA('TextButton') then child:Destroy() end
		end
		local lower = (query or ''):lower()
		local count = 0
		for name, mod in mainapi.Modules do
			if lower == '' or name:lower():find(lower, 1, true) then
				local alreadyAdded = false
				for _, d in mobileButtons do
					if d.module == mod then alreadyAdded = true break end
				end
				local rb = Instance.new('TextButton')
				rb.Size = UDim2.new(1, 0, 0, 36)
				rb.BackgroundColor3 = alreadyAdded and color.Light(uipallet.Main, 0.06) or color.Light(uipallet.Main, 0.03)
				rb.BorderSizePixel = 0
				rb.AutoButtonColor = false
				rb.Text = ''
				rb.ZIndex = 22
				rb.LayoutOrder = count
				rb.Parent = searchResultsFrame
				addCorner(rb, UDim.new(0, 6))
				local rLabel = Instance.new('TextLabel')
				rLabel.Size = UDim2.new(1, alreadyAdded and -28 or -10, 1, 0)
				rLabel.Position = UDim2.fromOffset(10, 0)
				rLabel.BackgroundTransparency = 1
				rLabel.Text = name
				rLabel.TextColor3 = alreadyAdded and vapeCol or uipallet.Text
				rLabel.TextSize = 14
				rLabel.FontFace = alreadyAdded and uipallet.FontSemiBold or uipallet.Font
				rLabel.TextXAlignment = Enum.TextXAlignment.Left
				rLabel.ZIndex = 23
				rLabel.Parent = rb
				if alreadyAdded then
					local checkLabel = Instance.new('TextLabel')
					checkLabel.Size = UDim2.fromOffset(20, 36)
					checkLabel.Position = UDim2.new(1, -24, 0, 0)
					checkLabel.BackgroundTransparency = 1
					checkLabel.Text = '\u{2713}'
					checkLabel.TextColor3 = vapeCol
					checkLabel.TextSize = 14
					checkLabel.FontFace = uipallet.FontSemiBold
					checkLabel.ZIndex = 23
					checkLabel.Parent = rb
				end
				if not alreadyAdded then
					rb.MouseButton1Click:Connect(function()
						addMobileButton(mod)
						addToRecents(mod)
						hideSearchPanel()
						refreshResults(searchBox.Text)
					end)
					rb.MouseEnter:Connect(function()
						tween:Tween(rb, uipallet.Tween, {BackgroundColor3 = color.Light(uipallet.Main, 0.08)})
						rLabel.TextColor3 = color.Light(uipallet.Text, 0.1)
					end)
					rb.MouseLeave:Connect(function()
						tween:Tween(rb, uipallet.Tween, {BackgroundColor3 = color.Light(uipallet.Main, 0.03)})
						rLabel.TextColor3 = uipallet.Text
					end)
				end
				count += 1
			end
		end
		task.defer(function()
			searchResultsFrame.CanvasSize = UDim2.fromOffset(0, resultsLayout.AbsoluteContentSize.Y)
		end)
	end

	activeRefreshResults = refreshResults
	refreshResults('')
	rebuildRecents() 
	searchBox:GetPropertyChangedSignal('Text'):Connect(function()
		refreshResults(searchBox.Text)
	end)
	resultsLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		searchResultsFrame.CanvasSize = UDim2.fromOffset(0, resultsLayout.AbsoluteContentSize.Y)
	end)

	for _, data in mobileButtons do
		data.editorMode = true
		setResizeHandlesVisible(data, false)
		updateMobileButtonColor(data.button, data.module.Enabled)
	end
end

addMobileButton = function(moduleapi, savedX, savedY, savedW, savedH, silent)
	for _, data in mobileButtons do
		if data.module == moduleapi then return end
	end

	local vp = workspace.CurrentCamera.ViewportSize
	local initX = savedX or (vp.X / 2 - 35)
	local initY = savedY or (vp.Y / 2 - 35)
	local initW = savedW or 70
	local initH = savedH or 70

	local btn = Instance.new('TextButton')
	btn.Size = UDim2.fromOffset(initW, initH)
	btn.Position = UDim2.fromOffset(initX, initY)
	btn.BackgroundTransparency = 0
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Text = formatModuleName(moduleapi.Name)
	btn.TextScaled = true
	btn.FontFace = uipallet.FontSemiBold
	btn.ZIndex = 12
	btn.Parent = mainapi.gui
	addCorner(btn, UDim.new(1, 0))
	updateMobileButtonColor(btn, moduleapi.Enabled)

	local constraint = Instance.new('UITextSizeConstraint')
	constraint.MaxTextSize = 15
	constraint.MinTextSize = 7
	constraint.Parent = btn
	local resizeFrame = Instance.new('Frame')
	resizeFrame.Name = 'ResizeFrame'
	resizeFrame.BackgroundTransparency = 1
	resizeFrame.BorderSizePixel = 0
	resizeFrame.ZIndex = 14
	resizeFrame.Visible = false
	resizeFrame.Size = UDim2.new(1, 16, 1, 16)
	resizeFrame.Position = UDim2.fromOffset(-8, -8)
	resizeFrame.Parent = btn

	local rfStroke = Instance.new('UIStroke')
	rfStroke.Color = Color3.new(1, 1, 1)
	rfStroke.Thickness = 1.5
	rfStroke.Transparency = 0.2
	rfStroke.Parent = resizeFrame

	local handles = {}
	for _, ca in {{0,0},{1,0},{0,1},{1,1}} do
		local h = Instance.new('Frame')
		h.Size = UDim2.fromOffset(12, 12)
		h.AnchorPoint = Vector2.new(ca[1], ca[2])
		h.Position = UDim2.new(ca[1], 0, ca[2], 0)
		h.BackgroundColor3 = Color3.new(1, 1, 1)
		h.BorderSizePixel = 0
		h.ZIndex = 16
		h.Parent = resizeFrame
		addCorner(h, UDim.new(0, 2))
		table.insert(handles, {frame = h, ax = ca[1], ay = ca[2]})
	end

	local panel = Instance.new('Frame')
	panel.Name = 'MobileBindPanel'
	panel.BackgroundColor3 = uipallet.Main
	panel.BorderSizePixel = 0
	panel.Size = UDim2.fromOffset(0, 34)
	panel.AnchorPoint = Vector2.new(0, 0.5)
	panel.ClipsDescendants = true
	panel.ZIndex = 20
	panel.Visible = false
	panel.Parent = mainapi.gui
	addCorner(panel, UDim.new(0, 6))
	addBlur(panel)
	local connector = Instance.new('Frame')
	connector.Name = 'MobileBindConnector'
	connector.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
	connector.BorderSizePixel = 0
	connector.Size = UDim2.fromOffset(0, 2)
	connector.ZIndex = 19
	connector.Visible = false
	connector.Parent = mainapi.gui
	local rowHolder = Instance.new('Frame')
	rowHolder.BackgroundTransparency = 1
	rowHolder.Size = UDim2.new(1, -12, 1, 0)
	rowHolder.Position = UDim2.fromOffset(8, 0)
	rowHolder.ZIndex = 21
	rowHolder.Parent = panel
	local rowList = Instance.new('UIListLayout')
	rowList.FillDirection = Enum.FillDirection.Horizontal
	rowList.VerticalAlignment = Enum.VerticalAlignment.Center
	rowList.HorizontalAlignment = Enum.HorizontalAlignment.Left
	rowList.Padding = UDim.new(0, 0)
	rowList.SortOrder = Enum.SortOrder.LayoutOrder
	rowList.Parent = rowHolder
	local nameLabel = Instance.new('TextLabel')
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = moduleapi.Name
	nameLabel.TextColor3 = uipallet.Text
	nameLabel.TextSize = 12
	nameLabel.FontFace = uipallet.FontSemiBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.ZIndex = 21
	nameLabel.LayoutOrder = 1
	nameLabel.Size = UDim2.fromOffset(0, 34) 
	nameLabel.Parent = rowHolder
	local div1 = Instance.new('Frame')
	div1.Size = UDim2.fromOffset(1, 20)
	div1.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
	div1.BorderSizePixel = 0
	div1.ZIndex = 21
	div1.LayoutOrder = 2
	div1.Parent = rowHolder
	local modeBtn = Instance.new('TextButton')
	modeBtn.BackgroundTransparency = 1
	modeBtn.AutoButtonColor = false
	modeBtn.Text = moduleapi.KeybindMode
	modeBtn.TextColor3 = color.Dark(uipallet.Text, 0.16)
	modeBtn.TextSize = 11
	modeBtn.FontFace = uipallet.Font
	modeBtn.ZIndex = 21
	modeBtn.LayoutOrder = 3
	modeBtn.Size = UDim2.fromOffset(50, 34)
	modeBtn.Parent = rowHolder
	local div2 = div1:Clone()
	div2.LayoutOrder = 4
	div2.Parent = rowHolder
	local removeBtn = Instance.new('TextButton')
	removeBtn.BackgroundTransparency = 1
	removeBtn.AutoButtonColor = false
	removeBtn.Text = 'Remove'
	removeBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
	removeBtn.TextSize = 11
	removeBtn.FontFace = uipallet.Font
	removeBtn.ZIndex = 21
	removeBtn.LayoutOrder = 5
	removeBtn.Size = UDim2.fromOffset(54, 34)
	removeBtn.Parent = rowHolder

	task.defer(function()
		local tw = math.ceil(getfontsize(moduleapi.Name, 12, uipallet.FontSemiBold).X) + 4
		nameLabel.Size = UDim2.fromOffset(tw, 34)
	end)

	local panelFullW = 54 + 1 + 50 + 1 + 8 
	local panelOpen = false

	local function repositionPanel()
		local bx = btn.AbsolutePosition.X
		local by = btn.AbsolutePosition.Y
		local bw = btn.AbsoluteSize.X
		local bh = btn.AbsoluteSize.Y
		local gap = 8

		local nw = nameLabel.AbsoluteSize.X > 0 and nameLabel.AbsoluteSize.X or (math.ceil(getfontsize(moduleapi.Name, 12, uipallet.FontSemiBold).X) + 4)
		panelFullW = nw + 1 + 50 + 1 + 54 + 16
		nameLabel.Size = UDim2.fromOffset(nw, 34)

		panel.Position = UDim2.fromOffset(bx + bw + gap, by + bh/2 - 17)
		panel.Size = UDim2.fromOffset(panelFullW, 34)

		connector.Size = UDim2.fromOffset(gap, 2)
		connector.Position = UDim2.fromOffset(bx + bw, by + bh/2 - 1)
	end

	local function openPanel()
		if panelOpen then return end
		panelOpen = true
		repositionPanel()
		panel.Size = UDim2.fromOffset(0, 34)
		panel.Visible = true
		connector.Visible = true
		tween:Tween(panel, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(panelFullW, 34)
		})
	end

	local function closePanel()
		if not panelOpen then return end
		panelOpen = false
		tween:Tween(panel, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.fromOffset(0, 34)
		})
		task.delay(0.15, function()
			if not panelOpen then
				panel.Visible = false
				connector.Visible = false
			end
		end)
	end

	local data = {
		module = moduleapi,
		button = btn,
		resizeFrame = resizeFrame,
		settingsPanel = panel,
		settingsOpen = false,
		editorMode = silent ~= true,
		closePanel = closePanel,
	}
	table.insert(mobileButtons, data)

	if mobileEditorOpen then
		for _, d in mobileButtons do
			d.editorMode = true
		end
	end

	modeBtn.MouseButton1Click:Connect(function()
		moduleapi.KeybindMode = (moduleapi.KeybindMode == 'Toggle') and 'Hold' or 'Toggle'
		moduleapi.HoldCount = 0
		modeBtn.Text = moduleapi.KeybindMode
	end)
	modeBtn.MouseEnter:Connect(function()
		modeBtn.TextColor3 = uipallet.Text
	end)
	modeBtn.MouseLeave:Connect(function()
		modeBtn.TextColor3 = color.Dark(uipallet.Text, 0.16)
	end)

	removeBtn.MouseButton1Click:Connect(function()
		closePanel()
		task.delay(0.15, function()
			for i, d in mobileButtons do
				if d.module == moduleapi then
					if d.resizeConn then d.resizeConn:Disconnect() end
					if d.resizeEndConn then d.resizeEndConn:Disconnect() end
					table.remove(mobileButtons, i)
					break
				end
			end
			panel:Destroy()
			connector:Destroy()
			btn:Destroy()
			if activeRefreshResults then
				activeRefreshResults('')
			end
		end)
	end)
	removeBtn.MouseEnter:Connect(function()
		removeBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
	end)
	removeBtn.MouseLeave:Connect(function()
		removeBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
	end)

	local resizing = false
	local resizeStartMouse, resizeStartSize, resizeStartPos = nil, nil, nil
	local resizeAnchorX, resizeAnchorY = 0, 0

	for _, h in handles do
		h.frame.InputBegan:Connect(function(input)
			if not data.editorMode then return end
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizing = true
				resizeStartMouse = Vector2.new(input.Position.X, input.Position.Y)
				resizeStartSize = Vector2.new(btn.AbsoluteSize.X, btn.AbsoluteSize.Y)
				resizeStartPos = Vector2.new(btn.AbsolutePosition.X, btn.AbsolutePosition.Y)
				resizeAnchorX = h.ax
				resizeAnchorY = h.ay
			end
		end)
	end

	local resizeConn = inputService.InputChanged:Connect(function(input)
		if not resizing then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local delta = Vector2.new(input.Position.X, input.Position.Y) - resizeStartMouse
		local dw = resizeAnchorX == 0 and -delta.X or delta.X
		local dh = resizeAnchorY == 0 and -delta.Y or delta.Y
		local newW = math.clamp(resizeStartSize.X + dw, 44, 220)
		local newH = math.clamp(resizeStartSize.Y + dh, 44, 220)
		local newX = resizeStartPos.X + (resizeAnchorX == 0 and (resizeStartSize.X - newW) or 0)
		local newY = resizeStartPos.Y + (resizeAnchorY == 0 and (resizeStartSize.Y - newH) or 0)
		btn.Size = UDim2.fromOffset(newW, newH)
		btn.Position = UDim2.fromOffset(newX, newY)
		if panelOpen then repositionPanel() end
	end)

	local resizeEndConn = inputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = false
		end
	end)

	local dragging = false
	local dragStart, startPos = nil, nil
	local dragMoveConn, dragEndConn = nil, nil

	btn.InputBegan:Connect(function(input)
		if not data.editorMode then return end
		if resizing then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = Vector2.new(input.Position.X, input.Position.Y)
			startPos = btn.Position
			if dragMoveConn then dragMoveConn:Disconnect() end
			if dragEndConn then dragEndConn:Disconnect() end
			dragMoveConn = inputService.InputChanged:Connect(function(inp)
				if not dragging or not data.editorMode or resizing then return end
				if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
					local delta = Vector2.new(inp.Position.X, inp.Position.Y) - dragStart
					btn.Position = UDim2.fromOffset(startPos.X.Offset + delta.X, startPos.Y.Offset + delta.Y)
					if panelOpen then repositionPanel() end
				end
			end)
			dragEndConn = inputService.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					dragging = false
					if dragMoveConn then dragMoveConn:Disconnect(); dragMoveConn = nil end
					if dragEndConn then dragEndConn:Disconnect(); dragEndConn = nil end
				end
			end)
		end
	end)

	local lastClickTime = 0
	local holdActive = false

	btn.MouseButton1Click:Connect(function()
		if resizing then return end
		local now = tick()

		if data.editorMode then
			if now - lastClickTime < 0.4 then
				if panelOpen then
					closePanel()
					resizeFrame.Visible = false
				else
					for _, d in mobileButtons do
						if d ~= data and d.settingsPanel and d.settingsPanel.Visible then
							tween:Tween(d.settingsPanel, TweenInfo.new(0.14, Enum.EasingStyle.Quad), {Size = UDim2.fromOffset(0, 34)})
							task.delay(0.15, function() if d.settingsPanel then d.settingsPanel.Visible = false end end)
						end
					end
					openPanel()
					resizeFrame.Visible = true
				end
			end
			lastClickTime = now
		else
			if moduleapi.KeybindMode == 'Toggle' then
				moduleapi:Toggle()
				updateMobileButtonColor(btn, moduleapi.Enabled, true)
			end
		end
	end)

	btn.InputBegan:Connect(function(input)
		if data.editorMode then return end
		if resizing then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if moduleapi.KeybindMode ~= 'Hold' then return end
		holdActive = true
		moduleapi:SetEnabled(true)
		updateMobileButtonColor(btn, true)
	end)

	btn.InputEnded:Connect(function(input)
		if data.editorMode then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if moduleapi.KeybindMode ~= 'Hold' then return end
		if holdActive then
			holdActive = false
			moduleapi:SetEnabled(false)
			updateMobileButtonColor(btn, false)
		end
	end)

	mainapi:Clean(inputService.InputBegan:Connect(function(inp)
		if resizing then return end
		if not panelOpen then return end
		if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and inp.UserInputType ~= Enum.UserInputType.Touch then return end
		local pos = inp.Position
		local function inBounds(obj)
			if not obj or not obj.Parent then return false end
			local a = obj.AbsolutePosition
			local s = obj.AbsoluteSize
			return pos.X >= a.X and pos.X <= a.X + s.X and pos.Y >= a.Y and pos.Y <= a.Y + s.Y
		end
		if not inBounds(btn) and not inBounds(panel) then
			closePanel()
			resizeFrame.Visible = false
		end
	end))

	data.resizeConn = resizeConn
	data.resizeEndConn = resizeEndConn
end

local function createMobileButton(moduleapi, position, savedW, savedH)
	local sx = position and position.X or nil
	local sy = position and position.Y or nil
	addMobileButton(moduleapi, sx, sy, savedW, savedH, true) 
end

local function downloadFile(path, func)
	if not isfile(path) then
		createDownloader(path)
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/poopparty/poopparty/'..readfile('newvape/profiles/commit.txt')..'/'..select(1, path:gsub('newvape/', '')), true)
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

getcustomasset = not inputService.TouchEnabled and assetfunction and function(path)
	return downloadFile(path, assetfunction)
end or function(path)
	return getcustomassets[path] or ''
end

local function getTableSize(tab)
	local ind = 0
	for _ in tab do ind += 1 end
	return ind
end

local function loopClean(tab)
	for i, v in tab do
		if type(v) == 'table' then
			loopClean(v)
		end
		tab[i] = nil
	end
end

local function loadJson(path)
	local suc, res = pcall(function()
		return httpService:JSONDecode(readfile(path))
	end)
	return suc and type(res) == 'table' and res or nil
end
local draggableids = {}

local function removeDraggable(gui)
    if remove then
        if draggableids[gui] then
            draggableids[gui]:Disconnect()
            draggableids[gui] = nil
        end
        return
    end

end

local function isDraggable(gui)
	if draggableids[gui] then
		return true
	end
	return false
end

local function makeDraggable(gui, window,rmv)
	rmv = rmv or false
	if rmv then
		removeDraggable(gui)
	end
	if draggableids[gui] then return end
	draggableids[gui] = gui.InputBegan:Connect(function(inputObj)
		if window and not window.Visible then return end
		if
			(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
			and (inputObj.Position.Y - gui.AbsolutePosition.Y < 40 or window)
		then
			local dragPosition = Vector2.new(
				gui.AbsolutePosition.X - inputObj.Position.X,
				gui.AbsolutePosition.Y - inputObj.Position.Y + guiService:GetGuiInset().Y
			) / scale.Scale

			local changed = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
					local position = input.Position
					if inputService:IsKeyDown(Enum.KeyCode.LeftShift) then
						dragPosition = (dragPosition // 3) * 3
						position = (position // 3) * 3
					end
					gui.Position = UDim2.fromOffset((position.X / scale.Scale) + dragPosition.X, (position.Y / scale.Scale) + dragPosition.Y)
				end
			end)

			local ended
			ended = inputObj.Changed:Connect(function()
				if inputObj.UserInputState == Enum.UserInputState.End then
					if changed then
						changed:Disconnect()
					end
					if ended then
						ended:Disconnect()
					end
				end
			end)
		end
	end)
end

getgenv().DraggableFunc = makeDraggable
getgenv().IsDragFunc = isDraggable

local function randomString()
	local array = {}
	for i = 1, math.random(10, 100) do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local function removeTags(str)
	str = str:gsub('<br%s*/>', '\n')
	return str:gsub('<[^<>]->', '')
end

do
	local res = isfile('newvape/profiles/color.txt') and loadJson('newvape/profiles/color.txt')
	if res then
		uipallet.Main = res.Main and Color3.fromRGB(unpack(res.Main)) or uipallet.Main
		uipallet.Text = res.Text and Color3.fromRGB(unpack(res.Text)) or uipallet.Text
		uipallet.Font = res.Font and Font.new(
			res.Font:find('rbxasset') and res.Font
			or string.format('rbxasset://fonts/families/%s.json', res.Font)
		) or uipallet.Font
		uipallet.FontSemiBold = Font.new(uipallet.Font.Family, Enum.FontWeight.SemiBold)
	end
	fontsize.Font = uipallet.Font
end

do
	function color.Dark(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v + num or v - num, 0, 1))
	end

	function color.Light(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v - num or v + num, 0, 1))
	end

	function mainapi:Color(h)
		local s = 0.75 + (0.15 * math.min(h / 0.03, 1))
		if h > 0.57 then
			s = 0.9 - (0.4 * math.min((h - 0.57) / 0.09, 1))
		end
		if h > 0.66 then
			s = 0.5 + (0.4 * math.min((h - 0.66) / 0.16, 1))
		end
		if h > 0.87 then
			s = 0.9 - (0.15 * math.min((h - 0.87) / 0.13, 1))
		end
		return h, s, 1
	end

	function mainapi:TextColor(h, s, v)
		if v >= 0.7 and (s < 0.6 or h > 0.04 and h < 0.56) then
			return Color3.new(0.19, 0.19, 0.19)
		end
		return Color3.new(1, 1, 1)
	end
end

do
	function tween:Tween(obj, tweeninfo, goal, tab)
		tab = tab or self.tweens
		if tab[obj] then
			tab[obj]:Cancel()
			tab[obj] = nil
		end

		if obj.Parent and obj.Visible then
			tab[obj] = tweenService:Create(obj, tweeninfo, goal)
			tab[obj].Completed:Once(function()
				if tab then
					tab[obj] = nil
					tab = nil
				end
			end)
			tab[obj]:Play()
		else
			for i, v in goal do
				obj[i] = v
			end
		end
	end

	function tween:Cancel(obj)
		if self.tweens[obj] then
			self.tweens[obj]:Cancel()
			self.tweens[obj] = nil
		end
	end
end

mainapi.Libraries = {
	color = color,
	getcustomasset = getcustomasset,
	getfontsize = getfontsize,
	tween = tween,
	uipallet = uipallet,
}

mainapi.ModuleTags = {
    KitESP = {"alchemist", "beekeeper", "bigman", "ghost_catcher", "metal_detector", "sheep_herder", "sorcerer", "star_collector", "black_market_trader", "miner", "trapper", "necromancer", "battery", "metal", "eldertree", "gompy", "deathadder", "wren"},
}

mainapi.TagDisplay = {
    KitESP = {
        alchemist = "AlchemistESP",
        beekeeper = "BeekeeperESP",
        bigman = "EldertreeESP",
        ghost_catcher = "GompyESP",
        metal_detector = "MetalESP",
        metal = "MetalESP",
        sheep_herder = "SheepHerderESP",
        sorcerer = "DeathAdderESP",
        deathadder = "DeathAdderESP",
        star_collector = "StarCollectorESP",
        black_market_trader = "WrenESP",
        wren = "WrenESP",
        miner = "MinerESP",
        trapper = "TrapperESP",
        necromancer = "NecromancerESP",
        battery = "BatteryESP",
        eldertree = "EldertreeESP",
        gompy = "GompyESP",
    },
}

mainapi.ModuleAliases = {
    Wizard = {"Zeno"},
    Killaura = {"ka"},
    GrandKillaura = {"grandka"},
    ProjectileAimAssist = {"pa"},
    Spider_Queen = {"arachne"},
    Necromancer = {"crypt"},
    Midnight = {"nyx"},
    Sorcerer = {"death"},
    Davey = {"Pirate"},
    Battery = {"Cobalt"},
    Defender = {"Marcel"},
    Block_Kicker = {"terra"},
    Dragon_Slayer = {"Kaliyah"},
    Ice_Queen = {"Freiya"},
    Jailor = {"Warden"},
    Mimic = {"Milo"},
    Pinata = {"Lucia"},
    spirit_assassin = {"Evelyn"},
    void_knight = {"vk"},
    void_dragon = {"Xu'rot"},
    cactus = {"Martin"},
    card = {"Fortuna"},
    black_market_trader = {"Wren"},
    summoner = {"Kaida"},
    bigman = {"Eldertree"},
    spirit_summoner = {"Uma"},
    mage = {"Whim"},
    warlock = {"Eldric"},
    Breaker = {"Nuker"},  
    KitESP = {"alchemist", "beekeeper", "bigman", "ghost_catcher", "metal_detector", "sheep_herder", "sorcerer", "star_collector", "black_market_trader", "miner", "trapper", "necromancer", "battery"}
}

local components
components = {
	Button = function(optionsettings, children, api)
		local button = Instance.new('TextButton')
		button.Name = optionsettings.Name..'Button'
		button.Size = UDim2.new(1, 0, 0, 35) 
		button.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Visible = optionsettings.Visible == nil or optionsettings.Visible
		button.Text = ''
		button.Parent = children
		addTooltip(button, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Size = UDim2.fromOffset(200, 27)
		bkg.Position = UDim2.fromOffset(10, 2)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.05)
		bkg.Parent = button
		addCorner(bkg)
		local label = Instance.new('TextLabel')
		label.Size = UDim2.new(1, -4, 1, -4)
		label.Position = UDim2.fromOffset(2, 2)
		label.BackgroundColor3 = uipallet.Main
		label.Text = optionsettings.Name
		label.TextColor3 = color.Dark(uipallet.Text, 0.16)
		label.TextSize = 14
		label.FontFace = uipallet.Font
		label.Parent = bkg
		addCorner(label, UDim.new(0, 4))
		optionsettings.Function = optionsettings.Function or function() end
		
		button.MouseEnter:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.0875)
			})
		end)
		button.MouseLeave:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.05)
			})
		end)
		button.MouseButton1Click:Connect(optionsettings.Function)
	end,
	ColorSlider = function(optionsettings, children, api)
		local optionapi = {
			Type = 'ColorSlider',
			Hue = optionsettings.DefaultHue or 0.44,
			Sat = optionsettings.DefaultSat or 1,
			Value = optionsettings.DefaultValue or 1,
			Opacity = optionsettings.DefaultOpacity or 1,
			Rainbow = false,
			Default = {
				Hue = optionsettings.DefaultHue or 0.44,
				Sat = optionsettings.DefaultSat or 1,
				Value = optionsettings.DefaultValue or 1,
				Opacity = optionsettings.DefaultOpacity or 1
			},
			Index = 0
		}
		
		local function createSlider(name, gradientColor)
			local slider = Instance.new('TextButton')
			slider.Name = optionsettings.Name..'Slider'..name
			slider.Size = UDim2.new(1, 0, 0, 50)
			slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
			slider.BorderSizePixel = 0
			slider.AutoButtonColor = false
			slider.Visible = false
			slider.Text = ''
			slider.Parent = children
			local title = Instance.new('TextLabel')
			title.Name = 'Title'
			title.Size = UDim2.fromOffset(60, 30)
			title.Position = UDim2.fromOffset(10, 2)
			title.BackgroundTransparency = 1
			title.Text = name
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.TextColor3 = color.Dark(uipallet.Text, 0.16)
			title.TextSize = 11
			title.FontFace = uipallet.Font
			title.Parent = slider
			local bkg = Instance.new('Frame')
			bkg.Name = 'Slider'
			bkg.Size = UDim2.new(1, -20, 0, 2)
			bkg.Position = UDim2.fromOffset(10, 37)
			bkg.BackgroundColor3 = Color3.new(1, 1, 1)
			bkg.BorderSizePixel = 0
			bkg.Parent = slider
			local gradient = Instance.new('UIGradient')
			gradient.Color = gradientColor
			gradient.Parent = bkg
			local fill = bkg:Clone()
			fill.Name = 'Fill'
			fill.Size = UDim2.fromScale(math.clamp(name == 'Saturation' and optionapi.Sat or name == 'Vibrance' and optionapi.Value or optionapi.Opacity, 0.04, 0.96), 1)
			fill.Position = UDim2.new()
			fill.BackgroundTransparency = 1
			fill.Parent = bkg
			local knobholder = Instance.new('Frame')
			knobholder.Name = 'Knob'
			knobholder.Size = UDim2.fromOffset(24, 4)
			knobholder.Position = UDim2.fromScale(1, 0.5)
			knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
			knobholder.BackgroundColor3 = slider.BackgroundColor3
			knobholder.BorderSizePixel = 0
			knobholder.Parent = fill
			local knob = Instance.new('Frame')
			knob.Name = 'Knob'
			knob.Size = UDim2.fromOffset(14, 14)
			knob.Position = UDim2.fromScale(0.5, 0.5)
			knob.AnchorPoint = Vector2.new(0.5, 0.5)
			knob.BackgroundColor3 = uipallet.Text
			knob.Parent = knobholder
			addCorner(knob, UDim.new(1, 0))
		
			slider.InputBegan:Connect(function(inputObj)
				if
					(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
					and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
				then
					local changed = inputService.InputChanged:Connect(function(input)
						if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
							optionapi:SetValue(nil, name == 'Saturation' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil, name == 'Vibrance' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil, name == 'Opacity' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil)
						end
					end)
		
					local ended
					ended = inputObj.Changed:Connect(function()
						if inputObj.UserInputState == Enum.UserInputState.End then
							if changed then changed:Disconnect() end
							if ended then ended:Disconnect() end
						end
					end)
				end
			end)
			slider.MouseEnter:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(16, 16)
				})
			end)
			slider.MouseLeave:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(14, 14)
				})
			end)
		
			return slider
		end
		
		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.new(1, 0, 0, 50)
		slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		slider.BorderSizePixel = 0
		slider.AutoButtonColor = false
		slider.Visible = optionsettings.Visible == nil or optionsettings.Visible
		slider.Text = ''
		slider.Parent = children
		addTooltip(slider, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = UDim2.fromOffset(60, 15)
		valuebox.Position = UDim2.new(1, -69, 0, 9)
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = ''
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = true
		valuebox.Parent = slider
		local bkg = Instance.new('Frame')
		bkg.Name = 'Slider'
		bkg.Size = UDim2.new(1, -20, 0, 2)
		bkg.Position = UDim2.fromOffset(10, 39)
		bkg.BackgroundColor3 = Color3.new(1, 1, 1)
		bkg.BorderSizePixel = 0
		bkg.Parent = slider
		local rainbowTable = {}
		for i = 0, 1, 0.1 do
			table.insert(rainbowTable, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)))
		end
		local gradient = Instance.new('UIGradient')
		gradient.Color = ColorSequence.new(rainbowTable)
		gradient.Parent = bkg
		local fill = bkg:Clone()
		fill.Name = 'Fill'
		fill.Size = UDim2.fromScale(math.clamp(optionapi.Hue, 0.04, 0.96), 1)
		fill.Position = UDim2.new()
		fill.BackgroundTransparency = 1
		fill.Parent = bkg
		local preview = Instance.new('ImageButton')
		preview.Name = 'Preview'
		preview.Size = UDim2.fromOffset(12, 12)
		preview.Position = UDim2.new(1, -22, 0, 10)
		preview.BackgroundTransparency = 1
		preview.Image = getcustomasset('newvape/assets/new/colorpreview.png')
		preview.ImageColor3 = Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value)
		preview.ImageTransparency = 1 - optionapi.Opacity
		preview.Parent = slider
		local expandbutton = Instance.new('TextButton')
		expandbutton.Name = 'Expand'
		expandbutton.Size = UDim2.fromOffset(17, 13)
		expandbutton.Position = UDim2.new(0, textService:GetTextSize(title.Text, title.TextSize, title.Font, Vector2.new(1000, 1000)).X + 11, 0, 7)
		expandbutton.BackgroundTransparency = 1
		expandbutton.Text = ''
		expandbutton.Parent = slider
		local expand = Instance.new('ImageLabel')
		expand.Name = 'Expand'
		expand.Size = UDim2.fromOffset(9, 5)
		expand.Position = UDim2.fromOffset(4, 4)
		expand.BackgroundTransparency = 1
		expand.Image = getcustomasset('newvape/assets/new/expandicon.png')
		expand.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		expand.Parent = expandbutton
		local rainbow = Instance.new('TextButton')
		rainbow.Name = 'Rainbow'
		rainbow.Size = UDim2.fromOffset(12, 12)
		rainbow.Position = UDim2.new(1, -42, 0, 10)
		rainb
