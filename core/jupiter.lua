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

		if not J.twitch_user or not J.api_key then
			return
		end

		local request_headers = {}
		local request_payload = J.json.encode({
			joker_data = jokermap,
			time_seconds = os.time()
		})

		request_headers['Content-Type'] = "application/json"
		request_headers['Authorization'] = "Basic " .. (J.mime.b64(J.twitch_user .. ":" .. J.api_key))
		request_headers['Content-Length'] = request_payload:len()

		-- How do I make this nonblocking?
		J.http.request {
			url = 'http://localhost:8881/submitCardData',
			method = 'POST',
			source = J.ltn12.source.string(request_payload),
			headers = request_headers
		}
	end
end
