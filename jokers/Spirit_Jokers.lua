--[[
Spirit Jokers
Common, $4

Tells you the Ranks and Suits of the top 5 cards in your deck
However, one always lies
One says: <cards>
Another says:
--]]

local NOTHING = "Nothing yet"

SMODS.Joker{
	key = "spirit",
	loc_txt = {
		name = "Spirit Jokers",
		text = {
			"Tells you the {C:attention}Ranks{} and {C:attention}Suits{}",
			"of the top {C:chips}#1#{} cards in your deck",
			"However, one always lies",
			"One says: {C:mult}\"#2#\"",
			"Another says: {C:mult}\"#3#\"",
		}
	},
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 0, y = 4},
	blueprint_compat = false,
	config = {extra = {cards = 5, say1 = NOTHING, say2 = NOTHING}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_spirit", set = "Other"}
		end
        return {vars = {card.ability.extra.cards, card.ability.extra.say1, card.ability.extra.say2}}
    end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		--if context.first_hand_drawn or context.hand_drawn then
		if context.hand_drawn then
			local toptruth = pseudorandom("Green is a poisonous color?") < 0.5
			local spirit1 = {}
			local spirit2 = {}
			for i = 1, card.ability.extra.cards do
				spirit1.ind = #G.deck.cards + 1 - i
				spirit2.ind = 1 + math.floor(pseudorandom("Ha ha ha!") * #G.deck.cards)
				if not toptruth then
					local temp = spirit1.ind
					spirit1.ind = spirit2.ind
					spirit2.ind = temp
				end
				for _, spirit in ipairs({spirit1, spirit2}) do
					local playing_card = G.deck.cards[spirit.ind]
					if playing_card and not (SMODS.has_no_rank(playing_card) or SMODS.has_no_suit(playing_card)) then
						local rank = playing_card.base.value
						if rank ~= tostring(tonumber(rank)) then
							rank = rank:sub(1, 1)
						end
						spirit.say = rank..playing_card.base.suit:sub(1, 1)
					else
						spirit.say = "Nil"
					end
				end
				if i == 1 then
					card.ability.extra.say1 = spirit1.say
					card.ability.extra.say2 = spirit2.say
				else
					card.ability.extra.say1 = card.ability.extra.say1..", "..spirit1.say
					card.ability.extra.say2 = card.ability.extra.say2..", "..spirit2.say
				end
			end
		elseif context.end_of_round and context.game_over == false and context.main_eval then
			card.ability.extra.say1 = NOTHING
			card.ability.extra.say2 = NOTHING
		end
	end
}
