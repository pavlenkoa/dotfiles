import XMonad
import Data.Monoid
import System.Exit
import System.IO
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isDialog, isFullscreen, doFullFloat)
import XMonad.Hooks.DynamicBars
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition
import XMonad.Layout.NoBorders
import XMonad.Layout.Named
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
-- import XMonad.Layout.IndependentScreens
-- import XMonad.Layout.Spacing

xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ ["1","2","3","4","5","6","7","8","9"]
    where
        clickable l = [ "<action=xdotool key alt+" ++ show (n) ++ ">" ++ ws ++ "</action>" | (i,ws) <- zip [1..9] l, let n = i ]

--  myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- Launch
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "dmenu_run -fn 'Roboto Mono:style=Regular:pixelsize=18:antialias=true:autohint=true' -nb '#202125' -nf '#d7d7d7' -sb '#005577' -sf '#d7d7d7'")
    , ((modm .|. shiftMask, xK_b     ), spawn "google-chrome-stable --enable-features=WebUIDarkMode --force-dark-mode")
    -- Layout & windows & workspaces
    , ((modm,               xK_w),      kill)
    , ((modm,               xK_space),  sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space),  setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n),      refresh)
    , ((modm,               xK_j),      windows W.focusDown)
    , ((modm,               xK_k),      windows W.focusUp)
    , ((modm,               xK_m),      windows W.focusMaster)
    , ((modm,               xK_Return), dwmpromote)
    , ((modm .|. shiftMask, xK_j),      windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k),      windows W.swapUp    )
    , ((modm,               xK_h),      sendMessage Shrink)
    , ((modm,               xK_l),      sendMessage Expand)
    , ((modm,               xK_t),      withFocused $ windows . W.sink)
    , ((modm,               xK_i),      sendMessage (IncMasterN 1))
    , ((modm,               xK_d),      sendMessage (IncMasterN (-1)))
    , ((modm,               xK_f),      moveTo Next EmptyWS)
    , ((modm,               xK_period), nextScreen)
    , ((modm,               xK_comma),  prevScreen)
    , ((modm .|. shiftMask, xK_period), shiftNextScreen >> nextScreen)
    , ((modm .|. shiftMask, xK_comma),  shiftPrevScreen >> prevScreen)
    , ((modm,               xK_Tab),    toggleWS)
    -- Audio controls
    , ((0,               xF86XK_AudioMute),         spawn "amixer -q sset Master toggle")
    , ((0,               xF86XK_AudioRaiseVolume),  spawn "amixer -M set Master 5%+")
    , ((0,               xF86XK_AudioLowerVolume),  spawn "amixer -M set Master 5%-")
    , ((0,               xF86XK_AudioMicMute),      spawn "amixer set Capture toggle")
    -- Display brightness controls
    , ((0,               xF86XK_MonBrightnessUp),   spawn "xbacklight -inc 4")
    , ((0,               xF86XK_MonBrightnessDown), spawn "xbacklight -dec 4")
    -- Printscreen
    , ((0,               xK_Print),                 spawn "maim -s | xclip -sel clip -t image/png")
    -- Toggle the status bar gap
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "killall xmobar; xmonad --recompile; xmonad --restart")
    ] ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    {- lots of other keybindings -}
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]
    -- [((m .|. modm, k), windows $ onCurrentScreen f i)
    --     | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
    --     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    -- ] ++
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_period, xK_comma, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    -- ]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]

myLayout =  named "-" (avoidStruts $ smartBorders $ tiled) |||
    named "~" (avoidStruts $ noBorders Full)
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook :: ManageHook
myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "Volume Control" --> doShift (myWorkspaces !! 8)
    , className =? "Thunderbird" --> doShift (myWorkspaces !! 7)
    , className =? "Telegram" --> doShift (myWorkspaces !! 6)
    , className =? "Discord" --> doShift (myWorkspaces !! 5)
    , className =? "Steam" --> doShift (myWorkspaces !! 4)
    , className =? "Friends List" --> doShift (myWorkspaces !! 4)
    , className =? "Microsoft Teams - Preview" --> doFloat
    , className =? "microsoft teams - preview" --> doFloat
    , className =? "mpv" --> doFloat
    , isDialog --> doFloat
    , insertPosition Below Newer
    ]

-- myEventHook = mempty

wsPP h = xmobarPP {
    ppCurrent = xmobarColor "#d7d7d7" "" . wrap "[" "]"
    , ppHidden = xmobarColor "#d7d7d7" "" . wrap " " " "
    , ppUrgent = xmobarColor "#d7d7d7" "#35363a" . wrap " " "!"
    , ppVisible = xmobarColor "#d7d7d7" "" . wrap "(" ")"
    -- ppCurrent = xmobarColor "#d7d7d7" "#005577" . wrap " " " "
    -- , ppHidden = xmobarColor "#d7d7d7" "#35363a" . wrap " " " "
    -- , ppHiddenNoWindows = xmobarColor "#d7d7d7" "" . wrap " " " "
    , ppSep = " "
    , ppWsSep = ""
    , ppTitle = xmobarColor "#d7d7d7" "" . shorten 60
    -- , ppLayout = (\str -> "")
    , ppOutput = hPutStrLn h}
    -- , ppOrder  = \(w:t:_:s) -> w:s}

-- Main.
main = do
--    nScreens <- countScreens
    xmproc <- spawnPipe "xmobar /home/andrew/.xmonad/xmobar.hs"
    xmonad $ ewmh $ docks def
        { terminal           = "st -e tmux"
        , focusFollowsMouse  = True
        , borderWidth        = 1
        , modMask            = mod1Mask
        , normalBorderColor  = "#444444"
        , focusedBorderColor = "#ff0000"
        , workspaces         = myWorkspaces
        -- , workspaces         = withScreens nScreens (workspaces def)
        , keys               = myKeys
        , mouseBindings      = myMouseBindings
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , logHook            = dynamicLogWithPP $ wsPP xmproc
        , handleEventHook    = fullscreenEventHook
        }
