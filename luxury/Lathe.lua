--[[
Lathe
Luxury, $8

Decrease the rank of up
to 3 selected cards by 1
--]]

DBBQ.Luxury{
	key = "lathe",
	soul_pos = {x = 4, y = 2},
	config = {extra = {change = 1, cards = 3, used = false}},
	dbbq_sort_selected = true,
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.change, item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		return #G.hand.highlighted > 0 and #G.hand.highlighted <= item.ability.extra.cards
	end,
	luxury_use = function(self, item, area)
		if #G.hand.highlighted == 0 then return end
		for i, card in ipairs(G.hand.highlighted) do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
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
		for i, card in ipairs(G.hand.highlighted) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					SMODS.modify_rank(card, -item.ability.extra.change)
					return true
				end
			}))
		end
		for i, card in ipairs(G.hand.highlighted) do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
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
