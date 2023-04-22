local enabled = false

local write if io then
	function write(...)
		return io.stderr:write(...)
	end
else
	write = print
end

return function(...)
	if select('#', ...) == 1 and (...):byte()==64 then
		if ... == "@on" then
			enabled = true
		elseif ... == "@off" then
			enabled = false
		end
	elseif enabled then
		local prefix = WARN_PREFIX or function()
			local i = debug.getinfo(3)
			return "Lua warning ("..i.short_src..":"..i.currentline.."):"
		end
		write(table.concat({prefix(), ...}, ' '), "\n")
	end
end
