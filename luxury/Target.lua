--[[
Target
Luxury, $8

Selects a random card each round, and
becomes usable if you play that card,
Use to create a joker based on that card
(Currently: ??? of ??? to create ???)
--]]

local joker_map = {}

local function select_joker(item)
	item.ability.extra.played = false
	local card_map, card_pool, joker_pool = {}, {}, {}
	local highest = 0
	local previous = (item.ability.extra.suit or "???")..(item.ability.extra.rank or "???")
	for _, card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(card) and not SMODS.has_no_suit(card) then
			local key = card.base.suit..card.base.value
			if key ~= previous then
				card_map[key] = card_map[key] or {
					suit = card.base.suit,
					rank = tostring(card.base.value),
					amount = 0
				}
				card_map[key].amount = card_map[key].amount + 1
				if card_map[key].amount > highest then
					highest = card_map[key].amount
				end
			end
		end
	end
	for k, v in pairs(card_map) do
		for i = 1, 1 + highest - v.amount do
			table.insert(card_pool, v)
		end
	end
	local card = pseudorandom_element(card_pool, "c_dbbq_target")
	if not card then return end
	for joker, set in pairs(joker_map) do
		if set.suits[card.suit] or set.ranks[card.rank] then
			table.insert(joker_pool, joker)
		end
	end
	local joker_key = pseudorandom_element(joker_pool, "c_dbbq_target")
	if not joker_key then return end
	item.ability.extra.rank = card.rank
	item.ability.extra.suit = card.suit
	item.ability.extra.joker = joker_key
end

DBBQ.Luxury{
	key = "target",
	soul_pos = {x = 1, y = 1},
	config = {extra = {rank = false, suit = false, joker = false, used = false, played = false}},
	loc_vars = function(self, info_queue, item)
		local iae = item.ability.extra
		if iae.joker then
			info_queue[#info_queue + 1] = G.P_CENTERS[iae.joker]
		end
		return {vars = {
			iae.rank and localize(iae.rank, "ranks") or "???",
			iae.suit and localize(iae.suit, "suits_plural") or "???",
			iae.joker and localize{type = "name_text", key = iae.joker, set = "Joker"} or "???"
		}}
	end,
	luxury_can_use = function(self, item)
		return item.ability.extra.played and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
	end,
	luxury_use = function(self, item, area)
		G.E_MANAGER:add_event(Event({
			func = function()
				SMODS.add_card({key = item.ability.extra.joker})
				item:juice_up(0.3, 0.5)
				return true
			end
		}))
		SMODS.calculate_effect({message = localize("k_plus_joker"), sound = "tarot1"}, item)
	end,
	add_to_deck = function(self, item, from_debuff)
		DBBQ.Luxury.add_to_deck(self, item, from_debuff)
		if not from_debuff then
			select_joker(item)
		end
	end,
	calculate = function(self, item, context)
		DBBQ.Luxury.calculate(self, item, context)
		if context.blueprint then return end
		if context.end_of_round and context.main_eval and not context.game_over then
			select_joker(item)
		elseif context.before and item.ability.extra.joker then
			for _, card in ipairs(context.scoring_hand) do
				if card.base.suit == item.ability.extra.suit and tostring(card.base.value) == item.ability.extra.rank then
					item.ability.extra.played = true
					return
				end
			end
		end
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.after and item.ability.extra.played
	end
}

function DBBQ.register_target_joker(key, def)
	if joker_map[key] then
		sendWarnMessage(("DBBQ.register_target_joker: Joker key '%s' has already been registered."):format(key), "dbbq_luxury")
		return
	elseif not G.P_CENTERS[key] then
		sendWarnMessage(("DBBQ.register_target_joker: Joker key '%s' does not exist."):format(key), "dbbq_luxury")
		return
	elseif G.P_CENTERS[key].set ~= "Joker" then
		sendWarnMessage(("DBBQ.register_target_joker: Key '%s' is a '%s', not a Joker."):format(key, G.P_CENTERS[key].set), "dbbq_luxury")
		return
	end
	local set = {suits = {}, ranks = {}}
	for k, v in pairs(def) do
		if k ~= "suits" and k ~= "ranks" then
			sendWarnMessage(("DBBQ.register_target_joker: Definition key '%s' should instead be one of: 'suits', 'ranks'"):format(key), "dbbq_luxury")
			return
		end
		if type(v) ~= "table" then
			v = {v}
		end
		for _, a in ipairs(v) do
			set[k][tostring(a)] = true
		end
	end
	joker_map[key] = set
end

DBBQ.register_target_joker("j_greedy_joker", {suits = "Diamonds"})
DBBQ.register_target_joker("j_lusty_joker", {suits = "Hearts"})
DBBQ.register_target_joker("j_wrathful_joker", {suits = "Spades"})
DBBQ.register_target_joker("j_gluttenous_joker", {suits = "Clubs"})
DBBQ.register_target_joker("j_8_ball", {ranks = 8})
DBBQ.register_target_joker("j_fibonacci", {ranks = {2, 3, 5, 8, "Ace"}})
DBBQ.register_target_joker("j_scary_face", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_hack", {ranks = {2, 3, 4, 5}})
DBBQ.register_target_joker("j_even_steven", {ranks = {2, 4, 6, 8, 10}})
DBBQ.register_target_joker("j_odd_todd", {ranks = {3, 5, 7, 9, "Ace"}})
DBBQ.register_target_joker("j_scholar", {ranks = "Ace"})
DBBQ.register_target_joker("j_business", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_ride_the_bus", {ranks = {"Ace", 2, 3, 4, 5, 6, 7, 8, 9, 10}})
DBBQ.register_target_joker("j_blackboard", {suits = {"Spades", "Clubs"}})
DBBQ.register_target_joker("j_sixth_sense", {ranks = 6})
DBBQ.register_target_joker("j_faceless", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_superposition", {ranks = "Ace"})
DBBQ.register_target_joker("j_baron", {ranks = "King"})
DBBQ.register_target_joker("j_cloud_9", {ranks = 9})
DBBQ.register_target_joker("j_midas_mask", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_photograph", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_reserved_parking", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_walkie_talkie", {ranks = {4, 10}})
DBBQ.register_target_joker("j_smiley", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_sock_and_buskin", {ranks = {"King", "Queen", "Jack"}})
DBBQ.register_target_joker("j_rough_gem", {suits = "Diamonds"})
DBBQ.register_target_joker("j_bloodstone", {suits = "Hearts"})
DBBQ.register_target_joker("j_arrowhead", {suits = "Spades"})
DBBQ.register_target_joker("j_onyx_agate", {suits = "Clubs"})
DBBQ.register_target_joker("j_flower_pot", {suits = {"Diamonds", "Hearts", "Spades", "Clubs"}})
DBBQ.register_target_joker("j_wee", {ranks = 2})
DBBQ.register_target_joker("j_seeing_double", {suits = "Clubs"})
DBBQ.register_target_joker("j_hit_the_road", {ranks = "Jack"})
DBBQ.register_target_joker("j_shoot_the_moon", {ranks = "Queen"})

G.E_MANAGER:add_event(Event({
	func = function()
		DBBQ.register_target_joker("j_dbbq_brc", {suits = {"Hearts", "Clubs"}})
		DBBQ.register_target_joker("j_dbbq_fax", {ranks = {3, 4, 6, 7, 8}})
		DBBQ.register_target_joker("j_dbbq_heno", {ranks = {"King", "Queen", "Jack"}})
		DBBQ.register_target_joker("j_dbbq_honest", {suits = "Spades"})
		DBBQ.register_target_joker("j_dbbq_sixeyed", {ranks = 6})
		return true
	end
}))
