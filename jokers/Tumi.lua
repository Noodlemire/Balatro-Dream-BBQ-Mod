--[[
Tumi
Uncommon, $8

If poker hand is <hand>:
X4 Mult and +1 hand
X0 Mult otherwise
Poker hand changes
after every hand played
--]]

SMODS.Joker{
	key = "tumi",
	loc_txt = {
		name = "Tumi",
		text = {
			"If {C:attention}poker hand{} is {C:attention}#1#{}:",
			"{X:mult,C:white}X#2#{} Mult and {C:blue}+#3#{} hand",
			"{X:mult,C:white}X#4#{} Mult otherwise",
			"Poker hand changes",
			"after every hand played"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 1, y = 4},
	blueprint_compat = true,
	config = {extra = {poker_hand = "High Card", Xmult = 4, hand = 1, penalty = 0}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.poker_hand, card.ability.extra.Xmult, card.ability.extra.hand, card.ability.extra.penalty}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			if context.scoring_name == card.ability.extra.poker_hand then
				return {
					xmult = card.ability.extra.Xmult,
					message = localize("ph_you_win"),
					func = function()
						ease_hands_played(card.ability.extra.hand)
					end
				}
			else
				return {
					xmult = card.ability.extra.penalty,
					message = localize("k_nope_ex")
				}
			end
		elseif context.after and context.main_eval and not context.blueprint then
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.extra.poker_hand then
					_poker_hands[#_poker_hands + 1] = k
				end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed((card.area and card.area.config.type == "title") and "false_to_do" or "to_do"))
			return {
				message = card.ability.extra.poker_hand
			}
		end
	end
}
