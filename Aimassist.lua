-- Aim Assist Prototype

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local FOV_RADIUS = 130

-- Create FOV circle
local gui = Instance.new("ScreenGui")
gui.Name = "AimAssistPrototype"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local circle = Instance.new("Frame")
circle.Name = "FOVCircle"
circle.AnchorPoint = Vector2.new(0.5, 0.5)
circle.Size = UDim2.fromOffset(
	FOV_RADIUS * 2,
	FOV_RADIUS * 2
)
circle.BackgroundTransparency = 1
circle.Position = UDim2.fromScale(0.5, 0.5)
circle.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = circle

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 60, 60)
stroke.Thickness = 2
stroke.Parent = circle

-- Selected target indicator
local highlight = Instance.new("Highlight")
highlight.FillColor = Color3.fromRGB(255, 60, 60)
highlight.OutlineColor = Color3.new(1, 1, 1)
highlight.Enabled = false
highlight.Parent = workspace

local function getNearestTarget()
	local camera = workspace.CurrentCamera
	if not camera then
		return nil
	end

	local screenCenter = camera.ViewportSize / 2
	local nearestTarget = nil
	local nearestDistance = FOV_RADIUS

	for _, object in ipairs(workspace:GetDescendants()) do
		if object:IsA("BasePart") and object.Name == "AimTarget" then
			local screenPos, onScreen =
				camera:WorldToViewportPoint(object.Position)

			if onScreen and screenPos.Z > 0 then
				local point = Vector2.new(screenPos.X, screenPos.Y)
				local distance = (point - screenCenter).Magnitude

				if distance < nearestDistance then
					nearestDistance = distance
					nearestTarget = object
				end
			end
		end
	end

	return nearestTarget
end

RunService.RenderStepped:Connect(function()
	local target = getNearestTarget()

	if target then
		highlight.Adornee = target
		highlight.Enabled = true
	else
		highlight.Adornee = nil
		highlight.Enabled = false
	end
end)
