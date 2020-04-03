import XMonad
import XMonad.Actions.PhysicalScreens
import XMonad.Config.Kde
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Accordion
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import qualified Data.Map as M
import qualified XMonad.StackSet as W -- to shift and float windows
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops

import Graphics.X11.ExtraTypes.XF86

startupWorkspace = "4"

main = xmonad kdeConfig
    { modMask = mod4Mask -- use the Windows button as mod
    , startupHook = do
        ewmhDesktopsStartup
        windows $ W.greedyView startupWorkspace
        spawn "~/.xmonad/startup-hook"
    , manageHook = myManageHook <+> manageHook kdeConfig
    , handleEventHook = handleEventHook kdeConfig <+> ewmhDesktopsEventHook
    , layoutHook = (addTopBar (avoidStruts $ spacing spacingPx $ Tall 1 (3/100) (1/2)))
                   ||| (addTopBar (avoidStruts $ spacing spacingPx $ Accordion))
                   ||| (avoidStruts $ spacing spacingPx $ simpleTabbed)
                   ||| Full
    , logHook = ewmhDesktopsLogHook
    , keys = myKeys `mappend` (keys defaultConfig)
    , workspaces = myWorkspaces
    , XMonad.focusFollowsMouse = False
    , XMonad.clickJustFocuses = False
    , focusedBorderColor = active
    , normalBorderColor = base
    }
  where spacingPx = 5

base    = "#002b36"
yellow  = "#b58900"
red     = "#dc322f"
blue    = "#268bd2"
white   = "#ffffff"
grey    = "#bbbbbb"

myFont      = "xft:DejaVu Sans:size=12:antialias=true"

active = blue
topbar = 17
-- this is a "fake title" used as a highlight bar in lieu of full borders
-- (I find this a cleaner and less visually intrusive solution)
topBarTheme = def
    {
      fontName              = myFont
    , inactiveBorderColor   = base
    , inactiveColor         = base
    , inactiveTextColor     = grey
    , activeBorderColor     = active
    , activeColor           = active
    , activeTextColor       = white
    , urgentBorderColor     = red
    , urgentTextColor       = yellow
    , decoHeight            = topbar
    }

addTopBar =  noFrillsDeco shrinkText topBarTheme

myWorkspaces = ["con", "code", "tools", "www", "win1", "win2", "7", "music", "9", "10"]

myManageHook = composeAll . concat $
    [ [ className   =? c --> doFloat           | c <- myFloatsByClass]
    , [ title       =? t --> doFloat           | t <- myOtherFloatsByTitle]
    , [ className   =? c --> doF (W.shift "2") | c <- webApps]
    , [ className   =? c --> doF (W.shift "3") | c <- ircApps]
    , [ className   =? c --> doIgnore          | c <- ignoredOsWindows ]
    ]
  where myFloatsByClass      = ["MPlayer", "Gimp", "plasmashell", "ksmserver", "Firefox"]
        myOtherFloatsByTitle = ["alsamixer"]
        webApps       = ["Firefox-bin", "Opera"] -- open on desktop 2
        ircApps       = ["Ksirc"]                -- open on desktop 3
        ignoredOsWindows = ["plasmashell"]       -- No OS windows should get focus, like notifications. This also fixes the dropdown menus from the KDE panel.

myKeys = mconcat [myApplicationKeys, mySoundControlKeys, myScreenSwitchingKeys, myWorkspaceSwitchingKeys, myShutdownKeys, myScratchpadKeys]

myApplicationKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [
    ((modm, xK_p), spawn "rofi -show run")
  ]

mySoundControlKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [
    ((modm, xK_F8), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ((modm, xK_F9), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
  , ((modm .|. shiftMask, xK_F9), spawn "pactl set-sink-volume @DEFAULT_SINK@ -1%")
  , ((modm, xK_F10), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
  , ((modm .|. shiftMask, xK_F10), spawn "pactl set-sink-volume @DEFAULT_SINK@ +1%")
  ]

myScreenSwitchingKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [((modm .|. mask, key), f sc)
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, mask) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]
  ]

myWorkspaceSwitchingKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [
    ((modm, xK_0), windows $ W.greedyView "10")
  ]

myShutdownKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [
    ((modm .|. shiftMask, xK_q), spawn "qdbus org.kde.ksmserver /KSMServer logout -1 2 -1") -- Poweroff
  , ((modm .|. controlMask, xK_q), spawn "sleep 0.3 ; /usr/bin/qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock") -- Lock
  ]

myScratchpadKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
  [
    ((modm, xK_grave), namedScratchpadAction scratchpads "firefox")
  ]

-- Copied from https://notabug.org/Digit/tabularboonad/src/master/xmonad.hs
scratchpads =
  [
    NS "firefox" "firefox" (className =? "Firefox")
      (customFloating $ W.RationalRect (0/1) (0/1) (1/1) (1/2))
  ] where role = stringProperty "WM_WINDOW_ROLE"
