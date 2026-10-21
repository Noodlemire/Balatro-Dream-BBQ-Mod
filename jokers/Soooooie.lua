--[[
Soooooie!
Secret, $10

When Blind is selected:
Create 1 Negative Dog Inside An Hourglass
(They will be removed if you lose Soooooie!)
--]]

local key = "soooooie"
DBBQ.quip_colours[key] = {HEX("ff390a"), HEX("5380ff"), HEX("d26be9")}
DBBQ.quip_pitch[key] = 1.65
DBBQ.add_quip(key, "sad", "loss", 6, 0.2)
DBBQ.add_quip(key, "bright", "loss", 9)
DBBQ.add_quip(key, "existential", "win", 16)
DBBQ.add_quip(key, "daily", "any", 16)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = "dbbq_secret",
	cost = 10,
	pos = {x = 6, y = 3},
	blueprint_compat = true,
	no_mod_badges = true,
	pronouns = "he_they",
	config = {extra = {diah = 1}},
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
			DBBQ.iterate_jokers(function(joker)
				if joker.config.center.key == "j_dbbq_diah" and not SMODS.is_eternal(joker, card) and not joker.getting_sliced then
					joker.getting_sliced = true
					G.E_MANAGER:add_event(Event({
						func = function()
							joker:start_dissolve()
							return true
						end
					}))
				end
			end)
		end
	end
}
