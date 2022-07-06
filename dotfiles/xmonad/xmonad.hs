import Data.List (elemIndex)
import Data.Map as M
import Data.Maybe (fromJust, fromMaybe)
import XMonad
import XMonad.Hooks.DynamicLog (PP (ppCurrent, ppHidden, ppHiddenNoWindows, ppSep), wrap, xmobarColor)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doFullFloat, isDialog, isFullscreen)
import XMonad.Hooks.StatusBar (statusBarProp, withSB)
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.Simplest (Simplest (Simplest))
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Layout.SubLayouts (GroupMsg (MergeAll, UnMerge), onGroup, pullGroup, subLayout, subTabbed)
import XMonad.Layout.Tabbed
import XMonad.Layout.Tabbed (Shrinker (shrinkIt), addTabs, shrinkText)
import XMonad.Layout.ToggleLayouts (ToggleLayout (ToggleLayout), toggleLayouts)
import XMonad.Layout.WindowNavigation (windowNavigation)
import XMonad.StackSet as W
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce

main =
  xmonad . withSB mySB . ewmh . docks $
    def
      { terminal = "kitty",
        modMask = myModMask,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        manageHook = myManageHook,
        normalBorderColor = nord10,
        focusedBorderColor = nord8,
        borderWidth = 2,
        XMonad.workspaces = myWorkspaces
      }
      `additionalKeys` myKeys
      `additionalKeysP` myKeysP

mySB = statusBarProp "xmobar" (pure myPP)

myPP =
  def
    { ppCurrent = wrapWithColor nord6 . getIcon,
      ppHidden = wrapWithColor "#97a1b4" . getIcon,
      ppHiddenNoWindows = wrapWithColor nord3 . getIcon,
      ppSep = " | "
    }

wrapWithColor color text = "<fc=" ++ color ++ ">" ++ text ++ "</fc>"

myWorkspaces = ["dev", "www", "fs", "doc", "chat", "vbox"]

workspaceIcons = ["\xf121", "\xe007", "\xf07b", "\xf15b", "\xf086", "\xf108"]

workspaceIndex w = fromMaybe 0 $ elemIndex w myWorkspaces

getIcon :: String -> String
getIcon w =
  let icon = fromMaybe "" (M.lookup w (M.fromList (zip myWorkspaces workspaceIcons)))
      clickableIcon = "<action=`xdotool key super+" ++ show ((workspaceIndex w) + 1) ++ "`>" ++ icon ++ "</action>"
   in case w of
        "www" -> wrap " <fn=3>" "</fn> " clickableIcon
        _ -> wrap " <fn=2>" "</fn> " clickableIcon

myManageHook =
  composeAll
    [ (fmap not isDialog) --> doF W.swapDown,
      (className =? "Emacs") --> shiftFocus "dev",
      (className =? "kitty") --> shiftFocus "dev",
      (className =? "firefox") --> shiftFocus "www",
      (className =? "Pcmanfm") --> shiftFocus "fs",
      (className =? "lf") --> shiftFocus "fs",
      (className =? "Zathura") --> shiftFocus "doc",
      (className =? "Gimp") --> shiftFocus "doc",
      (className =? "Soffice") --> shiftFocus "doc",
      (className =? "TelegramDesktop") --> shiftFocus "chat",
      (className =? "VirtualBox Manager") --> shiftFocus "vbox"
    ]
  where
    shiftFocus ws = doShift ws <+> (doF $ greedyView ws)

myKeys =
  [ ((myModMask, xK_d), spawn "rofi -show run"),
    ((myModMask .|. shiftMask, xK_f), spawn "firefox"),
    ((myModMask, xK_q), kill),
    ((myModMask, xK_Return), spawn "kitty"),
    ((myModMask, xK_e), spawn "emacs"),
    ((myModMask, xK_p), spawn "kitty --class lf ~/.local/share/lf-ueberzug/lf-ueberzug ~"),
    ((myModMask .|. shiftMask, xK_p), spawn "pcmanfm"),
    ((myModMask, xK_b), sendMessage ToggleStruts),
    ((myModMask, xK_f), sendMessage ToggleLayout),
    ((myModMask .|. shiftMask, xK_l), spawn "betterlockscreen -l ~/.local/share/wallpaper.png -- --ring-color '#ECEFF4' --keyhl-color '#5e81ac' --insidewrong-color '#BF616A'"),
    ((myModMask .|. controlMask, xK_h), sendMessage $ pullGroup L),
    ((myModMask .|. controlMask, xK_l), sendMessage $ pullGroup R),
    ((myModMask .|. controlMask, xK_k), sendMessage $ pullGroup U),
    ((myModMask .|. controlMask, xK_j), sendMessage $ pullGroup D),
    ((myModMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll)),
    ((myModMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge)),
    ((myModMask .|. controlMask, xK_period), onGroup W.focusUp'),
    ((myModMask .|. controlMask, xK_comma), onGroup W.focusDown')
  ]

myKeysP =
  [ ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%"),
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%"),
    ("<XF86MonBrightnessUp>", spawn "light -A 10"),
    ("<XF86MonBrightnessDown>", spawn "light -U 10"),
    ("<Print>", spawn "~/.local/share/scripts/screenshot.sh")
  ]

myModMask = mod4Mask

myStartupHook = do
  spawnOnce "setxkbmap -layout 'us,ru' -option grp:alt_shift_toggle"
  spawnOnce "feh --bg-scale ~/.local/share/wallpaper.png"
  spawnOnce "yandex-disk start"
  spawnOnce "trayer --edge top --align right --height 30 --transparent true --alpha 0 --widthtype request --tint 0x3B4252"
  spawnOnce "xsetroot -cursor_name left_ptr"
  spawnOnce "betterlockscreen -u ~/.local/share/wallpaper.png"

myLayoutHook = windowNavigation $ avoidStruts (toggleLayouts myFull myTall)
  where
    myFull = renamed [Replace "Full"] $ smartBorders $ Full
    myTall = renamed [Replace "Tall"] $ addTabs shrinkText myTabTheme $ subLayout [] (Simplest) $ smartSpacing 5 $ smartBorders $ Tall 1 (3 / 100) (1 / 2)
    myTabTheme =
      def
        { activeBorderWidth = 0,
          inactiveBorderWidth = 0,
          activeColor = nord2,
          inactiveColor = nord1,
          activeTextColor = nord6,
          inactiveTextColor = nord4,
          fontName = "xft:Roboto-12:regular"
        }

-- Nord theme
-- Polar Night
nord0 = "#2E3440"

nord1 = "#3B4252"

nord2 = "#434C5E"

nord3 = "#4C566A"

-- Snow Storm
nord4 = "#D8DEE9"

nord5 = "#E5E9F0"

nord6 = "#ECEFF4"

-- Frost
nord7 = "#8FBCBB"

nord8 = "#88C0D0"

nord9 = "#81A1C1"

nord10 = "#5E81AC"

-- Aurora
nord11 = "#BF616A"

nord12 = "#D08770"

nord13 = "#EBCB8B"

nord14 = "#A3BE8C"

nord15 = "#B48EAD"
