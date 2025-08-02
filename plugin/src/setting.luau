
--[[
	setting
	plugin setting wrapper
]]

export type Setting<V> = (() -> V) & ((value: V) -> V)

local function setting<V>(plugin: Plugin, key: string, default: V): Setting<V>
	if not plugin:GetSetting(key) then
		plugin:SetSetting(key, default)
	end

	return function(...)
		if select("#", ...) ~= 0 then
			plugin:SetSetting(key, select(1, ...) :: any)
		end

		return plugin:GetSetting(key)
	end
end

return setting
