--[[
Cucumber Horse
Uncommon, $4

When Blind is selected:
4 random cards in deck
will gain Pet? Seals
--]]

--[[
Pet? Seal

If all cards with Pet? Seals are
played and scored before round's end,
they are replaced with Gold Seals
Otherwise, the Pet? Seals will vanish
--]]

SMODS.Joker{
	key = "horse",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 4,
	pos = {x = 2, y = 0},
	blueprint_compat = false,
	config = {extra = {pets = 4, success = false, dbbq_quotes = {
		{type = "win", key = "j_dbbq_horse_boss"},
		{type = "lose", key = "j_dbbq_horse_no"},
		{type = "lose", key = "j_dbbq_horse_shitchat"},
		{type = "win", key = "j_dbbq_horse_money"},
		{type = "win", key = "j_dbbq_horse_early"},
		{type = "win", key = "j_dbbq_horse_meal"},
	}}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_horse", set = "Other"}
		end
		info_queue[#info_queue+1] = G.P_SEALS.dbbq_pet
		return {vars = {
			joker.ability.extra.pets
		}}
	end,
	calculate = function(self, joker, context)
		if context.setting_blind and not context.blueprint then
			local valid_cards = {}
			joker.ability.extra.success = false

			for _, card in ipairs(G.deck.cards) do
				if not card.seal then
					table.insert(valid_cards, card)
				end
			end

			if #valid_cards >= joker.ability.extra.pets then
				for _ = 1, joker.ability.extra.pets do
					local card = table.remove(valid_cards, pseudorandom("Bad service! You are here early!", 1, #valid_cards))
					card:set_seal("dbbq_pet", true, true)
				end
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{ref_table = "card.joker_display_values", ref_value = "seals"}
			},
			text_config = {colour = G.C.IMPORTANT},
			calc_function = function(card)
				if #G.play > 0 then return end
				local seals = 0
				for _, area in ipairs({G.discard, G.hand, G.deck}) do
					for __, card_ in ipairs(area.cards) do
						if card_.seal == "dbbq_pet" then
							if area ~= G.discard then
								seals = seals + 1
							elseif not card_.ability.seal.extra.status and not card.ability.extra.success then
								card.joker_display_values.seals = "Failed"
								return
							end
						end
					end
				end
				card.joker_display_values.seals = seals.." Left"
			end
		}
	end
}

SMODS.Seal{
	key = "pet",
	atlas = "dbbq_seals",
	pos = {x = 0, y = 0},
	badge_colour = HEX("F68022"),
	config = {extra = {status = false}},
	loc_vars = function(self, info_queue, seal)
		info_queue[#info_queue+1] = G.P_SEALS.Gold
	end,
	calculate = function(self, seal, context)
		if context.main_scoring and context.cardarea == G.play then
			seal.ability.seal.extra.status = true
		elseif context.after then
			for _, area in ipairs({G.play, G.hand, G.discard, G.deck}) do
				for __, card in ipairs(area.cards) do
					if card.seal == "dbbq_pet" and not card.ability.seal.extra.status then
						return
					end
				end
			end
			for _, joker in ipairs(G.jokers.cards) do
				if joker.config.center.key == "j_dbbq_horse" then
					joker.ability.extra.success = true
				end
			end
			for _, area in ipairs({G.play, G.hand, G.discard, G.deck}) do
				for __, card in ipairs(area.cards) do
					if card.seal == "dbbq_pet" then
						card.ability.seal.extra.status = false
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.1,
							func = function()
								card:set_seal("Gold", nil, true)
								return true
							end
						}))
					end
				end
			end
		elseif context.playing_card_end_of_round then
			seal:set_seal()
		end
	end,
	in_pool = function(self, args)
		return false
	end
}

--[[
Cucumber Horse (Old)

When Blind is selected: Any Pet Joker you own is destroyed and adds +100 Chips to this card
If all four Pet Jokers are given, this will also pay out $10 each Round
--]]
