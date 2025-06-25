--[[
Sales Joker
Legendary, $20

All played cards become Mult cards when scored
When Blind is defeated, transforms into Mean Joker
--]]

SMODS.Joker{
	key = "sales",
	loc_txt = {
		name = "Sales Joker",
		text = {
			"All played cards become",
			"{C:attention}Mult{} cards when scored",
			"When Blind is defeated,",
			"transforms into {C:inactive}Mean Joker{}"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 4,
	cost = 20,
	pos = {x = 2, y = 3},
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_sales", set = "Other"}
		end
		info_queue[#info_queue + 1] = {key = "j_dbbq_mean_dummy", set = "Other"}
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			for k, v in ipairs(context.scoring_hand) do
				v:set_ability("m_mult", nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
						return true
					end
				}))
			end
			return {
				message = localize('k_mult'),
				colour = G.C.MULT
			}
		elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					card:flip()
					play_sound('card1', percent)
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					card:set_ability("j_dbbq_mean")
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					card:flip()
					play_sound('tarot2', percent, 0.6)
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
	end,
    in_pool = function(self, args)
		return #SMODS.find_card("j_dbbq_mean") == 0
    end
}
