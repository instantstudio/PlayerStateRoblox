--[[
	PlayerState.Init
	By InstantStudio
]]

local PlayerState = {}

function CreateFolder(Player)
	local NewTemp = script.Template:Clone()
	NewTemp.Name = "PlayerState"
	NewTemp.Parent = Player
	return NewTemp
end

function PlayerState.CreateState(Player, ValueType, ValueName, Value)
	local StateFolder = Player:FindFirstChild("PlayerState")
	if not StateFolder then
		StateFolder = CreateFolder(Player)
	end
	local New = Instance.new(ValueType, StateFolder)
	New.Name = ValueName
	if Value then
		New.Value = Value
	end
	return {true, New}
end


function PlayerState.RemoveState(Player, ValueName)
	local StateFolder = Player:FindFirstChild("PlayerState")
	if not StateFolder then
		StateFolder = CreateFolder(Player)
		return {false, "No State Folder"}
	else
		local Search = StateFolder:FindFirstChild(ValueName)
		if Search then
			Search:Destroy()
			return {true}
		else
			return {false, "No Such Value Found"}
		end
	end
end


function PlayerState.GetState(Player, ValueName)
	local StateFolder = Player:FindFirstChild("PlayerState")
	if not StateFolder then
		return {false, "No State Folder"}
	else
		local Search = StateFolder:FindFirstChild(ValueName)
		if Search then
			return {true, Search}
		else
			return {false, "No Such Value"}
		end
	end
end


function PlayerState.UpdateState(Player, ValueName, Value)
	local StateFolder = Player:FindFirstChild("PlayerState")
	if not StateFolder then
		return {false, "No State Folder"}
	else
		local Search = StateFolder:FindFirstChild(ValueName)
		if Search then
			Search.Value = Value
			return {true}
		else
			return {false, "No Such Value"}
		end
	end
end


function PlayerState.GetStates(Player)
	local StateFolder = Player:FindFirstChild("PlayerState")
	if not StateFolder then
		return {false, "No State Folder"}
	else
		return {true, StateFolder:GetChildren()}
	end
end

--	Events
function PlayerState:WatchState(Player, ValueName)
	local StateFolder = Player:FindFirstChild("PlayerState")
	if not StateFolder then
		warn("StateWarn: No Such Folder the event will not fire if the fold does not exsist")
	else
		local Search = StateFolder:FindFirstChild(ValueName)
		if Search then
			local Old = Search.Value
			repeat
				wait()
				if Search == nil then
					return
				end
			until Search.Value ~= Old
			return
		else
			warn("StateWarn: No Such Value the evnt will not fire if it does not exsist.")
		end
	end
end


function PlayerState:Watch(Player)
	warn("StateWarn: This Function is decrypted and cannot be used. Use PlayerState:WatchState() Instead.")
end

return PlayerState
