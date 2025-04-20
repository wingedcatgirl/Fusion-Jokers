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
    end
}

-- See localization/en-us.lua to create joker text