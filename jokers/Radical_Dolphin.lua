--[[
Radical Dolphin
Secret, $10

Retrigger rightmost scoring
card once for each other
scoring card with a unique rank
(Currently: 0)
--]]

local function unique_numbers(scoring_hand)
	if not scoring_hand or #scoring_hand == 0 then return 0 end
	local ranks = {}
	local sum = -1
	for _, card in ipairs(scoring_hand) do
		local rank = tostring(card:get_id())
		if not ranks[rank] then
			ranks[rank] = true
			sum = sum + 1
		end
	end
	return sum
end

SMODS.Joker{
	key = "radical",
	atlas = "dbbq_jokers",
	rarity = "dbbq_secret",
	cost = 10,
	pos = {x = 6, y = 2},
	blueprint_compat = true,
	no_mod_badges = true,
	config = {extra = {dbbq_quotes = {
		{type = "win", key = "j_dbbq_radical_polynomial"},
		{type = "win", key = "j_dbbq_radical_tangent"},
		{type = "loss", key = "j_dbbq_radical_chill"},
		{type = "win", key = "j_dbbq_radical_star"},
		{type = "any", key = "j_dbbq_radical_humor"},
	}}},
	set_badges = function(self, card, badges)
		if not SMODS.config.no_mod_badges then
			table.insert(badges, create_badge(localize("k_dbbq_temptation_stairway"), HEX("ffdf00"), HEX("1e5fff")))
		end
	end,
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_radical", set = "Other"}
		end
		local _, _, scoring_hand = JokerDisplay.evaluate_hand()
		return {vars = {unique_numbers(scoring_hand)}}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] then
			local reps = unique_numbers(context.scoring_hand)
			if reps > 0 then
				return {repetitions = reps}
			end
		end
    end,
	joker_display_def = function(jd)
		return {
			text = {
				{ref_table = "card.joker_display_values", ref_value = "retriggers", retrigger_type = "mult"},
				{text = " Retriggers"}
			},
			calc_function = function(card)
				local _, _, scoring_hand = JokerDisplay.evaluate_hand()
				card.joker_display_values.retriggers = unique_numbers(scoring_hand)
			end,
			retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
				if held_in_hand then return 0 end
				return playing_card == scoring_hand[scoring_hand] and unique_numbers(scoring_hand) * JokerDisplay.calculate_joker_triggers(joker_card) or 0
			end
		}
	end
}
