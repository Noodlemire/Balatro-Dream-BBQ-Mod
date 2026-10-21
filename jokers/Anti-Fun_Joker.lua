--[[
Anti-Fun Joker
Legendary, $20

When Blind is selected: Loses X0.01 Mult for each Enhanced card in full deck
(Currently X1 Mult)
When Blind is defeated, transforms into Mean Joker
(Challenge-Only)
--]]

local key = "antifun"
DBBQ.quip_colours[key] = {HEX("22665a"), HEX("99bccb"), HEX("7d3305")}
DBBQ.quip_pitch[key] = 1.6
DBBQ.quip_pitch[key.."_uh"] = 0.8
DBBQ.add_quip(key, "deplorable", "any", 12)
DBBQ.add_quip(key, "sick", "loss", 8)
DBBQ.add_quip(key, "morons", "win", 28)
DBBQ.add_quip(key, "uh", "loss", 20, 0.05)
DBBQ.add_quip(key, "schedule", "win", 26)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 4,
	cost = 20,
	pos = {x = 6, y = 4},
	soul_pos = {x = 5, y = 4},
	blueprint_compat = true,
	discovered = true,
	pronouns = "she_her",
	config = {extra = {mult_gain = 0.01}},
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
			G.GAME.j_dbbq_antifun_scalar = 0
			for _, card in ipairs(G.playing_cards) do
				if next(SMODS.get_enhancements(card)) then
					G.GAME.j_dbbq_antifun_scalar = G.GAME.j_dbbq_antifun_scalar + 1
				end
			end
			G.GAME.j_dbbq_antifun_scalar = G.GAME.j_dbbq_antifun_scalar * joker.ability.extra.mult_gain
			if G.GAME.j_dbbq_antifun_scalar ~= 0 then
				SMODS.scale_card(joker, {
					ref_table = G.GAME,
					ref_value = "j_dbbq_antifun_mult",
					scalar_value = "j_dbbq_antifun_scalar",
					operation = '-',
					no_message = true
				})
				return {
					message = G.GAME.j_dbbq_antifun_mult..' '..localize("k_mult"),
					colour = G.C.RED
				}
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
