SMODS.Atlas {
    key = 'club_wizard',
    path = "j_club_wizard.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "club_wizard",
    name = "Club Wizard",
    atlas = 'club_wizard',
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
            mult = 24,
            joker1 = "j_gluttenous_joker", 
            joker2 = "j_onyx_agate",
            art = "standard"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Clubs') then
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
            },
            text_config = { colour = G.C.MULT },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Clubs"], 0.35) },
                { text = ")" }
            },
            calc_function = function(card)
                local mult = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_suit("Clubs") then
                            mult = mult +
                                card.ability.extra.mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.mult = mult
                card.joker_display_values.localized_text = localize("Clubs", 'suits_plural')
            end
        }
    end,
	update = function(self, card, dt)
        if not self.discovered and not card.bypass_discovery_center then return end
        if FusionJokers.fusionconfig.cw_alt_art and card.ability.extra.art ~= "alt" then
            card.children.center:set_sprite_pos({ x = 1, y = 0})
            card.ability.extra.art = "alt"
        elseif not FusionJokers.fusionconfig.cw_alt_art and card.ability.extra.art ~= "standard" then
            card.children.center:set_sprite_pos({ x = 0, y = 0})
            card.ability.extra.art = "standard"
        end
    end
}

-- See localization/en-us.lua to create joker text