SMODS.Atlas {
    key = 'dementia_joker',
    path = "j_dementia_joker.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "dementia_joker",
    name = "Dementia Joker",
    atlas = 'dementia_joker',
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
            mult = 3,
            odds = 3,
            joker1 = "j_abstract",
            joker2 = "j_riff_raff",
        }
    },
    loc_vars = function(self, info_queue, card)
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "fusion_dementia_desc", false)
        return {
            vars = {
                card.ability.extra.mult,
                luck, odds,
                (G.jokers and G.jokers.cards and #G.jokers.cards or 0)*card.ability.extra.mult,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			if SMODS.pseudorandom_probability(card, 'dementia_joker', 1, card.ability.extra.odds, 'dementia_joker')
			and not (card.edition and card.edition.negative) then
				local card = copy_card(card, nil, nil, nil, card.edition and card.edition.negative)
				card:set_edition({negative = true}, true)
				card:add_to_deck()
				G.jokers:emplace(card)
				return {
					message = localize('k_copied_ex'),
					colour = G.C.DARK_EDITION
				}
			end
		end

		if context.cardarea == G.jokers and context.joker_main then
			local x = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.set == 'Joker' then x = x + 1 end
			end
			return {
				message = localize{type='variable',key='a_mult',vars={x*card.ability.extra.mult}},
				mult_mod = x*card.ability.extra.mult
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
            },
            extra = {
                {
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                }
            },
            extra_config = { colour = G.C.GREEN, scale = 0.3 },
            text_config = { colour = G.C.MULT },
            calc_function = function(card)
                local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "fusion_dementia_desc", false)
                card.joker_display_values.mult = (G.jokers and G.jokers.cards and #G.jokers.cards or 0) * card.ability.extra.mult
                if card.edition and card.edition.negative then
                    card.joker_display_values.odds = ""
                else
                    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { luck, odds } }
                end
            end
        }
    end
}

-- See localization/en-us.lua to create joker text