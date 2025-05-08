local mType = Game.createMonsterType("Loot Goblin")
local monster = {}

local LootGoblinConfig = {
	Storage = {
		SpawnTime = 1,
	},
	SecondsToDefeat = 120,
}

monster.description = "a loot goblin"
monster.experience = 25
monster.outfit = {
	lookType = 61,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

--monster.bosstiary = {
--	bossRaceId = 5003,
--	bossRace = RARITY_ARCHFOE,
--}

monster.health = 30000
monster.maxHealth = 30000
monster.race = "blood"
monster.corpse = 6002
monster.speed = 250
monster.manaCost = 290

monster.changeTarget = {
	interval = 5000,
	chance = 0,
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
	runHealth = 29000,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 5,
	color = 197,
}

monster.voices = {
	interval = 2000,
	chance = 30,
	{ text = "There is no cow level...", yell = true },
	{ text = "Hi, I am one of the 30-40 monsters on your screen.", yell = true },
	{ text = "My precious!", yell = true },
	{ text = "Help! Goblinkiller!", yell = true },
}

monster.loot = {
	{ name = "crystal coin", chance = 50000, maxCount = 40 },
	{ name = "silver token", chance = 20000, maxCount = 10 },
	{ name = "bullseye potion", chance = 24490, maxCount = 5 },
	{ name = "berserk potion", chance = 22449, maxCount = 5 },
	{ name = "mastermind potion", chance = 18367, maxCount = 5 },
	{ name = "raw watermelon tourmaline", chance = 7322, maxCount = 3 },
	{ id = 22772, chance = 30, maxCount = 1 }, -- exp boost scroll

	{ name = "winged boots", chance = 35 },
	{ name = "tagralt blade", chance = 35 },
	{ id = 30403, chance = 35 }, -- enchanted theurgic amulet

	{ name = "falcon battleaxe", chance = 35 },
	{ name = "falcon longsword", chance = 35 },
	{ name = "falcon mace", chance = 35 },
	{ name = "grant of arms", chance = 35 },
	{ name = "falcon bow", chance = 35 },
	{ name = "falcon circlet", chance = 35 },
	{ name = "falcon coif", chance = 35 },
	{ name = "falcon rod", chance = 35 },
	{ name = "falcon wand", chance = 35 },
	{ name = "falcon shield", chance = 35 },
	{ name = "falcon greaves", chance = 35 },
	{ name = "falcon plate", chance = 35 },

	{ name = "dawnfire sherwani", chance = 35 },
	{ name = "frostflower boots", chance = 35 },
	{ name = "feverbloom boots", chance = 35 },
	{ id = 39233, chance = 35 }, -- enchanted turtle amulet
	{ name = "midnight tunic", chance = 35 },
	{ name = "midnight sarong", chance = 35 },
	{ name = "naga quiver", chance = 35 },
	{ name = "naga sword", chance = 35 },
	{ name = "naga axe", chance = 35 },
	{ name = "naga club", chance = 35 },
	{ name = "naga wand", chance = 35 },
	{ name = "naga rod", chance = 35 },
	{ name = "naga crossbow", chance = 35 },

	{ id = 32616, chance = 35 }, -- phantasmal axe
	{ name = "ghost chestplate", chance = 35 },
	{ name = "fabulous legs", chance = 35 },
	{ name = "soulful legs", chance = 35 },
	{ name = "galea mortis", chance = 35 },
	{ name = "toga mortis", chance = 35 },
	{ name = "gnome shield", chance = 35 },
	{ name = "gnome armor", chance = 35 },
	{ name = "gnome helmet", chance = 35 },
	{ name = "gnome sword", chance = 35 },

	{ name = "unerring dragon scale armor", chance = 35 },
	{ name = "dauntless dragon scale armor", chance = 35 },
	{ name = "arcane dragon robe", chance = 35 },
	{ name = "mystical dragon robe", chance = 35 },

	{ name = "amber crusher", chance = 100 },
	{ id = 47375, chance = 35 }, -- amber axe
	{ id = 47369, chance = 35 }, -- amber greataxe
	{ id = 47368, chance = 35 }, -- amber slayer
	{ id = 47374, chance = 35 }, -- amber sabre
	{ id = 47376, chance = 35 }, -- amber cudgel
	{ id = 47370, chance = 35 }, -- amber bludgeon
	{ id = 47371, chance = 35 }, -- amber bow
	{ id = 47377, chance = 35 }, -- amber crossbow
	{ id = 47372, chance = 35 }, -- amber wand
	{ id = 47373, chance = 35 }, -- amber rod
	{ id = 48514, chance = 35 }, -- strange inedible fruit

	{ name = "eldritch breeches", chance = 35 },
	{ name = "eldritch cowl", chance = 35 },
	{ name = "eldritch hood", chance = 35 },
	{ name = "eldritch bow", chance = 35 },
	{ name = "eldritch quiver", chance = 35 },
	{ name = "eldritch claymore", chance = 35 },
	{ name = "eldritch greataxe", chance = 35 },
	{ name = "eldritch warmace", chance = 35 },
	{ name = "eldritch shield", chance = 35 },
	{ name = "eldritch cuirass", chance = 35 },
	{ name = "eldritch folio", chance = 35 },
	{ name = "eldritch tome", chance = 35 },
	{ name = "eldritch rod", chance = 35 },
	{ name = "eldritch wand", chance = 35 },
	{ name = "gilded eldritch claymore", chance = 35 },
	{ name = "gilded eldritch greataxe", chance = 35 },
	{ name = "gilded eldritch warmace", chance = 35 },
	{ name = "gilded eldritch wand", chance = 35 },
	{ name = "gilded eldritch rod", chance = 35 },
	{ name = "gilded eldritch bow", chance = 35 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -600 },
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -600, range = 7, shootEffect = CONST_ANI_SMALLSTONE, target = false },
}

monster.defenses = {
	defense = 90,
	armor = 90,
	mitigation = 2.51,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = -20 },
	{ type = COMBAT_LIFEDRAIN, percent = -20 },
	{ type = COMBAT_MANADRAIN, percent = -20 },
	{ type = COMBAT_DROWNDAMAGE, percent = -20 },
	{ type = COMBAT_ICEDAMAGE, percent = -20 },
	{ type = COMBAT_HOLYDAMAGE, percent = -20 },
	{ type = COMBAT_DEATHDAMAGE, percent = -20 },
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = false },
	{ type = "bleed", condition = false },
}

mType.onSpawn = function(monster, spawnPosition)
	monster:setStorageValue(LootGoblinConfig.Storage.SpawnTime, os.time())
	monster:say("You have " .. LootGoblinConfig.SecondsToDefeat .. " seconds to kill the loot goblin.", TALKTYPE_MONSTER_SAY)
end
mType.onThink = function(monster, interval)
	if os.time() > monster:getStorageValue(LootGoblinConfig.Storage.SpawnTime) + LootGoblinConfig.SecondsToDefeat then
		if monster:getId() then
			monster:remove()
		end
	end
end

mType:register(monster)
