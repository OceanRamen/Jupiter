local lovely = require("lovely")
VERSION = "1.0.0b"
VERSION = VERSION .. "-FULL"
MOD_PATH = lovely.mod_dir .. "/Jupiter/"

function Jupiter:set_globals()
  self.VERSION = VERSION
  self.MOD_PATH = MOD_PATH
end

J = Jupiter()