--[[
Blobby Joker
Common, $4

+15 Mult if you don't play one of your most played hands.
--]]

SMODS.Joker{
	key = "blobby",
	loc_txt = {
		name = "Blobby Joker",
		text = {
			"{C:mult}+#1#{} Mult if you don't",
			"play one of your",
			"most played hands"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 1, y = 0},
	blueprint_compat = true,
	config = {extra = {mult = 15}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_blobby", set = "Other"}
		end
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			local mult = false
			local max_limit = G.GAME.hands[context.scoring_name].played - 1
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played > max_limit and v.visible then
					mult = true
					break
				end
			end
			if mult then
				return {mult = card.ability.extra.mult}
			end
		end
	end
}
