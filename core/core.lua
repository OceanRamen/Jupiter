local lovely = require ("lovely")
local nativefs = require ("nativefs")

assert(load(nativefs.read(lovely.mod_dir .. "/Jupiter/core/".."jupiter.lua")))()
assert(load(nativefs.read(lovely.mod_dir .. "/Jupiter/core/".."globals.lua")))()