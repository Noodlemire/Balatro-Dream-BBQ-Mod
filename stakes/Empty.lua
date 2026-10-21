SMODS.Stake {
	key = "empty",
	applied_stakes = {"dbbq_depression"},
	above_stake = "dbbq_depression",
	atlas = "dbbq_stakes",
	pos = {x = 4, y = 0},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 4, y = 1},
	colour = G.C.UI.TEXT_INACTIVE,
	calculate = function(self, context)
		if context.end_of_round and context.main_eval and context.beat_boss and context.scoring_name and G.GAME.hands[context.scoring_name].level > 0 then
			return {level_up = -math.min(G.GAME.hands[context.scoring_name].level, G.GAME.round_resets.ante)}
		end
	end
}
