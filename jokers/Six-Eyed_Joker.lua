--[[
Six-Eyed Joker
Common, $4

Each 6 held in hand
grants +36 Chips
--]]

local key = "sixeyed"
DBBQ.quip_colours[key] = {HEX("122b12"), HEX("ff04fa"), HEX("5d3ebd")}
DBBQ.quip_sound[key] = DBBQ.sound_range(key, 4)
DBBQ.quip_speed[key] = 0.4
DBBQ.quip_pitch[key] = 1
DBBQ.add_quip(key, "thank", "win", 3)
DBBQ.add_quip(key, "back", "loss", 3)
DBBQ.add_quip(key, "before", "win", 3)
DBBQ.add_quip(key, "death", "any", 3)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 3, y = 3},
	blueprint_compat = true,
	pronouns = "he_they",
	config = {extra = {target = "6", chips = 36}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_sixeyed", set = "Other"}
		end
		return {vars = {card.ability.extra.target, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.individual and not context.end_of_round and context.cardarea == G.hand and context.other_card:get_id() == 6 then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
				}
			else
				return {
					chips = card.ability.extra.chips,
				}
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.CHIPS},
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local chips = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if playing_card.facing and not (playing_card.facing == "back") and not playing_card.debuff and playing_card:get_id() == 6 then
							chips = chips + card.ability.extra.chips * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.chips = chips
			end
		}
	end
}
