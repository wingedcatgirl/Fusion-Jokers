SMODS.Atlas {
    key = 'collectible_chaos_card',
    path = "j_collectible_chaos_card.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "collectible_chaos_card",
    name = "Collectible Chaos Card",
    atlas = 'collectible_chaos_card',
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
            per_reroll = 2,
            free = 1,
            mult = 0,
            joker1 = "j_chaos",
            joker2 = "j_flash"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.per_reroll,
                card.ability.extra.free,
                card.ability.extra.mult,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then -- no gameplan shenanigans for bunco enjoyers :p 
            G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + card.ability.extra.free
            calculate_reroll_cost(true)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls - card.ability.extra.free, 0)
        calculate_reroll_cost(true)
    end,
    set_ability = function(self, card, initial, delay_sprites)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3, blocking = false,
			func = function()
                if card.ability.mult and (card.ability.extra.mult == 0) then
                    card.ability.extra.mult = card.ability.mult or 0
                    card.ability.mult = nil
                end
			return true
			end}))
    end,
    calculate = function(self, card, context)
        if context.starting_shop and not context.blueprint then
            G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls or 0
            G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + card.ability.extra.free
            calculate_reroll_cost(true)
        end

		if context.reroll_shop and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.per_reroll
            G.E_MANAGER:add_event(Event({
                func = (function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, colour = G.C.MULT})
                return true
             end)}))
		end

		if context.cardarea == G.jokers and card.ability.extra.mult > 0 and context.joker_main then
			return {
				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
				mult_mod = card.ability.extra.mult
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.ability", ref_value = "mult", retrigger_type = "mult" }
            },
            text_config = { colour = G.C.MULT },
        }
    end
}

-- See localization/en-us.lua to create joker text