Config {

-- appearance
font = "xft:Roboto Mono:pixelsize=18:antialias=true"
, bgColor = "#202125"
, fgColor = "#d7d7d7"
, position = Top
, border = BottomB
, borderColor = "#444444"

-- layout
, sepChar = "%"   -- delineator between plugin names and straight text
, alignSep = "}{"  -- separator between left-right alignment
, template = "%StdinReader% }{ %cpu_process% %cpu_temp%  VOLUME:%volume%  BATTERY:%bat_status% %bat_percentage%  %kbd%  %date%"

-- general behavior
, lowerOnStart = False    -- send to bottom of window stack on start
, hideOnStart = False   -- start with window unmapped (hidden)
, allDesktops = True    -- show on all desktops
, overrideRedirect = True    -- set the Override Redirect flag (Xlib)
, pickBroadest = False   -- choose widest display (multi-monitor)
, persistent = True    -- enable/disable hiding (True = disabled)

-- plugins
, commands = [
        Run Date "%a %b %d %I:%M%P" "date" 10
        , Run Com "/home/andrew/bin/xmobar_status" ["print_bat_status"] "bat_status" 10
        , Run Com "/home/andrew/bin/xmobar_status" ["print_bat_percentage"] "bat_percentage" 10
        , Run Com "/home/andrew/bin/xmobar_status" ["print_cpu_process"] "cpu_process" 10
        , Run Com "/home/andrew/bin/xmobar_status" ["print_cpu_temp"] "cpu_temp" 10
        , Run Com "/home/andrew/bin/xmobar_status" ["print_volume"] "volume" 10
        , Run Kbd [("us", "US"), ("us(colemak)", "US"), ("ru", "RU"), ("ua", "UA")]
        , Run StdinReader
    ]
}
