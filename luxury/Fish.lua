--[[
Fish
Luxury, $8

All cards held in hand become Bonus
Cards, then discard all but 1 card
--]]

DBBQ.Luxury{
	key = "fish",
	soul_pos = {x = 1, y = 4},
	luxury_can_use = function(self, item)
		return #G.hand.cards > 0
	end,
	luxury_use = function(self, item, area)
		local kept = pseudorandom_element(G.hand.cards, "c_dbbq_fish")
		if not kept then return end
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
					card:set_ability("m_bonus")
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
		for i, card in ipairs(G.hand.cards) do
			if card ~= kept then
				local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
				local func = function()
					draw_card(G.hand, G.discard, percent, "down", false, card)
					return true
				end
				if i == 1 then
					G.E_MANAGER:add_event(Event({
						func = func
					}))
				else
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.15,
						func = func
					}))
				end
			end
		end
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}
