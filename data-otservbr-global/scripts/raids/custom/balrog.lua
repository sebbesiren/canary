local zone = Zone("orc_main_fortress.balrog")
zone:addArea(Position(5968, 5967, 6), Position(5974, 5972, 6))

local raid = Raid("orc_main_fortress.balrog", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 0,
	initialChance = 2,
	targetChancePerDay = 33,
	maxChancePerCheck = 50,
	maxChecksPerDay = 10,
	minGapBetween = "48h",
})

raid:addBroadcast("Something is making the ground beneath Orc Main Fortress tremble."):autoAdvance("10m")
raid:addBroadcast("The Balrog has risen from the depths of hell."):autoAdvance("5s")

raid:addSpawnMonsters({
	{
		name = "Demon",
		amount = 7,
	},
	{
		name = "Balrog",
		amount = 1,
	},
})

raid:register()