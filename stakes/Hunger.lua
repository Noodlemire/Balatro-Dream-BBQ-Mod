SMODS.Stake {
	key = "hunger",
	applied_stakes = {"dbbq_displaced"},
	above_stake = "dbbq_displaced",
	atlas = "dbbq_stakes",
	pos = {x = 3, y = 1},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 3, y = 2},
	colour = HEX("d54405"),
	modifiers = function()
		G.E_MANAGER:add_event(Event({
			func = function()
				G.jokers.config.card_limit = G.jokers.config.card_limit - 1
				return true
			end
		}))
	end
}
