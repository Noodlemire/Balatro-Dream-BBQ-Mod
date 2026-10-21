SMODS.Stake {
	key = "depression",
	applied_stakes = {"dbbq_drunk"},
	above_stake = "dbbq_drunk",
	atlas = "dbbq_stakes",
	pos = {x = 3, y = 0},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 3, y = 1},
	colour = G.C.SECONDARY_SET.Spectral,
	modifiers = function()
		G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) - 1
	end
}
