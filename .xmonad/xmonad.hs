import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Monoid
import Data.List
import System.Exit
import Graphics.X11.ExtraTypes.XF86

import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.RefocusLast
import XMonad.Hooks.DynamicBars
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition

import XMonad.Layout.NoBorders
import XMonad.Layout.Named

import XMonad.Util.Run
import XMonad.Util.SpawnOnce

main = do
    xmonad $ withUrgencyHookC NoUrgencyHook urgentConfig
        $ ewmh
        $ docks def
        { terminal           = "st -e tmux"
        , focusFollowsMouse  = True
        , borderWidth        = 1
        , modMask            = mod1Mask
        , normalBorderColor  = "#444444"
        , focusedBorderColor = "#ff0000"
        , workspaces         = myWorkspaces
        , keys               = myKeys
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , logHook            = myLogHook
        , handleEventHook    = myEventHook
        , startupHook        = myStartupHook
        }

myWorkspaces :: [String]
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myLayout =  named "-" ( lessBorders Screen $ refocusLastLayoutHook $ avoidStruts $ tiled ) |||
    named "+" ( noBorders $ refocusLastLayoutHook $ avoidStruts Full )
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook :: ManageHook
myManageHook = composeOne
    [ title     =? "Open File"                 -?> doCenterFloat
    , title     =? "Open Files"                -?> doCenterFloat
    , className =? "mpv"                       -?> doCenterFloat
    , title =? "teams.miscrosoft.com is sharing your screen."                       -?> doCenterFloat
    , isDialog                                 -?> doFloat
    , title     =? "Volume Control"            -?> doShift (myWorkspaces !! 8)
    , title     =? "Telegram"                  -?> doShift (myWorkspaces !! 6)
    , title     =? "Discord"                   -?> doShift (myWorkspaces !! 5)
    , title     =? "Friends List"              -?> doShift (myWorkspaces !! 4)
    , className =? "Thunderbird"               -?> doShift (myWorkspaces !! 7)
    , className =? "Steam"                     -?> doShift (myWorkspaces !! 4)
    , className =? "Microsoft Teams - Preview" -?> doSideFloat SE
    , isFullscreen                             -?> doFullFloat
    , return True                              -?> insertPosition Below Newer
    ]

myEventHook = handleEventHook def
          <+> fullscreenEventHook
          <+> docksEventHook
          <+> dynStatusBarEventHook barCreate barDestroy

myStartupHook = dynStatusBarStartup barCreate barDestroy

barCreate (S sid) = spawnPipe $ "xmobar -x " ++ show sid ++ " /home/andrew/.xmonad/xmobar.hs"

barDestroy = return ()

myLogHook = multiPP myPP myPP

urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont }

myPP = xmobarPP {
        ppCurrent = xmobarColor "#d7d7d7" "" . clickWorkspace "[" "]"
        , ppVisible = xmobarColor "#d7d7d7" "" . clickWorkspace "˜" " "
        -- alternative symbols: ˜ ¯ ` ' ‘
        , ppHidden = xmobarColor "#d7d7d7" "" . clickWorkspace " " " "
        -- , ppHiddenNoWindows = xmobarColor "#d7d7d7" "" . clickWorkspace " " " "
        , ppUrgent = xmobarColor "#202125" "#d7d7d7" . clickWorkspace "˜" "!"
        , ppSep = ""
        , ppWsSep = ""
        , ppTitle = xmobarColor "#d7d7d7" "" . wrap " " "" . shorten 77
    }
    where
        clickWorkspace a b ws = "<action=xdotool key alt+" ++ show(index) ++ ">" ++ a ++ ws ++ b ++ "</action>" where
            wsIdxToString Nothing = "1"
            wsIdxToString (Just n) = show $ mod (n+1) $ (length myWorkspaces) + 1 -- if you use 10 ws and 10 is bind to 0 remove the +1
            index = wsIdxToString (elemIndex ws myWorkspaces)

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launching and killing
    [ ((modm .|. shiftMask, xK_Return),                spawn $ XMonad.terminal conf)
    , ((modm,               xK_p),                     spawn "dmenu_run -fn 'Roboto Mono:style=Regular:pixelsize=18:antialias=true:autohint=true' -nb '#202124' -nf '#d7d7d7' -sb '#005577' -sf '#d7d7d7'")
    , ((modm .|. shiftMask, xK_b),                     spawn "google-chrome-stable --enable-features=WebUIDarkMode --force-dark-mode")
    , ((modm,               xK_w),                     kill)

    -- show notification with network info
    , ((modm.|. shiftMask,  xK_n),                     spawn "notify-send \"Network\" \"`iwconfig wlp61s0 | head -6 && echo && ifconfig wlp61s0 | head -2 && echo && ifconfig enp0s31f6 | head -3 && echo && ifconfig mullvad-nl1 | head -2`\"")

    -- send notification with clipboard
    , ((modm.|. shiftMask,  xK_c),                     spawn "primary=$(xclip -o); clipboard=$(xclip -sel clip -o); notify-send \"Clipboards\" \"`echo PRIMARY: $primary && echo CLIPBOARD: $clipboard`\"")

    -- clipmenu
    , ((modm,               xK_c),                     spawn "clipmenu -fn 'Roboto Mono:style=Regular:pixelsize=18:antialias=true:autohint=true' -nb '#202124' -nf '#d7d7d7' -sb '#005577' -sf '#d7d7d7'")

    -- screen locker
    , ((0,                  xK_F12),                   spawn "slock")

    -- screenshot to clipboard
    , ((0,                  xK_Print),                 spawn "maim -s | xclip -sel clip -t image/png")

    -- upload screenshot
    , ((modm,               xK_Print),                 spawn "screenshot")

    -- cycle layouts
    , ((modm,               xK_space),                 sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space),                 setLayout $ XMonad.layoutHook conf)

    -- refresh
    , ((modm,               xK_n),                     refresh)

    -- place float in tile
    , ((modm,               xK_t),                     withFocused $ windows . W.sink)

    -- focusing windows
    , ((modm,               xK_j),                     windows W.focusDown)
    , ((modm,               xK_k),                     windows W.focusUp)
    , ((modm,               xK_m),                     windows W.focusMaster)

    -- swap windows
    , ((modm .|. shiftMask, xK_j),                     windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k),                     windows W.swapUp    )
    , ((modm,               xK_Return),                dwmpromote)

    -- keyboard remapping
    , ((mod4Mask,           xK_k),                     spawn "xdotool keyup k key --clearmodifiers Up")
    , ((mod4Mask,           xK_j),                     spawn "xdotool keyup j key --clearmodifiers Down")
    , ((mod4Mask,           xK_h),                     spawn "xdotool keyup h key --clearmodifiers Left")
    , ((mod4Mask,           xK_l),                     spawn "xdotool keyup l key --clearmodifiers Right")
    , ((mod4Mask,           xK_n),                     spawn "xdotool keyup n key --clearmodifiers Home")
    , ((mod4Mask,           xK_e),                     spawn "xdotool keyup e key --clearmodifiers End")
    , ((mod4Mask,           xK_i),                     spawn "xdotool keyup i key --clearmodifiers Insert")

    -- increase or decrease number of windows in the master area
    , ((modm,               xK_i),                     sendMessage (IncMasterN 1))
    , ((modm,               xK_d),                     sendMessage (IncMasterN (-1)))

    -- resizing windows
    , ((modm,               xK_h),                     sendMessage Shrink)
    , ((modm,               xK_l),                     sendMessage Expand)

    -- move to next empty workspace
    , ((modm,               xK_f),                     moveTo Next EmptyWS)

    -- focus next screen
    , ((modm,               xK_period),                nextScreen)
    , ((modm,               xK_comma),                 prevScreen)

    -- swap window to next screen
    , ((modm .|. shiftMask, xK_period),                shiftNextScreen >> nextScreen)
    , ((modm .|. shiftMask, xK_comma),                 shiftPrevScreen >> prevScreen)

    -- focus previous workspace
    , ((modm,               xK_Tab),                   toggleWS)

    -- audio controls
    , ((0,                  xF86XK_AudioMute),         spawn "amixer -q sset Master toggle")
    , ((0,                  xF86XK_AudioRaiseVolume),  spawn "amixer -M set Master 5%+")
    , ((0,                  xF86XK_AudioLowerVolume),  spawn "amixer -M set Master 5%-")
    , ((0,                  xF86XK_AudioMicMute),      spawn "amixer set Capture toggle")

    -- display brightness controls
    , ((0,                  xF86XK_MonBrightnessUp),   spawn "xbacklight -inc 4")
    , ((0,                  xF86XK_MonBrightnessDown), spawn "xbacklight -dec 4")

    -- toggle the status bar gap
    , ((modm,               xK_b),                     sendMessage ToggleStruts)

    -- quit, or restart xmonad
    , ((modm .|. shiftMask, xK_q),                     io (exitWith ExitSuccess))
    , ((modm,               xK_q),                     spawn "xmonad --recompile; xmonad --restart")
    ] ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
