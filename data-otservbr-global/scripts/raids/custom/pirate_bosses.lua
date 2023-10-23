local zone = Zone("liberty_bay.pirate-bosses")
zone:addArea(Position(32274, 32796, 7), Position(32316, 32873, 7))

local raid = Raid("liberty_bay.pirate-bosses", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 0,
	initialChance = 5,
	targetChancePerDay = 50,
	maxChancePerCheck = 50,
	maxChecksPerDay = 3,
	minGapBetween = "23h",
})

raid:addBroadcast("Pirates are launching a surprise attack on Liberty Bay! Take care, they seem to be everywhere."):autoAdvance("10m")
raid:addBroadcast("Pirates have invaded the fortress."):autoAdvance("5s")

local bosses = { "Ron the Ripper", "Lethal Lissy", "Brutus Bloodbeard", "Deadeye Devious" }

raid:addSpawnMonsters({
	{
		name = "Pirate Corsair",
		amount = 60,
	},
	{
		name = "Pirate Buccaneer",
		amount = 60,
	},
	{
		name = "Pirate Cutthroat",
		amount = 60,
	},
	{
		name = "Pirate Marauder",
		amount = 60,
	},
	{
		name = "Smuggler",
		amount = 60,
	},
	{
		name = bosses[math.random(#bosses)],
		amount = 1,
	},
})

raid:register()
