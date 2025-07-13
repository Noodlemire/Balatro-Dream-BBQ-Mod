--[[
Not Stalker
Common, $4

When sold, all present and future copies of Not Stalker double their XMult
(Currently X1 Mult)
--]]

SMODS.Joker{
	key = "stalker",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 4, y = 2},
	blueprint_compat = true,
	config = {extra = {dbbq_quotes = {
		{type = "win", key = "j_dbbq_stalker_boss"},
		{type = "lose", key = "j_dbbq_stalker_mistake"},
		{type = "any", key = "j_dbbq_stalker_heheheheh"},
		{type = "win", key = "j_dbbq_stalker_delight"},
		{type = "lose", key = "j_dbbq_stalker_captivity"},
	}}},
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
	end
}
