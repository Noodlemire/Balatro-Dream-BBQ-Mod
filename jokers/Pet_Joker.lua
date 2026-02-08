--[[
Pet? Joker
Common, $5

Sell to reduce the Boss Blind's chip requirement by 25%.
--]]

SMODS.Joker{
	key = "pet",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 0, y = 3},
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_pet", set = "Other"}
		end
    end,
	calculate = function(self, card, context)
		if context.selling_self and G.GAME.blind and G.GAME.blind.in_blind then
			G.GAME.blind.chips = math.max(math.floor(G.GAME.blind.chips * 0.75), 1)
    		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.GAME.blind:set_text()
			G.GAME.blind:wiggle()
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					if (to_big and to_big(G.GAME.chips - G.GAME.blind.chips) >= to_big(0)) or (not to_big and G.GAME.chips - G.GAME.blind.chips >= 0) then
						G.STATE = G.STATES.NEW_ROUND
						G.STATE_COMPLETE = false
					end
					return true
				end
			}))
		end
    end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "-"},
				{ref_table = "card.joker_display_values", ref_value = "deduction"}
			},
			reminder_text = {
				{ref_table = "card.joker_display_values", ref_value = "total"},
				{text = " Total"}
			},
			calc_function = function(card)
				if not G.GAME.blind or G.GAME.blind.chips == 0 then
					card.joker_display_values.deduction = 0
					card.joker_display_values.total = 0
				else
					card.joker_display_values.total = math.max(math.floor(G.GAME.blind.chips * 0.75), 1)
					card.joker_display_values.deduction = G.GAME.blind.chips - card.joker_display_values.total
				end
			end
		}
	end
}
