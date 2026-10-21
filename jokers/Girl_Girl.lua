--[[
Girl Girl
Rare, $12

When Blind is selected:
Flip and shuffle all Jokers
1 in 6 chance: Add Negative
to one other Joker at random
--]]

local key = "girl"
DBBQ.quip_colours[key] = {HEX("d09c45"), HEX("b02831"), HEX("f2bcae")}
DBBQ.quip_pitch[key] = 2
DBBQ.quip_pitch[key.."_rude"] = 0.25
DBBQ.add_quip(key, "care", "loss", 8)
DBBQ.add_quip(key, "thankz", "loss", 20)
DBBQ.add_quip(key, "rude", "loss", 15, 0.2)
DBBQ.add_quip(key, "fell", "loss", 8)
DBBQ.add_quip(key, "words", "win", 27)
DBBQ.add_quip(key, "resuemay", "win", 23)
DBBQ.add_quip(key, "job", "win", 12)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 12,
	pos = {x = 0, y = 1},
	blueprint_compat = false,
	pronouns = "she_her",
	config = {extra = {num = 1, den = 6}},
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
			local joker_areas = {}
			DBBQ.iterate_jokers(function(joker, area)
				joker_areas[area] = true
				joker:flip()
				if joker ~= card and not joker.edition then
					neg_eligible[#neg_eligible+1] = joker
				end
			end)
			for area in pairs(joker_areas) do
				if DBBQ.count_jokers() > 1 then 
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() 
						G.E_MANAGER:add_event(Event({func = function() area:shuffle("I don care!"); play_sound("cardSlide1", 0.85); return true end})) 
						delay(0.15)
						G.E_MANAGER:add_event(Event({func = function() area:shuffle("DON CARE!!! >:OO"); play_sound("cardSlide1", 1.15); return true end})) 
						delay(0.15)
						G.E_MANAGER:add_event(Event({func = function() area:shuffle("GO AWAY!!!"); play_sound("cardSlide1", 1); return true end})) 
						delay(0.5)
						return true
					end})) 
				end
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
