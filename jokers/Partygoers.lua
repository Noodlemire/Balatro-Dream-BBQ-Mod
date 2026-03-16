--[[
Partygoers
Common, $4

Wild Cards score +Mult
instead of +Chips equal
to their base value
--]]

SMODS.Joker{
	key = "pg",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 0, y = 5},
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_pg", set = "Other"}
		end
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
	end
}

local old_card_chips = Card.get_chip_bonus
function Card:get_chip_bonus()
	local chips = old_card_chips(self)
	if #SMODS.find_card("j_dbbq_pg") > 0 and not SMODS.has_no_rank(self) and SMODS.has_enhancement(self, "m_wild") then
		chips = chips - self.base.nominal
	end
	return chips
end

local old_card_mult = Card.get_chip_mult
function Card:get_chip_mult()
	local mult = old_card_mult(self)
	if #SMODS.find_card("j_dbbq_pg") > 0 and not SMODS.has_no_rank(self) and SMODS.has_enhancement(self, "m_wild") then
		mult = mult + self.base.nominal
	end
	return mult
end
