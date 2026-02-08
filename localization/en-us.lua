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

return {
	descriptions = {
		Joker = {
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
			j_dbbq_horse = {
				name = "Cucumber Horse",
				text = {
					"When {C:attention}Blind{} is selected:",
					"{C:attention}#1#{} random cards in deck",
					"will gain {C:attention}Pet? Seals",
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
					"Create random {C:attention}Enhanced{} face",
					"card and draw it to hand"
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
			j_dbbq_kintsugi = {
				name = "Kintsugi",
				text = {
					"Gains {C:money}$#1#{} of {C:attention}sell value{}",
					"at end of round",
					"If {C:inactive}Glass Card{} shatters",
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
			j_dbbq_matry = {
				name = "Matryoshka Joker",
				text = {
					"Sell this card to",
					"create a random {C:attention}Joker{}",
					"that is one step below",
					"your Jokers' highest rarity",
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
					"All unenhanced cards",
					"are destroyed after",
					"being played and scored",
					"When Blind is defeated,",
					"transforms into {V:1}#1# Joker{}"
				}
			},
			j_dbbq_stalker = {
				name = "Not Stalker",
				text = {
					"When sold, all present",
					"and future copies of",
					"{C:attention}Not Stalker{} double their {X:mult,C:white}XMult",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
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
			j_dbbq_smoker = {
				name = "Smoker",
				text = {
					"{C:green}#1# in #2#{} cards are drawn face down",
					"Each face down card held",
					"in hand grants {X:mult,C:white}X#3#{} Mult"
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
					"{X:mult,C:white} X#1# {} Mult",
					"If {C:inactive}Glass Card{} shatters",
					"or a {C:attention}Lucky Card{} fails,",
					"destroy this card",
				}
			},
		},
		Back = {
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
		Other = {
			dbbq_pet_seal = {
				name = "Pet? Seal",
				text = {
					"If all cards with {C:attention}Pet? Seals{} are",
					"played and scored before round's end,",
					"they are replaced with {C:money}Gold Seals",
					"Otherwise, the Pet? Seals will vanish"
				}
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
					"your cards' Chip values will skyrocket."
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
			j_dbbq_source_bus = {
				name = "Source",
				text = {
					"I'M THE BUS!"
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
					"beat every Blind for free anyways."
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
			j_dbbq_source_spirit = {
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
		}
	},
	misc = {
		challenge_names = {
			c_dbbq_antifun = "The Fun Hater"
		},
		quips = {
			j_dbbq_antifun_deplorable = {
				"{C:planet}I need to get back to",
				"{C:planet}my d-deplorable job..."
			},
			j_dbbq_antifun_sick = {
				"{C:planet}I am f-feeling... sick in this p-place."
			},
			j_dbbq_antifun_morons = {
				"{C:planet}L-Listen to me! Regrettably,",
				"{C:planet}I'm v-very hard-working and",
				"{C:planet}sh-shouldn't be in a place full",
				"{C:planet}of m-morons having... FUN."
			},
			j_dbbq_antifun_uh = {
				"{C:planet}......................................."
			},
			j_dbbq_antifun_schedule = {
				"{C:planet}H-How can I leave this stupid event?",
				"{C:planet}M-My lame schedule is full.",
				"{C:planet}I c-can't afford. Another minute of joy."
			},
			j_dbbq_blobby_friends = {
				"All my \"friends\" criticized me",
				"for coming here. I laugh at them",
				"because they are all the same.",
			},
			j_dbbq_blobby_crazy = {
				"You were right this whole",
				"time and we called you crazy.",
				"Or... maybe we're the crazy",
				"ones for believing you now."
			},
			j_dbbq_blobby_sick = {
				"I'm getting sick from",
				"how scared I am."
			},
			j_dbbq_blobby_run = {
				"This is the part of",
				"the game where you",
				"run to your death."
			},
			j_dbbq_bunraku_haters = {
				"Ohohoh, YEAAH!! There will always",
				"be haters hatin' on you, mate!",
				"You can't live your life trying",
				"to make everybody happy!!",
				"YyeeeaAAAAH!!"
			},
			j_dbbq_bunraku_harder = {
				"HAAAA, WAHOOOOO!! More reason",
				"to party even harder, mate!!"
			},
			j_dbbq_bunraku_comes = {
				"HERE IT COMEEESSS!!!",
				"YeeaaAAAAAAAAAAH!!"
			},
			j_dbbq_bunraku_bathroom = {
				"Consider: Would the sane put",
				"only one Bathroom in a place",
				"full of party poopers?"
			},
			j_dbbq_horse_boss = {
				"I am Boss!!!"
			},
			j_dbbq_horse_no = {
				"Don't care. Not",
				"recognized. Go away."
			},
			j_dbbq_horse_shitchat = {
				"No time for shit-chat."
			},
			j_dbbq_horse_money = {
				"I will give so many",
				"money. Many money."
			},
			j_dbbq_horse_early = {
				"Bad service! You are here early!"
			},
			j_dbbq_horse_meal = {
				"Ohhh, thank GOD! I was starving.",
				"Now I can have a good meal!"
			},
			j_dbbq_beholder_condolences = {
				"My condolences on",
				"reaching this place."
			},
			j_dbbq_beholder_never = {
				"Forgiveness is only a",
				"gift you can never have."
			},
			j_dbbq_beholder_food = {
				"Remember: \"All it takes is",
				"a place and the right food.\""
			},
			j_dbbq_beholder_toilet = {
				"All of your sins are now forgotten.",
				"Ascend to the toilet of GOD and",
				"wipe the guilt off of your face,",
				"beloved angel."
			},
			j_dbbq_beholder_unforgiven = {
				"Wait wait wait, you are UNforgiven!",
				"My job here is terminated..."
			},
			j_dbbq_beholder_capable = {
				"You can't aspire for more",
				"than what you are capable of."
			},
			j_dbbq_fax_handshake = {
				"Ah... Sorry, handshakes weren't",
				"part of the job description."
			},
			j_dbbq_fax_shambles = {
				"My whole life is in",
				"shambles right now..."
			},
			j_dbbq_fax_opportunity = {
				"I turned down another job",
				"opportunity to be here..."
			},
			j_dbbq_fax_highly = {
				"...I'm highly concerned and",
				"astonished at the same time."
			},
			j_dbbq_girl_care = {
				"I don care! DON CARE!!",
				">:OO GO AWAY!!!"
			},
			j_dbbq_girl_thankz = {
				"POO!!! >:( I am nice to you",
				"and this is the thankz I get?!",
				"umwbmhjnbgrzmmafbczlcmnkvn"
			},
			j_dbbq_girl_rude = {
				"Rude entities like you get",
				"punished for the sins of others.",
			},
			j_dbbq_girl_fell = {
				"MWAA-HA!!!, fell for",
				"it, didn'tchuU?! ^-^",
			},
			j_dbbq_girl_words = {
				"U know, im pretty good",
				"@ organizing words!!",
				"I should be the CEO of",
				"organizing events or",
				"sumthing... O . O"
			},
			j_dbbq_girl_resuemay = {
				"I should send my worky",
				"resuemay to the boss",
				"nao. Im supa good with",
				"organizing bosses!! , !!!"
			},
			j_dbbq_girl_job = {
				"GUESS WHAT!! ! THIS",
				"CHICKEN BUTT GOTTA",
				"NEW JOB, BABEH!! ! :d"
			},
			j_dbbq_head_work = {
				"{C:gold}Work! Yes, I work a lot."
			},
			j_dbbq_head_party = {
				"{C:gold}Have fun at the Extinction",
				"{C:gold}Party!! Wait, wrong event."
			},
			j_dbbq_head_doom = {
				"{C:inactive}I bring the doom to anyone",
				"{C:inactive}looking for it. I can even",
				"{C:inactive}send your meatslab into",
				"{C:inactive}eternal darkness."
			},
			j_dbbq_head_awaiting = {
				"{C:inactive}Suffering and loneliness",
				"{C:inactive}are awaiting you."
			},
			j_dbbq_head_ride = {
				"{C:chips}Get in the taxi and prepare",
				"{C:chips}for the ride of your life!"
			},
			j_dbbq_head_awful = {
				"{C:chips}Have an awful day!"
			},
			j_dbbq_heno_boss = {
				"YESSS, I AM THE BOSS!!",
				"HA HA HA, HAH HAH!!"
			},
			j_dbbq_heno_dratula = {
				"I AM DRATULAAA!!"
			},
			j_dbbq_heno_nuts = {
				"I AM NOT NUTS, I AM DRATULA."
			},
			j_dbbq_heno_pengvin = {
				"VHAT?!! DID YOU CALL",
				"ME A STINKY PENGVIN?!!"
			},
			j_dbbq_heno_stronk = {
				"I AM A VAMPIRE. SO STRONK!!"
			},
			j_dbbq_hoarder_another = {
				"Oh no, not another one."
			},
			j_dbbq_hoarder_fought = {
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
			j_dbbq_hoarder_enjoy = {
				"You think I enjoy this?",
				"Being a professional",
				"hoarder is no joke."
			},
			j_dbbq_hoarder_ogling = {
				"Perfect. Now quit ogling my",
				"properties and fly off."
			},
			j_dbbq_hoarder_posterior = {
				"Go pull yourself along on",
				"your mother's posterior."
			},
			j_dbbq_hoarder_rad = {
				"Oh, you actually",
				"did it? Okay. Rad."
			},
			j_dbbq_im_the_bus = {
				"I'M THE BUS!"
			},
			j_dbbq_legs_eyeball = {
				"Are you here on purpose?",
				"Or are you going to",
				"bounce like an eyeball?"
			},
			j_dbbq_legs_how = {
				"How am I supposed",
				"to win big now?!"
			},
			j_dbbq_legs_damnation = {
				"Time for you to visit the",
				"toilet of eternal damnation!"
			},
			j_dbbq_legs_boobstraps = {
				"Pull yourself up by your",
				"boobstraps. Seek help."
			},
			j_dbbq_legs_epic = {
				"May the Doors guide",
				"my epic moves!"
			},
			j_dbbq_legs_imploded = {
				"I was so excited that",
				"half of my body imploded!",
				"That's what I get for",
				"being on my feets all day."
			},
			j_dbbq_lazy_sweat = {
				"Sweat that shirt! Keep",
				"up that hard work.",
			},
			j_dbbq_lazy_slack = {
				"I certainly won't be",
				"picking up your slack!",
				"Find a way out of there!"
			},
			j_dbbq_lazy_easier = {
				"Good job. You always",
				"make work easier."
			},
			j_dbbq_lazy_proactive = {
				"Being proactive at work, eh?",
				"Good signal, good signal."
			},
			j_dbbq_lazy_meat = {
				"Now we're running out",
				"of time to put that",
				"dead meat in its place!"
			},
			j_dbbq_lazy_novice = {
				"Stop acting like a novice!",
				"You know your job."
			},
			j_dbbq_lazy_working = {
				"I don't know what you did,",
				"but it is really working!"
			},
			j_dbbq_matry_cents = {
				"Listen to yourself, you don't",
				"even make cents. Typical."
			},
			j_dbbq_matry_toot = {
				"This is the real",
				"deal, sugar-toot."
			},
			j_dbbq_matry_ruin = {
				"Losers always ruin the party.",
			},
			j_dbbq_mean_boss = {
				"{C:inactive}WHERE THE HELL IS THE BOSS?!"
			},
			j_dbbq_mean_hogwash = {
				"{C:inactive}That was the boss? Hah!",
				"{C:inactive}The boss of what? Hogwash?!"
			},
			j_dbbq_mean_fraud = {
				"{C:inactive}You're not fooling anyone, FRAUD!"
			},
			j_dbbq_mean_sympathy = {
				"{C:inactive}HEY PAL! My sympathy",
				"{C:inactive}is gonna COST you",
				"{C:inactive}for every condolence."
			},
			j_dbbq_mean_prices = {
				"{C:inactive}With prices this low,",
				"{C:inactive}you can't afford a",
				"{C:inactive}lifetime to wait!"
			},
			j_dbbq_mean_bullshit = {
				"{C:inactive}You know, I don't even believe",
				"{C:inactive}anything! But you're bleeding",
				"{C:inactive}out some real BULLSHIT here!!",
				"{C:inactive}YOU'RE A FLUKE!!!"
			},
			j_dbbq_stalker_boss = {
				"HEHEHEH. I Am. The",
				"Boss. Heheheheh."
			},
			j_dbbq_stalker_mistake = {
				"NO! NO. NO! NO. Common",
				"Mistake. But Sad. Mistake."
			},
			j_dbbq_stalker_heheheheh = {
				"HEHEHEHEH..."
			},
			j_dbbq_stalker_delight = {
				"What A Delight. To See. YOU!"
			},
			j_dbbq_stalker_captivity = {
				"GLORY! It Is To See. Your",
				"Actions. While. YOU Are",
				"Trapped Here. In Captivity."
			},
			j_dbbq_party_boss = {
				"I AM THE BOSS!!"
			},
			j_dbbq_party_focusing = {
				"You're better off focusing",
				"on other things in life."
			},
			j_dbbq_party_crazy = {
				"What the hell are you talking about?",
				"You better start dancing, crazy."
			},
			j_dbbq_party_whistle = {
				"Follow the whistle",
				"and let yourself go."
			},
			j_dbbq_quartet_delightful = {
				"{C:purple}Delightful! Off we go, then.",
				"{C:gold}Don't spend it all in one place.",
				"{C:mult}Take care, dearie!",
			},
			j_dbbq_quartet_reference = {
				"{C:gold}Psst... \"We should go home,",
				"{C:gold}I am allergic to persons.\"",
				"{C:green}HAAAA-HA! I GOT THAT REFERENCE!!!",
				"{C:mult}Shhh! Zip it!!!"
			},
			j_dbbq_quartet_fault = {
				"{C:green}GREAT! NOW WE WON'T MAKE IT TO THE",
				"{C:green}PURGE EVENT AND IT'S ALL YOUR FAULT.",
				"{C:gold}Could you hurry it, please? I miss",
				"{C:gold}my coffin.",
				"{C:mult}I'd be surprised if you're still",
				"{C:mult}alive. 5 minutes alone with us would",
				"{C:mult}drive any entity to split into its",
				"{C:mult}component parts."
			},
			j_dbbq_sales_loop = {
				"{C:mult}Huh. Seems I am out of",
				"{C:mult}the loop. Shall we review",
				"{C:mult}the job description?"
			},
			j_dbbq_sales_ambush = {
				"{C:mult}Let's arrange our next",
				"{C:mult}ambush at the scene!"
			},
			j_dbbq_sales_doable = {
				"{C:mult}That was most categorically doable."
			},
			j_dbbq_sales_child = {
				"{C:mult}Worry not, you are",
				"{C:mult}still a child of GOD."
			},
			j_dbbq_sales_bless = {
				"{C:mult}Bless you for your business."
			},
			j_dbbq_sales_personally = {
				"{C:mult}Don't take it personally."
			},
			j_dbbq_sixeyed_thank = {
				"Thank you. I don't know what",
				"I would have done without this."
			},
			j_dbbq_sixeyed_back = {
				"I want to go back.",
				"I'm so tired..."
			},
			j_dbbq_sixeyed_before = {
				"I've never seen",
				"something like this",
				"before. It's relaxing."
			},
			j_dbbq_sixeyed_death = {
				"To toil beyond death itself."
			},
			j_dbbq_casino_tv_dinner = {
				"Ugh, you again. Go away!",
				"You smell poor! Go eat a",
				"TV dinner, you broke,",
				"ping-collared slug!"
			},
			j_dbbq_casino_nonsense = {
				"What?! I hope you are spitting",
				"some needy nonsense!"
			},
			j_dbbq_casino_richer = {
				"Now SHOO! Come back when",
				"you're a little, mmm, richer!"
			},
			j_dbbq_casino_clodpoll = {
				"You poor, needy, beggarly, hard up,",
				"schlocky, frowzy, scrimpy clodpoll!"
			},
			j_dbbq_casino_problematic = {
				"Ah, making more losses, are we?",
				"You seem rather... ah, pro-ble-ma-tic."
			},
			j_dbbq_casino_luck = {
				"You are pushing your luck, 'winner'."
			},
			j_dbbq_casino_slacking = {
				"I have no time for slacking off and",
				"insulting a lowly conman all day.",
				"Do what you need to do and leave."
			},
			j_dbbq_casino_party = {
				"If you are a party person, you",
				"can always switch the mood and",
				"attend the infamous Purge Event."
			},
			j_dbbq_tumi_boss = {
				"I am the B-O-S-S! ...Naaah,",
				"I W-I-S-H. I wish! Hahaha!"
			},
			j_dbbq_tumi_nobody = {
				"What do have H-A-V-E H-E-R-E?",
				"L-O-O-K at this nobody who",
				"isn't having a G-O-O-D T-I-M-E!"
			},
			j_dbbq_tumi_waste = {
				"Uhhh... What a W-A-S-TE...",
				"w-aaa-s-ttt... aw, shoot."
			},
			j_dbbq_tumi_menu = {
				"What's on the M-E-N-U tonight?!",
				"Oh, I'm really hoping it's me!"
			},
			j_dbbq_tpao_understand = {
				"I'm glad we understand each",
				"each other. YOU are here",
				"because you want to be.",
				"I can see it in your eyes."
			},
			j_dbbq_tpao_life = {
				"Now, go away, and get a LIFE.",
				"That shall be your quest today!"
			},
			j_dbbq_tpao_forgive = {
				"May the GODS forgive me",
				"for what I'm about to do."
			},
			j_dbbq_tpao_done = {
				"What had to be done was done,",
				"but... what hadn't been done",
				"was done too. And now that it",
				"is done, it may be done again.",
				"Done. Done. Done..."
			},
			j_dbbq_tpao_anew = {
				"Now, it's your turn",
				"to BEGIN LIFE ANEW!",
				"...Possibly."
			},
			j_dbbq_tpao_explain = {
				"I shall be happy to explain",
				"everything to you:",
				"\"One person can be in two places",
				"at once. Althrough, the magician does",
				"not have to be in two places at once.",
				"He can be in one place at once ti&#-\""
			},
			j_dbbq_unlucky_boss = {
				"I am the Boss!"
			},
			j_dbbq_unlucky_simpleton = {
				"I have seen you millions",
				"of times here, is this something",
				"like a simpleton event?!",
				"AHAHAHAHAHA!"
			},
			j_dbbq_unlucky_cruise = {
				"I am so ready to cruise",
				"and party responsibly",
				"in every illegal way!"
			},
			j_dbbq_unlucky_poppers = {
				"Had one too many",
				"party poppers?"
			},
		},		
		labels = {
			dbbq_pet_seal = "Pe? Seal",
		}
	}
}
