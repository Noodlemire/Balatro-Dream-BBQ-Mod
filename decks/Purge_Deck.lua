--[[
Purge Deck

When Boss Blind is defeated:
Destroy all playing cards of one random Rank
Cycles through all possible Ranks, repeating the order if necessary

"The Purge Event is a mysterious",
"dance party that leads to the",
"transformations of all guests",
"into cannibalistic beasts.",
"Similarly, this deck will",
"also steadily rid itself of all",
"inhabitants.",
"This is very strong for deck-fixing",
"but there's always the chance that",
"you lose a bunch of your best cards.",
"In addition, there is minimal benefit",
"to using this deck in early Antes."
--]]

SMODS.Back{
	key = "purge",
	atlas = "dbbq_decks",
	pos = {x = 0, y = 0},
	calculate = function(self, deck, context)
		if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
			if not G.GAME.dbbq_purge_order then
				local order = {}
				for k, v in pairs(SMODS.Ranks) do
					local i = 1 + pseudorandom("That whistle sounds... hungry...") * #order
					table.insert(order, i, k)
				end
				G.GAME.dbbq_purge_order = order
			end
			if not G.GAME.dbbq_purge_index or G.GAME.dbbq_purge_index >= #G.GAME.dbbq_purge_order then
				G.GAME.dbbq_purge_index = 1
			else
				G.GAME.dbbq_purge_index = G.GAME.dbbq_purge_index + 1
			end
			local rank = G.GAME.dbbq_purge_order[G.GAME.dbbq_purge_index]
			local destroy_cards = {}
			local destroy_indices = {}
			for i, card in ipairs(G.playing_cards) do
				if card.base.value == rank and not SMODS.has_no_rank(card) then
					table.insert(destroy_cards, card)
					draw_card(G.deck, G.play, 1, "up", false, card)
				end
			end
			if #destroy_cards > 0 then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						SMODS.destroy_cards(destroy_cards)
						return true
					end
				}))
			end
		end
	end
}
