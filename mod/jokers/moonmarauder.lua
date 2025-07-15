FusionJokers.fusions:add_fusion("j_six_slothful_joker", nil, false, "j_six_moonstone", nil, false, "j_fuse_moon_marauder", 12)

SMODS.Atlas {
    key = 'moon_marauder',
    path = "j_moon_marauder.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "moon_marauder",
    name = "Moon Marauder",
    atlas = 'moon_marauder',
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
            joker1 = "j_six_slothful_joker",
            joker2 = "j_six_moonstone"
        }
    },
    loc_vars = function(self, info_queue, card)
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "fusion_moonmarauder_desc", false)
        return {
            vars = {
                luck,
                odds,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and (context.cardarea == G.jokers) then
            local moons = {}
            for _, v in ipairs(context.full_hand) do
                if v:is_suit('Moons') and not (v.ability.name == 'Glass Card') and SMODS.pseudorandom_probability(card, 'moon_marauder', 1, card.ability.extra.odds, 'moon_marauder') then
                    moons[#moons + 1] = v
                    v:set_ability(G.P_CENTERS.m_glass, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            if #moons > 0 then
                return {
                    message = localize('k_glass'),
                    colour = G.C.SECONDARY_SET.Enhanced,
                    card = context.blueprint_card or card
                }
            end
        end

        if context.remove_playing_cards and not context.blueprint then
            -- G.E_MANAGER:add_event(Event({
            -- 	trigger = 'after', 
            -- 	delay = 1,
            -- 	func = function()
            -- 		sendDebugMessage(tostring(#context.removed))
            -- 		for k, v in ipairs(context.removed) do
            -- 			sendDebugMessage(tostring(v.shattered))
            -- 			if v.shattered then
            -- 				local _card = Card(G.play.T.x, G.play.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.c_base, {playing_card = G.playing_card})

            -- 				_card = copy_card(v, _card, nil, G.playing_card)
            -- 				_card:start_materialize({G.C.SECONDARY_SET.Enhanced})
            -- 				G.deck:emplace(_card)

            -- 				G.E_MANAGER:add_event(Event({
            -- 					func = function()
            -- 						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
            -- 						{ message = localize('k_in_tact_ex'), colour = G.C.SECONDARY_SET.edition })
            -- 						return true
            -- 					end
            -- 				}))
            -- 			end
            -- 		end
            -- 	end
            -- }))
            sendDebugMessage(tostring(#context.removed))
            for k, v in ipairs(context.removed) do
                sendDebugMessage(tostring(v.shattered))
                if v.shattered then
                    local _card = Card(G.play.T.x, G.play.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS.c_base, {playing_card = G.playing_card})

                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    _card = copy_card(v, _card, nil, G.playing_card)
                    _card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                    G.deck:emplace(_card)
                    table.insert(G.playing_cards, _card)

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                            { message = localize('k_in_tact_ex'), colour = G.C.SECONDARY_SET.edition })
                            return true
                        end
                    }))
                end
            end
        end
    end
}

-- See localization/en-us.lua to create joker text