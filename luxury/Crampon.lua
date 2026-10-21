--[[
Crampon
Luxury, $8

Draw 5 cards
--]]

DBBQ.Luxury{
	key = "crampon",
	soul_pos = {x = 4, y = 0},
	config = {extra = {cards = 5, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		return G.hand and #G.hand.cards > 0 and G.deck and #G.deck.cards > 0
	end,
	luxury_use = function(self, item, area)
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, item.ability.extra.cards do
					draw_card(G.deck, G.hand, 90, "up")
				end
				return true
			end
		}))
	end,
}
