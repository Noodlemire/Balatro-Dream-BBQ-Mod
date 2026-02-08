--[[
Trio Casino
Uncommon, $6

When poker hand is played:
Create 3 random Negative Rare Vanilla Jokers
Unless they all match, they are destroyed

Chance for all played cards
to give $2 when scored
Chance depends on number of
held consumables, but they
must all be the same card
(Currently 0 in 3 chance)
--]]

local matching_consumables = function()
	if not G.consumeables or #G.consumeables.cards == 0 then return 0 end

	local first = G.consumeables.cards[1].config.center.key
	local count = 1

	for i = 2, #G.consumeables.cards do
		if G.consumeables.cards[i].config.center.key ~= first then
			return 0
		end

		count = count + 1
	end

	return count
end

--local RARE_VANILLA_JOKERS = {"j_ancient", "j_baron", "j_baseball", "j_blueprint", "j_brainstorm", "j_burnt", "j_campfire", "j_dna", "j_drivers_license", "j_hit_the_road", "j_invisible", "j_obelisk", "j_stuntman", "j_duo", "j_trio", "j_family", "j_order", "j_tribe", "j_vagabond", "j_wee"}

SMODS.Joker{
	key = "casino",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 6, y = 0},
	blueprint_compat = true,
	config = {extra = {dollars = 2, odds = 3, active = false, dbbq_quotes = {
		{type = "lose", key = "j_dbbq_casino_tv_dinner"},
		{type = "lose", key = "j_dbbq_casino_nonsense"},
		{type = "lose", key = "j_dbbq_casino_richer"},
		{type = "lose", key = "j_dbbq_casino_clodpoll"},
		{type = "lose", key = "j_dbbq_casino_problematic"},
		{type = "win", key = "j_dbbq_casino_luck"},
		{type = "any", key = "j_dbbq_casino_slacking"},
		{type = "win", key = "j_dbbq_casino_party"},
	}}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_casino", set = "Other"}
		end
		local numerator, denominator = SMODS.get_probability_vars(card, matching_consumables(), card.ability.extra.odds)
		return {vars = {card.ability.extra.dollars, numerator, denominator}}
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.active = SMODS.pseudorandom_probability(card, "Poor?! Cheap?! Moi?!", matching_consumables(), card.ability.extra.odds)
		elseif context.individual and context.cardarea == G.play and card.ability.extra.active then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
			return {
				dollars = card.ability.extra.dollars,
				func = function() -- This is for timing purposes, this goes after the dollar modification
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.dollar_buffer = 0
							return true
						end
					}))
				end
			}
		end
    end,
	joker_display_def = function(jd)
		return {
			text = {
				{ref_table = "card.joker_display_values", ref_value = "num"},
				{text = " in "},
				{ref_table = "card.joker_display_values", ref_value = "den"}
			},
			text_config = {colour = G.C.GREEN},
			reminder_text = {
				{text = "$"},
				{ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult"}
			},
			reminder_text_config = {colour = G.C.GOLD},
			calc_function = function(card)
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				local count = 0
				if text ~= "Unknown" then
					for _, scoring_card in pairs(scoring_hand) do
						count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
					end
				end
				card.joker_display_values.money = count * card.ability.extra.dollars
				card.joker_display_values.num, card.joker_display_values.den = SMODS.get_probability_vars(card, matching_consumables(), card.ability.extra.odds)
			end
		}
	end
}
