local zone = Zone("ferumbras.ferumbras_raid")
zone:addArea(Position(32117, 32684, 4), Position(32126, 32691, 4))

local raid = Raid("ferumbras.ferumbras_raid", {
	zone = zone,
	allowedDays = { "Saturday", "Sunday" },
	minActivePlayers = 1,
	initialChance = 0.04,
	targetChancePerDay = 0.1,
	maxChancePerCheck = 1,
	minGapBetween = "720h",
})

raid:addBroadcast("The seals on Ferumbras' old citadel are glowing. Prepare for HIS return, mortals."):autoAdvance("10m")
raid:addBroadcast("Ferumbras' return is at hand. The Edron Academy calls for heroes to fight that evil."):autoAdvance("10m")
raid:addBroadcast("Ferumbras has returned to his citadel once more. Stop him before it is too late."):autoAdvance("5s")

raid
	:addSpawnMonsters({
		{
			name = "Demon",
			amount = 4,
		},
		{
			name = "Ferumbras",
			amount = 1,
		},
	})
	:autoAdvance("12h")

raid:register()
