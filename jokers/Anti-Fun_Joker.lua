--[[
Anti-Fun Joker
Legendary, $20

When Blind is selected: Loses X0.01 Mult for each Enhanced card in full deck
(Currently X1 Mult)
When Blind is defeated, transforms into Mean Joker
(Challenge-Only)
--]]

SMODS.Joker{
	key = "antifun",
	atlas = "dbbq_jokers",
	rarity = 4,
	cost = 20,
	pos = {x = 6, y = 4},
	soul_pos = {x = 5, y = 4},
	blueprint_compat = true,
	discovered = true,
	config = {extra = {mult_gain = 0.01, dbbq_quotes = {
		{type = "any", key = "j_dbbq_antifun_deplorable"},
		{type = "lose", key = "j_dbbq_antifun_sick"},
		{type = "win", key = "j_dbbq_antifun_morons"},
		{type = "lose", key = "j_dbbq_antifun_uh"},
		{type = "win", key = "j_dbbq_antifun_schedule"},
	}}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_antifun", set = "Other"}
		end
		info_queue[#info_queue + 1] = {key = "j_dbbq_mean_dummy2", set = "Other"}
		return {vars = {joker.ability.extra.mult_gain, G.GAME.j_dbbq_antifun_mult or 1}}
	end,
	add_to_deck = function(self, joker, from_debuff)
		G.GAME.j_dbbq_antifun_mult = G.GAME.j_dbbq_antifun_mult or 1
	end,
	calculate = function(self, joker, context)
		if context.joker_main then
			return {Xmult = G.GAME.j_dbbq_antifun_mult}
		elseif context.blueprint then
			return
		end
		if context.setting_blind then
			local total = 0
			for _, card in ipairs(G.playing_cards) do
				if next(SMODS.get_enhancements(card)) then
					total = total + 1
				end
			end
			total = total * -joker.ability.extra.mult_gain
			if total ~= 0 then
				G.GAME.j_dbbq_antifun_mult = G.GAME.j_dbbq_antifun_mult + total
				return {message = G.GAME.j_dbbq_antifun_mult..' '..localize("k_mult")}
			end
		elseif context.end_of_round and context.game_over == false and context.main_eval then
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
		return false
    end,
	joker_display_def = function(jd)
		return {
			text = {{border_nodes = {
				{text = "X"},
				{ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp"}
			}}},
			calc_function = function(card)
				card.joker_display_values.xmult = G.GAME.j_dbbq_antifun_mult or 1
			end
		}
	end
}
