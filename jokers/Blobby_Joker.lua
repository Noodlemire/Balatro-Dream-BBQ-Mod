--[[
Blobby Joker
Common, $4

+15 Mult if you play one of your least played hands.
--]]

SMODS.Joker{
	key = "blobby",
	loc_txt = {
		name = "Blobby Joker",
		text = {
			"{C:mult}+#1#{} Mult if you",
			"play one of your",
			"least played hands"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 1, y = 0},
	blueprint_compat = true,
	config = {extra = {mult = 15}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			local mult = true
			local hopefully_min = G.GAME.hands[context.scoring_name].played - 1
			for k, v in pairs(G.GAME.hands) do
				if v.played < hopefully_min and v.visible then
					mult = false
				end
			end
			if mult then
				return {mult = card.ability.extra.mult}
			end
		end
	end
}
