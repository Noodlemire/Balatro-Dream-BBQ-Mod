--[[
Capsule Of One
Rare, $8

+2 shop card slots, but you
may only buy one card out
of each set of shop cards
--]]

local key = "capsule"
DBBQ.quip_function[key] = function(self, times)
	if self.key == "dbbq_"..key.."_no" then
		if times % 6 == 0 then
			play_sound("dbbq_capsule_angry")
		end
	else
		play_sound("dbbq_"..key..math.random(1, 4))
	end
end
DBBQ.quip_colours[key] = {HEX("ffffff"), HEX("ccffff"), HEX("cc0033")}
DBBQ.add_quip(key, "boss", "win", 5)
DBBQ.add_quip(key, "dreams", "any", 20)
DBBQ.add_quip(key, "bargain", "win", 9)
DBBQ.add_quip(key, "horses", "win", 13)
DBBQ.add_quip(key, "no", "loss", 12, 1/3)
DBBQ.add_quip(key, "losers", "loss", 14)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 7, y = 5},
	blueprint_compat = false,
	pronouns = "it_its",
	dbbq_i_am_the_boss = "dbbq_boss_capsule",
	config = {extra = {slots = 2}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_tim", set = "Other"}
		end
		return {vars = {joker.ability.extra.slots}}
	end,
	add_to_deck = function(self, joker, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				change_shop_size(joker.ability.extra.slots)
				return true
			end
		}))
	end,
	remove_from_deck = function(self, joker, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				change_shop_size(-joker.ability.extra.slots)
				return true
			end
		}))
	end,
	calculate = function(self, joker, context)
		if context.buying_card and not context.buying_self and #G.shop_jokers.cards > 0 and #G.shop_jokers.cards < G.shop_jokers.config.card_limit then
			SMODS.destroy_cards(G.shop_jokers.cards)
		end
	end
}
