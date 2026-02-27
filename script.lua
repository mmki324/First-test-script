-- [[ MULTI-FUNCTION UI: FLY + COPY AVATAR ]] --
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

-- สร้าง UI หลัก
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGameDevTools"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- เฟรมหลัก (Main Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 180, 0, 220)
mainFrame.Position = UDim2.new(0.75, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local uiCornerMain = Instance.new("UICorner")
uiCornerMain.CornerRadius = UDim.new(0, 10)
uiCornerMain.Parent = mainFrame

-- หัวข้อ
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "CREATOR TOOLS"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- [[ ส่วนของระบบบิน (FLY) ]] --
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.9, 0, 0, 40)
flyBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyBtn.Text = "FLY: OFF"
flyBtn.TextColor3 = Color3.new(1, 1, 1)
flyBtn.Font = Enum.Font.Gotham
flyBtn.Parent = mainFrame

local flying = false
local flySpeed = 50
local bv, bg

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        flyBtn.Text = "FLY: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(1, 1, 1) * math.huge
        bg = Instance.new("BodyGyro", root)
        bg.MaxTorque = Vector3.new(1, 1, 1) * math.huge
        task.spawn(function()
            while flying do
                bv.Velocity = camera.CFrame.LookVector * flySpeed
                bg.CFrame = camera.CFrame
                task.wait()
            end
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end)
    else
        flyBtn.Text = "FLY: OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- [[ ส่วนของระบบเปลี่ยนร่าง (COPY AVATAR) ]] --
local idInput = Instance.new("TextBox")
idInput.Size = UDim2.new(0.9, 0, 0, 35)
idInput.Position = UDim2.new(0.05, 0, 0.45, 0)
idInput.PlaceholderText = "Enter User ID"
idInput.Text = ""
idInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
idInput.TextColor3 = Color3.new(1, 1, 1)
idInput.Parent = mainFrame

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.9, 0, 0, 40)
copyBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
copyBtn.Text = "COPY AVATAR"
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Parent = mainFrame

copyBtn.MouseButton1Click:Connect(function()
    local targetId = tonumber(idInput.Text)
    if targetId then
        -- ใช้ฟังก์ชันของ Roblox ในการดึงร่าง (ฝั่ง Client อาจเห็นคนเดียว)
        player.CharacterAppearanceId = targetId
        if character then
            character:BreakJoints() -- รีเซ็ตตัวละครเพื่อให้ร่างใหม่โหลดมาแทน
        end
    end
end)

-- ปุ่มลัดปิด UI
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.9, 0, 0, 25)
closeBtn.Position = UDim2.new(0.05, 0, 0.85, 0)
closeBtn.Text = "CLOSE GUI"
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
