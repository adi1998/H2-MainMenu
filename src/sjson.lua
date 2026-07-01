local bink_prefixes = {
    "zpMMAres",
    "zpMMProm",
    "zpMMSkel"
}

local guiScreensVfxFile = rom.path.combine(rom.paths.Content, "Game\\Animations\\GUI_Screens_VFX.sjson")

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

local selectedBink = math.random(0, #bink_prefixes)

print("Selected bink", selectedBink, bink_prefixes[selectedBink])

sjson.hook(guiScreensVfxFile, function (data)
    if selectedBink ~= 0 then
        for _, entry in ipairs(newMenuAnimations) do
            local newentry = game.DeepCopyTable(entry)
            if newentry.VideoTexture then
                if bink_prefixes[selectedBink] ~= "zpMMSkel" then
                    newentry.VideoTexture = bink_prefixes[selectedBink] .. newentry.VideoTexture
                else
                    newentry.VideoTexture = bink_prefixes[selectedBink]
                    if newentry.Name == _PLUGIN.guid .. "MainMenuLoop" then
                        newentry.StartFrame = 91
                        newentry.NumFrames = 90
                    end
                end
            end
            table.insert(data.Animations, sjson.to_object(newentry, order))
        end
    end
    return data
end)

local mainMenuScreenFile = rom.path.combine(rom.paths.Content, "Game\\GUI\\MainMenuScreen.sjson")

sjson.hook(mainMenuScreenFile, function (data)
    if selectedBink ~= 0 then
        data.MainMenuScreen.AnimatedBackground.Graphic = _PLUGIN.guid .. data.MainMenuScreen.AnimatedBackground.Graphic
        data.MainMenuScreen.PlayGameButton.X = 452
        data.MainMenuScreen.PlayGameButton.Y = 575
    end
    return data
end)