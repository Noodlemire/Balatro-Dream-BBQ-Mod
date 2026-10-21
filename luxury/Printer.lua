--[[
Printer
Luxury, $8

Create 2 copies
of selected card
--]]

DBBQ.Luxury{
	key = "printer",
	soul_pos = {x = 3, y = 1},
	config = {extra = {cards = 2, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		return #G.hand.highlighted == 1
	end,
	luxury_use = function(self, item, area)
		local selection = G.hand.highlighted[1]
		if not selection then return end
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = 1, item.ability.extra.cards do
					SMODS.copy_card(selection)
				end
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}
