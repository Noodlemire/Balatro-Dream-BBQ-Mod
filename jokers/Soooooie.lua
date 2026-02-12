--[[
Soooooie!
Secret, $10

When Blind is selected:
Create 1 Negative Dog Inside An Hourglass
(They will be removed if you lose Soooooie!)
--]]

SMODS.Joker{
	key = "soooooie",
	atlas = "dbbq_jokers",
	rarity = "dbbq_secret",
	cost = 10,
	pos = {x = 6, y = 3},
	blueprint_compat = true,
	no_mod_badges = true,
	config = {extra = {diah = 1, dbbq_quotes = {
		{type = "loss", key = "j_dbbq_soooooie_sad"},
		{type = "lose", key = "j_dbbq_soooooie_bright"},
		{type = "win", key = "j_dbbq_soooooie_existential"},
		{type = "any", key = "j_dbbq_soooooie_daily"},
	}}},
	set_badges = function(self, card, badges)
		if not SMODS.config.no_mod_badges then
			table.insert(badges, create_badge(localize("k_dbbq_auction_day"), HEX("ffdf00"), HEX("1e5fff")))
		end
	end,
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_soooooie", set = "Other"}
		end
		info_queue[#info_queue+1] = G.P_CENTERS.j_dbbq_diah
		info_queue[#info_queue + 1] = {key = "e_negative", set = "Edition", config = {extra = 1}}
		return {vars = {card.ability.extra.diah}}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card({key = "j_dbbq_diah", edition = "e_negative"})
					return true
				end
			}))
			return {
				message = localize("k_plus_joker"),
				colour = G.C.BLUE,
			}
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			for _, joker in ipairs(G.jokers.cards) do
				if joker.config.center.key == "j_dbbq_diah" and not SMODS.is_eternal(joker, card) and not joker.getting_sliced then
					joker.getting_sliced = true
					G.E_MANAGER:add_event(Event({
						func = function()
							joker:start_dissolve()
							return true
						end
					}))
				end
			end
		end
	end
}
