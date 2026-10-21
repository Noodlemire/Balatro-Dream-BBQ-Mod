--[[
Plimsol
Luxury, $8

+3 discards each round
-1 hand size
--]]

DBBQ.Luxury{
	key = "plimsol",
	soul_pos = {x = 2, y = 1},
	config = {extra = {disc = 3, size = -1, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.disc, item.ability.extra.size}}
	end,
	luxury_can_use = function(self, item)
		return G.hand.config.card_limit > 1
	end,
	luxury_use = function(self, item, area)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.discards = G.GAME.round_resets.discards + item.ability.extra.disc
				ease_discard(item.ability.extra.disc)
				G.hand:change_size(item.ability.extra.size)
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.ante_end and G.hand.config.card_limit > 1
	end,
	luxury_start_juice = function(self, item)
		juice_card_until(item, function(item)
			return not item.ability.extra.used
		end, true)
	end
}
