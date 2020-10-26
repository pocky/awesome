local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local lain = require("lain")

local icons = require('theme.icons')
local screen_numbers = screen:count()

local tags = {
	{
		icon = icons.terminal,
		type = 'terminal',
		default_app = 'terminator',
		screen = 1
	},
	{
		icon = icons.development,
		type = 'development',
		default_app = 'phpstorm',
		screen = 1
	},
	{
		icon = icons.web_browser,
		type = 'chrome',
		default_app = 'brave',
		screen = 1
	},
	{
		icon = icons.file_manager,
		type = 'files',
		default_app = 'nemo',
		screen = 1
	},
	{
	   icon = icons.social,
	   type = 'social',
	   default_app = 'discord',
	   screen = screen_numbers
	},
	{
		icon = icons.mail,
		type = 'mail',
		default_app = 'Mailspring',
		screen = 1
	},
	{
		icon = icons.text_editor,
		type = 'code',
		default_app = 'code-oss',
		screen = 1
	},
	{
		icon = icons.multimedia,
		type = 'music',
		default_app = 'vlc',
		screen = 1
	},
	{
		icon = icons.games,
		type = 'game',
		default_app = 'supertuxkart',
		screen = 1
	},
	{
		icon = icons.graphics,
		type = 'art',
		default_app = 'gimp-2.10',
		screen = 1
	},
	{
		icon = icons.sandbox,
		type = 'virtualbox',
		default_app = 'virtualbox',
		screen = 1
	}
}


tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
		awful.layout.suit.spiral.dwindle,
		awful.layout.suit.tile,
		awful.layout.suit.max,
		lain.layout.termfair.center
    })
end)


screen.connect_signal("request::desktop_decoration", function(s)
	lain.layout.termfair.center.nmaster = 2
	lain.layout.termfair.center.ncol = 1

	layout = lain.layout.termfair.center

	if (s.index == 2) then
		layout = awful.layout.suit.tile;
	end

	if (screen_numbers == 1) then
		layout = awful.layout.suit.tile;
	end

	for i, tag in pairs(tags) do
		awful.tag.add(
			i,
			{
				icon = tag.icon,
				icon_only = true,
				layout = layout,
				gap_single_client = false,
				gap = beautiful.useless_gap,
				screen = s,
				default_app = tag.default_app,
				selected = i == 1
			}
		)
	end
end)

tag.connect_signal(
	'property::layout',
	function(t)
		local currentLayout = awful.tag.getproperty(t, 'layout')
		if (currentLayout == awful.layout.suit.max) then
			t.gap = 0
		else
			t.gap = beautiful.useless_gap
		end
	end
)