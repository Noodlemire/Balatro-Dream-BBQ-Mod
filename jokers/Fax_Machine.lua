--[[
Fax Machine
Rare, $7

When poker hand is played:
If held cards contain all of:
Ranks 3, 4, 6, 8, and three 7s,
All cards held in hand gain
double their Chips
--]]

SMODS.Joker{
	key = "fax",
	loc_txt = {
		name = "Fax Machine",
		text = {
			"When {C:attention}poker hand{} is played:",
			"If held cards contain all of:",
			"Ranks {C:money}3{}, {C:money}4{}, {C:money}6{}, {C:money}8{}, and three {C:money}7{}s,",
			"All cards held in hand",
			"{C:chips}double{} their Chips"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 7,
	pos = {x = 4, y = 0},
	blueprint_compat = true,
    config = {extra = {upgrade = false}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_fax", set = "Other"}
		end
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			local ranks = {
				['3'] = 1,
				['4'] = 1,
				['6'] = 1,
				['7'] = 3,
				['8'] = 1,
			}
			for _, held in ipairs(G.hand.cards) do
				local id = tostring(held:get_id())
				if not SMODS.has_no_rank(held) and not card.debuff and ranks[id] then
					ranks[id] = ranks[id] - 1
				end
			end
			for _, rank in pairs(ranks) do
				if rank > 0 then
					card.ability.extra.upgrade = false
					return
				end
			end
			card.ability.extra.upgrade = true
		elseif context.individual and context.cardarea == G.hand and not context.end_of_round and card.ability.extra.upgrade then
			if context.other_card.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED
				}
			else
				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + context.other_card:get_chip_bonus()
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
            end
		end
	end
}
