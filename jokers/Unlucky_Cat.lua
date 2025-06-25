--[[
Unlucky Cat
Uncommon, $6

X2 Mult
If a Glass Card shatters or a Lucky Card fails,
destroy this card
--]]

SMODS.Joker{
	key = "unlucky",
	loc_txt = {
		name = "Unlucky Cat",
		text = {
			"{X:mult,C:white} X#1# {} Mult",
			"If {C:inactive}Glass Card{} shatters",
			"or a {C:attention}Lucky Card{} fails,",
			"destroy this card",
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 3, y = 4},
	blueprint_compat = true,
    config = {extra = {Xmult = 2}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_unlucky", set = "Other"}
		end
        return {vars = {card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		elseif not context.blueprint then
			local meteor = false
			if context.remove_playing_cards then
				for _, removed_card in ipairs(context.removed) do
					if removed_card.shattered then
						meteor = true
						break
					end
				end
			elseif context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_lucky') and not context.other_card.lucky_trigger then
				meteor = true
			end
			if meteor then
				card.getting_sliced = true
				card:start_dissolve()
			end
		end
	end,
    in_pool = function(self, args)
        return false
    end
}
