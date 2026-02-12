--[[
Toll Booth
Uncommon, $6

If your first play or discard
(not both) contains only 1 card,
add a Sticker of Entry to it 
--]]

SMODS.Joker{
	key = "toll",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 7, y = 1},
	blueprint_compat = false,
	config = {extra = {dbbq_quotes = {
		{type = "any", key = "j_dbbq_toll_toll"},
		{type = "lose", key = "j_dbbq_toll_armleg"},
		{type = "any", key = "j_dbbq_toll_surprise"},
		{type = "lose", key = "j_dbbq_toll_refund"},
		{type = "win", key = "j_dbbq_toll_wait"}
	}}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_legs", set = "Other"}
		end
		info_queue[#info_queue+1] = {key = "dbbq_entry", set = "Other"}
	end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.first_hand_drawn then
			local eval = function() return G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
			juice_card_until(card, eval, true)
		elseif (context.discard or context.before) and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 and #context.full_hand == 1 and not context.full_hand[1].debuff then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					context.full_hand[1].ability.dbbq_entry = true
					play_sound("tarot1")
					context.full_hand[1]:juice_up()
					return true
				end
			}))
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{ref_table = "card.joker_display_values", ref_value = "active_text"}
			},
			calc_function = function(card)
				card.joker_display_values.is_active = G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0
				card.joker_display_values.active_text = localize("jdis_" ..
					(card.joker_display_values.is_active and "active" or "inactive"))
			end,
			style_function = function(card, text, reminder_text, extra)
				if text and text.children and text.children[1] then
					text.children[1].config.colour = card.joker_display_values.is_active and G.C.GREEN or
						G.C.UI.TEXT_INACTIVE
				end
			end
		}
	end
}

SMODS.Sticker{
	key = "entry",
	atlas = "dbbq_stickers",
	pos = {x = 0, y = 0},
	badge_colour = HEX("ba7a4d")
}

local old_set_debuff = Card.set_debuff
function Card:set_debuff(should_debuff)
	old_set_debuff(self, should_debuff)

	if self.ability.dbbq_entry then
		self.debuff = false
		self.perma_debuff = false
	end
end
