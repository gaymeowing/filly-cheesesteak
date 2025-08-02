
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local DraggerService = game:GetService("DraggerService")
local Selection = game:GetService("Selection")
local Studio = settings().Studio
local create_dock_widget_plugin_gui = require("./create_dock_widget_plugin_gui")
local setting = require("./setting")

type JoinMode = "Auto" | "Angled" | "Cutout" | "Rounded" | "Square"

local JOIN_MODE = setting(plugin, "JoinMode", "Auto" :: JoinMode)
local RESIZE_PARTS = setting(plugin, "ResizeParts", true)
local DEEP_FILL = setting(plugin, "DeepFill", true)
local ENABLED = false

local DOCK_GUI = create_dock_widget_plugin_gui(plugin, "gaymeowing-Filly", {
	initally_enabled_should_override_restore = false,
	inital_dock_state = Enum.InitialDockState.Float,
	inital_size = vector.create(220, 350),
	initally_enabled = false,
})
local OPEN_BUTTON = plugin:CreateToolbar("gaymeowing")
	:CreateButton(
		"Filly",
		"Generate geometry to fill in gaps between two selected part edges.",
		"rbxassetid://16928343218"
	)

local function ON_DESTROY()
	OPEN_BUTTON:SetActive(false)
	ENABLED = false
end

local function TEMP_ON_UNLOAD()
	pcall(function()
		DOCK_GUI.Main.Parent = game:GetService("ReplicatedFirst")
	end)
end

OPEN_BUTTON.Click:Connect(function()
	ENABLED = not ENABLED

	if ENABLED then
		if #DOCK_GUI:GetChildren() == 0 then
			game:GetService("ReplicatedFirst").Main.Parent = DOCK_GUI
		end
		Selection:Set({ DOCK_GUI })
	end

	OPEN_BUTTON:SetActive(ENABLED)
	DOCK_GUI.Enabled = ENABLED
end)

DOCK_GUI.Destroying:Connect(ON_DESTROY)
DOCK_GUI:BindToClose(ON_DESTROY)

plugin.Deactivation:Connect(function()
	TEMP_ON_UNLOAD()
end)

plugin.Unloading:Connect(function()
	TEMP_ON_UNLOAD()
end)


pcall(function()
	if #DOCK_GUI:GetChildren() == 0 then
		game:GetService("ReplicatedFirst").Main.Parent = DOCK_GUI
	end
end)
