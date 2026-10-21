--[[
Mead
Luxury, $8

Randomize the ranks and suits
of all cards held in hand
--]]

DBBQ.Luxury{
	key = "mead",
	soul_pos = {x = 2, y = 0},
	luxury_can_use = function(self, item)
		return #G.hand.cards > 0
	end,
	luxury_use = function(self, item, area)
		for i, card in ipairs(G.hand.cards) do
			local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					card:flip()
					play_sound("card1", percent)
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for i, card in ipairs(G.hand.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					local suit = pseudorandom_element(SMODS.Suits, pseudoseed("c_dbbq_mead")).key
					local rank = pseudorandom_element(SMODS.Ranks, pseudoseed("c_dbbq_mead")).key
					SMODS.change_base(card, suit, rank)
					return true
				end
			}))
		end
		for i, card in ipairs(G.hand.cards) do
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					card:flip()
					play_sound("tarot2", percent, 0.6)
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.5)
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}
