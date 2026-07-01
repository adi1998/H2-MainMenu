local vanillaMainMenuHash = rom.data.get_hash_guid_from_string("MainMenu")
local moddedMainMenuHash = rom.data.get_hash_guid_from_string(_PLUGIN.guid)

rom.data.load_package_overrides_set(vanillaMainMenuHash, { vanillaMainMenuHash, moddedMainMenuHash })

if game.GameState == nil then
    game.LoadPackages({ Name = _PLUGIN.guid, IgnoreAssert = true })
end