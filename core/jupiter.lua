Jupiter = Object:extend()

function Jupiter:init()
	J = self

	self:set_globals()
end

function Jupiter:start_up()
end

function Jupiter:emit_joker_data()
	local jokermap = {}

	if #G.jokers.cards > 0 then
		print("Number of jokers: "..#G.jokers.cards)
		for number, card in ipairs(G.jokers.cards) do
			print("Joker " .. number .. " name: "..card.ability.name)
			print("Joker " .. number .. " effect: "..(card.ability.effect or ""))

			local config_center = card.config.center
			local loc_var = card:get_localization_vars()
			local text = localize { type = 'raw_descriptions', set = config_center.set, key = config_center.key, vars = loc_var }

			local joker_description = nil
			for _, textline in ipairs(text) do
				if joker_description == nil then
					joker_description = textline
				else
					joker_description = joker_description .. " " .. textline
				end
			end

			print("Joker " .. number .. " description: "..(joker_description or ""))
			jokermap[number] = {
				joker_name = card.ability.name,
				joker_spot = number,
				joker_description = joker_description
			}
		end

		if not J.twitch_user or not J.api_key then return end

		J.http.request(
			'http://localhost:8881/',
			J.json.encode(jokermap)
		)
	end
end
