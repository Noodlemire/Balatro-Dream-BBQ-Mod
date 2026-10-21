--[[
Two Places At Once
Rare, $10

When Blind is selected:
Unpin and copy self without modifiers,
then pin the copy to the left
(Must have room)
When Blind is defeated:
If there's a copy to the right,
destroy it and gain X0.15 Mult
(Currently X1 Mult)
--]]

local key = "tpao"
DBBQ.quip_colours[key] = {HEX("1339e4"), HEX("1026ac"), HEX("e4d113")}
DBBQ.quip_pitch[key] = 0.8
DBBQ.quip_speed[key] = 0.2
DBBQ.add_quip(key, "understand", "win", 25)
DBBQ.add_quip(key, "life", "win", 15)
DBBQ.add_quip(key, "forgive", "loss", 13)
DBBQ.add_quip(key, "done", "any", 31)
DBBQ.add_quip(key, "anew", "win", 13)
DBBQ.add_quip(key, "expain", "any", 51)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 10,
	pos = {x = 2, y = 4},
	blueprint_compat = true,
	eternal_compat = false,
	pronouns = "he_him",
	config = {extra = {Xmult_gain = 0.15, Xmult = 1}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_tpao", set = "Other"}
		end
		local num = math.min(#SMODS.find_card("j_dbbq_tpao"), 3)
		if num == 0 then num = 2 end
		return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}, key = self.key..num}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		elseif not context.blueprint then
			if context.setting_blind then
				local buffer = self.area == G.jokers and "joker_buffer" or self.area == G.consumeables and "consumeable_buffer"
				if #card.area.cards + (buffer and G.GAME[buffer] or 0) < card.area.config.card_limit then
					if buffer then
						G.GAME[buffer] = G.GAME[buffer] + 1
					end
					G.E_MANAGER:add_event(Event({
						func = function()
							local copy = Card(card.area.T.x + card.area.T.w/2, card.area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.j_dbbq_tpao, {bypass_discovery_center = true, bypass_discovery_ui = true, discover = true, bypass_back = G.GAME.selected_back.pos})
							SMODS.add_to_deck(copy, {area = card.area})
							copy.pinned = true
							copy.ability.extra.Xmult = card.ability.extra.Xmult
							card.pinned = nil
							card.ability.pinned = nil
							if buffer then
								G.GAME[buffer] = G.GAME[buffer] - 1
							end
							return true
						end
					}))
					return {
						message = localize('k_plus_joker'),
						colour = G.C.BLUE,
					}
				end
			elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				local found_self = false
				DBBQ.iterate_jokers(function(joker)
					if joker == card then
						found_self = true
					elseif found_self and joker.config.center.key == "j_dbbq_tpao" then
						joker.getting_sliced = true
						joker:start_dissolve()
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = "Xmult",
							scalar_value = "Xmult_gain"
						})
					end
				end)
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {{border_nodes = {
				{text = "X"},
				{ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp"}
			}}}
		}
	end
}
