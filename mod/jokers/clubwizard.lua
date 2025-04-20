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
            joker2 = "j_onyx_agate"
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
    end
}

-- See localization/en-us.lua to create joker text