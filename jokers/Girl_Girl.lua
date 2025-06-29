--[[
Girl Girl
Rare, $12

When Blind is selected: Flip and shuffle all Jokers.
1 in 6 chance: Add Negative to one other Joker at random.
--]]

SMODS.Joker{
	key = "girl",
	loc_txt = {
		name = "Girl Girl",
		text = {
			"When {C:attention}Blind{} is selected:",
			"Flip and shuffle all Jokers",
			"{C:green}#1# in #2#{} chance: Add {C:dark_edition}Negative{}",
			"to one other Joker at random"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 12,
	pos = {x = 0, y = 1},
	blueprint_compat = false,
	config = {extra = {odds = 6}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_girl", set = "Other"}
		end
        info_queue[#info_queue + 1] = {key = "e_negative", set = "Edition", config = {extra = 1}}
		return {vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
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
				if pseudorandom("U know, im pretty good @ organizing words!!") < G.GAME.probabilities.normal / card.ability.extra.odds then
					return {
						func = function()
							pseudorandom_element(neg_eligible, pseudoseed("umwbmhjnbgrzmmafbczlcmnkvn")):set_edition({negative = true}, true)
						end
					}
				else
					SMODS.calculate_context({roff_probability_missed = true})
					return {
						message = localize("k_nope_ex")
					}
				end
			end
		end
	end
}
