local zone = Zone("liberty_bay.pirate-bosses")
zone:addArea(Position(32176, 32769, 7), Position(32255, 32847, 7))

raid:addBroadcast("Pirates are launching a surprise attack on Liberty Bay! Take care, they seem to be everywhere."):autoAdvance("10m")
raid:addBroadcast("Pirates have invaded the fortress.")

local raid = Raid("thais.pirate-bosses", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 0,
	initialChance = 5,
	targetChancePerDay = 50,
	maxChancePerCheck = 50,
	maxChecksPerDay = 3,
	minGapBetween = "23h",
})

local bosses = { "Ron the Ripper", "Lethal Lissy", "Brutus Bloodbeard", "Deadeye Devious" }

raid
	:addSpawnMonsters({
	{
		name = "Pirate Corsair",
		amount = 40,
	},
	{
		name = "Pirate Buccaneer",
		amount = 50,
	},
	{
		name = "Pirate Cutthroat",
		amount = 50,
	},
	{
		name = "Pirate Marauder",
		amount = 50,
	},
	{
		name = "Smuggler",
		amount = 50,
	},
	{
		name = bosses[math.random(#bosses)],
		amount = 1
	}
})

raid:register()
