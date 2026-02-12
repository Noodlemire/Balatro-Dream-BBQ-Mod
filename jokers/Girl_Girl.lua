--[[
Girl Girl
Rare, $12

When Blind is selected: Flip and shuffle all Jokers.
1 in 6 chance: Add Negative to one other Joker at random.
--]]

SMODS.Joker{
	key = "girl",
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 12,
	pos = {x = 0, y = 1},
	blueprint_compat = false,
	config = {extra = {num = 1, den = 6, dbbq_quotes = {
		{type = "lose", key = "j_dbbq_girl_care"},
		{type = "lose", key = "j_dbbq_girl_thankz"},
		{type = "lose", key = "j_dbbq_girl_rude"},
		{type = "lose", key = "j_dbbq_girl_fell"},
		{type = "win", key = "j_dbbq_girl_words"},
		{type = "win", key = "j_dbbq_girl_resuemay"},
		{type = "win", key = "j_dbbq_girl_job"},
	}}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_girl", set = "Other"}
		end
		info_queue[#info_queue + 1] = {key = "e_negative", set = "Edition", config = {extra = 1}}
		local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den)
		return {vars = {num, den}}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			local neg_eligible = {}
			for k, v in ipairs(G.jokers.cards) do
				v:flip()
				if v ~= card and not v.edition then
					neg_eligible[#neg_eligible+1] = v
				end
			end
			if #G.jokers.cards > 1 then 
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
					G.E_MANAGER:add_event(Event({func = function() G.jokers:shuffle("I don care!"); play_sound("cardSlide1", 0.85); return true end})) 
					delay(0.15)
					G.E_MANAGER:add_event(Event({func = function() G.jokers:shuffle("DON CARE!!! >:OO"); play_sound("cardSlide1", 1.15); return true end})) 
					delay(0.15)
					G.E_MANAGER:add_event(Event({func = function() G.jokers:shuffle("GO AWAY!!!"); play_sound("cardSlide1", 1); return true end})) 
					delay(0.5)
					return true
				end})) 
			end
			if #neg_eligible > 0 then
				if SMODS.pseudorandom_probability(card, "U know, im pretty good @ organizing words!!", card.ability.extra.num, card.ability.extra.den) then
					return {
						func = function()
							pseudorandom_element(neg_eligible, pseudoseed("umwbmhjnbgrzmmafbczlcmnkvn")):set_edition({negative = true}, true)
						end
					}
				else
					return {message = localize("k_nope_ex")}
				end
			end
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
			calc_function = function(card)
				card.joker_display_values.num, card.joker_display_values.den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den)
			end
		}
	end
}
