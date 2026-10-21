SMODS.Stake {
	key = "moody",
	applied_stakes = {"dbbq_cheery"},
	above_stake = "dbbq_cheery",
	atlas = "dbbq_stakes",
	pos = {x = 1, y = 0},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 1, y = 1},
	colour = G.C.BLUE,
	config = {chip_loss = -1},
	loc_vars = function(self)
		return {vars = {self.config.chip_loss}}
	end,
	--modifiers = function()
	--	G.GAME.modifiers.dbbq_moody = true
	--end,
	calculate = function(self, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			SMODS.scale_card(context.other_card, {
				ref_table = context.other_card.ability,
				ref_value = "perma_bonus",
				scalar_table = SMODS.Stakes.stake_dbbq_moody.config,
				scalar_value = "chip_loss",
				message_key = "k_dbbq_minus_chip"
			})
		end
	end
}
--[[
--TODO: Update MewgenicsCD and Abondonia with SMODS.has_playing_card_property(self, "replace_base_card") and the math.max check
local old_card_chips = Card.get_chip_bonus
function Card:get_chip_bonus()
	local chips = old_card_chips(self)
	if not SMODS.has_playing_card_property(self, "replace_base_card") and G.GAME.modifiers.dbbq_moody then
		chips = math.max(chips - self.base.nominal, self.ability.perma_bonus or 0)
	end
	return chips
end

local old_generate_ui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
	if specific_vars and specific_vars.nominal_chips and G.GAME.modifiers.dbbq_moody and not SMODS.has_playing_card_property(_c, "replace_base_card") then
		local new_vars = {}
		for k, var in pairs(specific_vars) do
			if k ~= "nominal_chips" then
				new_vars[k] = var
			else
				new_vars[k] = 0
			end
		end
		specific_vars = new_vars
	end

	return old_generate_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
end--]]
