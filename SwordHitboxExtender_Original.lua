local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local StarterGui       = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local VALID_KEY = "scriptinghub"
local DISCORD   = "https://discord.gg/UMq8nuQdbX"
local KEY_FILE  = "SHE_Key.txt"
local EXP_FILE  = "SHE_Exp"

-- 7-day expiry check (silent)
pcall(function()
    if isfile(EXP_FILE) then
        local t = tonumber(readfile(EXP_FILE))
        if t and os.time() - t > 604800 then
            delfile(EXP_FILE)
            if isfile(KEY_FILE) then delfile(KEY_FILE) end
        end
    end
end)

local function make(cls, props, parent)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end

local ScreenGui = make("ScreenGui", {
    Name = "SHE_Key",
    ResetOnSpawn = false,
    DisplayOrder = 999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, LocalPlayer:WaitForChild("PlayerGui"))

local KeyFrame = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(420, 240),
    BackgroundColor3 = Color3.fromRGB(18, 18, 28),
    BorderSizePixel = 0,
    Active = true,
}, ScreenGui)
make("UICorner", {CornerRadius = UDim.new(0, 12)}, KeyFrame)
make("UIStroke", {Color = Color3.fromRGB(0, 190, 255), Transparency = 0.15, Thickness = 1.5}, KeyFrame)

-- Drag bar
local DragBar = make("Frame", {
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundColor3 = Color3.fromRGB(13, 13, 22),
    BorderSizePixel = 0,
    ZIndex = 2,
}, KeyFrame)
make("UICorner", {CornerRadius = UDim.new(0, 12)}, DragBar)

make("TextLabel", {
    Position = UDim2.fromOffset(14, 8),
    Size = UDim2.new(1, -28, 0, 22),
    BackgroundTransparency = 1,
    Text = "ScriptingHub | Sword Hitbox Extender",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3,
}, DragBar)

-- Dragging logic
local dragging, dragStart, startPos = false, nil, nil
DragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = KeyFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        KeyFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

make("TextLabel", {
    Position = UDim2.fromOffset(16, 44),
    Size = UDim2.new(1, -32, 0, 16),
    BackgroundTransparency = 1,
    Text = "Get the key from our Discord server.",
    TextColor3 = Color3.fromRGB(130, 140, 165),
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
}, KeyFrame)

local KeyBox = make("TextBox", {
    Position = UDim2.fromOffset(16, 68),
    Size = UDim2.new(1, -32, 0, 40),
    BackgroundColor3 = Color3.fromRGB(26, 28, 42),
    BorderSizePixel = 0,
    PlaceholderText = "Paste key here...",
    Text = "",
    TextColor3 = Color3.fromRGB(245, 245, 255),
    PlaceholderColor3 = Color3.fromRGB(90, 100, 125),
    Font = Enum.Font.GothamMedium,
    TextSize = 14,
    ClearTextOnFocus = false,
}, KeyFrame)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, KeyBox)
make("UIStroke", {Color = Color3.fromRGB(50, 58, 82), Transparency = 0.3}, KeyBox)

-- Auto-fill saved key
pcall(function()
    if isfile(KEY_FILE) then KeyBox.Text = readfile(KEY_FILE) end
end)

local Status = make("TextLabel", {
    Position = UDim2.fromOffset(16, 114),
    Size = UDim2.new(1, -32, 0, 16),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = Color3.fromRGB(255, 75, 75),
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
}, KeyFrame)

local BtnHolder = make("Frame", {
    Position = UDim2.fromOffset(16, 136),
    Size = UDim2.new(1, -32, 0, 40),
    BackgroundTransparency = 1,
}, KeyFrame)
make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, BtnHolder)

local function makeBtn(text)
    local b = make("TextButton", {
        Size = UDim2.new(0.333, -6, 1, 0),
        BackgroundColor3 = Color3.fromRGB(30, 32, 48),
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = text,
        TextColor3 = Color3.fromRGB(235, 240, 255),
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
    }, BtnHolder)
    make("UICorner", {CornerRadius = UDim.new(0, 8)}, b)
    make("UIStroke", {Color = Color3.fromRGB(60, 68, 95), Transparency = 0.4}, b)
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 46, 68)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 32, 48)}):Play()
    end)
    return b
end

local GetKeyBtn = makeBtn("Get Key")
local EnterBtn  = makeBtn("Enter Key")
local CloseBtn  = makeBtn("Close")

make("TextLabel", {
    Position = UDim2.fromOffset(16, 186),
    Size = UDim2.new(1, -32, 0, 14),
    BackgroundTransparency = 1,
    Text = "discord.gg/UMq8nuQdbX",
    TextColor3 = Color3.fromRGB(0, 160, 220),
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Center,
}, KeyFrame)

local startScript

local function tryKey()
    local key = KeyBox.Text:gsub("%s+", "")
    if key == VALID_KEY then
        pcall(function() writefile(KEY_FILE, key) end)
        task.defer(function()
            pcall(function()
                if not isfile(EXP_FILE) then writefile(EXP_FILE, tostring(os.time())) end
            end)
        end)
        ScreenGui:Destroy()
        startScript()
    else
        Status.Text = "Invalid key. Get it from Discord."
        TweenService:Create(KeyFrame, TweenInfo.new(0.08, Enum.EasingStyle.Bounce), {
            Position = UDim2.new(KeyFrame.Position.X.Scale, KeyFrame.Position.X.Offset + 6, KeyFrame.Position.Y.Scale, KeyFrame.Position.Y.Offset)
        }):Play()
        task.delay(0.08, function()
            TweenService:Create(KeyFrame, TweenInfo.new(0.08, Enum.EasingStyle.Bounce), {
                Position = UDim2.new(KeyFrame.Position.X.Scale, KeyFrame.Position.X.Offset - 6, KeyFrame.Position.Y.Scale, KeyFrame.Position.Y.Offset)
            }):Play()
        end)
    end
end

GetKeyBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(DISCORD) end)
    GetKeyBtn.Text = "Copied!"
    task.delay(2, function()
        if GetKeyBtn and GetKeyBtn.Parent then GetKeyBtn.Text = "Get Key" end
    end)
end)

EnterBtn.MouseButton1Click:Connect(tryKey)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then tryKey() end
end)

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
            pcall(function() setclipboard(DISCORD) end)
            Rayfield:Notify({Title = "Copied!", Content = "Discord link copied to clipboard.", Duration = 3, Image = "clipboard-copy"})
        end,
    })
end
