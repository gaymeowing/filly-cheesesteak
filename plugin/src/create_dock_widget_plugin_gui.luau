
--[[
	create dock widget plugin gui
	wrapper around plugin:CreateDockWidgetPluginGui() becuase i hate DockWidgetPluginGuiInfo
	and dockwidgetplugingui has semi horrible default properties
]]

local PluginDebugService = game:GetService("PluginDebugService")

export type DockWidgetPluginGuiInfo = {
	initally_enabled_should_override_restore: boolean,
	inital_dock_state: Enum.InitialDockState,
	initally_enabled: boolean,
	inital_size: vector,
	min_size: vector?,
	title: string?,
}

local function create_dock_widget_plugin_gui(plugin: Plugin, id: string, info: DockWidgetPluginGuiInfo)
	local inital_size = info.inital_size
	local min_size = info.min_size or inital_size
	local plugin_name = plugin.Name
	local title = info.title

	if plugin.Parent == PluginDebugService then
		plugin_name = string.sub(plugin_name, 6, #plugin_name - 5)
	end

	local gui = plugin:CreateDockWidgetPluginGui(
		id, DockWidgetPluginGuiInfo.new(
			info.inital_dock_state, info.initally_enabled,
			info.initally_enabled_should_override_restore,
			inital_size.x, inital_size.y,
			min_size.x, min_size.y
		)
	)

	if title then
		gui.Name = `{plugin_name} "{title}"`
		gui.Title = title
	else
		gui.Title = plugin_name
		gui.Name = plugin_name
	end

	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.ResetOnSpawn = false
	return gui
end

return create_dock_widget_plugin_gui
