local urls = {
	"https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/doors.luau",
	"https://raw.githubusercontent.com/print-lua/print-lua-/refs/heads/main/doors2.luau"
}

for index, url in ipairs(urls) do
	local success, result = pcall(function()
		return game:HttpGet(url)
	end)
	
	if success then
		local fn, err = loadstring(result)
		if fn then
			task.spawn(fn)
			print(string.Successfully loaded and executed script [index]: %s, url)
		else
			warn(string.format("Failed to compile script %d: %s", index, tostring(err)))
		end
	else
		warn(string.format("Failed to fetch script %d: %s", index, tostring(result)))
	end
end

print("lowk idk what to put here pls star on github lol")