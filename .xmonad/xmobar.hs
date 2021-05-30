Config {

-- appearance
font = "xft:Roboto Mono:pixelsize=18:antialias=true"
--font = "xft:SF Mono:pixelsize=18:antialias=true"
, bgColor = "#202124"
--, bgColor = "#000000"
, fgColor = "#ffffff"
, position = Top
-- , alpha = 170
, border = NoBorder


-- layout
, sepChar = "%"   -- delineator between plugin names and straight text
, alignSep = "}{"  -- separator between left-right alignment
, template = "%UnsafeStdinReader% }{ %cpu_process% %cpu_temp%  Volume %volume%  %bat_status%  %kbd%  %date% "

-- general behavior
, lowerOnStart = True     -- send to bottom of window stack on start
, hideOnStart = False   -- start with window unmapped (hidden)
, allDesktops = True    -- show on all desktops
, overrideRedirect = True    -- set the Override Redirect flag (Xlib)
, pickBroadest = True   -- choose widest display (multi-monitor)
, persistent = True    -- enable/disable hiding (True = disabled)

-- plugins
, commands = [
        Run Date "%a %b %d %I:%M %p" "date" 10
        , Run Com "/home/andrii/bin/xmobar_status" ["print_bat_status"] "bat_status" 10
        , Run Com "/home/andrii/bin/xmobar_status" ["print_bat_percentage"] "bat_percentage" 10
        , Run Com "/home/andrii/bin/xmobar_status" ["print_cpu_process"] "cpu_process" 10
        , Run Com "/home/andrii/bin/xmobar_status" ["print_cpu_temp"] "cpu_temp" 10
        , Run Com "/home/andrii/bin/xmobar_status" ["print_volume"] "volume" 10
--        , Run Kbd [("us", "US"), ("us(colemak)", "US"), ("ru", "RU"), ("ua", "UA")]
        , Run Kbd [("us", "USS CALISTER OOUH"), ("us(colemak)", "US"), ("ru", "RU"), ("ua", "UA")]
        , Run UnsafeStdinReader
    ]
}
