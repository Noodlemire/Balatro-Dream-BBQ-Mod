--[[
Pencil
Luxury, $8

Select 3 cards, and convert
the left cards into the
rank of the rightmost card
--]]

DBBQ.Luxury{
	key = "pencil",
	soul_pos = {x = 1, y = 0},
	config = {extra = {cards = 3, used = false}},
	dbbq_sort_selected = true,
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		return #G.hand.highlighted == math.floor(item.ability.extra.cards) and G.hand.highlighted[#G.hand.highlighted] and not SMODS.has_no_rank(G.hand.highlighted[#G.hand.highlighted])
	end,
	luxury_use = function(self, item, area)
		local rightmost = G.hand.highlighted[#G.hand.highlighted]
		if not rightmost then return end
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
		for i = 1, #G.hand.highlighted-1 do
			local card = G.hand.highlighted[i]
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					SMODS.change_base(card, nil, rightmost.base.value)
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
