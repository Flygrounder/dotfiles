import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isDialog)
import XMonad.Hooks.StatusBar (statusBarProp, withSB)
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.StackSet as W
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import Data.Map as M
import Data.List (elemIndex)
import Data.Maybe (fromJust, fromMaybe)
import XMonad.Hooks.DynamicLog (PP(ppSep, ppCurrent, ppHidden, ppHiddenNoWindows), xmobarColor, wrap)
import XMonad.Layout.ToggleLayouts (toggleLayouts, ToggleLayout (ToggleLayout))
import XMonad.Layout.Renamed (Rename(Replace), renamed)

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
myPP = def {
  ppCurrent = wrapWithColor nord6 . getIcon
  ,ppHidden = wrapWithColor "#97a1b4" . getIcon
  ,ppHiddenNoWindows = wrapWithColor nord3 . getIcon
  ,ppSep = " | "
}

wrapWithColor color text = "<fc=" ++ color ++ ">" ++ text ++ "</fc>"

myWorkspaces = [ "dev", "www", "fs", "doc", "chat", "vbox" ]
workspaceIcons = [ "\xf121", "\xe007", "\xf07b", "\xf15b", "\xf086", "\xf108" ]
workspaceIndex w = fromMaybe 0 $ elemIndex w myWorkspaces

getIcon :: String -> String
getIcon w = let
  icon = fromMaybe "" (M.lookup w (M.fromList (zip myWorkspaces workspaceIcons)))
  clickableIcon = "<action=`xdotool key super+" ++ show ((workspaceIndex w) + 1) ++ "`>" ++ icon ++ "</action>"
  in
  case w of
    "www" -> wrap " <fn=3>" "</fn> " clickableIcon
    _ -> wrap " <fn=2>" "</fn> " clickableIcon

myManageHook =
  composeAll
    [ (fmap not isDialog) --> doF W.swapDown
    ]

myKeys =
  [ ((myModMask, xK_d), spawn "rofi -show run"),
    ((myModMask .|. shiftMask, xK_f), spawn "firefox"),
    ((myModMask, xK_q), kill),
    ((myModMask, xK_Return), spawn "kitty"),
    ((myModMask, xK_e), spawn "emacs"),
    ((myModMask, xK_b), sendMessage ToggleStruts),
    ((myModMask, xK_f), sendMessage ToggleLayout),
    ((myModMask .|. shiftMask, xK_l), spawn "betterlockscreen -l ~/.local/share/wallpaper.png -- --ring-color '#ECEFF4' --keyhl-color '#5e81ac' --insidewrong-color '#BF616A'")
  ]

myKeysP = [
  ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  ,("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
  ,("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
          ]

myModMask = mod4Mask

myStartupHook = do
  spawnOnce "setxkbmap -layout 'us,ru' -option grp:alt_shift_toggle"
  spawnOnce "feh --bg-scale ~/.local/share/wallpaper.png"
  spawnOnce "yandex-disk start"
  spawnOnce "trayer --edge top --align right --height 30 --transparent true --alpha 0 --widthtype request --tint 0x3B4252"

myLayoutHook = avoidStruts (toggleLayouts myFull myTall)
  where myFull = renamed [Replace "Full"] Full
        myTall = renamed [Replace "Tall"] $ smartSpacing 5 $ Tall 1 (3 / 100) (1 / 2)

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
