local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local Workspace = game:GetService("Workspace")

repeat task.wait() until Workspace:FindFirstChild("Drops") and Workspace:FindFirstChild("Projectiles")
local LocalPlayer = PlayerService.LocalPlayer
local Aimbot,SilentAim,Trigger = false,nil,nil

local Window = Parvus.Utilities.UI:Window({
    Name = "Parvus Hub — "..Parvus.Game,
    Position = UDim2.new(0.05,0,0.5,-248)
    }) do Window:Watermark({Enabled = true})

    local AimAssistTab = Window:Tab({Name = "Combat"}) do
        local AimbotSection = AimAssistTab:Section({Name = "Aimbot",Side = "Left"}) do
            AimbotSection:Toggle({Name = "Enabled",Flag = "Aimbot/Enabled",Value = false})
            AimbotSection:Toggle({Name = "Visibility Check",Flag = "Aimbot/WallCheck",Value = false})
            AimbotSection:Toggle({Name = "Dynamic FOV",Flag = "Aimbot/DynamicFOV",Value = false})
            AimbotSection:Keybind({Name = "Keybind",Flag = "Aimbot/Keybind",Value = "MouseButton2",
            Mouse = true,Callback = function(Key,KeyDown) Aimbot = Window.Flags["Aimbot/Enabled"] and KeyDown end})
            AimbotSection:Slider({Name = "Smoothness",Flag = "Aimbot/Smoothness",Min = 0,Max = 100,Value = 25,Unit = "%"})
            AimbotSection:Slider({Name = "Field Of View",Flag = "Aimbot/FieldOfView",Min = 0,Max = 500,Value = 100})
            AimbotSection:Slider({Name = "Distance",Flag = "Aimbot/Distance",Min = 25,Max = 1000,Value = 250,Unit = "meters"})
            AimbotSection:Dropdown({Name = "Priority",Flag = "Aimbot/Priority",List = {
                {Name = "Head",Mode = "Toggle",Value = true},
                {Name = "Torso",Mode = "Toggle",Value = true}
            }})
            AimbotSection:Divider({Text = "Prediction"})
            AimbotSection:Toggle({Name = "Enabled",Flag = "Aimbot/Prediction/Enabled",Value = false})
            AimbotSection:Slider({Name = "Velocity",Flag = "Aimbot/Prediction/Velocity",Min = 100,Max = 5000,Value = 1600})
        end
        local AFOVSection = AimAssistTab:Section({Name = "Aimbot FOV Circle",Side = "Left"}) do
            AFOVSection:Toggle({Name = "Enabled",Flag = "Aimbot/Circle/Enabled",Value = true})
            AFOVSection:Toggle({Name = "Filled",Flag = "Aimbot/Circle/Filled",Value = false})
            AFOVSection:Colorpicker({Name = "Color",Flag = "Aimbot/Circle/Color",Value = {1,0.75,1,0.5,false}})
            AFOVSection:Slider({Name = "NumSides",Flag = "Aimbot/Circle/NumSides",Min = 3,Max = 100,Value = 100})
            AFOVSection:Slider({Name = "Thickness",Flag = "Aimbot/Circle/Thickness",Min = 1,Max = 10,Value = 1})
        end
        local TFOVSection = AimAssistTab:Section({Name = "Trigger FOV Circle",Side = "Left"}) do
            TFOVSection:Toggle({Name = "Enabled",Flag = "Trigger/Circle/Enabled",Value = true})
            TFOVSection:Toggle({Name = "Filled",Flag = "Trigger/Circle/Filled",Value = false})
            TFOVSection:Colorpicker({Name = "Color",Flag = "Trigger/Circle/Color",Value = {1,0.25,1,0.5,true}})
            TFOVSection:Slider({Name = "NumSides",Flag = "Trigger/Circle/NumSides",Min = 3,Max = 100,Value = 100})
            TFOVSection:Slider({Name = "Thickness",Flag = "Trigger/Circle/Thickness",Min = 1,Max = 10,Value = 1})
        end
        local SilentAimSection = AimAssistTab:Section({Name = "Silent Aim",Side = "Right"}) do
            SilentAimSection:Toggle({Name = "Enabled",Flag = "SilentAim/Enabled",Value = false})
            :Keybind({Mouse = true,Flag = "SilentAim/Keybind"})
            SilentAimSection:Toggle({Name = "Visibility Check",Flag = "SilentAim/WallCheck",Value = false})
            SilentAimSection:Toggle({Name = "Dynamic FOV",Flag = "SilentAim/DynamicFOV",Value = false})
            SilentAimSection:Slider({Name = "Hit Chance",Flag = "SilentAim/HitChance",Min = 0,Max = 100,Value = 100,Unit = "%"})
            SilentAimSection:Slider({Name = "Field Of View",Flag = "SilentAim/FieldOfView",Min = 0,Max = 500,Value = 50})
            SilentAimSection:Slider({Name = "Distance",Flag = "SilentAim/Distance",Min = 25,Max = 1000,Value = 250,Unit = "meters"})
            SilentAimSection:Dropdown({Name = "Priority",Flag = "SilentAim/Priority",List = {
                {Name = "Head",Mode = "Toggle",Value = true},
                {Name = "Torso",Mode = "Toggle"}
            }})
        end
        local SAFOVSection = AimAssistTab:Section({Name = "Silent Aim FOV Circle",Side = "Right"}) do
            SAFOVSection:Toggle({Name = "Enabled",Flag = "SilentAim/Circle/Enabled",Value = true})
            SAFOVSection:Toggle({Name = "Filled",Flag = "SilentAim/Circle/Filled",Value = false})
            SAFOVSection:Colorpicker({Name = "Color",Flag = "SilentAim/Circle/Color",Value = {0.66666668653488,0.75,1,0.5,false}})
            SAFOVSection:Slider({Name = "NumSides",Flag = "SilentAim/Circle/NumSides",Min = 3,Max = 100,Value = 100})
            SAFOVSection:Slider({Name = "Thickness",Flag = "SilentAim/Circle/Thickness",Min = 1,Max = 10,Value = 1})
        end
        local TriggerSection = AimAssistTab:Section({Name = "Trigger",Side = "Right"}) do
            TriggerSection:Toggle({Name = "Enabled",Flag = "Trigger/Enabled",Value = false})
            TriggerSection:Toggle({Name = "Visibility Check",Flag = "Trigger/WallCheck",Value = true})
            TriggerSection:Toggle({Name = "Dynamic FOV",Flag = "Trigger/DynamicFOV",Value = false})
            TriggerSection:Keybind({Name = "Keybind",Flag = "Trigger/Keybind",Value = "MouseButton2",
            Mouse = true,Callback = function(Key,KeyDown) Trigger = Window.Flags["Trigger/Enabled"] and KeyDown end})
            TriggerSection:Slider({Name = "Field Of View",Flag = "Trigger/FieldOfView",Min = 0,Max = 500,Value = 10})
            TriggerSection:Slider({Name = "Distance",Flag = "Trigger/Distance",Min = 25,Max = 1000,Value = 250,Unit = "meters"})
            TriggerSection:Slider({Name = "Delay",Flag = "Trigger/Delay",Min = 0,Max = 1,Precise = 2,Value = 0.15})
            TriggerSection:Toggle({Name = "Hold Mode",Flag = "Trigger/HoldMode",Value = false})
            TriggerSection:Dropdown({Name = "Priority",Flag = "Trigger/Priority",List = {
                {Name = "Head",Mode = "Toggle",Value = true},
                {Name = "Torso",Mode = "Toggle",Value = true}
            }})
            TriggerSection:Divider({Text = "Prediction"})
            TriggerSection:Toggle({Name = "Enabled",Flag = "Trigger/Prediction/Enabled",Value = false})
            TriggerSection:Slider({Name = "Velocity",Flag = "Trigger/Prediction/Velocity",Min = 100,Max = 5000,Value = 1600})
        end
    end
    local VisualsTab = Window:Tab({Name = "Visuals"}) do
        local GlobalSection = VisualsTab:Section({Name = "Global",Side = "Left"}) do
            GlobalSection:Colorpicker({Name = "Ally Color",Flag = "ESP/Player/Ally",Value = {0.33333334326744,0.75,1,0,false}})
            GlobalSection:Colorpicker({Name = "Enemy Color",Flag = "ESP/Player/Enemy",Value = {1,0.75,1,0,false}})
            GlobalSection:Toggle({Name = "Team Check",Flag = "ESP/Player/TeamCheck",Value = true})
            GlobalSection:Toggle({Name = "Use Player Color",Flag = "ESP/Player/TeamColor",Value = false}):ToolTip("Same As Team Color")
            GlobalSection:Slider({Name = "Distance",Flag = "ESP/Player/Distance",Min = 25,Max = 1000,Value = 250,Unit = "meters"})
        end
        local BoxSection = VisualsTab:Section({Name = "Boxes",Side = "Left"}) do
            BoxSection:Toggle({Name = "Box Enabled",Flag = "ESP/Player/Box/Enabled",Value = false})
            BoxSection:Toggle({Name = "Filled",Flag = "ESP/Player/Box/Filled",Value = false})
            BoxSection:Toggle({Name = "Outline",Flag = "ESP/Player/Box/Outline",Value = true})
            BoxSection:Slider({Name = "Thickness",Flag = "ESP/Player/Box/Thickness",Min = 1,Max = 10,Value = 1})
            BoxSection:Slider({Name = "Transparency",Flag = "ESP/Player/Box/Transparency",Min = 0,Max = 1,Precise = 2,Value = 0})
            BoxSection:Divider()
            BoxSection:Toggle({Name = "Text Enabled",Flag = "ESP/Player/Text/Enabled",Value = false})
            BoxSection:Toggle({Name = "Outline",Flag = "ESP/Player/Text/Outline",Value = true})
            BoxSection:Toggle({Name = "Autoscale",Flag = "ESP/Player/Text/Autoscale",Value = true})
            BoxSection:Dropdown({Name = "Font",Flag = "ESP/Player/Text/Font",List = {
                {Name = "UI",Mode = "Button"},
                {Name = "System",Mode = "Button"},
                {Name = "Plex",Mode = "Button"},
                {Name = "Monospace",Mode = "Button",Value = true}
            }})
            BoxSection:Slider({Name = "Size",Flag = "ESP/Player/Text/Size",Min = 13,Max = 100,Value = 16})
            BoxSection:Slider({Name = "Transparency",Flag = "ESP/Player/Text/Transparency",Min = 0,Max = 1,Precise = 2,Value = 0})
        end
        local OoVSection = VisualsTab:Section({Name = "Offscreen Arrows",Side = "Left"}) do
            OoVSection:Toggle({Name = "Enabled",Flag = "ESP/Player/Arrow/Enabled",Value = false})
            OoVSection:Toggle({Name = "Filled",Flag = "ESP/Player/Arrow/Filled",Value = true})
            OoVSection:Slider({Name = "Width",Flag = "ESP/Player/Arrow/Width",Min = 14,Max = 28,Value = 18})
            OoVSection:Slider({Name = "Height",Flag = "ESP/Player/Arrow/Height",Min = 14,Max = 28,Value = 28})
            OoVSection:Slider({Name = "Distance From Center",Flag = "ESP/Player/Arrow/Distance",Min = 80,Max = 200,Value = 200})
            OoVSection:Slider({Name = "Thickness",Flag = "ESP/Player/Arrow/Thickness",Min = 1,Max = 10,Value = 1})
            OoVSection:Slider({Name = "Transparency",Flag = "ESP/Player/Arrow/Transparency",Min = 0,Max = 1,Precise = 2,Value = 0})
        end
        local HeadSection = VisualsTab:Section({Name = "Head Circles",Side = "Right"}) do
            HeadSection:Toggle({Name = "Enabled",Flag = "ESP/Player/Head/Enabled",Value = false})
            HeadSection:Toggle({Name = "Filled",Flag = "ESP/Player/Head/Filled",Value = true})
            HeadSection:Toggle({Name = "Autoscale",Flag = "ESP/Player/Head/Autoscale",Value = true})
            HeadSection:Slider({Name = "Radius",Flag = "ESP/Player/Head/Radius",Min = 1,Max = 10,Value = 8})
            HeadSection:Slider({Name = "NumSides",Flag = "ESP/Player/Head/NumSides",Min = 3,Max = 100,Value = 4})
            HeadSection:Slider({Name = "Thickness",Flag = "ESP/Player/Head/Thickness",Min = 1,Max = 10,Value = 1})
            HeadSection:Slider({Name = "Transparency",Flag = "ESP/Player/Head/Transparency",Min = 0,Max = 1,Precise = 2,Value = 0})
        end
        local TracerSection = VisualsTab:Section({Name = "Tracers",Side = "Right"}) do
            TracerSection:Toggle({Name = "Enabled",Flag = "ESP/Player/Tracer/Enabled",Value = false})
            TracerSection:Dropdown({Name = "Mode",Flag = "ESP/Player/Tracer/Mode",List = {
                {Name = "From Bottom",Mode = "Button",Value = true},
                {Name = "From Mouse",Mode = "Button"}
            }})
            TracerSection:Slider({Name = "Thickness",Flag = "ESP/Player/Tracer/Thickness",Min = 1,Max = 10,Value = 1})
            TracerSection:Slider({Name = "Transparency",Flag = "ESP/Player/Tracer/Transparency",Min = 0,Max = 1,Precise = 2,Value = 0})
        end
        local HighlightSection = VisualsTab:Section({Name = "Highlights",Side = "Right"}) do
            HighlightSection:Toggle({Name = "Enabled",Flag = "ESP/Player/Highlight/Enabled",Value = false})
            HighlightSection:Slider({Name = "Transparency",Flag = "ESP/Player/Highlight/Transparency",Min = 0,Max = 1,Precise = 2,Value = 0})
            HighlightSection:Colorpicker({Name = "Outline Color",Flag = "ESP/Player/Highlight/OutlineColor",Value = {1,1,0,0.5,false}})
        end
    end
    local SettingsTab = Window:Tab({Name = "Settings"}) do
        local MenuSection = SettingsTab:Section({Name = "Menu",Side = "Left"}) do
            MenuSection:Toggle({Name = "Enabled",IgnoreFlag = true,Flag = "UI/Toggle",
            Value = Window.Enabled,Callback = function(Bool) Window:Toggle(Bool) end})
            :Keybind({Value = "RightShift",Flag = "UI/Keybind",DoNotClear = true})
            MenuSection:Toggle({Name = "Open On Load",Flag = "UI/OOL",Value = true})
            MenuSection:Toggle({Name = "Blur Gameplay",Flag = "UI/Blur",Value = false,
            Callback = function() Window:Toggle(Window.Enabled) end})
            MenuSection:Toggle({Name = "Watermark",Flag = "UI/Watermark",Value = true,
            Callback = function(Bool) Window.Watermark:Toggle(Bool) end})
            MenuSection:Toggle({Name = "Custom Mouse",Flag = "Mouse/Enabled",Value = false})
            MenuSection:Colorpicker({Name = "Color",Flag = "UI/Color",Value = {1,0.25,1,0,true},
            Callback = function(HSVAR,Color) Window:SetColor(Color) end})
        end
        SettingsTab:AddConfigSection("Left")
        SettingsTab:Button({Name = "Rejoin",Side = "Left",
        Callback = Parvus.Utilities.Misc.ReJoin})
        SettingsTab:Button({Name = "Server Hop",Side = "Left",
        Callback = Parvus.Utilities.Misc.ServerHop})
        SettingsTab:Button({Name = "Join Discord Server",Side = "Left",
        Callback = Parvus.Utilities.Misc.JoinDiscord})
        :ToolTip("Join for support, updates and more!")
        local BackgroundSection = SettingsTab:Section({Name = "Background",Side = "Right"}) do
            BackgroundSection:Dropdown({Name = "Image",Flag = "Background/Image",List = {
                {Name = "Legacy",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://2151741365"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Hearts",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073763717"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Abstract",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073743871"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Hexagon",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073628839"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Circles",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6071579801"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Lace With Flowers",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6071575925"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Floral",Mode = "Button",Value = true,Callback = function()
                    Window.Background.Image = "rbxassetid://5553946656"
                    Window.Flags["Background/CustomImage"] = ""
                end}
            }})
            BackgroundSection:Textbox({Name = "Custom Image",Flag = "Background/CustomImage",Placeholder = "rbxassetid://ImageId",
            Callback = function(String) if string.gsub(String," ","") ~= "" then Window.Background.Image = String end end})
            BackgroundSection:Colorpicker({Name = "Color",Flag = "Background/Color",Value = {1,1,0,0,false},
            Callback = function(HSVAR,Color) Window.Background.ImageColor3 = Color Window.Background.ImageTransparency = HSVAR[4] end})
            BackgroundSection:Slider({Name = "Tile Offset",Flag = "Background/Offset",Min = 74, Max = 296,Value = 74,
            Callback = function(Number) Window.Background.TileSize = UDim2.new(0,Number,0,Number) end})
        end
        local CrosshairSection = SettingsTab:Section({Name = "Custom Crosshair",Side = "Right"}) do
            CrosshairSection:Toggle({Name = "Enabled",Flag = "Mouse/Crosshair/Enabled",Value = false})
            CrosshairSection:Colorpicker({Name = "Color",Flag = "Mouse/Crosshair/Color",Value = {1,1,1,0,false}})
            CrosshairSection:Slider({Name = "Size",Flag = "Mouse/Crosshair/Size",Min = 0,Max = 20,Value = 4})
            CrosshairSection:Slider({Name = "Gap",Flag = "Mouse/Crosshair/Gap",Min = 0,Max = 10,Value = 2})
        end
        local CreditsSection = SettingsTab:Section({Name = "Credits",Side = "Right"}) do
            CreditsSection:Label({Text = "This script was made by AlexR32#0157"})
            CreditsSection:Divider()
            CreditsSection:Label({Text = "Thanks to Jan for awesome Background Patterns"})
            CreditsSection:Label({Text = "Thanks to Infinite Yield Team for Server Hop and Rejoin"})
            CreditsSection:Label({Text = "Thanks to Blissful for Offscreen Arrows"})
            CreditsSection:Label({Text = "Thanks to coasts for Universal ESP"})
            CreditsSection:Label({Text = "Thanks to el3tric for Bracket V2"})
            CreditsSection:Label({Text = "❤️ ❤️ ❤️ ❤️"})
        end
    end
end

Window:LoadDefaultConfig()
Window:SetValue("UI/Toggle",
Window.Flags["UI/OOL"])

Parvus.Utilities.Misc:SetupWatermark(Window)
Parvus.Utilities.Drawing:SetupCursor(Window.Flags)

Parvus.Utilities.Drawing:FOVCircle("Aimbot",Window.Flags)
Parvus.Utilities.Drawing:FOVCircle("Trigger",Window.Flags)
Parvus.Utilities.Drawing:FOVCircle("SilentAim",Window.Flags)

local function TeamCheck(Character)
    if Character and Character:FindFirstChild("Team") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Team") then
        return Character.Team.Value ~= LocalPlayer.Character.Team.Value
        or Character.Team.Value == "None"
    end
    return true
end

local function WallCheck(Enabled,Hitbox,Character)
    if not Enabled then return true end
    local Camera = Workspace.CurrentCamera
    return not Camera:GetPartsObscuringTarget({Hitbox.Position},{
        LocalPlayer.Character,
        Character
    })[1]
end

local function GetHitbox(Config)
    if not Config.Enabled then return end
    local Camera = Workspace.CurrentCamera

    local FieldOfView,ClosestHitbox = Config.DynamicFOV and
    ((120 - Camera.FieldOfView) * 4) + Config.FieldOfView
    or Config.FieldOfView,nil

    for Index, Player in pairs(PlayerService:GetPlayers()) do
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local IsAlive = Humanoid and Humanoid.Health > 0
        if Player ~= LocalPlayer and IsAlive and TeamCheck(Player) then
            for Index, HumanoidPart in pairs(Config.Priority) do
                local Hitbox = Character and Character:FindFirstChild(HumanoidPart)
                local Distance = (Hitbox.Position - Camera.CFrame.Position).Magnitude
                if Hitbox and Distance <= Config.Distance then
                    local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(Hitbox.Position)
                    local Magnitude = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if OnScreen and Magnitude < FieldOfView and WallCheck(Config.WallCheck,Hitbox,Character) then
                        FieldOfView,ClosestHitbox = Magnitude,Hitbox
                    end
                end
            end
        end
    end

    return ClosestHitbox
end

local function GetHitboxWithPrediction(Config)
    if not Config.Enabled then return end
    local Camera = Workspace.CurrentCamera

    local FieldOfView,ClosestHitbox = Config.DynamicFOV and
    ((120 - Camera.FieldOfView) * 4) + Config.FieldOfView
    or Config.FieldOfView,nil

    for Index, Player in pairs(PlayerService:GetPlayers()) do
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local IsAlive = Humanoid and Humanoid.Health > 0
        if Player ~= LocalPlayer and IsAlive and TeamCheck(Player) then
            for Index, HumanoidPart in pairs(Config.Priority) do
                local Hitbox = Character and Character:FindFirstChild(HumanoidPart)
                local Distance = (Hitbox.Position - Camera.CFrame.Position).Magnitude
                if Hitbox and Distance <= Config.Distance then
                    local HitboxDistance = (Hitbox.Position - Camera.CFrame.Position).Magnitude
                    local HitboxVelocityCorrection = (Hitbox.AssemblyLinearVelocity * HitboxDistance) / Config.Prediction.Velocity

                    local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(Config.Prediction.Enabled
                    and Hitbox.Position + HitboxVelocityCorrection or Hitbox.Position)

                    local Magnitude = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if OnScreen and Magnitude < FieldOfView and WallCheck(Config.WallCheck,Hitbox,Character) then
                        FieldOfView,ClosestHitbox = Magnitude,Hitbox
                    end
                end
            end
        end
    end

    return ClosestHitbox
end

local function AimAt(Hitbox,Config)
    if not Hitbox then return end
    local Camera = Workspace.CurrentCamera
    local Mouse = UserInputService:GetMouseLocation()
    
    local HitboxDistance = (Hitbox.Position - Camera.CFrame.Position).Magnitude
    local HitboxVelocityCorrection = (Hitbox.AssemblyLinearVelocity * HitboxDistance) / Config.Prediction.Velocity

    local HitboxOnScreen = Camera:WorldToViewportPoint(Config.Prediction.Enabled
    and Hitbox.Position + HitboxVelocityCorrection or Hitbox.Position)
    mousemoverel(
        (HitboxOnScreen.X - Mouse.X) * Config.Sensitivity,
        (HitboxOnScreen.Y - Mouse.Y) * Config.Sensitivity
    )
end

local OldNamecall
OldNamecall = hookmetamethod(game,"__namecall",function(Self,...)
    if SilentAim then local Args,Method = {...},getnamecallmethod()
        if Method == "FindPartOnRayWithIgnoreList" then
            if table.find(Args[2],LocalPlayer.Character,1)
            and table.find(Args[2],Workspace.Drops,3)
            and table.find(Args[2],Workspace.Drops,4)
            and table.find(Args[2],Workspace.Projectiles,5) then
                if math.random(0,100) <= Window.Flags["SilentAim/HitChance"] then
                    local Camera = Workspace.CurrentCamera
                    Args[1] = Ray.new(Args[1].Origin,SilentAim.Position - Camera.CFrame.Position)
                    return OldNamecall(Self,unpack(Args))
                end
            end
        end
    end
    return OldNamecall(Self,...)
end)

RunService.Heartbeat:Connect(function()
    SilentAim = GetHitbox({
        Enabled = Window.Flags["SilentAim/Enabled"],
        WallCheck = Window.Flags["SilentAim/WallCheck"],
        DynamicFOV = Window.Flags["SilentAim/DynamicFOV"],
        FieldOfView = Window.Flags["SilentAim/FieldOfView"],
        Distance = Window.Flags["SilentAim/Distance"],
        Priority = Window.Flags["SilentAim/Priority"]
    })
    if Aimbot then AimAt(
        GetHitbox({
            Enabled = Window.Flags["Aimbot/Enabled"],
            WallCheck = Window.Flags["Aimbot/WallCheck"],
            DynamicFOV = Window.Flags["Aimbot/DynamicFOV"],
            FieldOfView = Window.Flags["Aimbot/FieldOfView"],
            Distance = Window.Flags["Aimbot/Distance"],
            Priority = Window.Flags["Aimbot/Priority"]
        }),{
            Prediction = {
                Enabled = Window.Flags["Aimbot/Prediction/Enabled"],
                Velocity = Window.Flags["Aimbot/Prediction/Velocity"]
            },
            Sensitivity = Window.Flags["Aimbot/Smoothness"] / 100
        })
    end
end)
Parvus.Utilities.Misc:NewThreadLoop(0,function()
    if not Trigger then return end
    local TriggerHB = GetHitboxWithPrediction({
        Enabled = Window.Flags["Trigger/Enabled"],
        WallCheck = Window.Flags["Trigger/WallCheck"],
        Prediction = {
            Enabled = Window.Flags["Trigger/Prediction/Enabled"],
            Velocity = Window.Flags["Trigger/Prediction/Velocity"]
        },
        DynamicFOV = Window.Flags["Trigger/DynamicFOV"],
        FieldOfView = Window.Flags["Trigger/FieldOfView"],
        Distance = Window.Flags["Trigger/Distance"],
        Priority = Window.Flags["Trigger/Priority"]
    })

    if TriggerHB then mouse1press()
        task.wait(Window.Flags["Trigger/Delay"])
        if Window.Flags["Trigger/HoldMode"] then
            while task.wait() do
                TriggerHB = GetHitboxWithPrediction({
                    Enabled = Window.Flags["Trigger/Enabled"],
                    WallCheck = Window.Flags["Trigger/WallCheck"],
                    Prediction = {
                        Enabled = Window.Flags["Trigger/Prediction/Enabled"],
                        Velocity = Window.Flags["Trigger/Prediction/Velocity"]
                    },
                    DynamicFOV = Window.Flags["Trigger/DynamicFOV"],
                    FieldOfView = Window.Flags["Trigger/FieldOfView"],
                    Distance = Window.Flags["Trigger/Distance"],
                    Priority = Window.Flags["Trigger/Priority"]
                }) if not TriggerHB or not Trigger then break end
            end
        end mouse1release()
    end
end)

for Index,Player in pairs(PlayerService:GetPlayers()) do
    if Player == LocalPlayer then continue end
    Parvus.Utilities.Drawing:AddESP(Player,"Player","ESP/Player",Window.Flags)
end
PlayerService.PlayerAdded:Connect(function(Player)
    Parvus.Utilities.Drawing:AddESP(Player,"Player","ESP/Player",Window.Flags)
end)
PlayerService.PlayerRemoving:Connect(function(Player)
    Parvus.Utilities.Drawing:RemoveESP(Player)
end)
