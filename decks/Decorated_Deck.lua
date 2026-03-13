--[[
Decorated Deck

Start run with half of the
deck consisting of 4 new
Suits with special effects
Cards of these suits
may appear in packs

"Dream BBQ's title screen and official trailer",
"both feature a bunch of these random little",
"animated GIFs, and I figured they'd make for",
"some neat animated card suits. The sprite of",
"the deck itself is also based on the title",
"screen's background of various decorated tiles."
"There are actually way more than 4 of the little",
"GIFs, I just chose my favorites to keep the",
"scope of this deck reasonable."
--]]

DBBQ.deco_prune_deck = function(cond)
	if cond then
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in pairs(G.playing_cards) do
					if v.base.id == 2 or v.base.id == 4 or v.base.id == 6 or v.base.id == 8 or v.base.id == 10 or v.base.id == 12 or v.base.id == 14 then
						if v.base.suit == "Clubs" then
							v:change_suit("dbbq_travel")
						elseif v.base.suit == "Spades" then
							v:change_suit("dbbq_utility")
						elseif v.base.suit == "Hearts" then
							v:change_suit("dbbq_grit")
						elseif v.base.suit == "Diamonds" then
							v:change_suit("dbbq_fish")
						end
					end
				end
				G.GAME.dbbq_spawn_custom_ranks = true
				return true
			end
		}))
	else
		G.GAME.dbbq_spawn_custom_ranks = true
	end
end

SMODS.Back{
	key = "deco",
	atlas = "dbbq_decks",
	pos = {x = 1, y = 0},
	apply = function(self, back)
		DBBQ.deco_prune_deck(G.GAME.selected_sleeve ~= "sleeve_dbbq_deco")
	end
}
