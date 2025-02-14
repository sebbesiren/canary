-- Usage talkaction: "!hazardlevel darashia minos, 0"
local hazardlevel = TalkAction("!hazardlevel")

local hazards = {
	["gnomprona"] = { name = "hazard.gnomprona-gardens" },
	["origin"] = { name = "hazard.origin" },
	["world"] = { name = "hazard.world" },
}

local availableHazards = {}
for key, _ in pairs(hazards) do
	table.insert(availableHazards, key)
end

local function lstrip(s)
	return s:match("^%s*(.*)")
end

local function rstrip(s)
	return s:match("(.-)%s*$")
end

function hazardlevel.onSay(player, words, param)
	logger.debug("!hazardlevel executed")

	local paramParts = param:split(",")

	if paramParts[1] == "list" then
		player:sendTextMessage(MESSAGE_LOOK, "Available hazards: " .. table.concat(availableHazards, ", "))
		return true
	end

	local hazardName = paramParts[1]
	local selectedHazard = hazards[hazardName]
	if not selectedHazard then
		player:sendTextMessage(MESSAGE_LOOK, "Unknown hazard. Use one of: " .. table.concat(availableHazards, ", "))
		return true
	end
	local hazard = Hazard.getByName(selectedHazard.name)

	local desiredLevel = lstrip(rstrip(paramParts[2]))
	if desiredLevel == "max" then
		desiredLevel = hazard:getPlayerMaxLevel(player) or 1
	else
		desiredLevel = getMoneyCount(desiredLevel)
	end

	if desiredLevel == -1 then
		desiredLevel = 0
	end


	player:sendTextMessage(MESSAGE_LOOK, "Hazardlevel will be set in 10 seconds.")
	addEvent(function()
		if hazard:setPlayerCurrentLevel(player, desiredLevel) then
			player:sendTextMessage(MESSAGE_LOOK, "Hazard level for area '" .. hazardName .. "' set to " .. desiredLevel)
		else
			player:sendTextMessage(MESSAGE_LOOK, "You can't set your hazard level higher than your maximum unlocked level.")
		end
	end, 10000)


	return true
end

hazardlevel:separator(" ")
hazardlevel:groupType("normal")
hazardlevel:register()
