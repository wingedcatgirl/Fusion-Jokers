FusionJokers.fusions:add_fusion("j_six_envious_joker", nil, false, "j_six_star_ruby", nil, false, "j_fuse_star_oracle", 12)

SMODS.Atlas {
    key = 'star_oracle',
    path = "j_star_oracle.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "star_oracle",
    name = "Star Oracle",
    atlas = 'star_oracle',
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
			odds = 10,
            slots = 2, 
            joker1 = "j_six_envious_joker", 
            joker2 = "j_six_star_ruby",
        }
    },
    loc_vars = function(self, info_queue, card)
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "fusion_staroracle_desc", false)
        return {
            vars = {
                luck,
                odds,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(card.ability.extra.slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-card.ability.extra.slots)
    end,
    calculate = function(self, card, context)
        if context.individual and
        context.cardarea == G.play and
        context.other_card:is_suit('Stars') and
        #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and
        SMODS.pseudorandom_probability(card, 'starruby', 1, card.ability.extra.odds, 'starruby') then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local _card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'ruby')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                { message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral })
            return {}
        end
    end
}

-- See localization/en-us.lua to create joker text