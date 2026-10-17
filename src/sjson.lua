local bink_prefixes = {
    ares = "zpMMAres",
    prometheus = "zpMMProm",
    skelly = "zpMMSkel"
}

local guiScreensVfxFile = rom.path.combine(rom.paths.Content(), "Game\\Animations\\GUI_Screens_VFX.sjson")

local newMenuAnimations = {
    {
		Name = _PLUGIN.guid .. "MainMenuIn",
		ChainTo = _PLUGIN.guid .. "MainMenuLoop",
		FilePath = "Screens\\MainMenuIn\\MainMenuIn",
		VideoTexture = "In",
		EndFrame = 90,
		NumFrames = 90,
		PlaySpeed = 30.0,
		StartFrame = 1,
		Ambient = 0.0,
		OnlyWhenVisible = true,
		HoldLastFrame = false,
		Slides =
		{
			{ DurationFrames = 1, Sound = "/SFX/IrisMainMenuSFX", Frame = 1 }
        }
	},
    {
		Name = _PLUGIN.guid .. "MainMenuLoop",
		InheritFrom = _PLUGIN.guid .. "MainMenuIn",
		FilePath = "Screens\\MainMenuLoop\\MainMenuLoop",
		VideoTexture = "Loop",
		ClearSlides = true,
		Loop = true,
		ChainTo = "null",
		PlaySpeed = 30,
		ChildAnimation = _PLUGIN.guid .. "MainMenuMelHair",
	},
    {
		Name = _PLUGIN.guid .. "MainMenuMel",
		FilePath = _PLUGIN.guid .. "\\Screens\\MainMenuMel\\Mel",
		Ambient = 0.0,
		ChildAnimation = _PLUGIN.guid .. "StraightDaggerLoop",
		OffsetX = 450,
		OffsetY = 126,
		StartAlpha = 0,
		EndAlpha = 1,
		Duration = 1,
		EaseIn = 0,
		EaseOut = 1,
		HoldLastFrame = true,
	},
    {
		Name = _PLUGIN.guid .. "MainMenuMelHair",
		FilePath = _PLUGIN.guid .. "\\Screens\\MainMenuMel\\HairLaurelsLoop",
		NumFrames = 90,
		Loop = true,
		PlaySpeed = 30,
		OffsetX = 640.0,
		OffsetY = -341,
		ChildAnimation = _PLUGIN.guid .. "MainMenuMel", -- replaced MenuOptionsShadow with MainMenuMel
	},
    {
		Name = _PLUGIN.guid .. "StraightDaggerLoop",
		InheritFrom = _PLUGIN.guid .. "MainMenuMelHair",
		FilePath = _PLUGIN.guid .. "\\Screens\\MainMenuMel\\StraightDaggerLoop\\StraightDaggerLoop",
		ChildAnimation = _PLUGIN.guid .. "CrescentDaggerLoop",
		OffsetX = 169,
		OffsetY = 14,
		StartScale = 0.99,
		EndScale = 0.991,
		PlaySpeed = 30,
		PingPongShiftOverDuration = true,
		EaseIn = 0,
		EaseOut = 1,
		StartOffsetY = 0,
		EndOffsetY = 9,
		StartOffsetX = 0,
		EndOffsetX = -5,
		StartAngle = 0,
		EndAngle = 2,
		PingPongAngle = true,
		PhaseOffsetAngle = 0,
	},
    {
		Name = _PLUGIN.guid .. "CrescentDaggerLoop",
		InheritFrom = _PLUGIN.guid .. "StraightDaggerLoop",
		FilePath = _PLUGIN.guid .. "\\Screens\\MainMenuMel\\CrescentDaggerLoop\\CrescentDaggerLoop",
		OffsetX = 798.0,
		OffsetY = -80,
		StartAngle = 11.3,
		EndAngle = 9.3,
		StartScale = 0.987,
		EndScale = 0.986,
		PingPongScale = true,
		StartOffsetX = 0,
		EndOffsetX = 5,
		ChildAnimation = "null",
	},
    {
		Name = _PLUGIN.guid .. "MainMenuLogoOutline",
		FilePath = "Screens\\MainMenuLoop\\HadesLogoOutline",
		Scale = 0.5
	}
}

local order = {
    "Name",
    "InheritFrom",
    "FilePath"
}

local zjModifications = {
    ModsNikkelMHadesBiomes_MainMenuMashupLogo_Early =
    {
        StartScale = 0.4986,
		EndScale = 0.50,
        OffsetXOffset = -137,
        OffsetYOffset = -220,
        -- TODO: from upstream ZJ, remove when 2.0 launches
        OffsetX = 250,
		OffsetY = -370,
		Duration = 2.2,
        EaseIn = -7.25333,
    },
    ModsNikkelMHadesBiomes_MainMenuMashupX_Early =
    {
        StartScale = 0.4532,
		EndScale = 0.46,
        OffsetXOffset = -137,
        OffsetYOffset = -220,
        -- TODO: from upstream ZJ, remove when 2.0 launches
        OffsetX = -180,
		OffsetY = -425,
		Duration = 2.2,
        EaseIn = -7.25333,
    },
    MainMenuLogoOutline_Early =
    {
        StartScale = 0.61875,
		EndScale = 0.62,
        OffsetXOffset = -112,
        OffsetYOffset = -160,
        -- TODO: from upstream ZJ, remove when 2.0 launches
        OffsetX = -708,
		OffsetY = -326,
		Duration = 2.2,
        EaseIn = -7.25333,
    },
    ModsNikkelMHadesBiomes_MainMenuMashupLogo =
    {
        StartScale = 0.50,
		EndScale = 0.50001,
        OffsetXOffset = -137,
        OffsetYOffset = -220,
    },
    ModsNikkelMHadesBiomes_MainMenuMashupX =
    {
        StartScale = 0.46,
		EndScale = 0.46001,
        OffsetXOffset = -137,
        OffsetYOffset = -220,
    },
    MainMenuLogoOutline =
    {
        StartScale =  0.62,
		EndScale = 0.620001,
        OffsetXOffset = -112,
        OffsetYOffset = -160,
    }
}

local zj_base_mods = {
    [_PLUGIN.guid .. "MainMenuIn"] = {
        ChildAnimation = "ModsNikkelMHadesBiomes_MainMenuMashupX_Early",
    },
    [_PLUGIN.guid .. "CrescentDaggerLoop"] = {
        ChildAnimation = "ModsNikkelMHadesBiomes_MainMenuMashupX",
    },
}

local zj_vanilla_overwrite = {
    "OffsetX",
    "OffsetY",
    "Duration",
    "EaseIn",
}

local zj_vanilla_mods = {
    ["MainMenuIn"] = {
        ChildAnimation = "ModsNikkelMHadesBiomes_MainMenuMashupX_Early"
    }
}

local selectedScreen = config.screen
if not bink_prefixes[selectedScreen] then
    selectedScreen = "base"
end

if config.random then
    local valid_screens = {}
    for key, value in pairs(config.random_allowed) do
        if value then table.insert(valid_screens, key) end
    end
    if not next(valid_screens) then
        table.insert(valid_screens, "base")
    end
    selectedScreen = valid_screens[math.random(#valid_screens)]
end

local selectedBink = bink_prefixes[selectedScreen]

print("Selected screen", selectedScreen, selectedBink)

sjson.hook(guiScreensVfxFile, function (data)
    if selectedBink then
        for _, entry in ipairs(newMenuAnimations) do
            local newentry = game.DeepCopyTable(entry)
            if newentry.VideoTexture then
                if selectedBink ~= "zpMMSkel" then
                    newentry.VideoTexture = selectedBink .. newentry.VideoTexture
                else
                    newentry.VideoTexture = selectedBink
                    if newentry.Name == _PLUGIN.guid .. "MainMenuLoop" then
                        newentry.StartFrame = 91
                        newentry.NumFrames = 90
                    end
                end
            end
            table.insert(data.Animations, sjson.to_object(newentry, order))
        end
        if mod.IsZag then
            for _, entry in ipairs(data.Animations) do
                if zjModifications[entry.Name] then
                    for key, value in pairs(zjModifications[entry.Name]) do
                        if entry[key] then
                            entry[key] = value
                        end
                    end
                    if entry.OffsetX and zjModifications[entry.Name].OffsetXOffset then
                        entry.OffsetX = entry.OffsetX + zjModifications[entry.Name].OffsetXOffset
                    end
                    if entry.OffsetY and zjModifications[entry.Name].OffsetYOffset then
                        entry.OffsetY = entry.OffsetY + zjModifications[entry.Name].OffsetYOffset
                    end
                end
                if zj_base_mods[entry.Name] then
                    for key, value in pairs(zj_base_mods[entry.Name]) do
                        entry[key] = value
                    end
                end
            end
        end
    elseif mod.IsZag then
        -- TODO: remove on ZJ 2.0
        for _, entry in ipairs(data.Animations) do
            if zjModifications[entry.Name] then
                for key, value in pairs(zjModifications[entry.Name]) do
                    if game.Contains(zj_vanilla_overwrite, key) then
                        entry[key] = value
                    end
                end
            end
            if zj_vanilla_mods[entry.Name] then
                for key, value in pairs(zj_vanilla_mods[entry.Name]) do
                    entry[key] = value
                end
            end
        end
    end
    config.sjson_selected_cache = selectedBink or "null"
    print("caching selectedBink in sjson_selected_cache", config.sjson_selected_cache)
    return data
end)

local mainMenuScreenFile = rom.path.combine(rom.paths.Content(), "Game\\GUI\\MainMenuScreen.sjson")

sjson.hook(mainMenuScreenFile, function (data)
    print("main menu screen sjson hook called", config.sjson_selected_cache, selectedBink)
    if config.sjson_selected_cache ~= "null" then
        data.MainMenuScreen.AnimatedBackground.Graphic = _PLUGIN.guid .. data.MainMenuScreen.AnimatedBackground.Graphic
        data.MainMenuScreen.PlayGameButton.X = 457
        data.MainMenuScreen.PlayGameButton.Y = 575
    end
    return data
end)