--[[
Spigot
Luxury, $8

Fill joker slots with non-Common jokers,
then add Eternal to one compatible joker
(Must have room for at least 1 joker)
--]]

local function eternal_compat_filter(pool)
	local nothing = true
	for _, v in ipairs(pool) do
		if not G.P_CENTERS[v.key] or not G.P_CENTERS[v.key].eternal_compat then
			v.key = "UNAVAILABLE"
		else
			nothing = false
		end
	end
	if nothing then table.insert(pool, {key = "j_joker", type = "Joker"}) end
	return pool
end

DBBQ.Luxury{
	key = "spigot",
	soul_pos = {x = 2, y = 4},
	config = {extra = {room = 1, used = false}},
	loc_vars = function(self, info_queue, item)
		info_queue[#info_queue+1] = {key = "eternal", set = "Other"}
		return {vars = {item.ability.extra.room}}
	end,
	luxury_can_use = function(self, item)
		return G.jokers.config.card_limit - #G.jokers.cards >= item.ability.extra.room
	end,
	luxury_use = function(self, item, area)
		local compat = {}
		local room = G.jokers.config.card_limit - #G.jokers.cards
		local rarities = {}
		for key, def in pairs(SMODS.Rarities) do
			if key ~= "Common" and (def.default_weight or 0) > 0 then
				table.insert(rarities, key)
			end
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, room do
					local joker = SMODS.poll_object({
						type = "Joker",
						rarities = rarities,
						seed = "c_dbbq_spigot_jokers",
						filter = i == room and #compat == 0 and eternal_compat_filter
					})
					if joker then
						joker = SMODS.add_card({key = joker})
						if joker.config.center.eternal_compat then
							table.insert(compat, joker)
						end
					end
				end
				local eternal = pseudorandom_element(compat, "c_dbbq_spigot_eternal")
				if eternal then
					eternal:set_eternal(true)
				end
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.ante_end
	end,
	luxury_start_juice = function(self, item)
		juice_card_until(item, function(item)
			return not item.ability.extra.used
		end, true)
	end
}
