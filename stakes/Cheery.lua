SMODS.Stake {
	key = "cheery",
	applied_stakes = {},
	atlas = "dbbq_stakes",
	pos = {x = 0, y = 0},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 0, y = 1},
	colour = G.C.YELLOW,
	calculate = function(self, context)
		if (context.joker_type_destroyed or context.selling_card) and context.card.ability and context.card.ability.set == "Joker" and context.card.config.center.key ~= "j_joker" and not G.GAME.banned_keys[context.card.config.center.key] then
			G.GAME.banned_keys[context.card.config.center.key] = true
			return {message = localize("k_dbbq_banned"), message_card = context.card}
		end
	end
}
