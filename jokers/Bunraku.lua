--[[
Bunraku
Rare, $8

Gains X0.1 Mult every time a non-Bunraku Joker is triggered while in a Blind
Half of Mult will be lost when one of your played cards is first scored, at random
(Currently: X0 Mult)
--]]

SMODS.Joker{
	key = "bunraku",
	loc_txt = {
		name = "Bunraku",
		text = {
			"Gains {X:mult,C:white}X#1#{} Mult every time a non-{C:attention}Bunraku{}",
			"Joker is triggered while in a {C:attention}Blind{}",
			"Half of Mult will be lost when one of your",
			"played cards is first scored, at random",
			"{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 5, y = 0},
	blueprint_compat = true,
    config = {extra = {Xmult_gain = 0.1, Xmult = 0, dbbq_quotes = {
		{type = "any", key = "j_dbbq_bunraku_haters"},
		{type = "win", key = "j_dbbq_bunraku_harder"},
		{type = "win", key = "j_dbbq_bunraku_comes"},
		{type = "lose", key = "j_dbbq_bunraku_bathroom"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_bunraku", set = "Other"}
		end
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {xmult = card.ability.extra.Xmult}
		elseif context.blueprint then
			return
		end
		if context.before and context.main_eval then
			local nondebuffed = {}
			for i, v in ipairs(context.scoring_hand) do
				if not v.debuff then
					nondebuffed[#nondebuffed+1] = i
				end
			end
			if #nondebuffed > 0 then
				card.ability.extra.reset = pseudorandom_element(nondebuffed, "Yeeeaaaahaha!!")
			end
		elseif context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[card.ability.extra.reset] then
			card.ability.extra.reset = nil
			card.ability.extra.Xmult = card.ability.extra.Xmult / 2
			return {
				message = localize("k_reset"),
				colour = G.C.RED,
				message_card = card
			}
		elseif context.post_trigger and G.GAME.blind.in_blind and context.other_card.config.center and context.other_card.config.center.key ~= "j_dbbq_bunraku" then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.RED,
				message_card = card
			}
		end
	end
}
