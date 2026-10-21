--[[
Henohenohomeji
Uncommon, $7

When Blind is selected:
Create a random Enhanced
face card and draw it to hand

Also I'll write this here because
japanese characters do not render
in Balatro itself, or at least
not with the default English font.
じょ = jo
け = ke
る = ru
--]]

local key = "heno"
DBBQ.quip_colours[key] = {HEX("e9ae38"), HEX("232012"), HEX("f25f38")}
DBBQ.quip_pitch[key] = 0.85
DBBQ.add_quip(key, "boss", "win", 10)
DBBQ.add_quip(key, "dratula", "any", 6, 0.3)
DBBQ.add_quip(key, "nuts", "any", 9)
DBBQ.add_quip(key, "pengvin", "loss", 10)
DBBQ.add_quip(key, "stronk", "win", 7)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 7,
	pos = {x = 2, y = 1},
	blueprint_compat = true,
	pronouns = "he_him",
	dbbq_i_am_the_boss = "dbbq_boss_heno",
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_heno", set = "Other"}
		end
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			local rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed("I AM DRATULAAAAA!!!!!"))
			local suit = pseudorandom_element({'S','H','D','C'}, pseudoseed("I AM A VAMPIRE, SO STRONK!"))
			local cen_pool = {}
			for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
				if v.key ~= 'm_stone' and not v.no_rank then 
					cen_pool[#cen_pool+1] = v
				end
			end
			local new_card = create_playing_card({front = G.P_CARDS[suit..'_'..rank], center = pseudorandom_element(cen_pool, pseudoseed("GOOD MORNINK!"))}, G.hand, nil, false, {G.C.SECONDARY_SET.Enhanced}, true)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand:emplace(new_card)
					new_card:start_materialize()
					G.GAME.blind:debuff_card(new_card)
					G.hand:sort()
					if context.blueprint_card then
						context.blueprint_card:juice_up()
					else
						card:juice_up()
					end
					return true
				end
			}))
			SMODS.calculate_context({playing_card_added = true, cards = {new_card}})
			return nil, true
		end
	end
}
