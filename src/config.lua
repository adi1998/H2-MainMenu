local config = {
  enabled = true;
  screen = "ares";
  random = true;
  random_allowed = {
    base = true,
    ares = true,
    prometheus = true,
    skelly = true,
  }
}

local configDesc = {
  screen = "Main menu screen to show if random screen is off. Valid values: base, ares, prometheus, skelly",
  random = "Show a random main menu on each start",
  random_allowed = "Block any screen from random selection by setting it to false"
}

return config, configDesc