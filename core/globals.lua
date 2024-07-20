local lovely = require("lovely")
VERSION = "1.0.0b"
VERSION = VERSION .. "-FULL"
MOD_PATH = lovely.mod_dir .. "/Jupiter/"

function Jupiter:set_globals()
  self.VERSION = VERSION
  self.MOD_PATH = MOD_PATH

  self.twitch_user = 'testuser' -- TODO: load from a ui value
  self.api_key = 'testkey' -- TODO: load from a ui value

  self.http = require("socket.http")
  self.json = require("dkjson")

  print("Jupiter loaded")
end

J = Jupiter()