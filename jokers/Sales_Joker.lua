--[[
Sales Joker
Legendary, $20

All played cards become Mult cards when scored
When Blind is defeated, transforms into Mean Joker
--]]

SMODS.Joker{
	key = "sales",
	atlas = "dbbq_jokers",
	rarity = 4,
	cost = 20,
	pos = {x = 2, y = 3},
	soul_pos = {x = 5, y = 3},
	blueprint_compat = false,
	config = {extra = {dbbq_quotes = {
		{type = "lose", key = "j_dbbq_sales_loop"},
		{type = "win", key = "j_dbbq_sales_ambush"},
		{type = "win", key = "j_dbbq_sales_doable"},
		{type = "lose", key = "j_dbbq_sales_child"},
		{type = "win", key = "j_dbbq_sales_bless"},
		{type = "lose", key = "j_dbbq_sales_personally"},
	}}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_sales", set = "Other"}
		end
		info_queue[#info_queue + 1] = {key = "j_dbbq_mean_dummy", set = "Other"}
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
	end,
	calculate = function(self, joker, context)
		if context.before and context.main_eval and not context.blueprint then
			local any = false
			for k, v in ipairs(context.scoring_hand) do
				if not v.debuff then
					any = true
					v:set_ability("m_mult", nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					}))
				end
			end
			if any then
				return {
					message = localize('k_mult'),
					colour = G.C.MULT
				}
			end
		elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					joker:flip()
					play_sound('card1', 0.85)
					joker:juice_up(0.3, 0.3)
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					joker:set_ability("j_dbbq_mean")
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					joker:flip()
					play_sound('tarot2', 0.85, 0.6)
					joker:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
	end,
	in_pool = function(self, args)
		return #SMODS.find_card("j_dbbq_mean") == 0 and #SMODS.find_card("j_dbbq_antifun") == 0
	end
}
