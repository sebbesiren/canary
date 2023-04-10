local mType = Game.createMonsterType("Death Necromancer")
local monster = {}

monster.description = "a death necromancer"

monster.outfit = {
	lookType = 1071,
	lookHead = 76,
	lookBody = 18,
	lookLegs = 132,
	lookFeet = 41,
	lookAddons = 0,
	lookMount = 0
}

monster.raceId = 1647
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Falcon Bastion."
}

monster.health = 8000
monster.maxHealth = monster.health
monster.experience = monster.health * 1.3

monster.race = "blood"
monster.corpse = 28861
monster.speed = 110
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Uuunngh!", yell = false }
}

monster.loot = {
	{ name = "platinum coin", chance = 90000, maxCount = 5 },
	{ name = "small diamond", chance = 41000, maxCount = 2 },
	{ name = "great spirit potion", chance = 41000, maxCount = 2 },
	{ name = "small emerald", chance = 40000, maxCount = 2 },
	{ name = "small amethyst", chance = 40000, maxCount = 3 },
	{ name = "assassin star", chance = 25700, maxCount = 10 },
	{ name = "small ruby", chance = 20700, maxCount = 2 },
	{ name = "small topaz", chance = 20100, maxCount = 2 },
	{ name = "onyx arrow", chance = 14000, maxCount = 15 },
	{ id = 3039, chance = 7500, maxCount = 3 }, -- red gem
	{ name = "green gem", chance = 4880 },
	{ name = "violet gem", chance = 4180 },
	{ id = 282, chance = 2260 }, -- giant shimmering pearl (brown)
	{ name = "damaged armor plates", chance = 1120 },
	{ name = "falcon crest", chance = 730 },
	{ name = "golden armor", chance = 310 },
	{ name = "mastermind shield", chance = 310 },
	{ name = "cluster of solace", chance = 400 },
	{ name = "gold token", chance = 100 },
	{ name = "silver token", chance = 100 },
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_DEATHDAMAGE, minDamage = -500, maxDamage = -1000, range = 5, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_SMALLCLOUDS, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -300, maxDamage = -500, length = 5, spread = 3, effect = CONST_ME_MORTAREA, target = false },
	{ name = "Death Necromancer Summon", interval = 2000, chance = 5, minDamage = -300, maxDamage = -600, target = false },
}

monster.defenses = {
	defense = 50,
	armor = 82
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 }
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType:register(monster)
