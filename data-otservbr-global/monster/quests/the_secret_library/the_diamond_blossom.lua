local mType = Game.createMonsterType("The Diamond Blossom")
local monster = {}

monster.description = "The Diamond Blossom"
monster.experience = 20000 * 4
monster.outfit = {
	lookType = 1068,
	lookHead = 9,
	lookBody = 0,
	lookLegs = 86,
	lookFeet = 79,
	lookAddons = 3,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 1598,
	bossRace = RARITY_ARCHFOE,
}

monster.health = 20000
monster.maxHealth = 20000
monster.race = "undead"
monster.corpse = 28802
monster.speed = 175
monster.manaCost = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8,
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{ name = "crystal coin", chance = 7380, maxCount = 1 },
	{ id = 3035, chance = 100000, maxCount = 8 }, -- platinum coin
	{ id = 6558, chance = 19790 }, -- flask of demonic blood
	{ id = 239, chance = 21030, maxCount = 2 }, -- great health potion
	{ id = 3028, chance = 11900, maxCount = 2 }, -- small diamond
	{ id = 3032, chance = 16000, maxCount = 2 }, -- small emerald
	{ id = 3029, chance = 10970, maxCount = 2 }, -- small sapphire
	{ id = 3030, chance = 8000, maxCount = 2 }, -- small ruby
	{ id = 9057, chance = 8510, maxCount = 2 }, -- small topaz
	{ id = 3041, chance = 1160 }, -- blue gem
	{ id = 6499, chance = 15280 }, -- demonic essence
	{ id = 21974, chance = 12080 }, -- golden lotus brooch
	{ id = 21981, chance = 920 }, -- oriental shoes
	{ id = 21975, chance = 10510 }, -- peacock feather fan
	{ id = 3017, chance = 9640 }, -- silver brooch
	{ id = 5944, chance = 18670 }, -- soul orb
	{ id = 8074, chance = 940 }, -- spellbook of mind control
	{ name = "small enchanted sapphire", chance = 9640, maxCount = 3 },
	{ id = 3567, chance = 1540 }, -- blue robe
	{ name = "royal star", chance = 4000, maxCount = 3 },
	{ id = 7368, chance = 9640, maxCount = 5 }, -- assassin star
	{ id = 3403, chance = 3590 }, -- tribal mask
	{ id = 9058, chance = 2380 }, -- gold ingot
	{ id = 3027, chance = 10360, maxCount = 2 }, -- black pearl
	{ id = 3037, chance = 4510 }, -- yellow gem
	{ id = 3026, chance = 8620, maxCount = 2 }, -- white pearl
	{ name = "northwind rod", chance = 3180 },
	{ id = 3054, chance = 2260 }, -- silver amulet
	{ id = 7404, chance = 730 }, -- assassin dagger
	{ id = 8061, chance = 730 }, -- skullcracker armor
	{ id = 3067, chance = 1030 }, -- hailstorm rod
	{ id = 3007, chance = 820 }, -- crystal ring
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1000, condition = { type = CONDITION_FREEZING, totalDamage = 400, interval = 4000 } },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_MANADRAIN, minDamage = 0, maxDamage = -500, range = 7, target = false },
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_ICEDAMAGE, minDamage = -550, maxDamage = -1500, length = 8, spread = 3, effect = CONST_ME_ICETORNADO, target = false },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_LIFEDRAIN, minDamage = -100, maxDamage = -600, length = 8, spread = 3, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = -100, radius = 1, effect = CONST_ME_MAGIC_RED, target = true, duration = 30000 },
}

monster.defenses = {
	defense = 55,
	armor = 72,
	mitigation = 2.11,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 50, maxDamage = 100, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 2000, chance = 15, speedChange = 320, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 50 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
