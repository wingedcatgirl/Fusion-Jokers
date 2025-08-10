SMODS.Atlas {
    key = 'heart_paladin',
    path = "j_heart_paladin.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "heart_paladin",
    name = "Heart Paladin",
    atlas = 'heart_paladin',
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
            odds = 3,
            Xmult = 1.5,
            joker1 = "j_lusty_joker",
            joker2 = "j_bloodstone"
        }
    },
    loc_vars = function(self, info_queue, card)
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "fusion_heartpaladin_desc", false)
        return {
            vars = {
                card.ability.extra.Xmult,
                luck,
                odds,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Hearts') then
			return {
				x_mult = card.ability.extra.Xmult,
				card = card
			}
		end

		if context.repetition and context.cardarea == G.play and
		context.other_card:is_suit('Hearts') then
			if SMODS.pseudorandom_probability(card, 'heart_paladin', 1, card.ability.extra.odds, 'heart_paladin') then
				return {
					message = localize('k_again_ex'),
					repetitions = 1,
					card = card
				}
			end
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { ref_table = "card.joker_display_values", ref_value = "prefix" },
                        { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "mult" }
                    }
                }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
                { text = ")" }
            },
            calc_function = function(card)
                local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "fusion_heartpaladin_desc", false)
                local x_mult = 1
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                local m = 1.5
                card.joker_display_values.prefix = "X"
                if luck < odds then
                    card.joker_display_values.prefix = "X ~"
                    m = 1.25
                end
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_suit("Hearts") then
                            x_mult = x_mult * m ^ JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.Xmult = x_mult
                card.joker_display_values.localized_text = localize("Hearts", 'suits_plural')
            end
        }
    end
}

-- See localization/en-us.lua to create joker text