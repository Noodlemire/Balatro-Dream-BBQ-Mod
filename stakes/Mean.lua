SMODS.Stake {
	key = "mean",
	applied_stakes = {"dbbq_scam"},
	above_stake = "dbbq_scam",
	atlas = "dbbq_stakes",
	pos = {x = 1, y = 1},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 1, y = 2},
	colour = G.C.WHITE,
	modifiers = function()
		G.GAME.dbbq_unskippable_boosters = true
	end
}

local old_can_skip_booster = G.FUNCS.can_skip_booster
function G.FUNCS.can_skip_booster(e)
	if G.GAME.dbbq_unskippable_boosters and not next(SMODS.find_card("j_red_card")) then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		old_can_skip_booster(e)
	end
end
---[[
local old_generate_card_ui = generate_card_ui
function generate_card_ui(_c, ...)
	local fut = old_generate_card_ui(_c, ...)
	if G.GAME and G.GAME.dbbq_unskippable_boosters and _c.name == "Red Card" then
		old_generate_card_ui({set = "Other", key = "dbbq_red_card"}, fut)
	end
	return fut
end--]]
