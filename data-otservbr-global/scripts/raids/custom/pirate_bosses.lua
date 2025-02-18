local zone = Zone("liberty_bay.pirate-bosses")
zone:addArea(Position (32303, 32826, 7), Position(32341, 32852, 7))

local raid = Raid("liberty_bay.pirate-bosses", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 0,
	targetChancePerDay = 33,
	maxChancePerCheck = 100,
	minGapBetween = "48h",
})

raid:addBroadcast("Pirates are launching a surprise attack on Liberty Bay! Take care, they seem to be everywhere."):autoAdvance("10s")
raid:addBroadcast("Pirates have invaded the fortress."):autoAdvance("5s")

local bosses = { "Ron the Ripper", "Lethal Lissy", "Brutus Bloodbeard", "Deadeye Devious" }

raid
	:addSpawnMonsters({
		{
			name = "Pirate Corsair",
			amount = 15,
		},
		{
			name = "Pirate Buccaneer",
			amount = 15,
		},
		{
			name = "Pirate Cutthroat",
			amount = 15,
		},
		{
			name = "Pirate Marauder",
			amount = 15,
		},
		{
			name = "Smuggler",
			amount = 15,
		},
		{
			name = bosses[math.random(#bosses)],
			amount = 1,
		},
	})
	:autoAdvance("12h")

raid:register()
