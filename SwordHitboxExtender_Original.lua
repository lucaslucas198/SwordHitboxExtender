local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local StarterGui       = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local VALID_KEY = "scriptinghub"
local KEY_FILE  = "SHE_Key.txt"
local EXP_FILE  = "SHE_Exp"

-- ScriptingHub premium key system
local SHK = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucaslucas198/ScriptingHubKeySystem/main/KeySystem.lua"))()

local startScript  -- forward declared so OnSuccess can reference it

SHK.show({
    ScriptName  = "Sword Hitbox Extender",
    KeyFile     = KEY_FILE,
    ExpFile     = EXP_FILE,
    IsFPS       = false,
    ValidKey    = VALID_KEY,
    OnSuccess   = function() startScript() end,
})

startScript = function()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

    local Window = Rayfield:CreateWindow({
        Name = "ScriptingHub | Hitbox Extender",
        Icon = "sword",
        LoadingTitle = "ScriptingHub",
        LoadingSubtitle = "Sword Hitbox Extender",
        Theme = "Default",
        ToggleUIKeybind = "K",
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "ScriptingHub",
            FileName = "HitboxExtender"
        },
        Discord = {
            Enabled = true,
            Invite = "UMq8nuQdbX",
            RememberJoins = true
        },
    })

    Rayfield:Notify({
        Title = "Script Loaded!",
        Content = "Sword Hitbox Extender ready. Equip a sword and toggle On.",
        Duration = 5,
        Image = "check-circle",
    })

    local Settings = {
        Enabled = false,
        Range   = 7,
    }

    LocalPlayer.CharacterAdded:Connect(function(char)
        Character = char
    end)

    RunService.RenderStepped:Connect(function()
        if not Settings.Enabled then return end
        local char = Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if not tool then return end
        local handle = tool:FindFirstChild("Handle")
        if not handle then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            local target = player.Character
            if not target then continue end
            local humanoid = target:FindFirstChildOfClass("Humanoid")
            local root     = target:FindFirstChild("HumanoidRootPart")
            if not humanoid or humanoid.Health <= 0 or not root then continue end
            if LocalPlayer:DistanceFromCharacter(root.Position) <= Settings.Range then
                tool:Activate()
                for _, part in ipairs(target:GetChildren()) do
                    if part:IsA("BasePart") then
                        pcall(firetouchinterest, handle, part, 0)
                        pcall(firetouchinterest, handle, part, 1)
                    end
                end
            end
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Q then
            Settings.Range += 1
            Rayfield:Notify({Title = "Range Up!", Content = "Reach is now " .. Settings.Range .. " studs", Duration = 1})
        elseif input.KeyCode == Enum.KeyCode.E then
            Settings.Range = math.max(1, Settings.Range - 1)
            Rayfield:Notify({Title = "Range Down", Content = "Reach is now " .. Settings.Range .. " studs", Duration = 1})
        end
    end)

    local MainTab     = Window:CreateTab("Hitbox", "sword")
    local SettingsTab = Window:CreateTab("Settings", "settings")

    MainTab:CreateSection("Hitbox Extender")
    MainTab:CreateToggle({
        Name = "Enable Hitbox Extender",
        CurrentValue = false,
        Flag = "HitboxEnabled",
        Callback = function(value) Settings.Enabled = value end,
    })
    MainTab:CreateSlider({
        Name = "Range",
        Range = {1, 30},
        Increment = 1,
        Suffix = " studs",
        CurrentValue = 7,
        Flag = "HitboxRange",
        Callback = function(value) Settings.Range = value end,
    })
    MainTab:CreateSection("Controls")
    MainTab:CreateLabel("Q — Increase range by 1")
    MainTab:CreateLabel("E — Decrease range by 1")

    SettingsTab:CreateSection("Info")
    SettingsTab:CreateLabel("Key: scriptinghub")
    SettingsTab:CreateLabel("Discord: discord.gg/UMq8nuQdbX")
    SettingsTab:CreateButton({
        Name = "Copy Discord Link",
        Callback = function()
            pcall(function() setclipboard("https://discord.gg/UMq8nuQdbX") end)
            Rayfield:Notify({Title = "Copied!", Content = "Discord link copied to clipboard.", Duration = 3, Image = "clipboard-copy"})
        end,
    })
end
