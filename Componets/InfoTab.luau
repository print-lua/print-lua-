return function(Window)
	local LatestChangelog = {
		"24/7/2026",
		"<font color='rgb(255, 0, 0)'>- BlackKingV3.</font>",
		"<font color='rgb(0, 255, 0)'>+ BlackKing Official.</font>",
		"<font color='rgb(0, 255, 0)'>+ Fixed the main loader (obfuscator issue).</font>",
	}

	local function CloneReference(Object)
		if BlackKing and BlackKing.Environment.cloneref then
			return BlackKing.Environment.cloneref(Object)
		else
			return Object
		end
	end

	local Services = setmetatable({}, {
		__index = function(self, Name)
			return CloneReference(game:GetService(Name))
		end
	})

	local Library = BlackKing.Interface.Library
	local SaveManager = BlackKing.Interface.SaveManager
	local ThemeManager = BlackKing.Interface.ThemeManager

	local Toggles = Library.Toggles
	local Options = Library.Options

	local LocalPlayer = Services.Players.LocalPlayer
	local InfoTab = Window:AddTab("Info", "user")

	local User = InfoTab:AddLeftGroupbox("User Info")

	local ImageSize = Enum.ThumbnailSize.Size420x420
	local ImageType = Enum.ThumbnailType.HeadShot

	local Content = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ImageType, ImageSize)

	User:AddImage("UserIcon", {
		Image = Content
	})

	User:AddLabel("User: " .. LocalPlayer.Name, true)
	User:AddLabel("Total Executions: " .. (BlackKing.TotalExecutions and BlackKing.TotalExecutions or "N/A"), true)

	local Changelog = InfoTab:AddRightGroupbox("Changelog")
	for Index, Change in pairs(LatestChangelog) do
		Changelog:AddLabel(Change, true)
	end

	local Name, Version = BlackKing.Environment.identifyexecutor()
	local Executor = InfoTab:AddRightGroupbox("Executor Info")

	for Index, Result in pairs(BlackKing.Environment.Results) do
		-- fix for veloshitty 💔
		Result = Result:gsub("<", "(")
		Result = Result:gsub(">", ")")

		Executor:AddLabel(Result, true)
	end

	local Community = InfoTab:AddLeftGroupbox("Community")
	Community:AddButton("Copy Discord Invite", function()
		toclipboard("https://dsc.gg/BlackKing")
		Library:Notify("Discord invite copied.")
	end)
end