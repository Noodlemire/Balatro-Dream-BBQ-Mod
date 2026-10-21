--[[
Head Chaffeur
Uncommon, $6

When Hand is played:
Gain one of +5 Chips, +1 Mult,
or X0.05 Mult at random
(Currently +0 Chips, +0 Mult, X1 Mult)
--]]

local key = "head"
DBBQ.quip_function[key] = function(self, times)
	if self.key == "dbbq_"..key.."_work" or self.key == "dbbq_"..key.."_party" then
		if times == 5 then
			play_sound("dbbq_censored", 1, 0.6)
		elseif times > 5 then
			play_sound("voice"..math.random(1, 11), 0.7)
		end
	elseif self.key == "dbbq_"..key.."_doom" or self.key == "dbbq_"..key.."_awaiting" then
		play_sound("voice"..math.random(1, 11), 0.3)
	else
		play_sound("voice"..math.random(1, 11), 0.9)
	end
end
DBBQ.quip_colours[key] = {HEX("ecd1a6"), HEX("5c4942"), HEX("304088")}
DBBQ.quip_pitch[key] = 0.85
DBBQ.add_quip(key, "work", "win", 53)
DBBQ.add_quip(key, "party", "any", 12)
DBBQ.add_quip(key, "doom", "win", 27, 0.2)
DBBQ.add_quip(key, "awaiting", "loss", 12, 0.2)
DBBQ.add_quip(key, "ride", "win", 14)
DBBQ.add_quip(key, "awful", "loss", 5)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 1, y = 1},
	blueprint_compat = true,
	pronouns = "he_they",
    config = {extra = {chips_gain = 5, mult_gain = 1, Xmult_gain = 0.05, chips = 0, mult = 0, Xmult = 1}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_head", set = "Other"}
		end
        return {vars = {
			card.ability.extra.chips_gain,
			card.ability.extra.mult_gain,
			card.ability.extra.Xmult_gain,
			card.ability.extra.chips,
			card.ability.extra.mult,
			card.ability.extra.Xmult
		}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.Xmult
			}
		elseif context.before and context.main_eval and not context.blueprint then
			local gain = pseudorandom_element({"chips", "mult", "Xmult"}, pseudoseed("taxi"))
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = gain,
				scalar_value = gain.."_gain",
				scaling_message = {message = gain}
			})
		end
	end,
	joker_display_def = function(jd)
		return {
			extra = {
				{{border_nodes = {{text = "X"}, {ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp"}}}},
				{{text = "+", colour = G.C.MULT}, {ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT}},
				{{text = "+", colour = G.C.CHIPS}, {ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS}},
			},
			extra_config = {
				scale = 0.35
			},
			calc_function = function(card)
				card.joker_display_values.xmult = card.ability.extra.Xmult
				card.joker_display_values.mult = card.ability.extra.mult
				card.joker_display_values.chips = card.ability.extra.chips
			end
		}
	end
}
