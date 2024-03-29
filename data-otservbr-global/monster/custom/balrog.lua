local mType = Game.createMonsterType("Balrog")
local monster = {}

monster.name = "Balrog"
monster.description = "a Balrog"
monster.health = 325000
monster.maxHealth = monster.health

monster.bosstiary = {
	bossRaceId = 5000,
	bossRace = RARITY_ARCHFOE
}

monster.experience = monster.health * 12
monster.outfit = {
	lookType = 1468,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.race = "fire"
monster.corpse = 5995
monster.speed = 128
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 20,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
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
	staticAttackChance = 70,
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

monster.summon = {}

monster.voices = {
	interval = 10000,
	chance = 10,
	{ text = "MUST KILL TRANAN!", yell = false },
	{ text = "I SMELL TRANAN!", yell = false },
	{ text = "OFFER TRANAN TO ME NOW!", yell = false },
	{ text = "IT IS TRANJAKT!", yell = false },
}

monster.loot = {
	{ id = 3039, chance = 2220, maxCount = 20 }, -- red gem
	{ name = "crystal coin", chance = 100000, minCount = 10, maxCount = 30 },
	{ name = "golden legs", chance = 2000 },
	{ name = "magic plate armor", chance = 130 },
	{ name = "mastermind shield", chance = 480 },
	{ name = "demon shield", chance = 2000 },
	{ name = "fire mushroom", chance = 100000, maxCount = 100 },
	{ name = "demon horn", chance = 40920, maxCount = 10 },
	{ name = "demonrage sword", chance = 2500 },
	{ id = 32616, chance = 2500 }, -- phantasmal axe
	{ name = "ghost chestplate", chance = 2500 },
	{ name = "fabulous legs", chance = 2500 },
	{ name = "soulful legs", chance = 2500 },
	{ name = "galea mortis", chance = 2500 },
	{ name = "toga mortis", chance = 2500 },
	{ name = "gnome shield", chance = 2500 },
	{ name = "gnome armor", chance = 2500 },
	{ name = "gnome helmet", chance = 2500 },
	{ name = "gnome sword", chance = 2500 },
	{ id = 27649, chance = 2500 }, -- gnome legs
	{ id = 16114, chance = 10000 }, -- prismatic ring
	{ id = 20062, chance = 2000, maxCount = 14 }, -- cluster of solace
	{ id = 18339, chance = 5000 }, -- zaoan chess box
	{ name = "silver token", chance = 10000, maxCount = 20 },
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -0, maxDamage = -3000, range = 1, radius = 3, effect = CONST_ME_MAGIC_GREEN, target = true },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -100, maxDamage = -2000, range = 7, radius = 6, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = true },
	{ name = "combat", interval = 4000, chance = 35, type = COMBAT_ICEDAMAGE, minDamage = -900, maxDamage = -1100, range = 7, radius = 6, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true },
	{ name = "combat", interval = 1200, chance = 20, type = COMBAT_FIREDAMAGE, minDamage = -1000, maxDamage = -3000, length = 8, spread = 3, effect = CONST_ME_HITBYFIRE, target = false },
	{ name = "gaz'haragoth iceball", interval = 10000, chance = 100, minDamage = -1000, maxDamage = -1500, target = false },
	{ name = "gaz'haragoth death", interval = 60000, chance = 100, target = false },
	{ name = "gaz'haragoth paralyze", interval = 8000, chance = 100, target = false },
	{ name = "large mortar", interval = 3000, chance = 20 },
	{ name = "large mortar", interval = 3000, chance = 20 },
	{ name = "small mortar", interval = 3000, chance = 20 },
	{ name = "small mortar", interval = 3000, chance = 20 },
	{ name = "small mortar", interval = 3000, chance = 20 },
	{ name = "small mortar", interval = 3000, chance = 20 },
}

monster.defenses = {
	defense = 55,
	armor = 55,
	{ name = "combat", interval = 2000, chance = 15, type = COMBAT_HEALING, minDamage = 180, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 25 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 50 },
	{ type = COMBAT_EARTHDAMAGE, percent = 40 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -12 },
	{ type = COMBAT_HOLYDAMAGE, percent = -12 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
