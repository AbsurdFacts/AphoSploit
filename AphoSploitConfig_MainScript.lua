-- Create a ScreenGui to hold our button and notification
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Function to create a notification
local function createNotification()
    local notification = Instance.new("TextLabel")
    notification.Name = "AphoSploitNotification"
    notification.Text = "AphoSploit loaded! Press RIGHTSHIFT to open menu."
    notification.Size = UDim2.new(0, 300, 0, 50) -- Size of the notification
    notification.Position = UDim2.new(1, -320, 1, -70) -- Position it to the bottom right corner
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark background color
    notification.TextColor3 = Color3.new(1, 1, 1) -- White text color
    notification.Font = Enum.Font.SourceSansSemibold
    notification.TextSize = 18
    notification.BorderSizePixel = 0
    notification.TextWrapped = true
    notification.TextStrokeTransparency = 0.5
    notification.TextStrokeColor3 = Color3.new(0, 0, 0)
    notification.Parent = gui

    -- Animate notification to fade out after 1 second
    wait(3)
    notification:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.5, true)
    wait(0.5)
    notification:Destroy()
end

-- Call the function to create the notification when the player joins
createNotification()

-- Define hacks
local hacks = {
    {
        Name = "Movement Hacks",
        Buttons = {
            {Text = "Fly", Function = function()
                -- Toggle fly
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end, Keybind = Enum.KeyCode.F},
            {Text = "Speed", Function = function()
                -- Increase player speed
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 5
            end, Keybind = Enum.KeyCode.S}
        }
    },
    {
        Name = "Camera Hacks",
        Buttons = {
            {Text = "FreeCam", Function = function()
                -- Enable FreeCam
                local Camera = game.Workspace.CurrentCamera
                local Player = game.Players.LocalPlayer
                local Character = Player.Character or Player.CharacterAdded:Wait()
                local Humanoid = Character:WaitForChild("Humanoid")
                local humanoidRootPart = Character:WaitForChild("HumanoidRootPart")

                local freeCam = Instance.new("Camera")
                freeCam.CameraType = Enum.CameraType.Scriptable
                freeCam.Parent = Camera

                local offset = Camera.CFrame.Position - humanoidRootPart.Position

                while true do
                    freeCam.CFrame = CFrame.new(humanoidRootPart.Position + offset)
                    wait()
                end
            end, Keybind = Enum.KeyCode.C},
            {Text = "FOV", Function = function()
                -- Change Field of View to 120
                game.Workspace.CurrentCamera.FieldOfView = 150
            end, Keybind = Enum.KeyCode.V}
        }
    },
    {
        Name = "Miscellaneous",
        Buttons = {
            {Text = "Teleport", Function = function()
                -- Function to handle teleportation
                local player = game.Players.LocalPlayer
                local mouse = player:GetMouse()
                
                -- Prompt the player to click on a location to teleport
                local location = mouse.Hit
                
                -- Check if the location is valid
                if location then
                    -- Teleport the player to the clicked location
                    player.Character:SetPrimaryPartCFrame(CFrame.new(location.p))
                end
            end, Keybind = Enum.KeyCode.T},
            {Text = "ESP", Function = function()
                -- Function to display ESP
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        local distance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if distance <= 100000000 then
                            local esp = Instance.new("BoxHandleAdornment")
                            esp.Adornee = player.Character.HumanoidRootPart
                            esp.Size = Vector3.new(5, 5, 5)  -- Increase the size of the ESP box
                            esp.Color3 = Color3.fromRGB(255, 0, 0)
                            esp.Transparency = 0.5
                            esp.Parent = player.Character.HumanoidRootPart
                        end
                    end
                end
            end, Keybind = Enum.KeyCode.E},
            {Text = "red skybox", Function = function()
                -- Set Skybox to red
                game.Lighting.Ambient = Color3.fromRGB(255, 0, 0) -- Red Ambient light
                game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 0, 0) -- Red Outdoor Ambient light
            end, Keybind = Enum.KeyCode.K}
        }
    }
}

-- Create frames for each hack category
local frameOffset = 10
local frameWidth = 200
local frameHeight = 200
local totalWidth = 0

for _, hack in ipairs(hacks) do
    local frame = Instance.new("Frame")
    frame.Name = "AphoSploitFrame_" .. hack.Name
    frame.Size = UDim2.new(0, frameWidth, 0, frameHeight) -- Size of the frame
    frame.Position = UDim2.new(0, totalWidth, 0, frameOffset) -- Position it
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Dark background color
    frame.BorderSizePixel = 0
    frame.Visible = false
    frame.Parent = gui

    -- Function to create buttons inside the frame
    local function createButtons()
        local buttonHeight = (frameHeight - (#hack.Buttons - 1) * 10) / #hack.Buttons
        local yOffset = 0
        for _, buttonInfo in ipairs(hack.Buttons) do
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, 0, 0, buttonHeight)
            button.Position = UDim2.new(0, 0, 0, yOffset)
            button.Text = buttonInfo.Text
            button.Font = Enum.Font.SourceSansSemibold
            button.TextSize = 20
            button.TextColor3 = Color3.new(1, 1, 1)
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            button.BorderSizePixel = 0
            button.Parent = frame

            local menu = Instance.new("TextButton")
            menu.Size = UDim2.new(0, 30, 0, 30)
            menu.Position = UDim2.new(1, -30, 0, yOffset)
            menu.Text = "..."
            menu.Font = Enum.Font.SourceSansBold
            menu.TextSize = 20
            menu.TextColor3 = Color3.new(1, 1, 1)
            menu.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            menu.BorderSizePixel = 0
            menu.Parent = button

            local menuVisible = false
            menu.MouseButton1Click:Connect(function()
                menuVisible = not menuVisible
                if menuVisible then
                    -- No longer printing keybind information
                end
            end)

            button.MouseButton1Click:Connect(function()
                -- Activate the hack when the button is clicked
                buttonInfo.Function()
            end)

            -- Create a menu to allow keybind customization
            button.MouseButton2Click:Connect(function()
                local inputText = Instance.new("TextBox")
                inputText.Size = UDim2.new(0, 100, 0, 30)
                inputText.Position = UDim2.new(0.5, -50, 0.5, -15)
                inputText.AnchorPoint = Vector2.new(0.5, 0.5)
                inputText.Text = buttonInfo.Keybind.Name
                inputText.TextColor3 = Color3.new(1, 1, 1)
                inputText.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                inputText.BorderSizePixel = 0
                inputText.Font = Enum.Font.SourceSans
                inputText.TextSize = 14
                inputText.Parent = button

                inputText.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        local newKey = Enum.KeyCode[inputText.Text]
                        if newKey then
                            buttonInfo.Keybind = newKey
                            inputText:Destroy()
                        else
                            inputText.Text = "Invalid Key"
                        end
                    else
                        inputText:Destroy()
                    end
                end)
            end)

            yOffset = yOffset + buttonHeight + 10
        end
    end

    -- Call the function to create buttons when the frame is shown
    createButtons()

    totalWidth = totalWidth + frameWidth + 10
end

-- Function to toggle the visibility of the hacks menu
local isMenuOpen = false

local function toggleHacksMenu()
    isMenuOpen = not isMenuOpen
    for _, hack in ipairs(hacks) do
        local frame = gui:FindFirstChild("AphoSploitFrame_" .. hack.Name)
        if frame then
            frame.Visible = isMenuOpen
        end
    end
end

-- Bind the RightShift key to toggle the menu
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleHacksMenu()
    end
end)
