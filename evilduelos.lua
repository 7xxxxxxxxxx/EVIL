




























































































































































































































-- Servicios necesarios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Variables de configuración
local hitboxEnabled = false
local hitboxSize = 1 -- Tamaño por defecto (mínimo 1, máximo 4)

-- Crear la ScreenGui principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EvilDuelosGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- 1. PANEL PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

-- Título del Panel
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "EVIL Duelos beta"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Botón de Cerrar (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = MainFrame

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 4)
UICornerClose.Parent = CloseButton

-- 2. BOTÓN "HACERSE BOLITA" (Minimizar)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(0.5, -20, 0.1, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizeButton.Text = "🔴"
MinimizeButton.TextSize = 20
MinimizeButton.Active = true
MinimizeButton.Draggable = true
MinimizeButton.Visible = false
MinimizeButton.Parent = ScreenGui

local UICornerMini = Instance.new("UICorner")
UICornerMini.CornerRadius = UDim.new(1, 0)
UICornerMini.Parent = MinimizeButton

-- 3. TOGGLE HITBOX EXPANDER
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0, 45)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.Text = "Hitbox: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 100, 100)
ToggleButton.TextSize = 13
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Parent = MainFrame

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(0, 6)
UICornerToggle.Parent = ToggleButton

-- 4. SLIDER DE TAMAÑO (Rango 1 a 4)
local SliderLabel = Instance.new("TextLabel")
SliderLabel.Size = UDim2.new(1, -20, 0, 20)
SliderLabel.Position = UDim2.new(0, 10, 0, 90)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Text = "Tamaño: 1"
SliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SliderLabel.TextSize = 12
SliderLabel.Font = Enum.Font.SourceSans
SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
SliderLabel.Parent = MainFrame

local SliderButton = Instance.new("TextButton")
SliderButton.Name = "SliderButton"
SliderButton.Size = UDim2.new(1, -20, 0, 16)
SliderButton.Position = UDim2.new(0, 10, 0, 115)
SliderButton.BackgroundTransparency = 1
SliderButton.Text = ""
SliderButton.Parent = MainFrame

local SliderBar = Instance.new("Frame")
SliderBar.Size = UDim2.new(1, 0, 0, 8)
SliderBar.Position = UDim2.new(0, 0, 0.5, -4)
SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SliderBar.BorderSizePixel = 0
SliderBar.Parent = SliderButton

local UICornerBar = Instance.new("UICorner")
UICornerBar.CornerRadius = UDim.new(1, 0)
UICornerBar.Parent = SliderBar

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0, 0, 1, 0) -- Inicia en 0% (Tamaño 1)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

local UICornerFill = Instance.new("UICorner")
UICornerFill.CornerRadius = UDim.new(1, 0)
UICornerFill.Parent = SliderFill

-- Lógica para ajustar el Slider entre 1 y 4
local draggingSlider = false

local function updateSlider(input)
	local mousePos = input.Position.X
	local barPos = SliderBar.AbsolutePosition.X
	local barSize = SliderBar.AbsoluteSize.X
	
	local relativeX = math.clamp((mousePos - barPos) / barSize, 0, 1)
	SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
	
	-- Escala exacta de 1 a 4
	hitboxSize = math.floor(1 + (relativeX * 3))
	SliderLabel.Text = "Tamaño: " .. tostring(hitboxSize)
end

SliderButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingSlider = true
		updateSlider(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingSlider = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		updateSlider(input)
	end
end)

-- Lógica del Botón Toggle (Encender / Apagar Hitbox)
ToggleButton.MouseButton1Click:Connect(function()
	hitboxEnabled = not hitboxEnabled
	if hitboxEnabled then
		ToggleButton.Text = "Hitbox: ON"
		ToggleButton.TextColor3 = Color3.fromRGB(100, 255, 100)
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
	else
		ToggleButton.Text = "Hitbox: OFF"
		ToggleButton.TextColor3 = Color3.fromRGB(255, 100, 100)
		ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end
end)

-- Lógica de Cierre y Minimizado (Bolita)
CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	MinimizeButton.Visible = true
	MinimizeButton.Position = MainFrame.Position
end)

MinimizeButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	MinimizeButton.Visible = false
end)

-- Bucle principal para expandir la hitbox
RunService.RenderStepped:Connect(function()
	if not hitboxEnabled then return end
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local rootPart = player.Character.HumanoidRootPart
			rootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
			rootPart.Transparency = 0.7
			rootPart.CanCollide = false
		end
	end
end)
