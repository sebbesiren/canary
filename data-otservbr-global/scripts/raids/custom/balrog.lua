local zone = Zone("orc_main_fortress.balrog")
zone:addArea(Position(5968, 5967, 6), Position(5974, 5972, 6))

local raid = Raid("orc_main_fortress.balrog", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 0,
	targetChancePerDay = 33,
	maxChancePerCheck = 100,
	minGapBetween = "48h",
})

raid:addBroadcast("Something is making the ground beneath Orc Main Fortress tremble.", WEBHOOK_COLOR_RAID, "Incoming Boss!"):autoAdvance("10m")
raid:addBroadcast("The Balrog has risen from the depths of hell.", WEBHOOK_COLOR_RAID, "Incoming Boss!"):autoAdvance("5s")

raid
	:addSpawnMonsters({
		{
			name = "Demon",
			amount = 7,
		},
		{
			name = "Balrog",
			amount = 1,
		},
	})
	:autoAdvance("12h")

raid:register()
