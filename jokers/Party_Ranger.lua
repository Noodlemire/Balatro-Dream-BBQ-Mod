--[[
Puppet Mascot
Uncommon, $6

Retrigger each scoring Wild Card
an additional 2 times.
--]]

local key = "party"
DBBQ.quip_colours[key] = {HEX("e7423a"), HEX("f0bfbf"), HEX("614641")}
DBBQ.quip_pitch[key] = 0.6
DBBQ.add_quip(key, "boss", "win", 4)
DBBQ.add_quip(key, "focusing", "loss", 13)
DBBQ.add_quip(key, "crazy", "loss", 17)
DBBQ.add_quip(key, "whistle", "any", 10)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 5, y = 1},
	blueprint_compat = true,
	pronouns = "he_him",
	dbbq_i_am_the_boss = "dbbq_boss_party",
	config = {extra = {repetitions = 2}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_party", set = "Other"}
		end
		return {vars = {card.ability.extra.repetitions}}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_wild") and card.ability.extra.repetitions > 0 then
			return {repetitions = card.ability.extra.repetitions}
		end
	end,
	joker_display_def = function(jd)
		return {
			retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
				if held_in_hand then return 0 end
				return SMODS.has_enhancement(playing_card, "m_wild") and JokerDisplay.in_scoring(playing_card, scoring_hand) and
					joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
			end
		}
	end
}
