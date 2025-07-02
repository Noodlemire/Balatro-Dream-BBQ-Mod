--[[
Mean Joker
Legendary, $20

All unenhanced cards are destroyed after being played and scored
When Blind is defeated, transforms into Sales Joker
--]]

SMODS.Joker{
	key = "mean",
	loc_txt = {
		name = "Mean Joker",
		text = {
			"All unenhanced cards",
			"are destroyed after",
			"being played and scored",
			"When Blind is defeated,",
			"transforms into {C:mult}Sales Joker{}"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 4,
	cost = 20,
	pos = {x = 3, y = 2},
	blueprint_compat = false,
	config = {extra = {dbbq_quotes = {
		{type = "lose", key = "j_dbbq_mean_boss"},
		{type = "win", key = "j_dbbq_mean_hogwash"},
		{type = "lose", key = "j_dbbq_mean_fraud"},
		{type = "lose", key = "j_dbbq_mean_sympathy"},
		{type = "win", key = "j_dbbq_mean_prices"},
		{type = "lose", key = "j_dbbq_mean_bullshit"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_mean", set = "Other"}
		end
		info_queue[#info_queue + 1] = {key = "j_dbbq_sales_dummy", set = "Other"}
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
	end,
	calculate = function(self, card, context)
		if context.destroy_card and not context.blueprint and not next(SMODS.get_enhancements(context.destroy_card)) and not context.destroy_card.debuff then
			local found = false
			for k, v in ipairs(context.scoring_hand) do
				if context.destroy_card == v then
					found = true
					break
				end
			end
			if found then
				return {
					remove = true
				}
			end
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
					card:set_ability("j_dbbq_sales")
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
        return false
    end
}
