--[[
Lazy Coworker
Uncommon, $5

+50 Mult
When Blind is defeated,
decrease Mult depending on
how much your final chip total
overshot the Blind's requirement
--]]

local key = "lazy"
DBBQ.quip_colours[key] = {HEX("000000"), HEX("ffffff"), HEX("850a08")}
DBBQ.quip_pitch[key] = 1.5
DBBQ.add_quip(key, "sweat", "win", 8)
DBBQ.add_quip(key, "slack", "loss", 17)
DBBQ.add_quip(key, "easier", "win", 10)
DBBQ.add_quip(key, "proactive", "win", 14)
DBBQ.add_quip(key, "meat", "loss", 15)
DBBQ.add_quip(key, "novice", "loss", 11)
DBBQ.add_quip(key, "working", "win", 14)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 5,
	pos = {x = 1, y = 2},
	blueprint_compat = true,
	pronouns = "he_him",
	config = {extra = {mult = 50}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_lazy", set = "Other"}
		end
		return {vars = {card.ability.extra.mult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			local prev_mult = card.ability.extra.mult
			card.ability.extra.mult = math.ceil(card.ability.extra.mult / (G.GAME.chips / G.GAME.blind.chips))
			if type(card.ability.extra.mult) == "table" then card.ability.extra.mult = card.ability.extra.mult:to_number() end
			if prev_mult > card.ability.extra.mult then
				return {
					message = (card.ability.extra.mult - prev_mult).." Mult",
					color = G.C.MULT
				}
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.MULT}
		}
	end
}
