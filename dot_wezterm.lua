local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- OS detection
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_mac = wezterm.target_triple:find("darwin") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

-- Color scheme
config.color_scheme = "Catppuccin Mocha"

-- Font settings
config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "Cascadia Code",
    "Consolas",
    "Menlo",
    "DejaVu Sans Mono",
})
config.font_size = 12.0

-- Window appearance
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.95
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

-- Tab bar
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- Scrollback
config.scrollback_lines = 10000

-- Performance
config.front_end = "OpenGL"
config.webgpu_power_preference = "HighPerformance"

-- OS-specific configuration
if is_windows then
    config.wsl_domains = {
        {
            name = "WSL:Ubuntu",
            distribution = "Ubuntu",
            default_cwd = "~",
        },
    }
    config.default_domain = "WSL:Ubuntu"
    config.launch_menu = {
        { label = "WSL Ubuntu", domain = { DomainName = "WSL:Ubuntu" } },
        { label = "PowerShell", args = { "pwsh.exe" } },
        -- { label = "PowerShell (Windows)", args = { "powershell.exe" } },
    }
elseif is_mac then
    -- Make Alt key work as Alt instead of composing special characters
    config.send_composed_key_when_left_alt_is_pressed = false
    config.send_composed_key_when_right_alt_is_pressed = false
    config.launch_menu = {
        { label = "Zsh", args = { "/bin/zsh", "-l" } },
        { label = "Bash", args = { "/bin/bash", "-l" } },
    }
else
    -- Linux
    config.launch_menu = {
        { label = "Zsh", args = { "/bin/zsh", "-l" } },
        { label = "Bash", args = { "/bin/bash", "-l" } },
        { label = "Fish", args = { "/usr/bin/fish", "-l" } },
    }
end

-- Keep default key bindings
config.disable_default_key_bindings = false

config.keys = {
    -- Tab switching with Ctrl+number
    { key = "1", mods = "CTRL", action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "CTRL", action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "CTRL", action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "CTRL", action = wezterm.action.ActivateTab(3) },
    { key = "5", mods = "CTRL", action = wezterm.action.ActivateTab(4) },
    { key = "6", mods = "CTRL", action = wezterm.action.ActivateTab(5) },
    { key = "7", mods = "CTRL", action = wezterm.action.ActivateTab(6) },
    { key = "8", mods = "CTRL", action = wezterm.action.ActivateTab(7) },
    { key = "9", mods = "CTRL", action = wezterm.action.ActivateTab(-1) },

    -- Launch menu
    { key = "Space", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher },

    -- New tab / close tab
    { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },

    -- Also keep Ctrl+Shift+C/V as backup
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

    -- Split panes (Alt+Shift+Arrow)
    { key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action.SplitPane({ direction = "Left" }) },
    { key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action.SplitPane({ direction = "Right" }) },
    { key = "UpArrow", mods = "ALT|SHIFT", action = wezterm.action.SplitPane({ direction = "Up" }) },
    { key = "DownArrow", mods = "ALT|SHIFT", action = wezterm.action.SplitPane({ direction = "Down" }) },

    -- Navigate panes with Alt+Arrow
    { key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },

    -- Close pane (Alt+Shift+W)
    { key = "W", mods = "ALT|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

    -- Pass through common terminal shortcuts
    { key = "r", mods = "CTRL", action = wezterm.action.SendKey({ key = "r", mods = "CTRL" }) },
    { key = "d", mods = "CTRL", action = wezterm.action.SendKey({ key = "d", mods = "CTRL" }) },
    { key = "z", mods = "CTRL", action = wezterm.action.SendKey({ key = "z", mods = "CTRL" }) },
    { key = "l", mods = "CTRL", action = wezterm.action.SendKey({ key = "l", mods = "CTRL" }) },
    { key = "a", mods = "CTRL", action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }) },
    { key = "e", mods = "CTRL", action = wezterm.action.SendKey({ key = "e", mods = "CTRL" }) },
    { key = "w", mods = "CTRL", action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }) },
    { key = "u", mods = "CTRL", action = wezterm.action.SendKey({ key = "u", mods = "CTRL" }) },
    { key = "k", mods = "CTRL", action = wezterm.action.SendKey({ key = "k", mods = "CTRL" }) },
}

return config
