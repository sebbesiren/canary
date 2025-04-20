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

local function updateHazardLevel(player, selectedHazard, desiredLevel, hazardName)
	local hazard = Hazard.getByName(selectedHazard.name)

	local currentLevel = hazard:getPlayerCurrentLevel(player)

	if hazard:setPlayerCurrentLevel(player, desiredLevel) then
		if hazardName then
			player:sendTextMessage(MESSAGE_LOOK, "Hazard level for area '" .. hazardName .. "' set to " .. desiredLevel)
		end

		if desiredLevel > currentLevel then
			local spectators = Game.getSpectators(player:getPosition(), false, false, 15, 15, 15, 15)
			for _, spectator in ipairs(spectators) do
				if spectator:isMonster() then
					if spectator:getName() == "Loot Goblin" then
						spectator:remove()
					else
						spectator:setHealth(spectator:getMaxHealth())
					end
				end
			end
		end
	else
		if hazardName then
			player:sendTextMessage(MESSAGE_LOOK, "You can't set your hazard level for " .. hazardName .. " higher than your maximum unlocked level.")
		end
	end
end

function hazardlevel.onSay(player, words, param)
	logger.debug("!hazardlevel executed")

	local paramParts = param:split(",")

	if #paramParts < 2 then
		player:sendTextMessage(MESSAGE_LOOK, "Unknown input. Try !hazardlevel world, 1")
		return true
	end

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

	if not paramParts[2] then
		player:sendTextMessage(MESSAGE_LOOK, "Invalid level")
		return true
	end

	local desiredLevel = lstrip(rstrip(paramParts[2]))
	if desiredLevel == "max" then
		desiredLevel = hazard:getPlayerMaxLevel(player) or 1
	else
		desiredLevel = getMoneyCount(desiredLevel)
	end

	if desiredLevel == -1 then
		desiredLevel = 0
	end

	player:sendTextMessage(MESSAGE_LOOK, "Hazardlevel will be set in 5 seconds.")
	addEvent(function()
		updateHazardLevel(player, selectedHazard, desiredLevel, hazardName)

		if hazardName == "world" then
			updateHazardLevel(player, hazards["origin"], desiredLevel, nil)
		end
	end, 5000)

	return true
end

hazardlevel:separator(" ")
hazardlevel:groupType("normal")
hazardlevel:register()
