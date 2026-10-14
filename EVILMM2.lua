-- ========================================================
-- Evil Scripts Hub | Clean Movement & MM2 ESP Edition
-- ========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Contenedor GUI seguro
local parentGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
if gethui then
	parentGui = gethui()
elseif game:GetService("CoreGui") then
	pcall(function() parentGui = game:GetService("CoreGui") end)
end

-- Limpiar previa interfaz
if parentGui:FindFirstChild("EvilScriptsMainGUI") then
	parentGui.EvilScriptsMainGUI:Destroy()
end

-- ScreenGui Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EvilScriptsMainGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- ESTADOS Y VARIABLES GLOBALES
local espEnabled = false
local speedHack = false
local highJump = false
local noclipEnabled = false
local infJumpEnabled = false

local customSpeed = 50
local customJump = 120
local defaultWalkSpeed = 16
local defaultJumpPower = 50

local ROLE_COLORS = {
	Murderer = Color3.fromRGB(255, 35, 35),
	Sheriff  = Color3.fromRGB(35, 120, 255),
	Hero     = Color3.fromRGB(255, 215, 0),
	Innocent = Color3.fromRGB(35, 255, 100)
}
local espHighlights = {}

-- ========================================================
-- 1. PANTALLA DE KEY SYSTEM
-- ========================================================

local KeySystemFrame = Instance.new("Frame", ScreenGui)
KeySystemFrame.Name = "KeySystemFrame"
KeySystemFrame.Size = UDim2.new(0, 320, 0, 180)
KeySystemFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
KeySystemFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeySystemFrame.Active = true
KeySystemFrame.Draggable = true

Instance.new("UICorner", KeySystemFrame).CornerRadius = UDim.new(0, 12)
local ksStroke = Instance.new("UIStroke", KeySystemFrame)
ksStroke.Thickness = 2.5
ksStroke.Color = Color3.fromRGB(180, 0, 255)

local ksTitle = Instance.new("TextLabel", KeySystemFrame)
ksTitle.Size = UDim2.new(1, 0, 0, 40)
ksTitle.BackgroundTransparency = 1
ksTitle.Text = "EVIL SCRIPTS - KEY SYSTEM"
ksTitle.TextColor3 = Color3.fromRGB(220, 40, 255)
ksTitle.TextSize = 15
ksTitle.Font = Enum.Font.FredokaOne

local ksBox = Instance.new("TextBox", KeySystemFrame)
ksBox.Size = UDim2.new(0.8, 0, 0, 38)
ksBox.Position = UDim2.new(0.1, 0, 0.35, 0)
ksBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ksBox.PlaceholderText = "Ingresa la Key..."
ksBox.Text = ""
ksBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ksBox.TextSize = 13
ksBox.Font = Enum.Font.Gotham
Instance.new("UICorner", ksBox).CornerRadius = UDim.new(0, 6)

local ksButton = Instance.new("TextButton", KeySystemFrame)
ksButton.Size = UDim2.new(0.8, 0, 0, 38)
ksButton.Position = UDim2.new(0.1, 0, 0.65, 0)
ksButton.BackgroundColor3 = Color3.fromRGB(140, 0, 220)
ksButton.Text = "VERIFICAR KEY"
ksButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ksButton.TextSize = 13
ksButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", ksButton).CornerRadius = UDim.new(0, 6)

-- ========================================================
-- 2. PANEL PRINCIPAL
-- ========================================================

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(180, 0, 255)

-- Barra Superior
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local TopTitle = Instance.new("TextLabel", TopBar)
TopTitle.Size = UDim2.new(0, 200, 1, 0)
TopTitle.Position = UDim2.new(0, 15, 0, 0)
TopTitle.BackgroundTransparency = 1
TopTitle.Text = "EVIL SCRIPTS"
TopTitle.TextColor3 = Color3.fromRGB(220, 40, 255)
TopTitle.TextSize = 14
TopTitle.Font = Enum.Font.FredokaOne
TopTitle.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton", TopBar)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0.5, -15)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 20, 40)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
MinimizeBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

-- Sidebar Lateral
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 130, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Sidebar.BorderSizePixel = 0

local CategoryHeader = Instance.new("TextLabel", Sidebar)
CategoryHeader.Size = UDim2.new(1, -16, 0, 20)
CategoryHeader.Position = UDim2.new(0, 12, 0, 8)
CategoryHeader.BackgroundTransparency = 1
CategoryHeader.Text = "MENÚ"
CategoryHeader.TextColor3 = Color3.fromRGB(120, 100, 140)
CategoryHeader.TextSize = 9
CategoryHeader.Font = Enum.Font.GothamBold
CategoryHeader.TextXAlignment = Enum.TextXAlignment.Left

-- Área de Contenido
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -130, 1, -36)
ContentArea.Position = UDim2.new(0, 130, 0, 36)
ContentArea.BackgroundTransparency = 1

local ContentTitle = Instance.new("TextLabel", ContentArea)
ContentTitle.Size = UDim2.new(1, -20, 0, 25)
ContentTitle.Position = UDim2.new(0, 15, 0, 10)
ContentTitle.BackgroundTransparency = 1
ContentTitle.Text = "MM2 Roles & ESP"
ContentTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ContentTitle.TextSize = 15
ContentTitle.Font = Enum.Font.GothamBold
ContentTitle.TextXAlignment = Enum.TextXAlignment.Left

local TabFrames = {}
local function createTabContainer(name)
	local frame = Instance.new("ScrollingFrame", ContentArea)
	frame.Name = name .. "Frame"
	frame.Size = UDim2.new(1, 0, 1, -35)
	frame.Position = UDim2.new(0, 0, 0, 35)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.CanvasSize = UDim2.new(0, 0, 0, 280)
	frame.ScrollBarThickness = 3
	frame.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 255)
	frame.Visible = false
	TabFrames[name] = frame
	return frame
end

local function createToggleBtnInParent(parent, name, posX, posY, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0, 160, 0, 28)
	btn.Position = UDim2.new(0, posX, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 10
	btn.Font = Enum.Font.GothamBold
	btn.Text = name .. ": OFF"
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = name .. ": " .. (state and "ON" or "OFF")
		btn.BackgroundColor3 = state and Color3.fromRGB(140, 0, 220) or Color3.fromRGB(30, 25, 40)
		btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
		callback(state)
	end)
	return btn
end

-- Pestaña 1: MM2 Roles
local fMM2 = createTabContainer("MM2 Roles")
fMM2.Visible = true
local qMM2 = Instance.new("Frame", fMM2)
qMM2.Size = UDim2.new(1, -30, 0, 100)
qMM2.Position = UDim2.new(0, 15, 0, 10)
qMM2.BackgroundTransparency = 1

createToggleBtnInParent(qMM2, "ESP Roles (Murder/Sheriff)", 0, 0, function(st)
	espEnabled = st
	if not st then
		for _, h in pairs(espHighlights) do if h then h:Destroy() end end
		espHighlights = {}
	end
end)

-- Pestaña 2: Movimiento
local fMovimiento = createTabContainer("Movimiento")
local qMovimiento = Instance.new("Frame", fMovimiento)
qMovimiento.Size = UDim2.new(1, -30, 0, 220)
qMovimiento.Position = UDim2.new(0, 15, 0, 10)
qMovimiento.BackgroundTransparency = 1

createToggleBtnInParent(qMovimiento, "Super Velocidad (Speed)", 0, 0, function(st) 
	speedHack = st 
	if not st and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = defaultWalkSpeed
	end
end)

createToggleBtnInParent(qMovimiento, "Super Salto (High Jump)", 0, 35, function(st) 
	highJump = st 
	if not st and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid.JumpPower = defaultJumpPower
	end
end)

createToggleBtnInParent(qMovimiento, "Noclip (Atravesar Paredes)", 0, 70, function(st) noclipEnabled = st end)
createToggleBtnInParent(qMovimiento, "Salto Infinito", 0, 105, function(st) infJumpEnabled = st end)

-- Navegación Lateral (Solo MM2 Roles y Movimiento)
local tabs = {
	{Name = "MM2 Roles", Icon = "🎯", Active = true},
	{Name = "Movimiento", Icon = "🏃"}
}

local tabButtons = {}
for i, tab in ipairs(tabs) do
	local TabBtn = Instance.new("TextButton", Sidebar)
	TabBtn.Size = UDim2.new(1, -16, 0, 26)
	TabBtn.Position = UDim2.new(0, 8, 0, 28 + (i - 1) * 30)
	TabBtn.BackgroundColor3 = tab.Active and Color3.fromRGB(35, 20, 45) or Color3.fromRGB(0, 0, 0)
	TabBtn.BackgroundTransparency = tab.Active and 0 or 1
	TabBtn.Text = "  " .. tab.Icon .. "  " .. tab.Name
	TabBtn.TextColor3 = tab.Active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 160)
	TabBtn.TextSize = 10
	TabBtn.Font = Enum.Font.GothamSemibold
	TabBtn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

	local Indicator = Instance.new("Frame", TabBtn)
	Indicator.Size = UDim2.new(0, 3, 0, 14)
	Indicator.Position = UDim2.new(0, 0, 0.5, -7)
	Indicator.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
	Indicator.BorderSizePixel = 0
	Indicator.Visible = tab.Active
	Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

	tabButtons[i] = {Btn = TabBtn, Ind = Indicator, Name = tab.Name}

	TabBtn.MouseButton1Click:Connect(function()
		for _, tb in ipairs(tabButtons) do
			tb.Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			tb.Btn.BackgroundTransparency = 1
			tb.Btn.TextColor3 = Color3.fromRGB(150, 150, 160)
			tb.Ind.Visible = false
		end
		TabBtn.BackgroundColor3 = Color3.fromRGB(35, 20, 45)
		TabBtn.BackgroundTransparency = 0
		TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		Indicator.Visible = true
		ContentTitle.Text = tab.Name

		for _, frame in pairs(TabFrames) do frame.Visible = false end
		if TabFrames[tab.Name] then TabFrames[tab.Name].Visible = true end
	end)
end

-- Botón Flotante Minimizado
local MinimizedCircle = Instance.new("TextButton", ScreenGui)
MinimizedCircle.Size = UDim2.new(0, 50, 0, 50)
MinimizedCircle.Position = UDim2.new(0.05, 0, 0.2, 0)
MinimizedCircle.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MinimizedCircle.TextColor3 = Color3.fromRGB(220, 40, 255)
MinimizedCircle.Text = "EVIL"
MinimizedCircle.TextSize = 13
MinimizedCircle.Font = Enum.Font.FredokaOne
MinimizedCircle.Active = true
MinimizedCircle.Draggable = true
MinimizedCircle.Visible = false
Instance.new("UICorner", MinimizedCircle).CornerRadius = UDim.new(1, 0)

local UIStrokeCircle = Instance.new("UIStroke", MinimizedCircle)
UIStrokeCircle.Color = Color3.fromRGB(180, 0, 255)
UIStrokeCircle.Thickness = 2

MinimizeBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	MinimizedCircle.Visible = true
end)

MinimizedCircle.MouseButton1Click:Connect(function()
	MinimizedCircle.Visible = false
	MainFrame.Visible = true
end)

-- ==========================================================
-- LÓGICA DEL KEY SYSTEM
-- ==========================================================

ksButton.MouseButton1Click:Connect(function()
	if ksBox.Text == "EVILMM2" then
		ksButton.Text = "¡KEY CORRECTA!"
		ksButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
		task.wait(0.8)
		KeySystemFrame:Destroy()
		MainFrame.Visible = true
	else
		ksButton.Text = "KEY INCORRECTA!"
		ksButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
		task.wait(1.2)
		ksButton.Text = "VERIFICAR KEY"
		ksButton.BackgroundColor3 = Color3.fromRGB(140, 0, 220)
	end
end)

-- ==========================================================
-- BUCLES Y FUNCIONALIDADES EN TIEMPO REAL
-- ==========================================================

local function getPlayerRole(player)
	if not player or not player.Character then return "Innocent" end
	local bp = player:FindFirstChild("Backpack")
	local char = player.Character
	if (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife") then return "Murderer"
	elseif (bp and bp:FindFirstChild("Gun")) or char:FindFirstChild("Gun") then return "Sheriff" end
	return "Innocent"
end

-- Bucle constante de físicas (Speed, High Jump, Noclip)
RunService.Stepped:Connect(function()
	if not MainFrame.Visible and not MinimizedCircle.Visible then return end

	local char = LocalPlayer.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		
		-- Forzar Velocidad
		if speedHack and hum then
			hum.WalkSpeed = customSpeed
		end

		-- Forzar Salto Alto
		if highJump and hum then
			hum.UseJumpPower = true
			hum.JumpPower = customJump
		end

		-- Modo Noclip
		if noclipEnabled then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide == true then
					part.CanCollide = false
				end
			end
		end
	end
end)

-- Bucle de renderizado para ESP
RunService.RenderStepped:Connect(function()
	if not MainFrame.Visible and not MinimizedCircle.Visible then return end

	if espEnabled then
		for _, p in pairs(Players:GetPlayers()) do
			if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local role = getPlayerRole(p)
				local col = ROLE_COLORS[role] or ROLE_COLORS.Innocent
				if p == LocalPlayer then col = Color3.fromRGB(255, 255, 255) end
				
				local hl = espHighlights[p]
				if not hl or not hl.Parent then
					hl = Instance.new("Highlight")
					hl.Name = "EvilESP"
					hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					hl.FillTransparency = 0.5
					hl.Parent = p.Character
					espHighlights[p] = hl
				end
				hl.FillColor = col
				hl.OutlineColor = col
			end
		end
	end
end)

-- Evento de Salto Infinito
UserInputService.JumpRequest:Connect(function()
	if infJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
