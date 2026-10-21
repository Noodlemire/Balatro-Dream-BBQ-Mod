--[[
Timothy Rundle
Rare, $8

First shop each Ante has an extra
Spacious Durable Luxury Bag
Newly obtained Luxury Items will
not take up Consumable Slots
--]]

local key = "tim"
DBBQ.quip_colours[key] = {HEX("ffffff"), HEX("ccffff"), HEX("cc0033")}
DBBQ.quip_pitch[key] = 1.2
DBBQ.add_quip(key, "fortune", "win", 17)
DBBQ.add_quip(key, "thanks", "win", 11)
DBBQ.add_quip(key, "space", "any", 59)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 6, y = 5},
	blueprint_compat = true,
	pronouns = "he_him",
	config = {extra = {activated = false}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_tim", set = "Other"}
		end
	end,
	add_to_deck = function(self, joker, from_debuff)
		for _, area in ipairs({G.shop_jokers, G.pack_cards}) do
			for _, card in ipairs(area and area.cards or {}) do
				if card.ability and card.ability.set == "dbbq_luxury" then
					card.ability.extra_slots_used = -1
				end
			end
		end
		if from_debuff or G.GAME.dbbq_past_first_shop_this_ante or G.STATE ~= G.STATES.SHOP then return end
		SMODS.calculate_effect({
			message = localize("k_booster_group_p_dbbq_sdlb"),
			colour = G.C.SECONDARY_SET.dbbq_luxury,
			func = function()
				joker.ability.extra.activated = true
				SMODS.add_booster_to_shop("p_dbbq_sdlb")
			end
		}, joker)
	end,
	remove_from_deck = function(self, joker, from_debuff)
		for _, area in ipairs({G.shop_jokers, G.pack_cards}) do
			for _, card in ipairs(area and area.cards or {}) do
				if card.ability and card.ability.set == "dbbq_luxury" then
					card.ability.extra_slots_used = 0
				end
			end
		end
	end,
	calculate = function(self, joker, context)
		if (context.starting_shop or context.ending_booster) and not G.GAME.dbbq_past_first_shop_this_ante and not joker.ability.extra.activated then
			local bp = context.blueprint
			return {
				message = localize("k_booster_group_p_dbbq_sdlb"),
				colour = G.C.SECONDARY_SET.dbbq_luxury,
				func = function()
					if not bp then
						joker.ability.extra.activated = true
					end
					SMODS.add_booster_to_shop("p_dbbq_sdlb")
				end
			}
		elseif context.blueprint then return end
		if (context.card_added or context.modify_shop_card or context.modify_booster_card) and context.card.ability and context.card.ability.set == "dbbq_luxury" then
			context.card.ability.extra_slots_used = -1
		elseif context.ending_shop then
			joker.ability.extra.activated = false
		end
	end
}

table.insert(DBBQ.calculates, function(context)
	if context.ending_shop then
		G.GAME.dbbq_past_first_shop_this_ante = true
	elseif context.ante_end then
		G.GAME.dbbq_past_first_shop_this_ante = false
	end
end)
