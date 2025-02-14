local playerLevelReward = CreatureEvent("PlayerLevelReward")

local rewardsByLevel = {
	[20] = {
		{ 3043, 1 }, -- crystal coin
	},
	[30] = {
		{ 3043, 1 }, -- crystal coin
	},
	[40] = {
		{ 3043, 1 }, -- crystal coin
	},
	[50] = {
		{ 3043, 2 }, -- crystal coin
	},
	[60] = {
		{ 3043, 2 }, -- crystal coin
	},
	[70] = {
		{ 3043, 2 }, -- crystal coin
	},
	[80] = {
		{ 3043, 2 }, -- crystal coin
	},
	[90] = {
		{ 3043, 2 }, -- crystal coin
	},
	[100] = {
		{ 3043, 2 }, -- crystal coin
	}
}

function playerLevelReward.onAdvance(player, skill, oldLevel, newLevel)
	if skill ~= SKILL_LEVEL then
		return
	end

	local playerLevelRewardsReceived = player:kv():get("player-level-rewards-received") or {}

	local levels = {}
	for level in pairs(rewardsByLevel) do
		table.insert(levels, level)
	end
	table.sort(levels)

	for _, level in ipairs(levels) do
		local rewards = rewardsByLevel[level]

		if newLevel < level then
			break
		end
		if table.contains(playerLevelRewardsReceived, level) then
			goto continue
		end

		player:sendTextMessage(
			MESSAGE_EVENT_ADVANCE,
			"Congratulations! \z
			You have reached level " .. level .. " and received a reward!"
		)

		local container = player:getSlotItem(CONST_SLOT_BACKPACK)

		if not container then
			goto continue
		end

		for _, reward in ipairs(rewards) do
			container:addItem(reward[1], reward[2])
		end

		table.insert(playerLevelRewardsReceived, level)

		:: continue ::
	end
	player:kv():set("player-level-rewards-received", playerLevelRewardsReceived)

end

playerLevelReward:register()
