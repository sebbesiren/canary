-- Usage talkaction: "!hazardlevel darashia minos, 0"
local hazardlevel = TalkAction("!hazardlevel")

local hazards = {
	["ankh mother scarabs"] = { name = "hazard.ankrahmun-mother-scarabs" },
	["asura mirror"] = { name = "hazard.asura-mirror" },
	["banuta"] = { name = "hazard.banuta" },
	["buried cathedral"] = { name = "hazard.buried-cathedral" },
	["carnivoras"] = { name = "hazard.carnivoras" },
	["cobra"] = { name = "hazard.cobra" },
	["court of summer winter"] = { name = "hazard.court-of-summer-winter" },
	["darashia minos"] = { name = "hazard.darashia-minotaurs" },
	["darashia wyrms"] = { name = "hazard.darashia-wyrms" },
	["edron hero cave"] = { name = "hazard.edron-hero-cave" },
	["ferumbras ascension"] = { name = "hazard.ferumbras-ascension-grimeleech" },
	["flimsy"] = { name = "hazard.flimsy" },
	["falcon"] = { name = "hazard.falcon" },
	["gnomprona"] = { name = "hazard.gnomprona-gardens" },
	["goroma demons"] = { name = "hazard.goroma-demons" },
	["glooth bandits"] = { name = "hazard.glooth-bandits" },
	["ingol"] = { name = "hazard.ingol" },
	["inquisition"] = { name = "hazard.inquisition" },
	["issavi surface"] = { name = "hazard.issavi-surface" },
	["lower roshamuul"] = { name = "hazard.lower-roshamuul" },
	["pirats"] = { name = "hazard.pirats" },
	["prison"] = { name = "hazard.prison" },
	["rookgard"] = { name = "hazard.rookgard" },
	["secret library"] = { name = "hazard.secret-library" },
	["werehyaena"] = { name = "hazard.werehyaena" },
	["origin"] = { name = "hazard.origin" },
	["oramond catacombs"] = { name = "hazard.oramond-catacombs" },
	["soulwars"] = { name = "hazard.soulwars" },
	["tower"] = { name = "hazard.tower" }
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

	if not selectedHazard then
		player:sendTextMessage(MESSAGE_LOOK, "Unknown hazard. Use one of: " .. table.concat(availableHazards, ", "))
		return true
	end

	if hazard:setPlayerCurrentLevel(player, desiredLevel) then
		player:sendTextMessage(MESSAGE_LOOK, "Hazard level for area '" .. hazardName .. "' set to " .. desiredLevel)
	else
		player:sendTextMessage(MESSAGE_LOOK, "You can't set your hazard level higher than your maximum unlocked level.")
	end

	return true
end

hazardlevel:separator(" ")
hazardlevel:groupType("normal")
hazardlevel:register()
