--[[
Not Stalker
Uncommon, $4

When sold, all present
and future copies of
Not Stalker double their
XMult and spawn rate
(Currently X1 Mult)
(Max 64x spawn rate)
--]]

local key = "stalker"
DBBQ.quip_colours[key] = {HEX("0f352d"), HEX("7be387"), HEX("396f7d")}
DBBQ.quip_pitch[key] = 0.7
DBBQ.add_quip(key, "boss", "win", 11, 0.33)
DBBQ.add_quip(key, "mistake", "loss", 12, 0.33)
DBBQ.add_quip(key, "heheheheh", "any", 4, 0.2)
DBBQ.add_quip(key, "delight", "win", 7, 0.4)
DBBQ.add_quip(key, "captivity", "loss", 19, 0.2)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 4,
	pos = {x = 4, y = 2},
	blueprint_compat = true,
	eternal_compat = false,
	pronouns = "he_him",
	dbbq_i_am_the_boss = "dbbq_boss_stalker",
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_stalker", set = "Other"}
		end
		return {vars = {(G.GAME.dbbq_not_stalkers_sold or 1)}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = (G.GAME.dbbq_not_stalkers_sold or 1)
			}
		elseif not context.blueprint and context.selling_self then
			G.GAME.dbbq_not_stalkers_sold = (G.GAME.dbbq_not_stalkers_sold or 1) * 2
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {{border_nodes = {
				{text = "X"},
				{ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp"}
			}}},
			calc_function = function(card)
				card.joker_display_values.xmult = (G.GAME.dbbq_not_stalkers_sold or 1)
			end
		}
	end
}
