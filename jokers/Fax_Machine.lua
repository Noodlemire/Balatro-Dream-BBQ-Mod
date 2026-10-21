--[[
Fax Machine
Rare, $7

When poker hand is played:
If held cards contain all of:
Ranks 3, 4, 6, 8, and three 7s,
All cards held in hand gain double their Chips
--]]

--Known bug: Somehow, when used in tandem with UNIK's Mod and Bundles of Fun, attempting to add onto perma_bonus simply fails. No crash, it just acts like 0 + 8 = 0 and moves on. No clue how to fix.

local key = "fax"
DBBQ.quip_colours[key] = {HEX("000000"), HEX("bcb191"), HEX("cd4c3c")}
DBBQ.quip_pitch[key] = 1.5
DBBQ.add_quip(key, "handshake", "win", 14)
DBBQ.add_quip(key, "shambles", "loss", 9)
DBBQ.add_quip(key, "opportunity", "loss", 15, 0.2)
DBBQ.add_quip(key, "highly", "any", 13)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 7,
	pos = {x = 4, y = 0},
	blueprint_compat = true,
	pronouns = "she_her",
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
    end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "8"},
				{text = "7"},
				{text = "7"},
				{text = "7"},
				{text = "6"},
				{text = "4"},
				{text = "3"},
			},
			style_function = function(card, text, reminder_text, extra)
				if text and #text.children == 7 then
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
					text.children[1].config.colour = ranks['8'] == 1 and G.C.MULT or G.C.GREEN
					text.children[2].config.colour = ranks['7'] == 3 and G.C.MULT or G.C.GREEN
					text.children[3].config.colour = ranks['7'] >= 2 and G.C.MULT or G.C.GREEN
					text.children[4].config.colour = ranks['7'] >= 1 and G.C.MULT or G.C.GREEN
					text.children[5].config.colour = ranks['6'] == 1 and G.C.MULT or G.C.GREEN
					text.children[6].config.colour = ranks['4'] == 1 and G.C.MULT or G.C.GREEN
					text.children[7].config.colour = ranks['3'] == 1 and G.C.MULT or G.C.GREEN
				end
				return false
			end
		}
	end
}
