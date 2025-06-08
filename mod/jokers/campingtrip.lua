SMODS.Atlas {
    key = 'camping_trip',
    path = "j_camping_trip.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "camping_trip",
    name = "Camping Trip",
    atlas = 'camping_trip',
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
            bonus_base = 5, 
            bonus_final = 10, 
            joker1 = "j_hiker", 
            joker2 = "j_dusk"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bonus_base,
                card.ability.extra.bonus_final,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local buff = card.ability.extra.bonus_base
            if G.GAME.current_round.hands_left == 0 then
                buff = card.ability.extra.bonus_final
            end
			context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + buff

            return {
                extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                colour = G.C.CHIPS,
                card = card
            }
		end

		if context.repetition and context.cardarea == G.play and G.GAME.current_round.hands_left == 0 then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "active" },
                { text = ")" },
            },
            calc_function = function(card)
                card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_left <= 1 and
                    localize("jdis_active") or localize("jdis_inactive")
            end,
            retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
                if held_in_hand then return 0 end
                return G.GAME and G.GAME.current_round.hands_left <= 1 and
                1 * JokerDisplay.calculate_joker_triggers(joker_card) or 0
            end
        }
    end
}

-- See localization/en-us.lua to create joker text
