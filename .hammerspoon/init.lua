send_escape = false
last_mods = {}

control_key_handler = function()
	send_escape = false
end

control_key_timer = hs.timer.delayed.new(0.15, control_key_handler)

control_handler = function(evt)
	local new_mods = evt:getFlags()
	if last_mods["ctrl"] == new_mods["ctrl"] then
		return false
	end
	if not last_mods["ctrl"] then
		last_mods = new_mods
		send_escape = true
		control_key_timer:start()
	else
		if send_escape then
			hs.eventtap.keyStroke({}, "ESCAPE")
		end
		last_mods = new_mods
		control_key_timer:stop()
	end
	return false
end

control_tap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, control_handler)
control_tap:start()

other_handler = function(evt)
	send_escape = false
	return false
end

other_tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, other_handler)
other_tap:start()

local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function()
		hs.eventtap.keyStroke(mods, key, 1000)
	end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end

remap({ "cmd" }, "h", pressFn("left"))
remap({ "cmd" }, "j", pressFn("down"))
remap({ "cmd" }, "k", pressFn("up"))
remap({ "cmd" }, "l", pressFn("right"))

-- remap({ "ctrl", "shift" }, "h", pressFn({ "shift" }, "left"))
-- remap({ "ctrl", "shift" }, "j", pressFn({ "shift" }, "down"))
-- remap({ "ctrl", "shift" }, "k", pressFn({ "shift" }, "up"))
-- remap({ "ctrl", "shift" }, "l", pressFn({ "shift" }, "right"))
--
-- remap({ "ctrl", "cmd" }, "h", pressFn({ "cmd" }, "left"))
-- remap({ "ctrl", "cmd" }, "j", pressFn({ "cmd" }, "down"))
-- remap({ "ctrl", "cmd" }, "k", pressFn({ "cmd" }, "up"))
-- remap({ "ctrl", "cmd" }, "l", pressFn({ "cmd" }, "right"))
--
-- remap({ "ctrl", "alt" }, "h", pressFn({ "alt" }, "left"))
-- remap({ "ctrl", "alt" }, "j", pressFn({ "alt" }, "down"))
-- remap({ "ctrl", "alt" }, "k", pressFn({ "alt" }, "up"))
-- remap({ "ctrl", "alt" }, "l", pressFn({ "alt" }, "right"))
--
-- remap({ "ctrl", "shift", "cmd" }, "h", pressFn({ "shift", "cmd" }, "left"))
-- remap({ "ctrl", "shift", "cmd" }, "j", pressFn({ "shift", "cmd" }, "down"))
-- remap({ "ctrl", "shift", "cmd" }, "k", pressFn({ "shift", "cmd" }, "up"))
-- remap({ "ctrl", "shift", "cmd" }, "l", pressFn({ "shift", "cmd" }, "right"))
--
-- remap({ "ctrl", "shift", "alt" }, "h", pressFn({ "shift", "alt" }, "left"))
-- remap({ "ctrl", "shift", "alt" }, "j", pressFn({ "shift", "alt" }, "down"))
-- remap({ "ctrl", "shift", "alt" }, "k", pressFn({ "shift", "alt" }, "up"))
-- remap({ "ctrl", "shift", "alt" }, "l", pressFn({ "shift", "alt" }, "right"))
--
-- remap({ "ctrl", "cmd", "alt" }, "h", pressFn({ "cmd", "alt" }, "left"))
-- remap({ "ctrl", "cmd", "alt" }, "j", pressFn({ "cmd", "alt" }, "down"))
-- remap({ "ctrl", "cmd", "alt" }, "k", pressFn({ "cmd", "alt" }, "up"))
-- remap({ "ctrl", "cmd", "alt" }, "l", pressFn({ "cmd", "alt" }, "right"))
--
-- remap({ "ctrl", "cmd", "alt", "shift" }, "h", pressFn({ "cmd", "alt", "shift" }, "left"))
-- remap({ "ctrl", "cmd", "alt", "shift" }, "j", pressFn({ "cmd", "alt", "shift" }, "down"))
-- remap({ "ctrl", "cmd", "alt", "shift" }, "k", pressFn({ "cmd", "alt", "shift" }, "up"))
-- remap({ "ctrl", "cmd", "alt", "shift" }, "l", pressFn({ "cmd", "alt", "shift" }, "right"))
