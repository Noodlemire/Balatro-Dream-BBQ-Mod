--[[
Leek
Luxury, $8

Destroy selected card, and
all cards in your full deck
with the same rank and suit
--]]

DBBQ.Luxury{
	key = "leek",
	soul_pos = {x = 0, y = 3},
	luxury_can_use = function(self, item)
		return #G.hand.highlighted == 1
	end,
	luxury_use = function(self, item, area)
		local selection = G.hand.highlighted[1]
		if not selection then return end
		local rank = not SMODS.has_no_rank(selection) and selection:get_id()
		local suit = not SMODS.has_no_suit(selection) and selection.base.suit
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, card in ipairs(G.playing_cards) do
					if (not rank and SMODS.has_no_rank(card) or card:get_id() == rank) and (not suit and SMODS.has_no_suit(card) or card:is_suit(suit, false, true)) then
						card:start_dissolve()
					end
				end
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}
