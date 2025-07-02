SMODS.Atlas {
    key = "dbbq_jokers",
    path = "Jokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "dbbq_decks",
    path = "Decks.png",
    px = 71,
    py = 95,
}

local jokers = NFS.getDirectoryItems(SMODS.current_mod.path.."jokers")
for _, filename in pairs(jokers) do
    if string.sub(filename, string.len(filename) - 3) == '.lua' then
        assert(SMODS.load_file("jokers/"..filename))()
    end
end

local decks = NFS.getDirectoryItems(SMODS.current_mod.path.."decks")
for _, filename in pairs(decks) do
    if string.sub(filename, string.len(filename) - 3) == '.lua' then
        assert(SMODS.load_file("decks/"..filename))()
    end
end

local next_quote = nil

local old_cc_init = Card_Character.init
function Card_Character:init(args)
	if not G.jokers then
		return old_cc_init(self, args)
	end
	local eligible_jokers = {}
	for _, joker in ipairs(G.jokers.cards) do
		if type(joker.ability.extra) == "table" and joker.ability.extra.dbbq_quotes then
			eligible_jokers[#eligible_jokers+1] = joker
		end
	end
	if (G.STATE == G.STATES.GAME_OVER or G.GAME.won) and #eligible_jokers > 0 then
		local joker = pseudorandom_element(eligible_jokers, "Hope you don't mind, but could you tell me-")
		local eligible_quotes = {}
		for _, quote in ipairs(joker.ability.extra.dbbq_quotes) do
			if (G.STATE == G.STATES.GAME_OVER and quote.type ~= "win") or (G.GAME.won and quote.type ~= "lose") then
				eligible_quotes[#eligible_quotes+1] = quote
			end
		end
		if #eligible_quotes > 0 then
			args.center = joker.config.center
			next_quote = pseudorandom_element(eligible_quotes, "WHERE THE HELL IS THE BOSS?!").key
		end
	end
	old_cc_init(self, args)
end

local old_cc_add_speech_bubble = Card_Character.add_speech_bubble
function Card_Character:add_speech_bubble(text_key, align, loc_vars)
	if next_quote then
		text_key = next_quote
		next_quote = nil
	end
	old_cc_add_speech_bubble(self, text_key, align, loc_vars)
end
