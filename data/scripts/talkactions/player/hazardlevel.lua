-- Usage talkaction: "!hazardlevel darashia minos, 0"
local hazardlevel = TalkAction("!hazardlevel")

local hazards = {
	["gnomprona"] = { name = "hazard.gnomprona-gardens" },
	["darashia minos"] = { name = "hazard.darashia-minotaurs" },
	["darashia wyrms"] = { name = "hazard.darashia-wyrms" },
	["ankh mother scarabs"] = { name = "hazard.ankrahmun-mother-scarabs" },
	["prison"] = { name = "hazard.prison" },
	["asura mirror"] = { name = "hazard.asura-mirror" },
	["edron hero cave"] = { name = "hazard.edron-hero-cave" },
	["banuta"] = { name = "hazard.banuta" },
	["grimeleech"] = { name = "hazard.ferumbras-ascension-grimeleech" },
	["court of summer winter"] = { name = "hazard.court-of-summer-winter" },
	["goroma demons"] = { name = "hazard.goroma-demons" },
	["flimsy"] = { name = "hazard.flimsy" },
	["falcon"] = { name = "hazard.falcon" },
	["cobra"] = { name = "hazard.cobra" },
	["ingol"] = { name = "hazard.ingol" },
	["carnivoras"] = { name = "hazard.carnivoras" },
	["issavi surface"] = { name = "hazard.issavi-surface" },
	["glooth bandits"] = { name = "hazard.glooth-bandits" },
	["buried cathedral"] = { name = "hazard.buried-cathedral" },
	["inquisition"] = { name = "hazard.inquisition" },
	["lower roshamuul"] = { name = "hazard.lower-roshamuul" },
	["werehyaena"] = { name = "hazard.werehyaena" },
	["pirats"] = { name = "hazard.pirats" },
	["secret library"] = { name = "hazard.secret-library" },
}

local availableHazards = {}
for key, _ in pairs(hazards) do
	table.insert(availableHazards, key)
end

function hazardlevel.onSay(player, words, param)
	logger.debug("!hazardlevel executed")

	local param_parts = param:split(",")

	if param_parts[1] == "list" then
		player:sendTextMessage(MESSAGE_LOOK, "Available hazards: " .. table.concat(availableHazards, ", "))
		return true
	end

	local hazardName = param_parts[1]
	local desiredLevel = getMoneyCount(param_parts[2])
	if desiredLevel == -1 then
		desiredLevel = 0
	end

	local selectedHazard = hazards[hazardName]

	if not selectedHazard then
		player:sendTextMessage(MESSAGE_LOOK, "Unknown hazard. Use one of: " .. table.concat(availableHazards, ", "))
		return true
	end

	local hazard = Hazard.getByName(selectedHazard.name)
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
