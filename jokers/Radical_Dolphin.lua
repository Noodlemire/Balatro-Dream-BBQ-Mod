--[[
Radical Dolphin
Secret, $10

Retrigger rightmost scoring
card once for each other
scoring card with a unique rank
(Currently: 0)
--]]

local key = "radical"
DBBQ.quip_colours[key] = {HEX("000000"), HEX("c55fa9"), HEX("8c5f1a")}
DBBQ.quip_pitch[key] = 1.2
DBBQ.add_quip(key, "polynomial", "loss", 18)
DBBQ.add_quip(key, "tangent", "win", 23)
DBBQ.add_quip(key, "chill", "loss", 16)
DBBQ.add_quip(key, "star", "win", 5)
DBBQ.add_quip(key, "humor", "any", 34)

local function unique_numbers(scoring_hand)
	if not scoring_hand or #scoring_hand == 0 then return 0 end
	local ranks = {}
	if not SMODS.has_no_rank(scoring_hand[#scoring_hand]) then
		ranks[tostring(scoring_hand[#scoring_hand]:get_id())] = true
	end
	local sum = 0
	for i = 1, #scoring_hand-1 do
		local card = scoring_hand[i]
		local rank = tostring(card:get_id())
		if not ranks[rank] and not SMODS.has_no_rank(card) then
			ranks[rank] = true
			sum = sum + 1
		end
	end
	return sum
end

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = "dbbq_secret",
	cost = 10,
	pos = {x = 6, y = 2},
	blueprint_compat = true,
	no_mod_badges = true,
	pronouns = "he_him",
	set_badges = function(self, card, badges)
		if not SMODS.config.no_mod_badges then
			table.insert(badges, create_badge(localize("k_dbbq_temptation_stairway"), HEX("ffdf00"), HEX("1e5fff")))
		end
	end,
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_radical", set = "Other"}
		end
		if not G.hand or not G.play then
			return {vars = {0}}
		else
			return {vars = {unique_numbers(#G.play.cards > 0 and G.play.cards or G.hand.highlighted)}}
		end
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
				return playing_card == scoring_hand[#scoring_hand] and unique_numbers(scoring_hand) * JokerDisplay.calculate_joker_triggers(joker_card) or 0
			end
		}
	end
}
