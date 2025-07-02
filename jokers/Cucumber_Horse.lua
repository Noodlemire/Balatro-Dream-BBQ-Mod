--[[
Cucumber Horse
Uncommon, $4

When Blind is selected: Any Pet Joker you own is destroyed and adds +100 Chips to this card
If all four Pet Jokers are given, this will also pay out $10 each Round
--]]

SMODS.Joker{
	key = "horse",
	loc_txt = {
		name = "Cucumber Horse",
		text = {
			"When {C:attention}Blind{} is selected:",
			"Any {C:attention}Pet Joker{} you own is destroyed",
			"and adds {C:chips}+#1#{} Chips to this card",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
			"If all four {C:attention}Pet Jokers{} are given,",
			"this will also pay out {C:money}$#3# each Round"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 4,
	pos = {x = 2, y = 0},
	blueprint_compat = true,
    config = {extra = {chips_gain = 100, chips = 0, money = 10, dbbq_quotes = {
		{type = "win", key = "j_dbbq_horse_boss"},
		{type = "lose", key = "j_dbbq_horse_no"},
		{type = "lose", key = "j_dbbq_horse_shitchat"},
		{type = "win", key = "j_dbbq_horse_money"},
		{type = "win", key = "j_dbbq_horse_early"},
		{type = "win", key = "j_dbbq_horse_meal"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_horse", set = "Other"}
		end
        return {vars = {
			card.ability.extra.chips_gain,
			card.ability.extra.chips,
			card.ability.extra.money
		}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		elseif context.setting_blind and not context.blueprint then
			local gain = 0
			for _, joker in ipairs(G.jokers.cards) do
				if joker.config.center.key == "j_dbbq_pet" then
					gain = gain + 1
					joker.getting_sliced = true
					joker:start_dissolve()
				end
			end
			if gain > 0 then
				card.ability.extra.chips = card.ability.extra.chips + gain * card.ability.extra.chips_gain
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			end
		end
	end,
    calc_dollar_bonus = function(self, card)
		if card.ability.extra.chips >= 400 then
        	return card.ability.extra.money
		end
    end
}
