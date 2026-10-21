--[[
Toll Booth
Uncommon, $6

If your first play or discard
(not both) contains only 1 card,
add a Sticker of Entry to it 
--]]

local key = "toll"
DBBQ.quip_colours[key] = {HEX("000000"), HEX("9536a0"), HEX("819393")}
DBBQ.quip_pitch[key] = 0.5
DBBQ.quip_speed[key] = 0.3
DBBQ.add_quip(key, "toll", "any", 3)
DBBQ.add_quip(key, "armleg", "loss", 16)
DBBQ.add_quip(key, "surprise", "any", 3)
DBBQ.add_quip(key, "refund", "loss", 3)
DBBQ.add_quip(key, "wait", "win", 6, 0.15)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 7, y = 1},
	pronouns = "he_they",
	blueprint_compat = false,
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
		elseif (context.discard or context.before) and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 and #context.full_hand == 1 and not context.full_hand[1].debuff and not context.full_hand[1].ability.dbbq_entry then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					context.full_hand[1]:add_sticker("dbbq_entry", true)
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
				card.joker_display_values.active_text = localize("jdis_"..(card.joker_display_values.is_active and "active" or "inactive"))
			end,
			style_function = function(card, text, reminder_text, extra)
				if text and text.children and text.children[1] then
					text.children[1].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
				end
			end
		}
	end
}

SMODS.Sticker{
	key = "entry",
	atlas = "dbbq_stickers",
	pos = {x = 0, y = 0},
	badge_colour = HEX("ba7a4d"),
	apply = function(self, card, val)
		if G.STAGE == G.STAGES.RUN then
			SMODS.debuff_card(card, val and "prevent_debuff" or nil, "dbbq_entry")
		end
		card.ability[self.key] = val
	end
}
