SMODS.Joker {
    key = 'onetwenty', 
    atlas = 'bobnerholders',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            mult = 10,
            odds = 20,
        }
    },
    loc_txt = {
        name = 'OneTwenty Bass',
        text = {
            "{C:mult}+#1#{} Mult",
            "{C:green}#2# in #3#{} chance to",
            "destroy itself after",
            "a hand is played"
        }
    },
    rarity = 2,
    cost = 5,
    loc_vars = function(self, infoqueue, card)
        return {
            vars = {
                card.ability.extra.mult,
                -- We check if G.GAME exists so the game doesn't crash on the main menu!
                (G.GAME and G.GAME.probabilities.normal or 1), 
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        -- 1. Give the +10 Mult during the scoring phase
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult
            }
        end

        -- 2. The destruction check (happens AFTER the hand is played)
        if context.after and not context.blueprint then
            -- Check if our random chance hits
            if pseudorandom('onetwenty') < (G.GAME.probabilities.normal / card.ability.extra.odds) then
                
                -- Create a visual event to dissolve the card smoothly
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- 2. REPLACED 'tarot1' WITH YOUR CUSTOM BASS SOUND!
                        play_sound('bobner_bass_shatter', 1, 1) 
                        card:start_dissolve() 
                        return true
                    end
                }))
                
                return {
                    message = 'Broken!'
                }
            end
        end
    end
}