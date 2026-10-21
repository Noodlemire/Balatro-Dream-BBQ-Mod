--[[
Jodhpurs
Luxury, $8

+2 hand size,
-1 hand each round
--]]

DBBQ.Luxury{
	key = "jodhpurs",
	soul_pos = {x = 2, y = 3},
	config = {extra = {size = 2, hand = -1, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.size, item.ability.extra.hand}}
	end,
	luxury_can_use = function(self, item)
		return G.GAME.round_resets.hands > 1 and G.GAME.current_round.hands_left > 1
	end,
	luxury_use = function(self, item, area)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.hands = G.GAME.round_resets.hands + item.ability.extra.hand
				ease_hands_played(item.ability.extra.hand)
				G.hand:change_size(item.ability.extra.size)
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.ante_end and G.GAME.round_resets.hands > 1
	end,
	luxury_start_juice = function(self, item)
		juice_card_until(item, function(item)
			return not item.ability.extra.used
		end, true)
	end
}
