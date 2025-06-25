--[[
Eye Of The Beholder
Rare, $8

Each time you play and score one of each (Vanilla) Rank, gain X1 Mult
(Remaining: 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A)
(Currently: X1 Mult)
--]]

local VANILLA_RANKS = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'}

SMODS.Joker{
	key = "beholder",
	loc_txt = {
		name = "Eye Of The Beholder",
		text = {
			"Each time you play and score one of",
			"each {C:inactive}(Vanilla){} Rank, gain {X:mult,C:white}X#1#{} Mult",
			"{C:inactive}(Remaining: {C:chips}#2#{C:inactive})",
			"{C:inactive}(Currently: {X:mult,C:white}X#3#{C:inactive} Mult)"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 3, y = 0},
	blueprint_compat = true,
    config = {extra = {Xmult_gain = 1, played = {}, Xmult = 1}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_beholder", set = "Other"}
		end
		local remaining = ""
		for _, rank in ipairs(VANILLA_RANKS) do
			if not card.ability.extra.played[rank] then
				if remaining:len() == 0 then
					remaining = rank
				else
					remaining = remaining..", "..rank
				end
			end
		end
        return {vars = {card.ability.extra.Xmult_gain, remaining, card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		elseif context.before and context.main_eval and not context.blueprint then
			for _, play in ipairs(context.scoring_hand) do
				local id = play:get_id()
				if id >= 2 and id <= 14 and not SMODS.has_no_rank(play) then
					if id == 11 then id = 'J'
					elseif id == 12 then id = 'Q'
					elseif id == 13 then id = 'K'
					elseif id == 14 then id = 'A'
					else id = tostring(id)
					end
					card.ability.extra.played[id] = true
				end
			end
			for _, rank in ipairs(VANILLA_RANKS) do
				if not card.ability.extra.played[rank] then
					return
				end
			end
			card.ability.extra.played = {}
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.MULT
			}
		end
	end
}
