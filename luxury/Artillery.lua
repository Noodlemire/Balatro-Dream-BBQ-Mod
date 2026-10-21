--[[
Artillery
Luxury, $8

Destroy 5 random cards
from your full deck
--]]

DBBQ.Luxury{
	key = "artillery",
	soul_pos = {x = 4, y = 3},
	config = {extra = {cards = 5, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		return #G.playing_cards > 0
	end,
	luxury_use = function(self, item, area)
		local cards = {}
		for _, card in ipairs(G.playing_cards) do
			table.insert(cards, card)
		end
		table.sort(cards, function(a, b)
			return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
		end)
		pseudoshuffle(cards, pseudoseed("c_dbbq_artillery"))
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, item.ability.extra.cards do
					cards[i]:start_dissolve()
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
