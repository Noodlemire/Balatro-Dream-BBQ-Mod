--[[
Unlucky Cat
Uncommon, $6

X2 Mult
If a Glass Card shatters
or a Lucky Card fails,
destroy this card
--]]

local key = "unlucky"
DBBQ.quip_colours[key] = {HEX("fefde2"), HEX("fefe39"), HEX("a5aaf8")}
DBBQ.quip_pitch[key] = 1.5
DBBQ.add_quip(key, "boss", "win", 4, 0.36)
DBBQ.add_quip(key, "simpleton", "loss", 25)
DBBQ.add_quip(key, "cruise", "win", 20)
DBBQ.add_quip(key, "poppers", "loss", 9)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 3, y = 4},
	blueprint_compat = true,
	eternal_compat = false,
	pronouns = "he_him",
	dbbq_i_am_the_boss = "dbbq_boss_generic",
    config = {extra = {Xmult = 2}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_unlucky", set = "Other"}
		end
        return {vars = {card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		elseif not context.blueprint then
			local meteor = false
			if context.remove_playing_cards then
				for _, removed_card in ipairs(context.removed) do
					if removed_card.shattered then
						meteor = true
						break
					end
				end
			elseif context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_lucky') and not context.other_card.lucky_trigger then
				meteor = true
			end
			if meteor then
				card.getting_sliced = true
				card:start_dissolve()
			end
		end
	end,
    in_pool = function(self, args)
        return false
    end,
	joker_display_def = function(jd)
		return {
			text = {{border_nodes = {
				{text = "X"},
				{ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp"}
			}}}
		}
	end
}
