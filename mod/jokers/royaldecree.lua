SMODS.Atlas {
    key = 'royal_decree',
    path = "j_royal_decree.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "royal_decree",
    name = "Royal Decree",
    atlas = 'royal_decree',
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
            dollars = 2,
            joker1 = "j_business",
            joker2 = "j_reserved_parking",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.individual then
			if context.cardarea == G.hand and context.other_card:is_face() then
				return {
					h_dollars = 2,
					card = card
				}
			end
		end

		if context.cardarea == G.play and context.individual and context.other_card:is_face() then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 2
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                dollars = 2,
                card = card
            }

		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "$",                              colour = G.C.GOLD },
                { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult", colour = G.C.GOLD },
                { text = " (played)",              colour = G.C.GOLD },
            },
            reminder_text = {
                { text = "$",                              colour = G.C.GOLD },
                { ref_table = "card.joker_display_values", ref_value = "count2",   retrigger_type = "mult", colour = G.C.GOLD },
                { text = " (held)",               colour = G.C.GOLD },
            },
            reminder_text_config = { scale = 0.35 },
            calc_function = function(card)
                local count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_face() then
                            count = count + card.ability.extra.dollars *
                                JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.count = count
                local playing_hand = next(G.play.cards)
                local count = 0
                for _, playing_card in ipairs(G.hand.cards) do
                    if playing_hand or not playing_card.highlighted then
                        if playing_card.facing and not (playing_card.facing == 'back') and playing_card:is_face() then
                            count = count + 2 * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                        end
                    end
                end
                card.joker_display_values.count2 = count
            end
        }
    end
}

-- See localization/en-us.lua to create joker text