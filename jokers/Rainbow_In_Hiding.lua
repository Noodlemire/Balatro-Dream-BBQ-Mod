--[[
Rainbow In Hiding
Rare, $8

Gives +2 Spectral Cards
if you beat a boss blind
without triggering it
(Must have room)
--]]

local key = "rainbow"
DBBQ.quip_colours[key] = {HEX("000000"), HEX("9d05f6"), HEX("f1f30c")}
DBBQ.quip_pitch[key] = 0.75
DBBQ.add_quip(key, "bell", "loss", 7)
DBBQ.add_quip(key, "hiding", "any", 12)
DBBQ.add_quip(key, "prison", "win", 20)
DBBQ.add_quip(key, "left", "win", 11)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 3, y = 5},
	blueprint_compat = true,
	pronouns = "he_him",
	config = {extra = {cards = 2, active = false}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_rainbow", set = "Other"}
		end
		return {vars = {joker.ability.extra.cards}}
	end,
	calculate = function(self, joker, context)
		if context.setting_blind and G.GAME.blind.boss and not context.blueprint then
			joker.ability.extra.active = true
		elseif (context.debuffed_hand or context.joker_main) and G.GAME.blind.triggered and not context.blueprint then
			joker.ability.extra.active = false
		elseif context.blind_defeated then
			if joker.ability.extra.active then
				for i = 1, joker.ability.extra.cards do
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card({set = "Spectral"})
								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
								return true
							end
						}))
						SMODS.calculate_effect({message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral}, joker)
					end
				end
			end
			if not context.blueprint then
				G.E_MANAGER:add_event(Event({
					func = function()
						joker.ability.extra.active = false
						return true
					end
				}))
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.ability.extra", ref_value = "cards", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.SECONDARY_SET.Spectral},
			reminder_text = {
				{text = "("},
				{ref_table = "card.joker_display_values", ref_value = "active"},
				{text = ")"},
			},
			calc_function = function(joker)
				if joker.ability.extra.active then
					joker.joker_display_values.active = localize("k_active_ex")
				else
					joker.joker_display_values.active = localize("k_dbbq_inactive")
				end
			end,
			style_function = function(joker, text, reminder_text, extra)
				if reminder_text and reminder_text.children[2] then
					if joker.ability.extra.active then
						reminder_text.children[2].config.colour = G.C.GREEN
					else
						reminder_text.children[2].config.colour = G.C.UI.TEXT_INACTIVE
					end
				end
			end
		}
	end
}
