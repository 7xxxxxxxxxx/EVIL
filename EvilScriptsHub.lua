local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("EvilScripts99Noches") then
    playerGui.EvilScripts99Noches:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EvilScripts99Noches"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

----------------------------------------------------
-- SISTEMA DE ARRASTRE TÁCTIL Y MOUSE (3D/FLOTANTE)
----------------------------------------------------
local function MakeDraggable(guiObject)
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        guiObject.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

----------------------------------------------------
-- BOTÓN FLOTANTE "7" (ESTILO NEGRO 3D)
----------------------------------------------------
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Name = "FloatingBtn"
FloatingBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
FloatingBtn.Position = UDim2.new(0.04, 0, 0.25, 0)
FloatingBtn.Size = UDim2.new(0, 52, 0, 52)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "7"
FloatingBtn.TextColor3 = Color3.fromRGB(0, 160, 255)
FloatingBtn.TextSize = 24
FloatingBtn.Active = true
FloatingBtn.Parent = ScreenGui

Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", FloatingBtn)
BtnStroke.Color = Color3.fromRGB(0, 130, 255)
BtnStroke.Thickness = 2.5

local BtnShadow = Instance.new("UIStroke", FloatingBtn)
BtnShadow.Color = Color3.fromRGB(0, 0, 0)
BtnShadow.Thickness = 4
BtnShadow.Transparency = 0.4

MakeDraggable(FloatingBtn)

----------------------------------------------------
-- VENTANA PRINCIPAL
----------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.Active = true
MainFrame.Visible = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 140, 255)
MainStroke.Thickness = 2

MakeDraggable(MainFrame)

-- Barra Superior (Título)
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TitleBar)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "EVIL SCRIPTS // 99 NOCHES EN EL BOSQUE"
Title.TextColor3 = Color3.fromRGB(120, 200, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
CloseBtn.Position = UDim2.new(0.91, 0, 0.15, 0)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Barra Lateral (Pestañas)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 150, 1, -40)
Sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 18)

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPadding = Instance.new("UIPadding", Sidebar)
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 8)
SidebarPadding.PaddingRight = UDim.new(0, 8)

-- Área de Contenido Principal
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Name = "ContentArea"
ContentArea.Position = UDim2.new(0, 150, 0, 40)
ContentArea.Size = UDim2.new(1, -150, 1, -40)
ContentArea.BackgroundTransparency = 1

----------------------------------------------------
-- SISTEMA DE PESTAÑAS Y KEY
----------------------------------------------------
local isKeyUnlocked = false
local CORRECT_KEY = "EVILSCRIPTS7"
local WHATSAPP_LINK = "https://chat.whatsapp.com/GyyFAPXm5z04Q4ozjxq5nW?s=cl&p=i&mlu=4&ilr=4"

local Tabs = {}
local TabButtons = {}

local function CreateTab(tabName, requiresKey)
    local Scroll = Instance.new("ScrollingFrame", ContentArea)
    Scroll.Name = tabName .. "Scroll"
    Scroll.Size = UDim2.new(1, 0, 1, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.Visible = false
    Scroll.ScrollBarThickness = 4
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 140, 255)
    
    local List = Instance.new("UIListLayout", Scroll)
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Padding = UDim.new(0, 8)
    
    local Pad = Instance.new("UIPadding", Scroll)
    Pad.PaddingTop = UDim.new(0, 10)
    Pad.PaddingLeft = UDim.new(0, 10)
    Pad.PaddingRight = UDim.new(0, 10)
    
    List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 20)
    end)
    
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(160, 180, 210)
    TabBtn.TextSize = 13
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    TabBtn.MouseButton1Click:Connect(function()
        if requiresKey and not isKeyUnlocked then
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Acceso Denegado",
                    Text = "¡Ingresa la Key en la pestaña Principal!",
                    Duration = 3
                })
            end)
            return
        end
        
        for _, t in pairs(Tabs) do t.Visible = false end
        for _, b in pairs(TabButtons) do 
            b.BackgroundColor3 = Color3.fromRGB(20, 20, 28) 
            b.TextColor3 = Color3.fromRGB(160, 180, 210)
        end
        Scroll.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 235)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    Tabs[tabName] = Scroll
    table.insert(TabButtons, TabBtn)
    return Scroll
end

local function AddActionBtn(parent, text, func)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    Btn.Font = Enum.Font.Gotham
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(220, 230, 250)
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local Pad = Instance.new("UIPadding", Btn)
    Pad.PaddingLeft = UDim.new(0, 12)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(40, 40, 60)
    Stroke.Thickness = 1
    
    Btn.MouseButton1Click:Connect(function() pcall(func) end)
    return Btn
end

local function AddTitleHeader(parent, text)
    local Label = Instance.new("TextLabel", parent)
    Label.Size = UDim2.new(1, 0, 0, 24)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamBold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(0, 170, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    return Label
end

----------------------------------------------------
-- CREACIÓN DE LAS PESTAÑAS
----------------------------------------------------
local TabPrincipal = CreateTab("Principal", false)
local TabMadera    = CreateTab("Madera & Recursos", true)
local TabComida    = CreateTab("Comida", true)
local TabJugadores = CreateTab("Jugadores", true)
local TabNoches    = CreateTab("Supervivencia", true)
local TabScripts   = CreateTab("Scripts", true)

Tabs["Principal"].Visible = true
TabButtons[1].BackgroundColor3 = Color3.fromRGB(0, 120, 235)
TabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)

----------------------------------------------------
-- PESTAÑA: PRINCIPAL (KEY)
----------------------------------------------------
local KeySection = Instance.new("Frame", TabPrincipal)
KeySection.Size = UDim2.new(1, 0, 0, 230)
KeySection.BackgroundTransparency = 1

local KeyLayout = Instance.new("UIListLayout", KeySection)
KeyLayout.Padding = UDim.new(0, 8)

local WelcomeLabel = Instance.new("TextLabel", KeySection)
WelcomeLabel.Size = UDim2.new(1, 0, 0, 40)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Text = "ÚNETE AL CANAL DE WHATSAPP PARA OBTENER TU KEY"
WelcomeLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
WelcomeLabel.TextSize = 13
WelcomeLabel.TextWrapped = true

local CopyWpBtn = Instance.new("TextButton", KeySection)
CopyWpBtn.Size = UDim2.new(1, 0, 0, 36)
CopyWpBtn.BackgroundColor3 = Color3.fromRGB(37, 211, 102)
CopyWpBtn.Font = Enum.Font.GothamBold
CopyWpBtn.Text = "COPIAR LINK DE WHATSAPP"
CopyWpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyWpBtn.TextSize = 13
Instance.new("UICorner", CopyWpBtn).CornerRadius = UDim.new(0, 6)

CopyWpBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(WHATSAPP_LINK) end)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Enlace Copiado",
            Text = "Link copiado al portapapeles.",
            Duration = 3
        })
    end)
end)

local KeyBox = Instance.new("TextBox", KeySection)
KeyBox.Size = UDim2.new(1, 0, 0, 38)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeyBox.Font = Enum.Font.GothamBold
KeyBox.PlaceholderText = "Ingresa tu Key aquí..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 110, 140)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 13
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 6)

local KeyBtn = Instance.new("TextButton", KeySection)
KeyBtn.Size = UDim2.new(1, 0, 0, 36)
KeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 235)
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.Text = "VERIFICAR KEY"
KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBtn.TextSize = 13
Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 6)

local StatusLabel = Instance.new("TextLabel", KeySection)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Estado: Esperando Key..."
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextSize = 12

local WelcomeSuccessLabel = Instance.new("TextLabel", TabPrincipal)
WelcomeSuccessLabel.Size = UDim2.new(1, 0, 0, 100)
WelcomeSuccessLabel.BackgroundTransparency = 1
WelcomeSuccessLabel.Font = Enum.Font.GothamBold
WelcomeSuccessLabel.Text = "BIENVENIDO A EVILSCRIPTS // 99 NOCHES"
WelcomeSuccessLabel.TextColor3 = Color3.fromRGB(0, 220, 255)
WelcomeSuccessLabel.TextSize = 18
WelcomeSuccessLabel.TextWrapped = true
WelcomeSuccessLabel.Visible = false

KeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CORRECT_KEY then
        isKeyUnlocked = true
        KeySection.Visible = false
        WelcomeSuccessLabel.Visible = true
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Acceso Concedido",
                Text = "¡Key correcta! Pestañas desbloqueadas.",
                Duration = 4
            })
        end)
    else
        StatusLabel.Text = "Key incorrecta."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

----------------------------------------------------
-- PESTAÑA: MADERA & RECURSOS
----------------------------------------------------
AddTitleHeader(TabMadera, "Teleport de Recursos Seguros")

AddActionBtn(TabMadera, "Teleportar Solo Leña / Tronquitos", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = obj.Name:lower()
            if (name:find("wood") or name:find("log") or name:find("madera") or name:find("branch") or name:find("leña")) 
               and not name:find("tree") and not name:find("house") and not name:find("cabin") and not name:find("base") and not name:find("barrel") and not name:find("barril") then
                if obj:IsA("BasePart") and obj.Size.Magnitude < 10 then
                    obj.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                elseif obj:IsA("Model") and obj.PrimaryPart and obj:GetExtentsSize().Magnitude < 10 then
                    obj:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

AddActionBtn(TabMadera, "Teleportar Solo Hierro Pequeño (Mena)", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = obj.Name:lower()
            if (name:find("iron") or name:find("hierro") or name:find("ore")) 
               and not name:find("cuerpo") and not name:find("body") and not name:find("big") and not name:find("huge") and not name:find("mountain") and not name:find("rock") and not name:find("node") then
                
                if obj:IsA("BasePart") and obj.Size.Magnitude < 6 then
                    obj.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                elseif obj:IsA("Model") and obj.PrimaryPart and obj:GetExtentsSize().Magnitude < 6 then
                    obj:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

AddActionBtn(TabMadera, "Teleportar Solo Carbón", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = obj.Name:lower()
            if (name:find("coal") or name:find("carbon")) and not name:find("node") and not name:find("rock") then
                if obj:IsA("BasePart") and obj.Size.Magnitude < 8 then
                    obj.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                elseif obj:IsA("Model") and obj.PrimaryPart and obj:GetExtentsSize().Magnitude < 8 then
                    obj:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

AddActionBtn(TabMadera, "Teleportar Solo Gasolina", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = obj.Name:lower()
            if (name:find("gas") or name:find("fuel") or name:find("gasolina") or name:find("lata")) 
               and not name:find("barrel") and not name:find("barril") then
                if obj:IsA("BasePart") and obj.Size.Magnitude < 10 then
                    obj.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                elseif obj:IsA("Model") and obj.PrimaryPart and obj:GetExtentsSize().Magnitude < 10 then
                    obj:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

----------------------------------------------------
-- PESTAÑA: COMIDA
----------------------------------------------------
AddTitleHeader(TabComida, "Teleport de Alimentos y Curaciones")

AddActionBtn(TabComida, "Teleportar Solo Comida / Frutas (Sin Arbustos)", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = obj.Name:lower()
            if (name:find("food") or name:find("meat") or name:find("berry") or name:find("baya") or name:find("comida") or name:find("carne") or name:find("apple") or name:find("manzana") or name:find("fish") or name:find("pescado") or name:find("bread") or name:find("pan"))
               and not name:find("bush") and not name:find("arbusto") and not name:find("plant") and not name:find("tree") then
                
                if obj:IsA("BasePart") and obj.Size.Magnitude < 6 then
                    obj.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                elseif obj:IsA("Model") and obj.PrimaryPart and obj:GetExtentsSize().Magnitude < 6 then
                    obj:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

AddActionBtn(TabComida, "💊 Traer Curaciones / Botiquines", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        for _, obj in pairs(workspace:GetDescendants()) do
            local name = obj.Name:lower()
            if name:find("med") or name:find("heal") or name:find("bandage") or name:find("venda") or name:find("botiquin") or name:find("pill") then
                if obj:IsA("BasePart") and obj.Size.Magnitude < 8 then
                    obj.CFrame = root.CFrame + Vector3.new(0, 3, 0)
                elseif obj:IsA("Model") and obj.PrimaryPart and obj:GetExtentsSize().Magnitude < 8 then
                    obj:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 3, 0))
                end
            end
        end
    end
end)

----------------------------------------------------
-- PESTAÑA: JUGADORES (TELEPORT Y ESP)
----------------------------------------------------
AddTitleHeader(TabJugadores, "Teleport por Nombre")

local UserBox = Instance.new("TextBox", TabJugadores)
UserBox.Size = UDim2.new(1, 0, 0, 38)
UserBox.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
UserBox.Font = Enum.Font.GothamBold
UserBox.PlaceholderText = "Escribe el nombre de usuario..."
UserBox.PlaceholderColor3 = Color3.fromRGB(100, 110, 140)
UserBox.Text = ""
UserBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UserBox.TextSize = 13
Instance.new("UICorner", UserBox).CornerRadius = UDim.new(0, 6)

local TpUserBtn = Instance.new("TextButton", TabJugadores)
TpUserBtn.Size = UDim2.new(1, 0, 0, 36)
TpUserBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
TpUserBtn.Font = Enum.Font.GothamBold
TpUserBtn.Text = "TELEPORTAR AL JUGADOR"
TpUserBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpUserBtn.TextSize = 13
Instance.new("UICorner", TpUserBtn).CornerRadius = UDim.new(0, 6)

TpUserBtn.MouseButton1Click:Connect(function()
    local targetText = UserBox.Text:lower()
    if targetText == "" then return end
    
    local foundPlayer = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            if p.Name:lower():sub(1, #targetText) == targetText or p.DisplayName:lower():sub(1, #targetText) == targetText then
                foundPlayer = p
                break
            end
        end
    end
    
    if foundPlayer and foundPlayer.Character and foundPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = player.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = foundPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
        end
    end
end)

AddTitleHeader(TabJugadores, "Utilidades de Jugador")

AddActionBtn(TabJugadores, "Ver Jugadores en el Bosque (ESP)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and not p.Character:FindFirstChild("Highlight") then
            local hl = Instance.new("Highlight", p.Character)
            hl.FillColor = Color3.fromRGB(0, 170, 255)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end)

AddActionBtn(TabJugadores, "Velocidad de Movimiento (WalkSpeed 45)", function()
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 45
    end
end)

AddActionBtn(TabJugadores, "Restaurar Velocidad Normal (16)", function()
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end)

AddActionBtn(TabJugadores, "Salto Infinito en el Bosque", function()
    UserInputService.JumpRequest:Connect(function()
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

----------------------------------------------------
-- PESTAÑA: SUPERVIVENCIA (99 NOCHES)
----------------------------------------------------
AddTitleHeader(TabNoches, "Ambiente y Control de Noche")

AddActionBtn(TabNoches, "Visión Nocturna Máxima (FullBright)", function()
    game.Lighting.Brightness = 3.5
    game.Lighting.ClockTime = 14
    game.Lighting.GlobalShadows = false
end)

AddActionBtn(TabNoches, "Eliminar Niebla Oscura del Bosque", function()
    game.Lighting.FogEnd = 999999
end)

AddActionBtn(TabNoches, "💡 Luz Flotante Personal (Aura)", function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if not char.HumanoidRootPart:FindFirstChild("EvilLight") then
            local light = Instance.new("PointLight", char.HumanoidRootPart)
            light.Name = "EvilLight"
            light.Brightness = 3
            light.Range = 60
            light.Color = Color3.fromRGB(255, 220, 150)
        end
    end
end)

AddActionBtn(TabNoches, "🌿 Eliminar Hojas / Claridad del Bosque", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        local name = obj.Name:lower()
        if name:find("leaf") or name:find("leaves") or name:find("hoja") or name:find("bush") or name:find("arbusto") then
            if obj:IsA("BasePart") then
                obj.Transparency = 1
            end
        end
    end
end)

AddActionBtn(TabNoches, "Aumentar Campo de Visión (FOV 120)", function()
    workspace.CurrentCamera.FieldOfView = 120
end)

AddActionBtn(TabNoches, "Restaurar Campo de Visión (FOV 70)", function()
    workspace.CurrentCamera.FieldOfView = 70
end)

AddActionBtn(TabNoches, "Modo NoClip (Atravesar Paredes y Árboles)", function()
    RunService.Stepped:Connect(function()
        if player.Character then
            for _, p in pairs(player.Character:GetChildren()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end)
end)

AddActionBtn(TabNoches, "Anti-AFK (Evitar desconexión)", function()
    local vu = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)

----------------------------------------------------
-- PESTAÑA: SCRIPTS
----------------------------------------------------
AddTitleHeader(TabScripts, "Scripts Externos")

AddActionBtn(TabScripts, "Cargar Infinite Yield (Admin Panel)", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

local NoticeLabel = Instance.new("TextLabel", TabScripts)
NoticeLabel.Size = UDim2.new(1, 0, 0, 50)
NoticeLabel.BackgroundTransparency = 1
NoticeLabel.Font = Enum.Font.GothamBold
NoticeLabel.Text = "¡Más scripts y funciones automatizadas próximamente!"
NoticeLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
NoticeLabel.TextSize = 12
NoticeLabel.TextWrapped = true

----------------------------------------------------
-- CONTROL DE APERTURA Y CIERRE
----------------------------------------------------
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

FloatingBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
