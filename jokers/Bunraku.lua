--[[
Bunraku
Rare, $8

Gains X0.1 Mult every time a non-Bunraku
Joker is triggered while in a Blind
Half of Mult will be lost when one of your
played cards is first scored, at random
(Currently: X0 Mult)
--]]

local key = "bunraku"
DBBQ.quip_colours[key] = {HEX("31511f"), HEX("fa4111"), HEX("ffbe62")}
DBBQ.quip_pitch[key] = 1
DBBQ.add_quip(key, "haters", "any", 37)
DBBQ.add_quip(key, "harder", "win", 16)
DBBQ.add_quip(key, "comes", "win", 7)
DBBQ.add_quip(key, "bathroom", "loss", 21)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 5, y = 0},
	blueprint_compat = true,
	pronouns = "he_him",
	config = {extra = {Xmult_gain = 0.1, Xmult = 0}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_bunraku", set = "Other"}
		end
		return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {xmult = card.ability.extra.Xmult}
		elseif context.blueprint then
			return
		end
		if context.before and context.main_eval then
			local nondebuffed = {}
			for i, v in ipairs(context.scoring_hand) do
				if not v.debuff then
					nondebuffed[#nondebuffed+1] = i
				end
			end
			if #nondebuffed > 0 then
				card.ability.extra.reset = pseudorandom_element(nondebuffed, "Yeeeaaaahaha!!")
			end
		elseif context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[card.ability.extra.reset] then
			card.ability.extra.reset = nil
			card.ability.extra.Xmult = card.ability.extra.Xmult / 2
			return {
				message = localize("k_reset"),
				colour = G.C.RED,
				message_card = card
			}
		elseif context.post_trigger and G.GAME.blind.in_blind and context.other_card.config.center and context.other_card.config.center.key ~= "j_dbbq_bunraku" and not context.other_context.modify_scoring_hand then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xmult",
				scalar_value = "Xmult_gain"
			})
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {{
				border_nodes = {
					{text = "X"},
					{ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "exp"}
				}
			}},
			--text_config = {colour = G.C.MULT},
			calc_function = function(card)
				card.joker_display_values.mult = card.ability.extra.Xmult
			end
		}
	end
}
