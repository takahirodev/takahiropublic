local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "takahiro - Blind Shot",
    Icon = 0,
    LoadingTitle = "takahiro",
    LoadingSubtitle = "is loading...",
    ShowText = "takahiro",
    Theme = "Default",

    ToggleUIKeybind = "Z",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "takahiro",
        FileName = "config"
    },

    Discord = {
        Enabled = true,
        Invite = "https://discord.gg/vxBusQFhnY",
        RememberJoins = true
    },

    KeySystem = false,
    KeySettings = {
        Title = "takahiro",
        Subtitle = "Key System",
        Note = "Join discord to get the key",
        FileName = "takakey",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/P8ntTK6W"}
    }
})

-- // Services

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local tabs = {
    ["LocalPlayer"] = Window:CreateTab("Local Player", "user"),
    ["Players"] = Window:CreateTab("Players", "users"),
    ["Farm"] = Window:CreateTab("Farming", "trophy")
    -- ["Settings"] = Window:CreateTab("Settings", "settings")
}

-- // Divisores

local div1 = tabs.LocalPlayer:CreateDivider()
local div1 = tabs.Players:CreateDivider()
local div1 = tabs.Farm:CreateDivider()

-- // Local Player

local antihit = tabs.LocalPlayer:CreateButton({
    Name = "Anti Hit",
    Callback = function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true
        end
    end
})

local bigassbaseplate = tabs.LocalPlayer:CreateToggle({
    Name = "Big Ass Baseplate",
    CurrentValue = false,
    Flag = "bigassbaseplatetoggle",
    Callback = function(value)
        _G.BigBaseplateLoop = value
        task.spawn(function()
            while _G.BigBaseplateLoop do
                local origin = Vector3.new(1000, 1000, 1000)
                local radius = 1000
                local targetSize = Vector3.new(70, 2046, 70)

                local parts = workspace:GetPartBoundsInRadius(origin, radius)

                for _, obj in ipairs(parts) do
                    if obj.Name == "chao" and obj.Parent == workspace then
                        if obj.Size ~= targetSize then
                            obj.Size = targetSize
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
})

local autoFarmEnabled = false

tabs.Farm:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        autoFarmEnabled = Value
        
        if Value then
            task.spawn(function()
                while autoFarmEnabled do
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = CFrame.new(111.031853, 75.9326248, 116.153847,
                            0.474211782, -1.11273238e-07, 0.88041079,
                            7.50206368e-08, 1, 8.59798277e-08,
                            -0.88041079, 2.52763304e-08, 0.474211782)
                    end
                    task.wait(1.1)
                end
            end)
        end
    end
})

local disablekillbricks = tabs.Farm:CreateToggle({
    Name = "Disable Kill Bricks",
    CurrentValue = false,
    Flag = "DisableKillBricksToggle",
    Callback = function(Value)
        local shortObby = workspace:FindFirstChild("Short Obby")

        if shortObby then
            for _, part in ipairs(shortObby:GetChildren()) do
                if part.Name:find("KillBrick") then
                    if Value then
                        part.CanCollide = false
                        part.CanQuery = false
                        part.CanTouch = false
                    else
                        part.CanCollide = true
                        part.CanQuery = true
                        part.CanTouch = true
                    end
                end
            end
        end
    end
})

-- // RunService Heartbeat

local originalSize = nil
RunService.Heartbeat:Connect(function()
    if Rayfield.Flags["bigassbaseplatetoggle"] and Rayfield.Flags["bigassbaseplatetoggle"].CurrentValue then
        local targetSize = Vector3.new(70, 2046, 70)
        local part = workspace:FindFirstChild("chao")

        if part then
            if originalSize == nil then
                originalSize = part.Size
            end

            if part.Size ~= targetSize then
                part.Size = targetSize
            end
        end
    else
        if originalSize ~= nil then
            local part = workspace:FindFirstChild("chao")
            if part then
                part.Size = originalSize
            end
            originalSize = nil
        end
    end
    if Rayfield.Flags.AutoFarmToggle.CurrentValue then
        local trophy = workspace:FindFirstChild("Trophy")
        if trophy and trophy:IsA("BasePart") and not trophy.CanCollide then
            trophy.CanCollide = true
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode == Enum.KeyCode.Space and game.Players.LocalPlayer.Character.Humanoid.PlatformStand == true then
        game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    end
end)

-- // Load ConfigurationSaving
Rayfield:LoadConfiguration()
