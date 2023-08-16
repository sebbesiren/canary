local mType = Game.createMonsterType("Death Paladin")
local monster = {}

monster.name = "Death Paladin"
monster.description = "a death paladin"
monster.outfit = {
	lookType = 1071,
	lookHead = 57,
	lookBody = 94,
	lookLegs = 57,
	lookFeet = 132,
	lookAddons = 2,
	lookMount = 0
}

monster.raceId = 4004
monster.Bestiary = {
	class = "Undead",
	race = BESTY_RACE_UNDEAD,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Death fortress"
}

monster.health = 14000
monster.maxHealth = monster.health
monster.experience = monster.health * 1.7
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
	targetDistance = 1,
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
	{ name = "gold token", chance = 1000 },
	{ name = "silver token", chance = 1000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -1250 },
	{ name = "combat", interval = 2000, chance = 50, type = COMBAT_PHYSICALDAMAGE, minDamage = -500, maxDamage = -650, range = 5, shootEffect = CONST_ANI_ROYALSPEAR, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -250, maxDamage = -600, range = 5, shootEffect = CONST_ANI_BOLT, target = true },
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_ENERGYDAMAGE, minDamage = -400, maxDamage = -500, range = 7, radius = 2, shootEffect = CONST_ANI_POWERBOLT, effect = CONST_ME_ENERGYHIT, target = true },
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_ENERGYDAMAGE, minDamage = -300, maxDamage = -400, length = 5, spread = 3, effect = CONST_ME_PURPLEENERGY, target = false },
	{ name = "Shotgun", interval = 2000, chance = 10, minDamage = -450, maxDamage = -600, target = false },
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
