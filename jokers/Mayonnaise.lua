--[[
Mayonnaise
Rare, $12

Blind the Blind, so it can't see you cheating your discards
(Your discards are free)
However, it will be extremely angry and become X10 as strong
(You may may get blasted by a giant laser)
--]]

SMODS.Joker{
	key = "mayo",
	loc_txt = {
		name = "Mayonnaise",
		text = {
			"Blind the {C:attention}Blind{}, so it can't",
			"see you cheating your {C:mult}discards{}",
			"{C:inactive}(Your discards are free){}",
			"However, it wil be extremely",
			"angry and become {X:mult,C:white}X#1#{} as strong",
			"{C:inactive}(You may get blasted by a giant laser)"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 12,
	pos = {x = 4, y = 4},
	blueprint_compat = false,
	config = {extra = {blind_angy = 10}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.blind_angy}}
    end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.setting_blind then
			G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_angy
    		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.GAME.blind:set_text()
			G.GAME.blind:wiggle()
		elseif context.discard and context.other_card == context.full_hand[#context.full_hand] then
			ease_discard(1, nil, true)
		end
	end
}
