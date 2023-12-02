local act = require('wezterm').action

return {
  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.EmitEvent 'show-title-bar',
    }
  }
}

