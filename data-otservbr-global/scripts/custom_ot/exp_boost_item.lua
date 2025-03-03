local expscroll = Action()
-- Function to apply a 50% XP boost
local function applyXpBoost(player)
	local remainingTime = player:getXpBoostTime()
	if remainingTime and remainingTime > 0 then
		local minutes = math.floor(remainingTime / 60)
		local seconds = remainingTime % 60
		player:say("You already have an active 50% XP boost. Time left: " .. minutes .. " minutes and " .. seconds .. " seconds.", TALKTYPE_MONSTER_SAY)
		return false
	end

	local rewardCount = 60

	player:setXpBoostTime(rewardCount * 60)
	player:kv():set("daily-reward-xp-boost", rewardCount)
	player:setXpBoostPercent(50)
	player:say("Added XP Bonus for " .. rewardCount .. " minutes.", TALKTYPE_MONSTER_SAY)

	--player:sendTextMessage(
	--	MESSAGE_STATUS,
	--	"Added XP Bonus for " .. rewardCount .. " minutes."
	--)
	return true
end

-- Main function for using XP scroll
function expscroll.onUse(player, item, fromPosition, itemEx, toPosition)
	-- Apply the XP boost if no other boost is active
	if applyXpBoost(player) then
		item:remove(1) -- Remove the scroll after use
	end

	return true -- XP boost successfully applied
end

-- Register action for XP scroll
expscroll:id(22772)
expscroll:register()
