local adire_desc = {
	"{C:mult}+#1#{} Mult per unique",
	"{C:attention}rank{} held in hand"
}

local slots_desc = {
	"Once per round, you may pay {C:money}$#1#",
	"to spin the slots! This joker's",
	"effect changes based the symbols",
	"you get, and if all three are",
	"the same, you get {X:attention,C:white}X#2#{} the reward",
	"{C:white}.",
	"If played hand #3# a",
	"{C:attention}#4#{} with at least one",
	"scoring {V:1}#5#{} card,",
	"{V:2,B:3}#6#{} #7#"
}

local tpao_desc = {
	"When {C:attention}Blind{} is selected:",
	"Unpin and copy self without modifiers,",
	"then pin the copy to the left",
	"{C:inactive}(Must have room){}",
	"When {C:attention}Blind{} is defeated:",
	"If there's a copy to the right,",
	"destroy it and gain {X:mult,C:white}X#1#{} Mult",
	"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
}

local luxury_reusable = "{C:inactive}(Reusable each Ante.)"

local function won_run_with(stake, color)
	return {
		"Used this Joker",
		"to win on {C:"..color.."}"..stake,
		"{C:"..color.."}Stake{} difficulty"
	}
end

return {
	descriptions = {
		Enhanced = {
			m_dbbq_damson = {
				name = "Damson",
				text = {
					"Has no rank or suit,",
					"{C:attention}Straights{} and {C:attention}Flushes{} can",
					"be formed with one less",
					"card per scoring {C:spectral}Damson{}"
				}
			},
		},
		Joker = {
			j_dbbq_adire = {
				name = "A Dealer In Real Estate",
				text = adire_desc
			},
			j_dbbq_adire0 = {
				name = "A Dealer In Real Estate",
				text = adire_desc
			},
			j_dbbq_adire1 = {
				name = "A Speculator In The Real Estate Market",
				text = adire_desc
			},
			j_dbbq_adire2 = {
				name = "A Speculative Investor In Real Estate",
				text = adire_desc
			},
			j_dbbq_adire3 = {
				name = "A Prospective Buyer And Seller In Real Estate Properties",
				text = adire_desc
			},
			j_dbbq_adire4 = {
				name = "Someone In The Market For Real Estate",
				text = adire_desc
			},
			j_dbbq_adire5 = {
				name = "An Investor Hoping To Purchase Real Estate",
				text = adire_desc
			},
			j_dbbq_adire6 = {
				name = "A Realtor",
				text = adire_desc
			},
			j_dbbq_adire7 = {
				name = "A Real Estate Agent",
				text = adire_desc
			},
			j_dbbq_adire8 = {
				name = "Someone Attempting To Acquire Real Estate Property",
				text = adire_desc
			},
			j_dbbq_adire9 = {
				name = "A Speculative Developer Of Land And Properties",
				text = adire_desc
			},
			j_dbbq_adire10 = {
				name = "A Hopeful Arbitrageur",
				text = adire_desc
			},
			j_dbbq_adire11 = {
				name = "The Representative Of A C-REIT Looking For Leverageable Assets",
				text = adire_desc
			},
			j_dbbq_adire12 = {
				name = "A Trade-Up Buyer On The Scent Of A Land Rush",
				text = adire_desc
			},
			j_dbbq_adire13 = {
				name = "A Prospective Mover On The Front Lines Of A Restructuring In The Real Estate Sector",
				text = adire_desc
			},
			j_dbbq_adire14 = {
				name = "An Aggressive Speculator In High-Yield Land-Base Securities",
				text = adire_desc
			},
			j_dbbq_adire15 = {
				name = "An Expectant Home-Improvement Profiteer",
				text = adire_desc
			},
			j_dbbq_adire16 = {
				name = "A Proto-Speculator, Seeking Growth At All Costs In The Wake Of A Marketwide Liquidity Crisis",
				text = adire_desc
			},
			j_dbbq_adire17 = {
				name = "Someone Trying To Acquire High LTV Financial Instruments In The Emerging Local Sector Of Real Estate",
				text = adire_desc
			},
			j_dbbq_adire18 = {
				name = "A Wannabe House Flipper",
				text = adire_desc
			},
			j_dbbq_adire19 = {
				name = "An Aspiring Property Enrichment Specialist Dabbling In Quick-Turnaround Investments",
				text = adire_desc
			},
			j_dbbq_adire20 = {
				name = "An Entry-Level Property Czar",
				text = adire_desc
			},
			j_dbbq_adire21 = {
				name = "A Would-Be Land Banker Rapidly Trading In Securitized Property Assets",
				text = adire_desc
			},
			j_dbbq_antifun = {
				name = "Anti-Fun Joker",
				text = {
					"When {C:attention}Blind{} is selected:",
					"Loses {X:mult,C:white}X#1#{} Mult for each",
					"{C:attention}Enhanced{} card in full deck",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					"When Blind is defeated,",
					"transforms into {C:inactive}Mean Joker{}",
					"{C:inactive}(Challenge-Only)"
				}
			},
			j_dbbq_bathroom = {
				name = "BATHROOM",
				text = {
					"When sold, {C:mult}destroys all Jokers{}",
					"For every third {C:attention}Joker{} destroyed,",
					"you gain {C:green}+#1# Joker Slot{}",
					"{C:inactive}(Includes itself)"
				}
			},
			j_dbbq_blobby = {
				name = "Blobby Joker",
				text = {
					"{C:mult}+#1#{} Mult if you don't",
					"play one of your",
					"most played hands"
				}
			},
			j_dbbq_brc = {
				name = "Blue Red Combine",
				text = {
					"{C:attention}Retrigger{} first {C:clubs}Club{} and {C:hearts}Heart",
					"in scoring hand if it has both"
				}
			},
			j_dbbq_body = {
				name = "Body",
				text = {
					"Any attempt to destroy a playing",
					"card will instead {C:attention}upgrade{} its",
					"edition, unless it's already",
					"{C:polychrome}Polychrome{} or has a modded edition",
					"{C:inactive}({C:dark_edition}Foil {C:inactive}-> {C:dark_edition}Holographic {C:inactive}-> {C:dark_edition}Polychrome{C:inactive})"
				}
			},
			j_dbbq_bunraku = {
				name = "Bunraku",
				text = {
					"Gains {X:mult,C:white}X#1#{} Mult every time a non-{C:attention}Bunraku{}",
					"Joker is triggered while in a {C:attention}Blind{}",
					"Half of Mult will be lost when one of your",
					"played cards is first scored, at random",
					"{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)"
				}
			},
			j_dbbq_capsule = {
				name = "Capsule of One",
				text = {
					"{C:attention}+#1#{} shop card slots, but you",
					"may only buy {C:attention}one{} card out",
					"of each set of shop cards"
				}
			},
			j_dbbq_horse = {
				name = "Cucumber Horse",
				text = {
					"When {C:attention}Blind{} is selected:",
					"{C:attention}#1#{} random cards in deck",
					"will gain {C:attention}Pet? Seals",
				}
			},
			j_dbbq_diah = {
				name = "Dog Inside An Hourglass",
				text = {
					"{C:money}Sell{} during a {C:attention}Blind{}",
					"to gain {C:chips}+#1#{} hands",
				}
			},
			j_dbbq_beholder = {
				name = "Eye Of The Beholder",
				text = {
					"Each time you play and score one of",
					"each {C:inactive}(Vanilla){} Rank, gain {X:mult,C:white}X#1#{} Mult",
					"{C:inactive}(Remaining: {C:chips}#2#{C:inactive})",
					"{C:inactive}(Currently: {X:mult,C:white}X#3#{C:inactive} Mult)"
				}
			},
			j_dbbq_fax = {
				name = "Fax Machine",
				text = {
					"When {C:attention}poker hand{} is played:",
					"If held cards contain all of:",
					"Ranks {C:money}3{}, {C:money}4{}, {C:money}6{}, {C:money}8{}, and three {C:money}7{}s,",
					"All cards held in hand",
					"{C:chips}double{} their Chips"
				}
			},
			j_dbbq_girl = {
				name = "Girl Girl",
				text = {
					"When {C:attention}Blind{} is selected:",
					"Flip and shuffle all Jokers",
					"{C:green}#1# in #2#{} chance: Add {C:dark_edition}Negative{}",
					"to one other Joker at random"
				}
			},
			j_dbbq_head = {
				name = "Head Chaffeur",
				text = {
					"When {C:attention}poker hand{} is played:",
					"Gain one of {C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult,",
					"or {X:mult,C:white}X#3#{} Mult at random",
					"{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips, {C:mult}+#5#{C:inactive} Mult, {X:mult,C:white}X#6#{C:inactive} Mult)",
				}
			},
			j_dbbq_heno = {
				name = "Henohenomoheji",
				text = {
					"When {C:attention}Blind{} is selected:",
					"Create a random {C:attention}Enhanced{}",
					"face card and draw it to hand"
				}
			},
			j_dbbq_hoarder = {
				name = "Hoarder",
				text = {
					"{C:attention}+#1#{} Consumable Slots",
					"{C:chips}+#2#{} Chips per held Consumable",
					"Prevents use of cards",
					"in Consumable Slots"
				}
			},
			j_dbbq_honest = {
				name = "Honesty and Unforgiveness",
				text = {
					"Gains {C:red}+#1#{} discard each round if you",
					"play a {C:attention}Straight Flush{} of {C:spades}Spades{} with",
					"five cards, no rank gaps, and no wrapping",
					"(Currently {C:red}+#2#{} discards each round)"
				}
			},
			j_dbbq_bus = {
				name = "I'M THE BUS!",
				text = {
					"Each played card scores {X:mult,C:white}X#1#{} Mult",
					"Add {X:mult,C:white}X#2#{} Mult to amount for each",
					"consecutive {C:attention}hand{} played",
					"without a scoring {C:attention}face{} card"
				}
			},
			j_dbbq_legs = {
				name = "Joker Legs",
				text = {
					"{C:chips}+#1#{} Chips if you",
					"have drawn through",
					"half of your deck"
				}
			},
			j_dbbq_tomb = {
				name = "Joker's Tombstone",
				text = {
					"This Joker gains {C:chips}Chips{} equal",
					"to {C:chips}X#2# {C:attention}#1#{}'s {C:money}sell value{} if",
					"you sell that joker",
					"{C:inactive}(Joker changes each round)",
					"{C:inactive}(Currently {C:chips}+#3# {C:inactive}Chips)"
				}
			},
			j_dbbq_kintsugi = {
				name = "Kintsugi",
				text = {
					"Gains {C:money}$#1#{} of {C:attention}sell value{}",
					"at end of round",
					"If a {C:inactive}Glass Card{} shatters",
					"or a {C:attention}Lucky Card{} fails,",
					"pay out the {C:attention}sell value{} and",
					"transform into {C:chips}Unlucky Cat{}"
				}
			},
			j_dbbq_lazy = {
				name = "Lazy Coworker",
				text = {
					"{C:mult}+#1#{} Mult",
					"When {C:attention}Blind{} is defeated,",
					"decrease Mult depending on",
					"how much your final chip total",
					"overshot the Blind's requirement"
				}
			},
			j_dbbq_tim = {
				name = "Timothy Rundle",
				text = {
					"First shop each Ante has an extra",
					"{C:dbbq_luxury}Spacious Durable Luxury Bag",
					"Newly obtained {C:dbbq_luxury}Luxury Items{} will",
					"not take up {C:attention}Consumable slots"
				}
			},
			j_dbbq_matry = {
				name = "Matryoshka Joker",
				text = {
					"Sell this card to crate",
					"a random {C:attention}Joker{} that is",
					"one step below your Jokers'",
					"highest {C:inactive}(Vanilla){} rarity",
					"{C:inactive}(Currently: {B:1,C:white}#1#{C:inactive})"
				}
			},
			j_dbbq_mayo = {
				name = "Mayonnaise",
				text = {
					"Blind the {C:attention}Blind{}, so it can't",
					"see you cheating your {C:mult}discards{}",
					"{C:inactive}(Your discards are free){}",
					"However, it will be extremely",
					"angry and become {X:mult,C:white}X#1#{} as strong",
					"{C:inactive}(You may get blasted by a giant laser)"
				}
			},
			j_dbbq_mean = {
				name = "Mean Joker",
				text = {
					"All unenhanced cards are destroyed",
					"after being played and scored",
					"When Blind is defeated,",
					"transforms into {V:1}#1# Joker{}"
				}
			},
			j_dbbq_stalker = {
				name = "Not Stalker",
				text = {
					"When sold, all present",
					"and future copies of",
					"{C:attention}Not Stalker{} double their",
					"{X:mult,C:white}XMult{} and {C:attention}spawn rate",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
					"{C:inactive}(Max 64x spawn rate)",
				}
			},
			j_dbbq_party = {
				name = "Party Ranger",
				text = {
					"Retrigger each scoring {C:attention}Wild Card{}",
					"an additional {C:attention}#1#{} times."
				}
			},
			j_dbbq_pet = {
				name = "Pet? Joker",
				text = {
					"Sell this card to",
					"reduce the current Blind's",
					"chip requirement by {C:attention}25%{}"
				}
			},
			j_dbbq_pg = {
				name = "Partygoers",
				text = {
					"If played {C:attention}5{} card hand is {C:attention}1{} suit",
					"away from containing a {C:chips}Flush{},",
					"the outlier becomes a {C:attention}Wild Card"
				}
			},
			j_dbbq_phone = {
				name = "Phone Call",
				text = {
					"When {C:attention}Hand{} is played:",
					"attempt to call someone using held cards",
					"If their ranks match one",
					"of four secret phone numbers,",
					"self-destruct and spawn the associated joker",
					"{C:inactive}(Phone numbers are all 7 digits",
					"{C:inactive}long, and only use numbers 2-8)",
					"{C:inactive}(Order doesn't matter)",
					"{C:inactive}(Cannot produce a joker you already have)"
				}
			},
			j_dbbq_quartet = {
				name = "Quartet",
				text = {
					"When {C:attention}Hand{} is played:",
					"Gain {C:mult}+#1#{} Mult if you",
					"have exactly {C:chips}#3#{} Jokers",
					"{C:mult}Resets{} otherwise",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				}
			},
			j_dbbq_radical = {
				name = "Radical Dolphin",
				text = {
					"Retrigger {C:attention}rightmost{} scoring",
					"card once for each other",
					"scoring card with a unique rank",
					"{C:inactive}(Currently: {C:attention}#1#{C:inactive})",
				}
			},
			j_dbbq_rainbow = {
				name = "Rainbow in Hiding",
				text = {
					"Gives {C:spectral}+#1#{} Spectral Cards",
					"if you beat a {C:attention}boss blind",
					"without triggering it",
					"{C:inactive}(Must have room)"
				}
			},
			j_dbbq_sales = {
				name = "Sales Joker",
				text = {
					"All played cards become",
					"{C:attention}Mult{} cards when scored",
					"When Blind is defeated,",
					"transforms into {C:inactive}Mean Joker{}"
				}
			},
			j_dbbq_sixeyed = {
				name = "Six-Eyed Joker",
				text = {
					"Each {C:attention}#1#{} held in hand",
					"gives {C:chips}+#2#{} Chips",
				}
			},
			j_dbbq_slots = {
				name = "Slot Machine",
				text = slots_desc
			},
			j_dbbq_slots_feeds = {
				name = "It Feeds On Hope",
				text = slots_desc
			},
			j_dbbq_smoker = {
				name = "Smoker",
				text = {
					"{C:green}#1# in #2#{} cards are drawn face down",
					"Each face down card held",
					"in hand grants {X:mult,C:white}X#3#{} Mult"
				}
			},
			j_dbbq_soooooie = {
				name = "Soooooie!",
				text = {
					"When {C:attention}Blind{} is selected:",
					"Create {C:attention}1 {C:dark_edition}Negative {C:attention}Dog Inside An Hourglass",
					"{C:inactive}(They will all be removed if you lose Soooooie!)"
				}
			},
			j_dbbq_spirit = {
				name = "Spirit Jokers",
				text = {
					"Tells you the {C:attention}Ranks{} and {C:attention}Suits{}",
					"of the top {C:chips}#1#{} cards in your deck",
					"However, one always lies",
					"One says: {C:mult}\"#2#\"",
					"Another says: {C:mult}\"#3#\"",
				}
			},
			j_dbbq_stress = {
				name = "Stress Resources",
				text = {
					"If you play your last hand,",
					"gain {C:money}$#1#{} per hand type that",
					"played poker hand contains"
				}
			},
			j_dbbq_toll = {
				name = "Toll Booth",
				text = {
					"If your first {C:chips}play{} or {C:mult}discard",
					"{C:inactive}(not both){} contains only {C:attention}1{} card,",
					"add a {C:attention}Sticker of Entry to it",
				}
			},
			j_dbbq_casino = {
				name = "Trio Casino",
				text = {
					"Chance for all played cards",
					"to give {C:money}$#1#{} when scored",
					"Chance depends on number of",
					"held consumables, but they",
					"must all be the same card",
					"{C:inactive}(Currently {C:green}#2# in #3# {C:inactive}chance)"
				}
			},
			j_dbbq_tumi = {
				name = "Tumi",
				text = {
					"If {C:attention}poker hand{} is {C:attention}#1#{}:",
					"{X:mult,C:white}X#2#{} Mult and {C:blue}+#3#{} hand",
					"{X:mult,C:white}X#4#{} Mult otherwise",
					"Poker hand changes",
					"after every hand played"
				}
			},
			j_dbbq_tpao = {
				name = "Two Places At Once",
				text = tpao_desc
			},
			j_dbbq_tpao1 = {
				name = "One Place At One Time",
				text = tpao_desc
			},
			j_dbbq_tpao2 = {
				name = "Two Places At Once",
				text = tpao_desc
			},
			j_dbbq_tpao3 = {
				name = "Many Places At Once",
				text = tpao_desc
			},
			j_dbbq_unlucky = {
				name = "Unlucky Cat",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"If {C:inactive}Glass Card{} shatters",
					"or a {C:attention}Lucky Card{} fails,",
					"destroy this card",
				}
			},
			j_dbbq_boss = {
				name = "Who is the Boss?",
				text = {
					"{X:mult,C:white}X#1#{} Mult per joker that",
					"claims to be the {C:attention}Boss",
				}
			},
		},
		Back = {
			b_dbbq_deco = {
				name = "Decorated Deck",
				text = {
					"Start run with half of the",
					"deck consisting of {C:attention}4{} new",
					"Suits with special effects",
					"Cards of these suits",
					"may appear in packs"
				}
			},
			b_dbbq_purge = {
				name = "Purge Deck",
				text = {
					"When {C:attention}Boss Blind{} is defeated:",
					"{C:mult}Destroy{} all playing cards",
					"of one random Rank",
					"Cycles through all possible Ranks,",
					"and repeats the order if necessary"
				}
			},
		},
		Sleeve = {
			sleeve_dbbq_deco = {
				name = "Decorated Sleeve",
				text = {
					"Start run with half of the deck consisting",
					"of {C:attention}4{} new Suits with special effects",
					"Cards of these new suits may appear in packs",
				}
			},
			sleeve_dbbq_deco_double = {
				name = "Decorated Sleeve",
				text = {
					"Start run with double the deck size",
				}
			},
			sleeve_dbbq_purge = {
				name = "Purge Sleeve",
				text = {
					"When {C:attention}Boss Blind{} is defeated:",
					"{C:mult}Destroy{} all playing cards of one random Rank",
					"Cycles through all possible Ranks,",
					"and repeats the order if necessary"
				}
			},
			sleeve_dbbq_purge_double = {
				name = "Purge Sleeve",
				text = {
					"An {C:attention}additional{} rank will be",
					"destroyed after each {C:attention}Boss Blind{}"
				}
			},
		},
		dbbq_luxury = {
			c_dbbq_argon = {
				name = "Argon",
				text = {
					"Create {C:attention}#1# {C:dark_edition}Negative{} copies of a",
					"{C:tarot}Tarot{} card corresponding to the",
					"median rank out of cards held in hand",
					"{C:inactive}(Currently: {C:tarot}#2# - #3#{C:inactive})",
					luxury_reusable
				}
			},
			c_dbbq_artillery = {
				name = "Artillery",
				text = {
					"{C:red}Destroy{} #1# random cards",
					"from your full deck",
					luxury_reusable
				}
			},
			c_dbbq_braid = {
				name = "Braid",
				text = {
					"{C:red}Destroy{} selected joker with an",
					"{C:dark_edition}edition{}, apply that {C:dark_edition}edition{} to up",
					"to {C:attention}#1#{} random cards held in hand",
					luxury_reusable
				}
			},
			c_dbbq_crampon = {
				name = "Crampon",
				text = {
					"Draw {C:attention}#1#{} cards",
					luxury_reusable
				}
			},
			c_dbbq_cutlets = {
				name = "Cutlets",
				text = {
					"Up to {C:attention}#1#{} selected cards will",
					"be torn into two {C:attention}Half Cards",
					luxury_reusable
				}
			},
			c_dbbq_damson = {
				name = "Damson",
				text = {
					"{C:attention}Enhance{} selected",
					"card into a {C:spectral}Damson",
					luxury_reusable
				}
			},
			c_dbbq_fish = {
				name = "Fish",
				text = {
					"All cards held in hand become {C:blue}Bonus",
					"{C:blue}Cards{}, then discard all but {C:attention}1{} card",
					luxury_reusable
				}
			},
			c_dbbq_flange = {
				name = "Flange",
				text = {
					"Apply random {C:attention}Seals{} to up",
					"to {C:attention}#1#{} cards held in hand",
					luxury_reusable
				}
			},
			c_dbbq_jodhpurs = {
				name = "Jodhpurs",
				text = {
					"{C:attention}+#1#{} hand size,",
					"{C:blue}#2#{} hand each round",
					luxury_reusable
				}
			},
			c_dbbq_knurler = {
				name = "Knurler",
				text = {
					"Select any type of card with an {C:dark_edition}edition,",
					"it loses that {C:dark_edition}edition{} and gains {C:money}$#1#{}, either",
					"as sell value or as a permanent bonus",
					"{C:inactive}(Must have room if you're removing {C:dark_edition}Negative{C:inactive})",
					luxury_reusable
				}
			},
			c_dbbq_lathe = {
				name = "Lathe",
				text = {
					"Decrease the rank of up",
					"to {C:attention}#1#{} selected cards by {C:attention}#2#",
					luxury_reusable
				}
			},
			c_dbbq_leek = {
				name = "Leek",
				text = {
					"{C:red}Destroy{} selected card, and",
					"all cards in your full deck",
					"with the same {C:attention}rank{} and {C:attention}suit",
					luxury_reusable
				}
			},
			c_dbbq_mead = {
				name = "Mead",
				text = {
					"Randomize the {C:attention}ranks{} and {C:attention}suits",
					"of all cards held in hand",
					luxury_reusable
				}
			},
			c_dbbq_pot = {
				name = "Pot",
				text = {
					"Use to {C:attention}remember{} cards held in hand,",
					"Those cards will be drawn first next round",
					luxury_reusable
				}
			},
			c_dbbq_pencil = {
				name = "Pencil",
				text = {
					"Select {C:attention}#1#{} cards, and convert",
					"the left cards into the",
					"{C:attention}rank{} of the rightmost card",
					luxury_reusable
				}
			},
			c_dbbq_periwinkle = {
				name = "Periwinkle",
				text = {
					"Convert {C:attention}#1#{} selected cards",
					"to the top {C:attention}#1#{} ranks and",
					"suits from your full deck",
					luxury_reusable
				}
			},
			c_dbbq_periwinkle_current = {
				name = "Periwinkle",
				text = {
					"Convert {C:attention}#1#{} selected cards",
					"to the top {C:attention}#1#{} ranks and",
					"suits from your full deck",
					"{C:inactive}(Currently: {C:attention}#2#{C:inactive})",
					luxury_reusable
				}
			},
			c_dbbq_pickle = {
				name = "Pickle",
				text = {
					"Gain {C:money}$#1#{} per card that has",
					"been present in your deck",
					"since the beginning of the run",
					"{C:inactive}(Max of {C:money}$#2#{C:inactive}, currently {C:money}$#3#{C:inactive})",
					luxury_reusable
				}
			},
			c_dbbq_pivot = {
				name = "Pivot",
				text = {
					"Upgrade all least",
					"played {C:legendary}poker hands",
					luxury_reusable
				}
			},
			c_dbbq_plimsol = {
				name = "Plimsol",
				text = {
					"{C:red}+#1#{} discards each round",
					"{C:attention}#2#{} hand size",
					luxury_reusable
				}
			},
			c_dbbq_printer = {
				name = "Printer",
				text = {
					"Create {C:attention}#1#{} copies",
					"of selected card",
					luxury_reusable
				}
			},
			c_dbbq_spigot = {
				name = "Spigot",
				text = {
					"Fill joker slots with non-{C:blue}Common{} jokers,",
					"then add {C:c75985}Eternal{} to one compatible joker",
					"{C:inactive}(Must have room for at least {C:attention}#1# {C:inactive}joker)",
					luxury_reusable
				}
			},
			c_dbbq_razorback = {
				name = "Razorback",
				text = {
					"{C:red}Destroy{} half of your jokers, rounded down,",
					"Remaining jokers gain random {C:dark_edition}editions",
					"{C:inactive}(Must have enough jokers to destroy)",
					luxury_reusable
				}
			},
			c_dbbq_target = {
				name = "Target",
				text = {
					"Selects a random card each round, and",
					"becomes usable if you play that card,",
					"Use to create a {C:attention}joker{} based on that card",
					"{C:inactive}(Currently: {C:attention}#1# of #2#{C:inactive} to create {C:attention}#3#{C:inactive})",
					luxury_reusable
				}
			},
			c_dbbq_tripod = {
				name = "Tripod",
				text = {
					"Combine {C:attention}#1#{} selected cards of",
					"the same {C:attention}suit{} together,",
					"The resulting card will have a",
					"random {C:attention}rank{}, {C:green}enhancement{}, {C:blue}seal{},",
					"and {C:dark_edition}edition{} from the selected cards",
					luxury_reusable
				}
			},
		},
		Stake = {
			stake_dbbq_cheery = {
				name = "Cheery Stake",
				text = {
					"Jokers you sell or destroy",
					"are {C:red}banned{} for the rest of",
					"the run, excluding {C:attention}Joker"
				}
			},
			stake_dbbq_moody = {
				name = "Moody Stake",
				text = {
					"With each hand played, every card",
					"held in hand loses {C:chips}#1#{} chip",
					"{s:0.8}Applies {C:gold,s:0.8}Cheery Stake"
				}
			},
			stake_dbbq_drunk = {
				name = "Drunk Stake",
				text = {
					"Shops can have Drunk Jokers",
					"{C:inactive,s:0.8}({C:green,s:0.8}1 in 4 {C:inactive,s:0.8}chance to turn into a random joker,",
					"{C:inactive,s:0.8}which will be a lower rarity if possible)",
					"{s:0.8}Applies {C:blue,s:0.8}Moody Stake"
				}
			},
			stake_dbbq_depression = {
				name = "Depression Stake",
				text = {
					"Excess hands do not",
					"grant extra money",
					"{s:0.8}Applies {C:c7bb2b,s:0.8}Drunk Stake"
				}
			},
			stake_dbbq_empty = {
				name = "Empty Stake",
				text = {
					"Beating a {C:attention}Boss Blind{} causes played hand",
					"to lose levels equal to current {C:attention}Ante",
					"(Can level a hand down to {C:red}0{})",
					"{s:0.8}Applies {C:spectral,s:0.8}Depression Stake"
				}
			},
			stake_dbbq_scam = {
				name = "Scam Stake",
				text = {
					"{C:attention}Playing cards{} can be",
					"purchased from the {C:attention}shop",
					"{s:0.8}Applies {C:inactive,s:0.8}Empty Stake"
				}
			},
			stake_dbbq_mean = {
				name = "Mean Stake",
				text = {
					"{C:attention}Booster packs{} cannot be skipped",
					"{s:0.8}Applies {C:red,s:0.8}Scam Stake"
				}
			},
			stake_dbbq_displaced = {
				name = "Displaced Stake",
				text = {
					"Shops can have Toll Jokers",
					"{C:inactive,s:0.8}({C:blue,s:0.8}-1 {C:inactive,s:0.8}hand every round)",
					"{s:0.8}Applies {C:inactive,s:0.8}Mean Stake"
				}
			},
			stake_dbbq_hunger = {
				name = "Hunger Stake",
				text = {
					"{C:attention}-1{} joker slot",
					"{s:0.8}Applies {C:99bccf,s:0.8}Displaced Stake"
				}
			},
			stake_dbbq_bbq = {
				name = "BBQ Stake",
				text = {
					"Shops can have {C:attention}Husk{} Jokers",
					"{C:inactive,s:0.8}(Debuffed until {C:attention,s:0.8}3 {C:inactive,s:0.8}rounds have passed)",
					"{s:0.8}Applies {C:d54405,s:0.8}Hunger Stake"
				}
			},
			stake_dbbq_gold_ena = {
				name = "Gold ENA Stake",
				text = {
					"Applies {C:gold}Gold Stake{} and {C:157516}BBQ Stake",
					"{C:red,s:0.8}Not recommended if you like yourself."
				}
			},
		},
		Other = {
			dbbq_entry = {
				name = "Sticker of Entry",
				text = {
					"Cannot be debuffed",
				},
			},
			dbbq_drunk = {
				name = "Drunk Sticker",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"degrade into a random",
					"lower rarity joker"
				},
			},
			dbbq_drunk_common = {
				name = "Drunk Sticker",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"turn into a random",
					"other {C:blue}common{} joker"
				},
			},
			dbbq_toll = {
				name = "Toll Sticker",
				text = {
					"{C:blue}-1{} hand every round"
				},
			},
			dbbq_husk = {
				name = "Husk Sticker",
				text = {
					"Debuffed until {C:attention}3",
					"rounds have passed",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}/{C:attention}3 {C:inactive}rounds)"
				},
			},
			dbbq_cheery_sticker = {
				name = "Cheery Stake",
				text = won_run_with("Cheery", "gold")
			},
			dbbq_moody_sticker = {
				name = "Moody Stake",
				text = won_run_with("Moody", "blue")
			},
			dbbq_drunk_sticker = {
				name = "Drunk Stake",
				text = won_run_with("Drunk", "c7bb2b")
			},
			dbbq_depression_sticker = {
				name = "Depression Stake",
				text = won_run_with("Depression", "spectral")
			},
			dbbq_empty_sticker = {
				name = "Empty Stake",
				text = won_run_with("Empty", "inactive")
			},
			dbbq_scam_sticker = {
				name = "Scam Stake",
				text = won_run_with("Scam", "red")
			},
			dbbq_mean_sticker = {
				name = "Mean Stake",
				text = won_run_with("Mean", "white")
			},
			dbbq_displaced_sticker = {
				name = "Displaced Stake",
				text = won_run_with("Displaced", "99bccf")
			},
			dbbq_hunger_sticker = {
				name = "Hunger Stake",
				text = won_run_with("Hunger", "d54405")
			},
			dbbq_bbq_sticker = {
				name = "BBQ Stake",
				text = won_run_with("BBQ", "157516")
			},
			dbbq_gold_ena_sticker = {
				name = "Gold ENA Stake",
				text = won_run_with("Gold ENA", "c79000")
			},
			dbbq_magic_trick = {
				name = "Magic Trick",
				text = {
					"Yes, you still have to",
					"purchase this to get {C:attention}Illusion"
				}
			},
			dbbq_red_card = {
				name = "Bonus",
				text = {
					"{C:red}Red Card{} lets you",
					"skip {C:attention}booster packs"
				}
			},
			dbbq_half_card = {
				name = "Half Card",
				text = {
					"Fills {C:dark_edition}0.5{} hand space"
				}
			},
			dbbq_fish = {
				name = "Fish",
				text = {
					"If scored hand has exactly {C:attention}2 {C:dbbq_fish}Fish{},",
					"convert the {C:attention}left{} card into the {C:attention}right{} card"
				}
			},
			dbbq_grit = {
				name = "Grit",
				text = {
					"Leftmost scoring {C:dbbq_grit}Grit{}",
					"card gets destroyed"
				}
			},
			dbbq_pet_seal = {
				name = "Pet? Seal",
				text = {
					"If all cards with {C:attention}Pet? Seals{} are",
					"played and scored before round's end,",
					"they are replaced with {C:gold}Gold Seals",
					"Otherwise, the Pet? Seals will vanish"
				}
			},
			dbbq_travel = {
				name = "Travel",
				text = {
					"Scoring cards increase {C:attention}rank",
					"for each scoring {C:dbbq_travel}Travel{} card"
				}
			},
			dbbq_utility = {
				name = "Utility",
				text = {
					"One random card will be converted",
					"to a {C:dbbq_utility}Utility{} card's rank after scoring"
				}
			},
			undiscovered_dbbq_luxury = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this item in an",
					"unseeded run to",
					"learn what it does"
				},
			},
			p_dbbq_sdlb = {
				name = "Spacious Durable Luxury Bag",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{C:dbbq_luxury} Luxury{} items"
				},
			},
			j_dbbq_antifun_dummy = {
				name = "Anti-Fun Joker",
				text = {
					"When {C:attention}Blind{} is selected:",
					"Loses {X:mult,C:white}X#1#{} Mult for each",
					"{C:attention}Enhanced{} card in full deck",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
					"When Blind is defeated,",
					"transforms into {C:inactive}Mean Joker{}",
					"{C:inactive}(Challenge-Only)"
				}
			},
			j_dbbq_mean_dummy = {
				name = "Mean Joker",
				text = {
					"All unenhanced cards",
					"are destroyed after",
					"being played and scored",
					"When Blind is defeated,",
					"transforms into {C:mult}Sales Joker{}"
				}
			},
			j_dbbq_mean_dummy2 = {
				name = "Mean Joker",
				text = {
					"All unenhanced cards",
					"are destroyed after",
					"being played and scored",
					"When Blind is defeated,",
					"transforms into {C:planet}Anti-Fun Joker{}"
				}
			},
			j_dbbq_sales_dummy = {
				name = "Sales Joker",
				text = {
					"All played cards become",
					"{C:attention}Mult{} cards when scored",
					"When Blind is defeated,",
					"transforms into {C:inactive}Mean Joker{}"
				}
			},
			j_dbbq_source_adire = {
				name = "Source",
				text = {
					"Many of these strange realtors appear",
					"after the smoke is lifted from the Lonely",
					"Door's central area, having been reduced",
					"to a barren, basic landscape. They don't",
					"say anything, they just have a bajillion",
					"possible descriptions. The only actual",
					"characteristic of them is that they buy",
					"and sell as much real estate as possible,",
					"so I represented in a form that rewards",
					"having a varied, undeveloped deck."
				}
			},
			j_dbbq_source_antifun = {
				name = "Source",
				text = {
					"ENA is a complete and total workaholic.",
					"Simply existing on a dance floor is all",
					"it takes for her to become... this.",
					"While it'd technically be more accurate",
					"for her to remain in this state constantly",
					"during the entire challenge, creating an",
					"effect that would mix poorly with Meanie's",
					"side of the ENA joker created a more",
					"interesting idea overall."
				}
			},
			j_dbbq_source_bathroom = {
				name = "Source",
				text = {
					"Reaching the Bathroom is the goal",
					"of Dream BBQ's first chapter, but",
					"there are two routes to seek it.",
					"One route is simple, but afterwards,",
					"you must cross a perilous river that",
					"distorts your vision. You only get",
					"one chance during your run.",
					"The other path requires much more",
					"exploration, but grants you an item",
					"that skips the river entirely.",
					"Here, the need to give up Jokers is that river.",
					"You cannot avoid it in low-stake runs",
					"but higher stakes' Eternal Jokers can",
					"bypass the challenge. Though, you do",
					"still need to lose a few Jokers to",
					"gain a new slot."
				}
			},
			j_dbbq_source_blobby = {
				name = "Source",
				text = {
					"Unlike the other generic NPCs, the",
					"physical features of 'blob' didn't",
					"give me any particular ideas. However,",
					"one line from a specific blob guy has it",
					"remark that its friends criticized it",
					"for visiting the Purge Event. It laughed,",
					"however, because 'they are all the same.'",
					"Thus, this Joker grants you a bonus",
					"for trying something unusual in your",
					"run. Easy to achieve in the early-game,",
					"worthless for late-game."
				}
			},
			j_dbbq_source_brc = {
				name = "Source",
				text = {
					"The area known as the 'Core' houses",
					"many silent blue and red figures that",
					"exist only to point the way forwards.",
					"Characters that don't do much have",
					"a lot of freedom to do any effect, so",
					"I made a joker where the blue and red",
					"suits (at least with Balatro's coloring)",
					"work together to retrigger each other."
				}
			},
			j_dbbq_source_body = {
				name = "Source",
				text = {
					"Mannequin characters are found throughout",
					"the ENA series. They're almost never",
					"acknowledged directly, and in Dream BBQ",
					"specifically, most of them are dead.",
					"Another recurring element is death, or",
					"more specifically, how it seemingly isn't",
					"permanent. Althoug it's unclear, there is",
					"also a chance they're all ENA's bodies in",
					"particular, but the exact mechanics and",
					"relations can only be speculated."
				}
			},
			j_dbbq_source_bunraku = {
				name = "Source",
				text = {
					"Bunrako-man is a talking puppet",
					"based on traditional Japanese",
					"Bunraku performances. While you",
					"interact with the puppet, some",
					"some sort of ninja-like figure",
					"is the one to operate him.",
					"This Joker must also be operated",
					"by your other Jokers, relying",
					"on them for any sort of growth.",
					"The puppet will occasionally",
					"malfunction and slump down;",
					"Ensure that your Jokers are able",
					"to give it a firm hit to keep it",
					"up and running smoothly."
				}
			},
			j_dbbq_source_capsule = {
				name = "Source",
				text = {
					"The Vending Machine is one of many characters",
					"that are immediately hateful towards ENA, just",
					"from her (or the ENA species') reputation for",
					"having done something terrible in the past.",
					"She does talk it into letting her buy anything",
					"at all... but only a single item, out of its",
					"usual selection of four.",
					"It took a while to settle upon the idea for",
					"this, with rejected ideas being based around",
					"booster packs in some way usually, as they",
					"typically also let you only choose one card.",
					"Those ideas were way less unique than this",
					"design though."
				}
			},
			j_dbbq_source_horse = {
				name = "Source",
				text = {
					"Shoryo is a character based on the",
					"Japanese 'Cucumber Horse', a decoration",
					"said to help carry spirits to the",
					"afterlife when they arrive to the Obon",
					"festival.",
					"This seems to be the explanation as to",
					"why Shoryo asks you to retrieve his four",
					"babies/pets, only for him to eat them.",
					"Here, the Cucumber Horse also asks you to",
					"bring it four 'Pet' Seals. But 10 units",
					"of currency wouldn't be worth the effort",
					"in Balatro, so instead, you get Gold Seals."
				}
			},
			j_dbbq_source_diah = {
				name = "Source",
				text = {
					"Hourglass Dogs are secret collectibles",
					"found throughout the game of Dream BBQ,",
					"but only if you play the Supporter Edition.",
					"They are often associated with time. Not",
					"just due to sometimes residing in hourglasses,",
					"but because multiple secret Hourglass Dogs",
					"require the player to wait long periods of",
					"time. Here, this is represented as the ability",
					"to give yourself extra time when needed,",
					"in the form of extra hands for one Blind."
				}
			},
			j_dbbq_source_beholder = {
				name = "Source",
				text = {
					"You first meet this character as a short",
					"round, pink/orange doll. But the visuals",
					"quickly reveal that not only are there",
					"many such dolls, they are but the pupils",
					"inside of the eye sockets of an animate",
					"stone statue of a lady.",
					"With the difficulty of reaching her in mind,",
					"this Joker also requests a difficult task",
					"of you, one that collects a multitude that",
					"will soon make up a singular goal."
				}
			},
			j_dbbq_source_beholder = {
				name = "Source",
				text = {
					"You first meet this character as a short",
					"round, pink/orange doll. But the visuals",
					"quickly reveal that not only are there",
					"many such dolls, they are but the pupils",
					"inside of the eye sockets of an animate",
					"stone statue of a lady.",
					"With the difficulty of reaching her in mind,",
					"this Joker also requests a difficult task",
					"of you, one that collects a multitude that",
					"will soon make up a singular goal."
				}
			},
			j_dbbq_source_fax = {
				name = "Source",
				text = {
					"Coral Glasses is the name of an almost",
					"ordinary (if nervous) businesswoman",
					"except for the coral growing out of one",
					"side of her face. Oh, also, the fact that",
					"her hairline hides a slot for fax papers",
					"to emerge from.",
					"While there are many chracters with secret",
					"phone numbers that you can dial for bonus",
					"dialogue, Coral Glasses is the only one who",
					"directly gives you her number. It's in the",
					"form of the Data Matrix seen on this Joker.",
					"The digits of her phone number are the card",
					"ranks you must assemble for this effect.",
					"There are seven of them, so this will be",
					"rather difficult. Thus, if you succeed,",
					"your cards' Chip values will skyrocket.",
					"Her exact phone number is 7746837."
				}
			},
			j_dbbq_source_girl = {
				name = "Source",
				text = {
					"'Maiden' is a fancy word for a virgin",
					"or unmarried girl. 'Taski' is a Quechuan",
					"word that also refers to virgin or girl.",
					"The name 'Taski Maiden' can just be",
					"read as 'Girl Girl'.",
					"Taski Maiden herself is a little gremlin",
					"who frequently sees herself as having",
					"traits she does not actually have.",
					"She's far from the sanest person around,",
					"and if her subtitles' spelling and grammer",
					"are anything to go by, she is also not",
					"good at organizing words.",
					"She certainly isn't good at organizing",
					"your Jokers. She does, at one point,",
					"turn herself into some near-pitch-black",
					"eldritch horror as a 'prank', though.",
					"That's why this Joker can turn one of",
					"your Jokers Negative."
				}
			},
			j_dbbq_source_head = {
				name = "Source",
				text = {
					"The Taxi Driver is a character who has",
					"had his entire head stolen. Or rather",
					"all three of them! Luckily, you find",
					"them all as a single unit.",
					"The exact head you speak to is entirely",
					"random, different for each playthrough.",
					"Locking this joker behind only one",
					"of its possible effects for your entire",
					"run would be boring, though, so instead,",
					"it gains a random bonus from each hand."
				}
			},
			j_dbbq_source_heno = {
				name = "Source",
				text = {
					"'Henohenohomeji' is the Japanese practice",
					"of trying to draw faces out of Hiragana",
					"characters. The word itself comes from",
					"trying to read one such face as a word.",
					"Dratula's personality of 'I AM DRATULAAAA'",
					"didn't leave me with much to work with,",
					"so I focused on the idea of 'drawing faces'",
					"into your hand each round.",
					"Similar to Certificate. Enhancements are",
					"less valuable than seals, but the Rank",
					"variety is greatly reduced to compensate.",
					"The face-writing in this Joker is meant",
					"to be 'Jokeru' in Hiragana, but it doesn't",
					"translate well into pixel art."
				}
			},
			j_dbbq_source_hoarder = {
				name = "Source",
				text = {
					"Hoarder Alex collects all sorts of junk.",
					"He never really does anything with it,",
					"except block your way past his bridge.",
					"The main utility of this jokers is to",
					"be able to hoard your items and create",
					"a huge supply similar to his. The chips",
					"are just a small bonus and probably won't",
					"contribute much to your score.",
					"Items you own don't show up in the shop",
					"or packs again, you can even buy a bunch",
					"of junk items to block them from spawning."
				}
			},
			j_dbbq_source_honest = {
				name = "Source",
				text = {
					"Unforgiven Frank is an old-timey king's head with",
					"cyborg legs, who speaks kindly and values honesty.",
					"It's not known what he did to be so unforgivable.",
					"His role in the game is to be a guide, giving a",
					"vague overview of a puzzle in the hidden village",
					"that blocks your progress, and talking to him more",
					"makes him increasingly obvious hints.",
					"In Balatro, the hardest hands to consistently play",
					"are almost always Straight Flushes, to the point",
					"where many utility jokers exist simply to let you",
					"bend the rules of what counts as a \"Straight Flush\".",
					"So, this joker instead helps you perform Straight",
					"Flushes by granting you extra discards, but only",
					"if you can prove yourself honest by not relying",
					"on effects like Shortcut, or Four Fingers, or any",
					"modded effect that allows Straights to wrap around.",
				}
			},
			j_dbbq_source_bus = {
				name = "Source",
				text = {
					"I'M THE BUS!",
					"{C:white}.",
					"...In all seriousness, this is a cameo of,",
					"and voiced by, Sr. Pelo. Almost all of the",
					"voice lines come from Dream BBQ itself, except",
					"for the one in Spanish. That one comes from",
					"Sr. Pelo's livestream of the game, where he",
					"explained this very cameo, first to English",
					"viewers, and then to Spanish/Mexican viewers.",
					"\"SOY EL BUS!\" was his translation for them."
				}
			},
			j_dbbq_source_slots = {
				name = "Source",
				text = {
					"This is very easily the most self-indulgent",
					"joker I have made for this mod. There's no",
					"practical purpose, no special reason, to make",
					"the slot machine of all things into the biggest",
					"and most complex joker of them all. These are",
					"just background decorations in ENA: Dream BBQ,",
					"you can't even use them (probably because ENA's",
					"broke). But it sure was fun to make some crazy",
					"and ridiculous jokers, with a code file size",
					"dwarfing that of the 6 other biggest jokers,",
					"or the 13 smallest jokers, from this mod."
				}
			},
			j_dbbq_source_legs = {
				name = "Source",
				text = {
					"Since this generic NPC is clearly half",
					"of something, my original idea was for",
					"it to just be Half Joker But With Chips.",
					"That's kinda boring, so now, the 'half'",
					"part applies to your deck instead."
				}
			},
			j_dbbq_source_tomb = {
				name = "Source",
				text = {
					"Any time these Headtombs appear, it's",
					"for some form of auction that offers",
					"random items.",
					"While it's not necessarily fitting",
					"for the tomb itself to choose the",
					"item on offer, but the spirit remains",
					"the same. Sell it random items to",
					"make it more powerful."
				}
			},
			j_dbbq_source_kintsugi = {
				name = "Source",
				text = {
					"'Kintsugi' is the Japanese tradition",
					"of sealing cracks in pottery using gold",
					"or other precious metals. The idea is",
					"that the history of an object gives it",
					"more value.",
					"When first met, Kane is initially inside",
					"a piggy bank covered in gold-coated cracks.",
					"For whatever reason, he seems to be very",
					"unlucky, and has a tendency to attract",
					"meteors that try to destroy him.",
					"Thus, this Joker begins initially as a",
					"pseudo-Egg, gaining sell value over time",
					"until you play an 'unlucky' card that",
					"destroys the outer shell to reveal Kane."
				}
			},
			j_dbbq_source_lazy = {
				name = "Source",
				text = {
					"Now, Froggy probably isn't lying when",
					"he says he can't join Ena in the Lonely",
					"Door because he can't handle the smoke.",
					"However, claiming to be working, while",
					"very clearly sitting off to the side",
					"doing nothing, doesn't seem like the",
					"making of a hard worker.",
					"Thus, if this Joker sees you going",
					"well over the Blinds' requirements,",
					"it will begin slacking off very soon.",
					"Originally, I was instead going to",
					"have offer +30 Mult, but be reduced",
					"by every XMult granted by anything.",
					"But this would be too powerful in the",
					"early/mid-game where you might have",
					"zero XMult sources, yet be able to",
					"beat every Blind for free anyways.",
					"His phone number is 8237653."
				}
			},
			j_dbbq_source_matry = {
				name = "Source",
				text = {
					"As this generic NPC seems to have the",
					"form of some strange, cracked and",
					"distorted Matryoshka Doll, that's the",
					"idea I went with. You can sell it to,",
					"'open' it up to find a new Joker inside,",
					"yet the contents will change based on",
					"the rarities of your other Jokers."
				}
			},
			j_dbbq_source_mayo = {
				name = "Source",
				text = {
					"The flavor text already pretty well",
					"describes how this item works in",
					"Dream BBQ. Well, the guy blinded by",
					"it blasts Hoarder Alex for blocking",
					"the bridge, not you (AKA ENA), but",
					"this works better for game purposes.",
					"Initially, I wanted to make a Joker",
					"out of the Vending Machine you buy the",
					"Mayo from instead. However, my ideas",
					"were all just worse than most other",
					"money-making Jokers in the game."
				}
			},
			j_dbbq_source_mean = {
				name = "Source",
				text = {
					"ENA has two emotional states that she",
					"will frequently flip between, even mid-",
					"sentence: 'Salesperson' and 'Meanie'.",
					"Distinctly, these two halves are often",
					"in sync with each other, effectively",
					"allowing ENA to play 'Good Cop Bad Cop'",
					"with her own split personality.",
					"This Joker represents her Meanie side.",
					"It is very mean to the cards you play,",
					"so that weak-willed cards that lack",
					"Enhancements will go away. Strategic",
					"use of the Sales version allows you",
					"to protect only your best cards from",
					"Mean's wrath, so that you can easily",
					"build towards very specific decks."
				}
			},
			j_dbbq_source_stalker = {
				name = "Source",
				text = {
					"This entity, known only as 'Suspicious",
					"Man', has studied ENA for a 'LONG. LONG?",
					"TIME!' Yet, yet claims not to be a stalker.",
					"'COMMON MISTAKE. BUT SAD. MISTAKE.', you see.",
					"So naturally, this Joker grows in power the",
					"more it stalks you through your run.",
					"I'm unsure of how powerful it is. It has",
					"expoential scaling, yet you have to leave a",
					"Joker Slot open, and be lucky enough to see",
					"Not Stalker again and again and again, if you",
					"want a super-high XMult."
				}
			},
			j_dbbq_source_pg = {
				name = "Source",
				text = {
					"The Purge Event's dance floor is littered",
					"with many dancing, shadowy entities such",
					"as these. All they do is dance, they have",
					"no interactions or even collision.",
					"They come in many shapes and sizes, all",
					"different while still sharing the same",
					"activity and colour scheme. So, I made",
					"a joker that helps Flushes by bringing",
					"any outlying card into the 'party', if",
					"there's ever one card not sharing the rest",
					"of the hand's suit."
				}
			},
			j_dbbq_source_party = {
				name = "Source",
				text = {
					"Heh-Ito is a Power Ranger/Super Sentai-esque",
					"character who speaks almost entirely in",
					"explosions and acrobatics. There is an actual",
					"voice somewhere in there, but it's unintelligible.",
					"I figured a wild spirit like this could deal in",
					"Wild Cards, which generally need all the help",
					"they can get."
				}
			},
			j_dbbq_source_pet = {
				name = "Source",
				text = {
					"One of Shoryo's four babies/pets/meals.",
					"Like Shoryo, you're allowed to 'consume'",
					"a pet to get you past a Blind you couldn't",
					"otherwise beat, or to beat it in one fewer",
					"hand than you could otherwise.",
					"It also used to be required for Cucumber",
					"Horse (Shoryo)'s function, but now it's",
					"entirely independent."
				}
			},
			j_dbbq_source_phone = {
				name = "Source",
				text = {
					"Througout the game, there are a few secret",
					"phone numbers that players can find from",
					"exploring the map. All four of them are",
					"presented in the form of data matrices,",
					"and once decoded, the player can use their",
					"number keys to dial the number for some",
					"bonus dialogue.",
					"Although this Joker won't tell you those",
					"numbers directly, the Source info of all",
					"callable Jokers will have their number listed.",
					"Jokers that don't originate from Dream BBQ",
					"are only obtainable via Phone Call."
				}
			},
			j_dbbq_source_quartet = {
				name = "Source",
				text = {
					"Dream BBQ's concept for this group of Witches",
					"simply is that there are supposed to be",
					"four of them, but one has gotten herself lost.",
					"I couldn't directly re-create that without",
					"just copying Cucumber Horse, so instead, I",
					"made this Joker focus on only having four of",
					"something. Jokers, in this case.",
					"I did try to think of something based on how",
					"each Witch has her own distinct personality,",
					"but each idea quickly became overcomplicated."
				}
			},
			j_dbbq_source_radical = {
				name = "Source",
				text = {
					"Phindoll is character introduced in the",
					"third ENA episode, Temptation Stairway.",
					"His high energy made him an easy choice",
					"for a retrigger effect, and since he often",
					"talk in math puns, that gave me the idea",
					"to base his retriggers on having many",
					"different card ranks in the played hand.",
					"He makes a cameo in Dream BBQ where it's",
					"revealed that he became unemployed between",
					"the two entries, so I hope he appreciates",
					"his new position.",
					"His phone number is 2543276."
				}
			},
			j_dbbq_source_rainbow = {
				name = "Source",
				text = {
					"The Squeedly Headman is a well-hidden NPC",
					"that is somewhat easy to spot if you look",
					"up, but impossible to reach and speak to",
					"if you haven't gotten a specific item yet.",
					"His dialogue ranges from overly cryptic",
					"hints, to rambling descriptions of his",
					"surroundings, to plainly telling you he's",
					"hiding from the civil authorities.",
					"...Which, when applied to Balatro, basically",
					"translates to 'hiding' from the Boss of each",
					"Ante. I don't love borrowing from Mataor's",
					"inconsistent mechanics, but that's why I give",
					"this joker a reward worth working towards",
				}
			},
			j_dbbq_source_sales = {
				name = "Source",
				text = {
					"ENA has two emotional states that she",
					"will frequently flip between, even mid-",
					"sentence: 'Salesperson' and 'Meanie'.",
					"Distinctly, these two halves are often",
					"in sync with each other, effectively",
					"allowing ENA to play 'Good Cop Bad Cop'",
					"with her own split personality.",
					"This Joker represents her Salesperson",
					"side. It allows you to rapidly build",
					"up your deck with Mult Enhancements.",
					"Yet, it does so even if the cards you",
					"play already have their own Enchancements.",
					"Mult cards are not the best option, nor",
					"are they necessarily what you want long-term.",
					"Like any true worker, you will want to",
					"dispose of her once you expend her usefulness."
				}
			},
			j_dbbq_source_sixeyed = {
				name = "Source",
				text = {
					"A generic NPC in the form of a purple-",
					"skinned child with six differently-",
					"colored eyes on their face.",
					"They are officially known as the",
					"'Watchers', so this one Watches for",
					"held 6s in hand to grant its bonus."
				}
			},
			j_dbbq_source_smoker = {
				name = "Source",
				text = {
					"This machine is the source of the Smoke",
					"that blocks the way to the Boss.",
					"It very presense significantly alters",
					"the world in a manner that is implied",
					"to be just an illusion.",
					"While Froggy detests it, most other",
					"characters greatly enjoy it, and are",
					"confused that anybody would want to get",
					"rid of it.",
					"Because of this, you, too, will benefit",
					"from flooding your hand with 'smoke' that",
					"flips your cards face-down."
				}
			},
			j_dbbq_source_soooooie = {
				name = "Source",
				text = {
					"Prior to a secret Phone Call Cameo in",
					"Dream BBQ, the Auctioneer was only ever",
					"seen in Auction Day, the first episode of",
					"the web series, and the shortest. All",
					"they do is host the Auction for the",
					"Hourglass Dog. It took Dream BBQ to expand",
					"upon their character, as in their cameo,",
					"they acknowledge that what they sell is",
					"practically everywhere, and nowhere near",
					"the exorbitant bids seen during the Auction.",
					"This Joker's name comes from the Auctioneer's",
					"catchphrase. Soooieee!",
					"Their phone number is 6687226."
				}
			},
			j_dbbq_source_spirit = {
				name = "Source",
				text = {
					"I wouldn't be surprised if most people",
					"don't know you can interact with these",
					"so-called 'Lantern Men'. They don't speak,",
					"you just get ENA mentally complimenting",
					"their work efforts because stress and high",
					"altitudes produce better resources."
				}
			},
			j_dbbq_source_stress = {
				name = "Source",
				text = {
					"These spirit entities are here to guide",
					"you towards your destination. However,",
					"only half of them tell the truth.",
					"Normally, it is very easy to know",
					"which one lies, because only the orange",
					"ones tell the truth. This would make the",
					"Joker too easy to figure out, though, so",
					"you don't get to see which color says what."
				}
			},
			j_dbbq_source_tim = {
				name = "Source",
				text = {
					"Timothy Rundle is one of, maybe, only four",
					"or five? characters in the entire game to",
					"introduce themselves by name, and he's just",
					"a minor, somewhat secret NPC you only meet",
					"once. When you find him, he's standing next",
					"to a regular trash bag, but he describes it",
					"as a \"spacious, durable, luxury bag\" that",
					"can allegedly allow him to hold a bunch of",
					"very random objects. All 24 of the items he",
					"lists off were turned into Luxury Items, with",
					"Timothy himself being a very reliable way",
					"to both find and store new Luxury Items."
				}
			},
			j_dbbq_source_toll = {
				name = "Source",
				text = {
					"There are two 'Counter Eyes' guarding the",
					"entrance to the Purge Event. They state",
					"the cost of entry to be an arm or a leg.",
					"When ENA pays the toll, she's given an odd",
					"vase with an unidentified green liquid inside.",
					"Upon drinking it, the barrier in front of the",
					"Purge Event's entrance simply disappears, and",
					"she can simply walk on inside as if nothing",
					"was ever in the way."
				}
			},
			j_dbbq_source_casino = {
				name = "Source",
				text = {
					"This is a French, arrogant, and rude Receptionist",
					"who watches over a casino filled with slot",
					"machines. She has three TV screens that project",
					"a woman's face as she talks, and when she's not",
					"insulting you, all she does is tell you about the",
					"three main Doors and their Genies.",
					"Because of this, it took a while for me to come up",
					"with a decent concept for her. I figured she'd",
					"have something to do with gambling, but it's hard",
					"to make a purely luck-based machanic interesting.",
					"Eventually, I settled on the idea of random chance",
					"that you can rig in your favor, but only in the",
					"unusual situation where you have multiple of the",
					"same consumable in your possession. She already",
					"calls you a scammer repeatedly, now it's finally true.",
				}
			},
			j_dbbq_source_tumi = {
				name = "Source",
				text = {
					"Mitu is a girl based on a ritualistic Tumi knife,",
					"and is also constantly forced to play four-letter",
					"Hangman with every sentence she speaks.",
					"If she wins? Hooray! But if she loses? H U R T.",
					"The easiest way to translate this into Balatro",
					"was to require you to play specific hands for",
					"a bonus. One big potential issue, though, was",
					"that you could just be forced to lose if you",
					"are only given low-scoring hands to work with.",
					"Plus, Family also gives x4 Mult, while offering",
					"a predictable hand requirement and no penalty.",
					"Granting an extra hand with each successful play",
					"Helps alleviate both issues. Now, as long as you",
					"have cards left, proper use of Tumi lets you just",
					"keep playing hands, over and over again, until you",
					"beat the Blind.",
					"It's maybe still not that good on its own, but many",
					"Jokers are scaled based on the idea that you don't",
					"typically send too many hands per round."
				}
			},
			j_dbbq_source_tpao = {
				name = "Source",
				text = {
					"The 'Shaman' has a very strange quirk where",
					"he will create a clone of himself, only to",
					"be quickly killed mid-sentence by said",
					"clone. The clone then finishes talking for",
					"him as if nothing just happened.",
					"This idea wasn't entirely necessary to",
					"directly translate into Balatro mechanics,",
					"but it leads to some unique quirks.",
					"This Joker will scale in a somewhat expoential",
					"manner, if a slow one. Or, you could sell the",
					"clone for a little extra cash if you don't",
					"mind delaying the scaling.",
					"Additionally, you can't maintain Editions",
					"or any other modifications to this card if",
					"you wish to let it scale up. After all, it's",
					"the original, not the zero-modifications copy",
					"that will be destroyed."
				}
			},
			j_dbbq_source_unlucky = {
				name = "Source",
				text = {
					"Kane is a Russain-speaking coin-cat",
					"creature that, for whatever reason,",
					"seems to be very unlucky, and has a",
					"tendency to attract meteors that try",
					"to destroy him.",
					"The first meteor only destroys the",
					"piggy bank he had been hiding in.",
					"Talk to him enough times, and yet",
					"another one appears and kills him",
					"instantly.",
					"Please be very cautious to protect",
					"this innocent boy."
				}
			},
			j_dbbq_source_boss = {
				name = "Source",
				text = {
					"For whatever reason, characters in Dream BBQ",
					"love claiming to be the Boss, even if their",
					"claims are immediately dismissed. There are",
					"so many, I was reasonably able to make a",
					"Baseball Card-style joker based on them."
				}
			},
			dbbq_boss_generic = {
				name = "Who is the Boss?",
				text = {
					"I am the Boss!"
				}
			},
			dbbq_boss_horse = {
				name = "Who is the Boss?",
				text = {
					"I am Boss!!!"
				}
			},
			dbbq_boss_heno = {
				name = "Who is the Boss?",
				text = {
					"YESSS, I AM THE BOSS!!",
					"HA HA HA, HAH HAH!!"
				}
			},
			dbbq_boss_party = {
				name = "Who is the Boss?",
				text = {
					"I AM THE BOSS!!"
				}
			},
			dbbq_boss_stalker = {
				name = "Who is the Boss?",
				text = {
					"HEHEHEH. I Am. The",
					"Boss. Heheheheh."
				}
			},
			dbbq_boss_tumi = {
				name = "Who is the Boss?",
				text = {
					"I am the B-O-S-S! ...Naaah,",
					"I W-I-S-H. I wish! Hahaha!"
				}
			},
			dbbq_boss_vending = {
				name = "Who is the Boss?",
				text = {
					"I COULD BE THE BOSS!"
				}
			},
		}
	},
	misc = {
		challenge_names = {
			c_dbbq_antifun = "The Fun Hater"
		},
		quips = {
			dbbq_antifun_deplorable = {
				"{C:planet}I need to get back to",
				"{C:planet}my d-deplorable job..."
			},
			dbbq_antifun_sick = {
				"{C:planet}I am f-feeling... sick in this p-place."
			},
			dbbq_antifun_morons = {
				"{C:planet}L-Listen to me! Regrettably,",
				"{C:planet}I'm v-very hard-working and",
				"{C:planet}sh-shouldn't be in a place full",
				"{C:planet}of m-morons having... FUN."
			},
			dbbq_antifun_uh = {
				"{C:planet}......................................."
			},
			dbbq_antifun_schedule = {
				"{C:planet}H-How can I leave this stupid event?",
				"{C:planet}M-My lame schedule is full.",
				"{C:planet}I c-can't afford. Another minute of joy."
			},
			dbbq_blobby_friends = {
				"All my \"friends\" criticized me",
				"for coming here. I laugh at them",
				"because they are all the same.",
			},
			dbbq_blobby_crazy = {
				"You were right this whole",
				"time and we called you crazy.",
				"Or... maybe we're the crazy",
				"ones for believing you now."
			},
			dbbq_blobby_sick = {
				"I'm getting sick from",
				"how scared I am."
			},
			dbbq_blobby_run = {
				"This is the part of",
				"the game where you",
				"run to your death."
			},
			dbbq_blobby_boss = {
				"I am the boss!"
			},
			dbbq_bunraku_haters = {
				"Ohohoh, YEAAH!! There will always",
				"be haters hatin' on you, mate!",
				"You can't live your life trying",
				"to make everybody happy!!",
				"YyeeeaAAAAH!!"
			},
			dbbq_bunraku_harder = {
				"HAAAA, WAHOOOOO!! More reason",
				"to party even harder, mate!!"
			},
			dbbq_bunraku_comes = {
				"HERE IT COMEEESSS!!!",
				"YeeaaAAAAAAAAAAH!!"
			},
			dbbq_bunraku_bathroom = {
				"Consider: Would the sane put",
				"only one Bathroom in a place",
				"full of party poopers?"
			},
			dbbq_capsule_boss = { --5
				"I COULD BE THE BOSS!"
			},
			dbbq_capsule_dreams = { --20
				"Dreams are made of wee doodles",
				"and tickers for sale are bought",
				"for car window washings!"
			},
			dbbq_capsule_bargain = { --9
				"Damn right! You found",
				"yourself a bargain!"
			},
			dbbq_capsule_horses = { --13
				"Bye for now. Be good! (I mean,",
				"good with horses, you know.)"
			},
			dbbq_capsule_no = { --5
				"NO!"
			},
			dbbq_capsule_losers = { --14
				"I can't sell things to losers",
				"NO NO!!!!!!!!!!!!!!!!!!!!!!!!"
			},
			dbbq_horse_boss = {
				"I am Boss!!!"
			},
			dbbq_horse_no = {
				"Don't care. Not",
				"recognized. Go away."
			},
			dbbq_horse_shitchat = {
				"No time for shit-chat!",
				"Asshole left door open,",
				"now pets are gone! My babies!"
			},
			dbbq_horse_money = {
				"I will give so many",
				"money. Many money."
			},
			dbbq_horse_early = {
				"Bad service! You are here early!"
			},
			dbbq_horse_meal = {
				"Ohhh, thank GOD! I was starving.",
				"Now I can have a good meal!"
			},
			dbbq_beholder_condolences = {
				"My condolences on",
				"reaching this place."
			},
			dbbq_beholder_never = {
				"Forgiveness is only a",
				"gift you can never have."
			},
			dbbq_beholder_food = {
				"Remember: \"All it takes is",
				"a place and the right food.\""
			},
			dbbq_beholder_toilet = {
				"All of your sins are now forgotten.",
				"Ascend to the toilet of GOD and",
				"wipe the guilt off of your face,",
				"beloved angel."
			},
			dbbq_beholder_unforgiven = {
				"Wait wait wait, you are UNforgiven!",
				"My job here is terminated..."
			},
			dbbq_beholder_capable = {
				"You can't aspire for more",
				"than what you are capable of."
			},
			dbbq_beholder_punishment = {
				"No punishment. Just like how",
				"nobody needs to be punished",
				"for being born.",
				"Except you, of course."
			},
			dbbq_fax_handshake = {
				"Ah... Sorry, handshakes weren't",
				"part of the job description."
			},
			dbbq_fax_shambles = {
				"My whole life is in",
				"shambles right now..."
			},
			dbbq_fax_opportunity = {
				"I turned down another job",
				"opportunity to be here..."
			},
			dbbq_fax_highly = {
				"...I'm highly concerned and",
				"astonished at the same time."
			},
			dbbq_girl_care = {
				"I don care! DON CARE!!",
				">:OO GO AWAY!!!"
			},
			dbbq_girl_thankz = {
				"POO!!! >:( I am nice to you",
				"and this is the thankz I get?!",
				"umwbmhjnbgrzmmafbczlcmnkvn"
			},
			dbbq_girl_rude = {
				"Rude entities like you get",
				"punished for the sins of others.",
			},
			dbbq_girl_fell = {
				"MWAA-HA!!!, fell for",
				"it, didn'tchuU?! ^-^",
			},
			dbbq_girl_words = {
				"U know, im pretty good",
				"@ organizing words!!",
				"I should be the CEO of",
				"organizing events or",
				"sumthing... O . O"
			},
			dbbq_girl_resuemay = {
				"I should send my worky",
				"resuemay to the boss",
				"nao. Im supa good with",
				"organizing bosses!! , !!!"
			},
			dbbq_girl_job = {
				"GUESS WHAT!! ! THIS",
				"CHICKEN BUTT GOTTA",
				"NEW JOB, BABEH!! ! :d"
			},
			dbbq_head_work = {
				"{C:gold}I salute. Work! Yes, I work a lot.",
				"{C:gold}I send people to this victory",
				"{C:gold}screen, yes? You wanna go?"
			},
			dbbq_head_party = {
				"{C:gold}Have fun at the Extinction",
				"{C:gold}Party!! Wait, wrong event."
			},
			dbbq_head_doom = {
				"{C:inactive}I bring the doom to anyone",
				"{C:inactive}looking for it. I can even",
				"{C:inactive}send your meatslab into",
				"{C:inactive}eternal darkness."
			},
			dbbq_head_awaiting = {
				"{C:inactive}Suffering and loneliness",
				"{C:inactive}are awaiting you."
			},
			dbbq_head_ride = {
				"{C:chips}Get in the taxi and prepare",
				"{C:chips}for the ride of your life!"
			},
			dbbq_head_awful = {
				"{C:chips}Have an awful day!"
			},
			dbbq_heno_boss = {
				"YESSS, I AM THE BOSS!!",
				"HA HA HA, HAH HAH!!"
			},
			dbbq_heno_dratula = {
				"I AM DRATULAAA!!"
			},
			dbbq_heno_nuts = {
				"I AM NOT NUTS, I AM DRATULA."
			},
			dbbq_heno_pengvin = {
				"VHAT?!! DID YOU CALL",
				"ME A STINKY PENGVIN?!!"
			},
			dbbq_heno_stronk = {
				"I AM A VAMPIRE. SO STRONK!!"
			},
			dbbq_hoarder_another = {
				"Oh no, not another one."
			},
			dbbq_hoarder_fought = {
				"HEY, HEY, HEY! LISTEN HERE:",
				"I JUST HAD THE WORST DAY",
				"OF MY LIFE, OKAY?!!",
				"I FOUGHT THREE TIMES- NO,",
				"FOUR! NO, NO, FIVE!!",
				"FIVE TIMES!!!",
				"BROKE UP WITH MY GIRLFRIEND,",
				"KILLED MY BROTHER, and NOW...",
				"ARGH!!!"
			},
			dbbq_hoarder_enjoy = {
				"You think I enjoy this?",
				"Being a professional",
				"hoarder is no joke."
			},
			dbbq_hoarder_ogling = {
				"Perfect. Now quit ogling my",
				"properties and fly off."
			},
			dbbq_hoarder_posterior = {
				"Go pull yourself along on",
				"your mother's posterior."
			},
			dbbq_hoarder_rad = {
				"Oh, you actually",
				"did it? Okay. Rad."
			},
			dbbq_honest_seen = {
				"Hast thou seen that?"
			},
			dbbq_honest_lies = {
				"So tired I am of lies..."
			},
			dbbq_honest_wends = {
				"And so the day wends away.",
				"Thou'rt tired, I'd warrant."
			},
			dbbq_honest_end = {
				"Strange it is, how problems always",
				"end later than sooner. But thou?",
				"Thou hast seen an end of it."
			},
			dbbq_honest_good = {
				"It was nice for me— No,",
				"it was a good time for me.",
				"Thou provided good company."
			},
			dbbq_honest_truth = {
				"I can no longer sense the",
				"stench of any lie. Vain",
				"pretense has met his match,",
				"and noble Truth holds sway."
			},
			dbbq_honest_learn = {
				"Unforgiven I must still",
				"remain, but always learning",
				"from my old mistakes."
			},
			dbbq_bus_im_the_bus = {
				"I'M THE BUS!"
			},
			dbbq_legs_eyeball = {
				"Are you here on purpose?",
				"Or are you going to",
				"bounce like an eyeball?"
			},
			dbbq_legs_how = {
				"How am I supposed",
				"to win big now?!"
			},
			dbbq_legs_damnation = {
				"Time for you to visit the",
				"toilet of eternal damnation!"
			},
			dbbq_legs_boobstraps = {
				"Pull yourself up by your",
				"boobstraps. Seek help."
			},
			dbbq_legs_epic = {
				"May the Doors guide",
				"my epic moves!"
			},
			dbbq_legs_imploded = {
				"I was so excited that",
				"half of my body imploded!",
				"That's what I get for",
				"being on my feets all day."
			},
			dbbq_legs_boss = {
				"I am the boss!"
			},
			dbbq_lazy_sweat = {
				"Sweat that shirt! Keep",
				"up that hard work.",
			},
			dbbq_lazy_slack = {
				"I certainly won't be",
				"picking up your slack!",
				"Find a way out of there!"
			},
			dbbq_lazy_easier = {
				"Good job. You always",
				"make work easier."
			},
			dbbq_lazy_proactive = {
				"Being proactive at work, eh?",
				"Good signal, good signal."
			},
			dbbq_lazy_meat = {
				"Now we're running out",
				"of time to put that",
				"dead meat in its place!"
			},
			dbbq_lazy_novice = {
				"Stop acting like a novice!",
				"You know your job."
			},
			dbbq_lazy_working = {
				"I don't know what you did,",
				"but it is really working!"
			},
			dbbq_matry_cents = {
				"Listen to yourself, you don't",
				"even make cents. Typical."
			},
			dbbq_matry_toot = {
				"This is the real",
				"deal, sugar-toot."
			},
			dbbq_matry_ruin = {
				"Losers always ruin the party.",
			},
			dbbq_matry_boss = {
				"I am the boss!"
			},
			dbbq_mean_boss = {
				"{C:inactive}WHERE THE HELL IS THE BOSS?!"
			},
			dbbq_mean_hogwash = {
				"{C:inactive}That was the boss? Hah!",
				"{C:inactive}The boss of what? Hogwash?!"
			},
			dbbq_mean_fraud = {
				"{C:inactive}You're not fooling anyone, FRAUD!"
			},
			dbbq_mean_sympathy = {
				"{C:inactive}HEY PAL! My sympathy",
				"{C:inactive}is gonna COST you",
				"{C:inactive}for every condolence."
			},
			dbbq_mean_prices = {
				"{C:inactive}With prices this low,",
				"{C:inactive}you can't afford a",
				"{C:inactive}lifetime to wait!"
			},
			dbbq_mean_bullshit = {
				"{C:inactive}You know, I don't even believe",
				"{C:inactive}anything! But you're bleeding",
				"{C:inactive}out some real BULLSHIT here!!",
				"{C:inactive}YOU'RE A FLUKE!!!"
			},
			dbbq_stalker_boss = {
				"HEHEHEH. I Am. The",
				"Boss. Heheheheh."
			},
			dbbq_stalker_mistake = {
				"NO! NO. NO! NO. Common",
				"Mistake. But Sad. Mistake."
			},
			dbbq_stalker_heheheheh = {
				"HEHEHEHEH..."
			},
			dbbq_stalker_delight = {
				"What A Delight. To See. YOU!"
			},
			dbbq_stalker_captivity = {
				"GLORY! It Is To See. Your",
				"Actions. While. YOU Are",
				"Trapped Here. In Captivity."
			},
			dbbq_party_boss = {
				"I AM THE BOSS!!"
			},
			dbbq_party_focusing = {
				"You're better off focusing",
				"on other things in life."
			},
			dbbq_party_crazy = {
				"What the hell are you talking about?",
				"You better start dancing, crazy."
			},
			dbbq_party_whistle = {
				"Follow the whistle",
				"and let yourself go."
			},
			dbbq_quartet_delightful = {
				"{C:purple}Delightful! Off we go, then.",
				"{C:gold}Don't spend it all in one place.",
				"{C:mult}Take care, dearie!",
			},
			dbbq_quartet_reference = {
				"{C:gold}Psst... \"We should go home,",
				"{C:gold}I am allergic to persons.\"",
				"{C:green}HAAAA-HA! I GOT THAT REFERENCE!!!",
				"{C:mult}Shhh! Zip it!!!"
			},
			dbbq_quartet_fault = {
				"{C:green}GREAT! NOW WE WON'T MAKE IT TO THE",
				"{C:green}PURGE EVENT AND IT'S ALL YOUR FAULT.",
				"{C:gold}Could you hurry it, please? I miss",
				"{C:gold}my coffin.",
				"{C:mult}I'd be surprised if you're still",
				"{C:mult}alive. 5 minutes alone with us would",
				"{C:mult}drive any entity to split into its",
				"{C:mult}component parts."
			},
			dbbq_radical_polynomial = {
				"Just leave me your polynomial and",
				"I'll integrate right on over."
			},
			dbbq_radical_tangent = {
				"You're pretty acute for a newbie,",
				"but now's not the time for",
				"me to go off on a tangent."
			},
			dbbq_radical_chill = {
				"Woah woah woah woah woah woah WOAH!",
				"Take a chill pill, I meant no ill-will!"
			},
			dbbq_radical_star = {
				"That's all, my star! Chyah!"
			},
			dbbq_radical_humor = {
				"DO YOU KNOW WHY CAMELS DON'T DO",
				"PROFESSIONAL WRESTLING? BECAUSE THEY--",
				"Woah, wooah, woooaah, wooaAAH, WOOAAHH...",
				"HAH, THAT'S DOLPHIN HUMOR FOR YAH."
			},
			dbbq_rainbow_bell = {
				"Ask not for whom the bell tolls."
			},
			dbbq_rainbow_hiding = {
				"I am hiding from the",
				"civil authorities."
			},
			dbbq_rainbow_prison = {
				"It may be small and dark and cramped and",
				"I may never be able to leave again...",
				"...but at least I'm not in prison."
			},
			dbbq_rainbow_left = {
				"The civil authorities",
				"got bored and left."
			},
			dbbq_sales_loop = {
				"{C:mult}Huh. Seems I am out of",
				"{C:mult}the loop. Shall we review",
				"{C:mult}the job description?"
			},
			dbbq_sales_ambush = {
				"{C:mult}Let's arrange our next",
				"{C:mult}ambush at the scene!"
			},
			dbbq_sales_doable = {
				"{C:mult}That was most categorically doable."
			},
			dbbq_sales_child = {
				"{C:mult}Worry not, you are",
				"{C:mult}still a child of GOD."
			},
			dbbq_sales_bless = {
				"{C:mult}Bless you for your business."
			},
			dbbq_sales_personally = {
				"{C:mult}Don't take it personally."
			},
			dbbq_sixeyed_thank = {
				"Thank you. I don't know what",
				"I would have done without this."
			},
			dbbq_sixeyed_back = {
				"I want to go back.",
				"I'm so tired..."
			},
			dbbq_sixeyed_before = {
				"I've never seen",
				"something like this",
				"before. It's relaxing."
			},
			dbbq_sixeyed_death = {
				"To toil beyond death itself."
			},
			dbbq_soooooie_sad = {
				"Hey, DON'T BE SAD! Soooooie!"
			},
			dbbq_soooooie_bright = {
				"Look on the bright side!",
				"Uh...",
				"Hmmm...",
				"...",
				"Soooieeee!"
			},
			dbbq_soooooie_existential = {
				"YEAH! All your existential",
				"troubles will go away soon, okay?"
			},
			dbbq_soooooie_daily = {
				"ALRIGHT, Y'ALL! Welcome to the",
				"Daily Auctioning! Sooie! Soooooieeee!"
			},
			dbbq_tim_fortune = {
				"What fortune! What bliss!",
				"What kind hands could have",
				"orchistrated such a thing?"
			},
			dbbq_tim_thanks = {
				"Well, you have the thanks",
				"of Timothy Rundle!"
			},
			dbbq_tim_space = {
				"Now, what will I do with all this space?",
				"I can carry flanges, pencils, mead…",
				"Pivots, crampons, artillery…",
				"Cutlets, targets, plimsols…",
				"Jodhpurs, printers, damsons…",
				"Fish, leeks, braid…",
				"Pots, knurlers, lathes…",
				"Spigots, tripods, pickles…",
				"Razorbacks, periwinkles, argon…"
			},
			dbbq_toll_toll = {
				"Pay the toll."
			},
			dbbq_toll_armleg = {
				"Hmm, that blood... Ah, I see.",
				"It will cost you an arm or a leg next."
			},
			dbbq_toll_surprise = {
				"Not surprised."
			},
			dbbq_toll_refund = {
				"No refunds."
			},
			dbbq_toll_wait = {
				"What are you waiting for?"
			},
			dbbq_tomb_cash = {
				"I don't like the cast.",
				"I prefer		 cash."
			},
			dbbq_tomb_act = {
				"The second act",
				"feels too obvious."
			},
			dbbq_tomb_owe = {
				"What are you looking at?",
				"Do I owe you something?"
			},
			dbbq_tomb_looks = {
				"This looks controversial.",
			},
			dbbq_tomb_now = {
				"Things are smelling",
				"much more valuable now!"
			},
			dbbq_tomb_congratulations = {
				"Congratulations!"
			},
			dbbq_tomb_island = {
				"This new island looked",
				"fancier in the catalogue.",
				"Not impressed."
			},
			dbbq_casino_tv_dinner = {
				"Ugh, you again. Go away!",
				"You smell poor! Go eat a",
				"TV dinner, you broke,",
				"ping-collared slug!"
			},
			dbbq_casino_nonsense = {
				"What?! I hope you are spitting",
				"some needy nonsense!"
			},
			dbbq_casino_richer = {
				"Now SHOO! Come back when",
				"you're a little, mmm, richer!"
			},
			dbbq_casino_clodpoll = {
				"You poor, needy, beggarly, hard up,",
				"schlocky, frowzy, scrimpy clodpoll!"
			},
			dbbq_casino_problematic = {
				"Ah, making more losses, are we?",
				"You seem rather... ah, pro-ble-ma-tic."
			},
			dbbq_casino_luck = {
				"You are pushing your luck, 'winner'."
			},
			dbbq_casino_slacking = {
				"I have no time for slacking off and",
				"insulting a lowly conman all day.",
				"Do what you need to do and leave."
			},
			dbbq_casino_party = {
				"If you are a party person, you",
				"can always switch the mood and",
				"attend the infamous Purge Event."
			},
			dbbq_tumi_boss = {
				"I am the B-O-S-S! ...Naaah,",
				"I W-I-S-H. I wish! Hahaha!"
			},
			dbbq_tumi_nobody = {
				"What do have H-A-V-E H-E-R-E?",
				"L-O-O-K at this nobody who",
				"isn't having a G-O-O-D T-I-M-E!"
			},
			dbbq_tumi_waste = {
				"Uhhh... What a W-A-S-TE...",
				"w-aaa-s-ttt... aw, shoot."
			},
			dbbq_tumi_menu = {
				"What's on the M-E-N-U tonight?!",
				"Oh, I'm really hoping it's me!"
			},
			dbbq_tpao_understand = {
				"I'm glad we understand",
				"each other. YOU are here",
				"because you want to be.",
				"I can see it in your eyes."
			},
			dbbq_tpao_life = {
				"Now, go away, and get a LIFE.",
				"That shall be your quest today!"
			},
			dbbq_tpao_forgive = {
				"May the GODS forgive me",
				"for what I'm about to do."
			},
			dbbq_tpao_done = {
				"What had to be done was done,",
				"but... what hadn't been done",
				"was done too. And now that it",
				"is done, it may be done again.",
				"Done. Done. Done..."
			},
			dbbq_tpao_anew = {
				"Now, it's your turn",
				"to BEGIN LIFE ANEW!",
				"...Possibly."
			},
			dbbq_tpao_explain = {
				"I shall be happy to explain",
				"everything to you:",
				"\"One person can be in two places",
				"at once. Althrough, the magician does",
				"not have to be in two places at once.",
				"He can be in one place at one ti&#-\""
			},
			dbbq_unlucky_boss = {
				"I am the Boss!"
			},
			dbbq_unlucky_simpleton = {
				"I have seen you millions",
				"of times here, is this something",
				"like a simpleton event?!",
				"AHAHAHAHAHA!"
			},
			dbbq_unlucky_cruise = {
				"I am so ready to cruise",
				"and party responsibly",
				"in every illegal way!"
			},
			dbbq_unlucky_poppers = {
				"Had one too many",
				"party poppers?"
			},
		},
		dictionary = {
			k_dbbq_auction_day = "Auction Day",
			k_dbbq_join_us = "Join us!",
			k_dbbq_secret = "Secret",
			k_dbbq_temptation_stairway = "Temptation Stairway",
			b_dbbq_luxury_cards = "Luxury Items",
			k_dbbq_luxury = "Luxury",
			k_dbbq_is = "is",
			k_dbbq_has = "has",
			k_dbbq_contains = "contains",
			k_dbbq_spin = "Spin",
			k_dbbq_banned = "Banned!",
			k_dbbq_enabled = "Enabled!",
			k_dbbq_remembered = "Remembered!",
			k_plus_dbbq_luxury = "+1 Luxury Item!",
			k_dbbq_plus_tag = "+1 Tag!",
			k_dbbq_slotreward0 = "Luxury Item",
			k_dbbq_slotrewards0 = "Luxury Items",
			k_dbbq_slotreward1 = "Spectral Card",
			k_dbbq_slotrewards1 = "Spectral Cards",
			k_dbbq_slotreward2 = "Mult given to each scoring card",
			k_dbbq_slotreward3 = "Retrigger for joker to the right",
			k_dbbq_slotrewards3 = "Retriggers for joker to the right",
			k_dbbq_slotreward4 = "random Skip Tag",
			k_dbbq_slotrewards4 = "random Skip Tags",
			k_dbbq_slotreward5 = "Chips given to each scoring card",
			k_dbbq_slotreward6 = "Mult given to each scoring card",
			k_dbbq_jd_slotreward0 = "Luxury",
			k_dbbq_jd_slotrewards0 = "Luxuries",
			k_dbbq_jd_slotreward1 = "Spectral",
			k_dbbq_jd_slotrewards1 = "Spectrals",
			k_dbbq_jd_slotreward2 = "Mult bonus",
			k_dbbq_jd_slotreward3 = "Right Retrigger",
			k_dbbq_jd_slotrewards3 = "Right Retriggers",
			k_dbbq_jd_slotreward4 = "Tag",
			k_dbbq_jd_slotrewards4 = "Tags",
			k_dbbq_jd_slotreward5 = "Chips bonus",
			k_dbbq_jd_slotreward6 = "Mult bonus",
			k_dbbq_4oak = "4oaK",
			k_dbbq_3oak = "3oaK",
			k_dbbq_holo = "Holo",
			k_dbbq_poly = "Poly",
			k_dbbq_least_played_hands = "Least Played Hands",
			k_booster_group_p_dbbq_sdlb = "Spacious Durable Luxury Bag",
			k_dbbq_boss = "Boss?",
			k_dbbq_inactive = "Inactive"
		},
		v_dictionary = {
			k_dbbq_minus_chip = "#1# chip",
		},
		labels = {
			dbbq_entry = "Sticker of Entry",
			dbbq_drunk = "Drunk Sticker",
			dbbq_toll = "Toll Sticker",
			dbbq_husk = "Husk Sticker",
			dbbq_pet_seal = "Pet? Seal",
			k_dbbq_secret = "Secret",
		},
		suits_singular = {
			dbbq_fish = "Fish",
			dbbq_grit = "Grit",
			dbbq_travel = "Travel",
			dbbq_utility = "Utility",
		},
		suits_plural = {
			dbbq_fish = "Fish",
			dbbq_grit = "Grit",
			dbbq_travel = "Travel",
			dbbq_utility = "Utility",
		}
	}
}
