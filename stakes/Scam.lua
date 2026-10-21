SMODS.Stake {
	key = "scam",
	applied_stakes = {"dbbq_empty"},
	above_stake = "dbbq_empty",
	atlas = "dbbq_stakes",
	pos = {x = 0, y = 1},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 0, y = 2},
	colour = G.C.RED,
	modifiers = function()
		G.GAME.playing_card_rate = 4
		G.GAME.dbbq_magic_trick = true
	end
}

local old_generate_card_ui = generate_card_ui
function generate_card_ui(_c, ...)
	if G.GAME and G.GAME.dbbq_magic_trick and _c.name == "Magic Trick" then
		return old_generate_card_ui({set = "Other", key = "dbbq_magic_trick"})
	else
		return old_generate_card_ui(_c, ...)
	end
end
