SMODS.Atlas {
    key = 'uncanny_face',
    path = "j_uncanny_face.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "uncanny_face",
    name = "Uncanny Face",
    atlas = 'uncanny_face',
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
            chips = 15,
            mult = 2,
            joker1 = "j_scary_face", 
            joker2 = "j_smiley"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips, 
                card.ability.extra.mult,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
		context.other_card:is_face() then
			local faces = 0
			for k, v in ipairs(context.scoring_hand) do
				if v:is_face() then
					faces = faces + 1
				end
			end
			return {
				mult = card.ability.extra.mult * faces,
				chips = card.ability.extra.chips * faces,
				card = card
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+",                              colour = G.C.CHIPS },
                { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
                { text = " +",                             colour = G.C.MULT },
                { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
            },
            reminder_text = {
                { ref_table = "card.joker_display_values", ref_value = "localized_text" }
            },
            calc_function = function(card)
                local chips, mult = 0, 0
                local face = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_face() then
                            local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                            face = face + 1
                            chips = chips + card.ability.extra.chips * retriggers
                            mult = mult + card.ability.extra.mult * retriggers
                        end
                    end
                end
                card.joker_display_values.mult = mult * face
                card.joker_display_values.chips = chips * face
                card.joker_display_values.localized_text = localize("k_face_cards")
            end
        }
    end
}

-- See localization/en-us.lua to create joker text