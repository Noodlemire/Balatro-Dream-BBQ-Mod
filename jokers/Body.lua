--[[
Body
Common, $4

Any attempt to destroy a playing
card will instead upgrade its
edition, unless it's already
Polychrome or has a modded edition
(Foil -> Holographic -> Polychrome)
--]]

SMODS.Joker{
	key = "body",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 7, y = 4},
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_body", set = "Other"}
		end
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
	end,
	in_pool = function(self, args)
		return G.GAME.selected_back ~= "b_dbbq_purge" and G.GAME.selected_sleeve ~= "sleeve_dbbq_purge"
	end
}

local function body_effect(self)
	if not self.debuff and self.ability and (self.ability.set == "Default" or self.ability.set == "Enhanced") and #SMODS.find_card("j_dbbq_body") > 0 and (not self.edition or self.edition.foil or self.edition.holo) then
		self.getting_sliced = nil
		self.destroyed = nil
		self.shattered = nil
		if not self.edition then
			self:set_edition{foil = true}
		elseif self.edition.foil then
			self:set_edition{holo = true}
		else
			self:set_edition{polychrome = true}
		end
		return true
	end

	return false
end

local old_card_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	if not body_effect(self) then
		old_card_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
	end
end

local old_card_shatter = Card.shatter
function Card:shatter()
	if not body_effect(self) then
		old_card_shatter(self)
	end
end

local old_dfptd = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
	for _, self in ipairs(G.play.cards) do
		if not self.debuff and self.ability and (self.ability.set == "Default" or self.ability.set == "Enhanced") and #SMODS.find_card("j_dbbq_body") > 0 and (not self.edition or self.edition.foil or self.edition.holo) then
			--I don't know why playing cards get re-destroyed/shattered after these values are nil'd in the start_dissolve hook, but this is what fixes it.
			self.getting_sliced = nil
			self.destroyed = nil
			self.shattered = nil
		end
	end
	old_dfptd(e)
end
