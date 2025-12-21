SMODS.Atlas {
    key = 'spade_archer',
    path = "j_spade_archer.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "spade_archer",
    name = "Spade Archer",
    atlas = 'spade_archer',
    pos = {
        x = 0,
        y = 0
    },
    rarity = "fuse_fusion",
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = {
		chips = 50,
        chip_mod = 10, 
        joker1 = "j_wrathful_joker", 
        joker2 = "j_arrowhead"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chip_mod,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Spades') then
			return {
				chips = card.ability.extra.chips,
				card = card
			}
		end

		if context.before and context.cardarea == G.jokers and not context.blueprint then
			local spades = 0
			for k, v in ipairs(context.scoring_hand) do
				if v:is_suit('Spades') then
					spades = spades + 1
				end
			end
			if spades >= 5 then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS,
					card = card
				}
			end
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" },
            },
            text_config = { colour = G.C.CHIPS },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Spades"], 0.35) },
                { text = ")" }
            },
            calc_function = function(card)
                local chips = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_suit("Spades") then
                            chips = chips +
                                card.ability.extra.chips * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.chips = chips
                card.joker_display_values.localized_text = localize("Spades", 'suits_plural')
            end
        }
    end,
}

-- See localization/en-us.lua to create joker text
