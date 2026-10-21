--[[
Who Is The Boss?
Rare, $8

X2 Mult per joker that
claims to be the Boss
--]]

SMODS.Joker{
	key = "boss",
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 2, y = 5},
	blueprint_compat = true,
	pronouns = "he_him",
	config = {extra = {xmult = 2}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_boss", set = "Other"}
		end
		return {vars = {card.ability.extra.xmult}}
	end,
	calculate = function(self, card, context)
		if context.other_joker and context.other_joker.config.center.dbbq_i_am_the_boss then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{ref_table = "card.joker_display_values", ref_value = "count", colour = G.C.ORANGE},
				{text = "x"},
				{ref_table = "card.joker_display_values", ref_value = "localized_text"},
			},
			calc_function = function(card)
				local count = 0
				DBBQ.iterate_jokers(function(joker)
					if joker.config.center.dbbq_i_am_the_boss then
						count = count + 1
					end
				end)
				card.joker_display_values.count = count
				card.joker_display_values.localized_text = localize("k_dbbq_boss")
			end,
			mod_function = function(card, mod_joker)
				return {x_mult = (card.config.center.dbbq_i_am_the_boss and mod_joker.ability.extra.xmult ^ JokerDisplay.calculate_joker_triggers(mod_joker))}
			end
		}
	end
}

local old_gcui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
	local fut = old_gcui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)

	if not full_UI_table and _c and _c.dbbq_i_am_the_boss and (next(SMODS.find_card("j_dbbq_boss")) or (card and card.area and card.area.config.collection)) then
		old_gcui({key = _c.dbbq_i_am_the_boss, set = "Other"}, fut)
	end

	return fut
end
