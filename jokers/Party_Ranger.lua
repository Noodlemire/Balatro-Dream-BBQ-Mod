--[[
Puppet Mascot
Uncommon, $6

Retrigger each scoring Wild Card an additional 2 times.
--]]

SMODS.Joker{
	key = "party",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 5, y = 1},
	blueprint_compat = true,
	config = {extra = {repetitions = 2, dbbq_quotes = {
		{type = "win", key = "j_dbbq_party_boss"},
		{type = "lose", key = "j_dbbq_party_focusing"},
		{type = "lose", key = "j_dbbq_party_crazy"},
		{type = "any", key = "j_dbbq_party_whistle"},
	}}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_party", set = "Other"}
		end
		return {vars = {card.ability.extra.repetitions}}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_wild") then
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
