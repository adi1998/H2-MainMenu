local screen_values = {
  "base",
  "ares",
  "prometheus",
  "skelly",
}

local screen_labels = {
  "Default",
  "Ares",
  "Prometheus",
  "Skelly",
}

local configDefault = {
  enabled = true;
  screen = "ares";
  random = true;
  random_allowed = {
    base = true,
    ares = true,
    prometheus = true,
    skelly = true,
  },
  sjson_selected_cache = "null"
}

local configDesc = {
  screen = {
    description = "Main menu screen shown if random screen is off. Restart game for the changes to take effect.",
    values = screen_values,
    labels = screen_labels,
    onChanged = function ()
      config.random = false
    end
  },
  random = {
    description = "Show a random main menu on each start",
  },
  random_allowed = {
    description = "Block any screen from random selection by setting it to false";
    base = {
      displayName = "Default",
      description = "The default main menu screen",
    },
    skelly = {
      displayName = "Skelly",
      description = "The Unseen Update main menu screen",
    },
    prometheus = {
      displayName = "Prometheus",
      description = "The Olympus Update main menu screen",
    },
    ares = {
      displayName = "Ares",
      description = "The Warsong Update main menu screen",
    }
  },
  sjson_selected_cache = {
    description = "Do not touch",
    hidden = true,
  }
}

return configDefault, configDesc