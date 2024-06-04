local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/ionlyusegithubformcmods/1-Line-Scripts/main/Mobile%20Friendly%20Orion')))()
local Window = OrionLib:MakeWindow({
    Name = "Speed HUD",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
    IntroText = "Speed HUD Library"
})

OrionLib:MakeNotification({
	Name = "Obrigada por usar meu script",
	Content = "Entre no meu Discord e no ytb para apoiar o desenvolvedor na Tab Inf",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local Tab2 = Window:MakeTab({
    Name = "Inf",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab2:AddParagraph("Versão do Script:","V1.0")
Tab2:AddParagraph("Data de criação","03/06/2024")

local Section = Tab2:AddSection({
	Name = "Entre no meu Discord por favor"
})

Tab2:AddButton({
	Name = "Discord principal",
	Callback = function()
      		setclipboard("https://discord.com/invite/XFUQggvG")
      		OrionLib:MakeNotification({
	Name = "Link Copiado!",
	Content = "Vá para o navegador e coloque o link e aceite o convite! estamos esperando...",
	Image = "rbxassetid://4483345998",
	Time = 5
})
  	end    
})

Tab2:AddButton({
	Name = "Discord Secundária",
	Callback = function()
      		setclipboard("https://discord.com/invite/Dc3a4Nrh")
      		OrionLib:MakeNotification({
      		Name = "Link Copiado!",
	Content = "Vá para o navegador e coloque o link e aceite o convite! estamos esperando...",
	Image = "rbxassetid://4483345998",
	Time = 5
})
  	end    
})

local Tab1 = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab1:AddSection({
	Name = "Esp Player"
})

local espColor = Color3.fromRGB(0, 255, 0)
local espEnabled = false
local espBoxes = {}

local function drawESP(target)
    local espBox = Drawing.new("Square")
    espBox.Visible = false
    espBox.Color = espColor
    espBox.Thickness = 2
    espBox.Filled = false

    local function updateESP()
        local targetPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(target.Position)
        if onScreen then
            local targetSize = target.Size * 3.5
            espBox.Size = Vector2.new(targetSize.X, targetSize.Y)
            espBox.Position = Vector2.new(targetPos.X - targetSize.X / 2, targetPos.Y - targetSize.Y / 2)
            espBox.Visible = true
        else
            espBox.Visible = false
        end
    end

    return updateESP, espBox
end

local function findPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPart = player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local updateESP, espBox = drawESP(targetPart)
                table.insert(espBoxes, {updateESP = updateESP, espBox = espBox})
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if espEnabled then
        for _, espData in pairs(espBoxes) do
            espData.updateESP()
        end
    end
end)

Tab1:AddToggle({
    Name = "Player ESP",
    Default = false,
    Callback = function(value)
        espEnabled = value
        if espEnabled then
            findPlayers()
        else
            for _, espData in pairs(espBoxes) do
                espData.espBox.Visible = false
            end
            espBoxes = {}
        end
    end    
})

local espColor = Color3.fromRGB(0, 255, 0)
local espEnabled = false
local espBoxes = {}
local espTracers = {}

local function drawESPBox(target)
    local espBox = Drawing.new("Square")
    espBox.Visible = false
    espBox.Color = espColor
    espBox.Thickness = 2
    espBox.Filled = false

    local function updateESPBox()
        local targetPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(target.Position)
        if onScreen then
            local targetSize = target.Size * 7.5
            espBox.Size = Vector2.new(targetSize.X, targetSize.Y)
            espBox.Position = Vector2.new(targetPos.X - targetSize.X / 2, targetPos.Y - targetSize.Y / 2)
            espBox.Visible = true
        else
            espBox.Visible = false
        end
    end

    return updateESPBox, espBox
end

local function drawESPTracer(target)
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = espColor
    tracer.Thickness = 2

    local function updateTracer()
        local targetPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(target.Position)
        if onScreen then
            tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
            tracer.To = Vector2.new(targetPos.X, targetPos.Y)
            tracer.Visible = true
        else
            tracer.Visible = false
        end
    end

    return updateTracer, tracer
end

local function findPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPart = player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local updateESPBox, espBox = drawESPBox(targetPart)
                local updateTracer, tracer = drawESPTracer(targetPart)
                table.insert(espBoxes, {updateESP = updateESPBox, espBox = espBox})
                table.insert(espTracers, {updateESP = updateTracer, tracer = tracer})
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if espEnabled then
        for _, espData in pairs(espBoxes) do
            espData.updateESP()
        end
        for _, tracerData in pairs(espTracers) do
            tracerData.updateESP()
        end
    end
end)

Tab1:AddToggle({
    Name = "Player ESP(traço)",
    Default = false,
    Callback = function(value)
        espEnabled = value
        if espEnabled then
            findPlayers()
        else
            for _, espData in pairs(espBoxes) do
                espData.espBox.Visible = false
            end
            for _, tracerData in pairs(espTracers) do
                tracerData.tracer.Visible = false
            end
            espBoxes = {}
            espTracers = {}
        end
    end    
})

local espColor = Color3.fromRGB(0, 255, 0)
local espEnabled = false
local espTextLabels = {}

local function drawESPText(target, playerName)
    local textLabel = Drawing.new("Text")
    textLabel.Visible = false
    textLabel.Color = espColor
    textLabel.Center = true
    textLabel.Outline = true
    textLabel.Font = Drawing.Fonts.UI
    textLabel.Size = 20

    local function updateESPText()
        if target.Parent then
            local targetPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(target.Position)
            if onScreen then
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - target.Position).Magnitude
                textLabel.Text = playerName .. " [" .. math.floor(distance) .. "m]"
                textLabel.Position = Vector2.new(targetPos.X, targetPos.Y - 30)
                textLabel.Visible = true
            else
                textLabel.Visible = false
            end
        else
            textLabel.Visible = false
        end
    end

    return updateESPText, textLabel
end

local function findPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPart = player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local updateESPText, textLabel = drawESPText(targetPart, player.Name)
                table.insert(espTextLabels, {updateESP = updateESPText, textLabel = textLabel})
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if espEnabled then
        for _, espData in pairs(espTextLabels) do
            espData.updateESP()
        end
    end
end)

Tab1:AddToggle({
    Name = "Player ESP(nome e distância)",
    Default = false,
    Callback = function(value)
        espEnabled = value
        if espEnabled then
            findPlayers()
        else
            for _, espData in pairs(espTextLabels) do
                espData.textLabel.Visible = false
            end
            espTextLabels = {}
        end
    end    
})

local Tab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local defaultSpeed = 16
local defaultJumpPower = 50 
local defaultGravity = 196.2

local newSpeed = defaultSpeed
local newJumpPower = defaultJumpPower
local newGravity = defaultGravity

local function setPlayerSpeed(speed)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
    end
end

local function setPlayerJumpPower(jumpPower)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").JumpPower = jumpPower
    end
end

local function setGravity(gravity)
    workspace.Gravity = gravity
end

Tab:AddSlider({
    Name = "Player Speed",
    Min = 0,
    Max = 100,
    Default = defaultSpeed,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    ValueName = "Velocidade",
    Callback = function(value)
        newSpeed = value
        setPlayerSpeed(newSpeed)
    end    
})

Tab:AddSlider({
    Name = "Jump Power",
    Min = 0,
    Max = 300,
    Default = defaultJumpPower,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "Pulo",
    Callback = function(value)
        newJumpPower = value
        setPlayerJumpPower(newJumpPower)
    end    
})

Tab:AddSlider({
    Name = "Gravity",
    Min = 0,
    Max = 500,
    Default = defaultGravity,
    Color = Color3.fromRGB(0, 0, 255),
    Increment = 1,
    ValueName = "Gravidade",
    Callback = function(value)
        newGravity = value
        setGravity(newGravity)
    end    
})

Tab:AddButton({
    Name = "Resetar todos",
    Callback = function()
        newSpeed = defaultSpeed
        newJumpPower = defaultJumpPower
        newGravity = defaultGravity
        setPlayerSpeed(newSpeed)
        setPlayerJumpPower(newJumpPower)
        setGravity(newGravity)
    end    
})

setPlayerSpeed(defaultSpeed)
setPlayerJumpPower(defaultJumpPower)
setGravity(defaultGravity)

local Tab3 = Window:MakeTab({
    Name = "Créditos",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab3:AddSection({
	Name = "esse Script foi feito pela biblioteca Orion!"
})

Tab3:AddButton({
	Name = "Biblioteca Orion(fazer Script hud)",
	Callback = function()
      		 setclipboard("https://github.com/shlexware/Orion/blob/main/Documentation.md")
      		 OrionLib:MakeNotification({
	Name = "Link Copiado",
	Content = "vá para seu navegador e comece seu exploit... boa sorte!",
	Image = "rbxassetid://4483345998",
	Time = 5
})
  	end    
})

OrionLib:Init()
