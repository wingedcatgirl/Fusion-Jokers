return {
	["misc"] = {
		["dictionary"] = {
            ["k_fusion"] = "Fusion",
			["k_fuse_fusion"] = "Fusion",
            ["k_flipped_ex"] = "Flipped!",
            ["k_copied_ex"] = "Cloned!",
            ["k_in_tact_ex"] = "In-Tact!",
            ["b_fuse"] = "FUSE",
		},
		["labels"] = {
			["k_fuse_fusion"] = "Fusion",
		},
	},
	["descriptions"] = {
		["Joker"] = {
			["j_fuse_diamond_bard"] = {
				["name"] = "Diamond Bard",
				["text"] = {
                    "Played cards with {C:diamonds}Diamond{} suit give",
                    "{C:money}$#1#{}, as well as {C:mult}+#2#{} Mult for every ",
                    "{C:money}$#3#{} you have when scored",
                    "{C:inactive}(#4# + #5#)",
				},
			},
			["j_fuse_heart_paladin"] = {
				["name"] = "Heart Paladin",
				["text"] = {
                    "Played cards with {C:hearts}Heart{} suit give",
                    "{X:mult,C:white}X#1#{} Mult when scored.",
                    "{C:green}#2# in #3#{} chance to re-trigger",
                    "{C:inactive}(#4# + #5#)",
				},
			},
			["j_fuse_spade_archer"] = {
				["name"] = "Spade Archer",
				["text"] = {
                    "Played cards with {C:spades}Spade{} suit give",
                    "{C:chips}+#1#{} Chips when scored. Gains {C:chips}+#2#{} ",
                    "chips when 5 or more {C:spades}Spades{} are played",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_club_wizard"] = {
				["name"] = "Club Wizard",
				["text"] = {
                    "Played cards with {C:clubs}Club{} suit",
                    "give {C:mult}+#1#{} Mult when scored",
                    "{C:inactive}(#2# + #3#)",
				},
			},
			["j_fuse_big_bang"] = {
				["name"] = "Big Bang",
				["text"] = {
                    "{X:mult,C:white} X#1# {} Mult per the number",
                    "of times {C:attention}poker hand{} has been played",
                    "plus the level of the {C:attention}poker hand{}.",
                    "{C:inactive}(#2# + #3#)",
				},
			},
			["j_fuse_dynamic_duo"] = {
				["name"] = "Dynamic Duo",
				["text"] = {
                    "Played {C:attention}number{} cards give {C:mult}+#1#{} Mult ",
                    "and {C:chips}+#2#{} Chips when scored.",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_collectible_chaos_card"] = {
				["name"] = "Collectible Chaos Card",
				["text"] = {
                    "{C:mult}+#1#{} Mult per {C:attention}reroll{} in the shop.",
                    "{C:attention}#2#{} free {C:green}Reroll{} per shop",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
                    "{C:inactive}(#4# + #5#)",
				},
			},
			["j_fuse_flip_flop"] = {
				["name"] = "Flip-Flop",
				["text"] = {
                    "{C:attention}+#1#{} hand size. {C:red}+#2#{} Mult",
                    "{C:attention}Flips{} after each blind",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_flip_flop_mult"] = {
				["name"] = "Flip-Flop",
				["text"] = {
                    "{C:attention}+#1#{} hand size. {C:red}+#2#{} Mult",
                    "{C:attention}Flips{} after each blind",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_flip_flop_chips"] = {
				["name"] = "Flip-Flop",
				["text"] = {
                    "{C:red}+#1#{} discard. {C:chips}+#2#{} Chips",
                    "{C:attention}Flips{} after each blind",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_royal_decree"] = {
				["name"] = "Royal Decree",
				["text"] = {
                    "Played {C:attention}face{} cards give {C:money}$#1#{} when scored.",
                    "Each {C:attention}face{} card held in hand",
                    "at end of round gives {C:money}$#1#{}",
                    "{C:inactive}(#2# + #3#)",
				},
			},
			["j_fuse_dementia_joker"] = {
				["name"] = "Dementia Joker",
				["text"] = {
                    "{C:mult}+#1#{} Mult for each {C:attention}Joker{} card.",
                    "{C:green}#2# in #3#{} chance to {C:attention}clone{} if ",
                    "not {C:dark_edition}Negative{} after you beat a blind",
                    "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)",
                    "{C:inactive}(#5# + #6#)",
				},
			},
			["j_fuse_golden_egg"] = {
				["name"] = "Golden Egg",
				["text"] = {
                    "Gains {C:money}$#1#{} of {C:attention}sell value{}",
                    " at end of round.",
                    " Earn {C:money}$#1#{} at end of round",
                    "{C:inactive}(#2# + #3#)",
				},
			},
			["j_fuse_flag_bearer"] = {
				["name"] = "Flag Bearer",
				["text"] = {
                    "{C:mult}+#1#{} Mult per hand played, {C:mult}-#2#{} Mult",
                    "per discard. Mult is multiplied by",
                    " remaining {C:attention}discards{}",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
                    "{C:inactive}(#4# + #5#)",
				},
			},
			["j_fuse_uncanny_face"] = {
				["name"] = "Uncanny Face",
				["text"] = {
                    "Played {C:attention}face{} cards give {C:chips}+#1#{} Chips and",
                    "{C:mult}+#2#{} Mult for every {C:attention}face{} card",
                    " in the scoring hand",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_commercial_driver"] = {
				["name"] = "Commercial Driver",
				["text"] = {
                    "{X:mult,C:white} X#1# {} Mult per consecutive hand",
                    "played with a scoring {C:attention}enhanced{} card",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_camping_trip"] = {
				["name"] = "Camping Trip",
				["text"] = {
                    "Played {C:attention}cards{} permanently gains",
                    "{C:chips}+#1#{} Chips when scored",
                    "({C:chips}+#2#{} on the final hand)",
                    "Your final hand triggers twice",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_star_oracle"] = {
				["name"] = "Star Oracle",
				["text"] = {
                    "{C:attention}+2{} consumable slots.",
                    "{C:green}#1# in #2#{} chance for played cards",
                    " with {C:stars}Star{} suit to create a",
                    "random {C:spectral}Spectral{} card when scored",
                    "{C:inactive}(#3# + #4#)",
				},
			},
			["j_fuse_moon_marauder"] = {
				["name"] = "Moon Marauder",
				["text"] = {
                    "{C:green}#1# in #2#{} chance for played cards with",
                    "{C:moons}Moon{} suit to become {C:attention}Glass{} Cards.",
                    "played {C:moons}Moon{} {C:attention}Glass{} cards never shatter",
                    "{C:inactive}(#3# + #4#)",
				},
			},
		},
	},
}