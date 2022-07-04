import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers (isDialog)

main = xmonad $ def {
  terminal = "kitty"
  , modMask = myModMask
  , startupHook = myStartupHook
  , layoutHook = myLayoutHook
  , manageHook = myManageHook
  , normalBorderColor = nord10
  , focusedBorderColor = nord8
  , borderWidth = 2
} `additionalKeys` myKeys

myManageHook = composeAll
  [
    (fmap not isDialog) --> doF W.swapDown
  ]

myKeys = [
  ((myModMask, xK_d), spawn "dmenu_run")
  ,((myModMask .|. shiftMask, xK_f), spawn "firefox")
  ,((myModMask, xK_q), kill)
  ,((myModMask, xK_Return), spawn "kitty")
  ,((myModMask, xK_e), spawn "emacs")
  ]

myModMask = mod4Mask

myStartupHook = do
  spawnOnce "feh --bg-scale ~/.local/share/wallpaper.png"
  spawnOnce "yandex-disk start"

myLayoutHook = smartSpacing 5 $ Tall 1 (3/100) (1/2) ||| Full

-- Nord theme
-- Polar Night
nord0 = "#2e3440"
nord1 = "#3b4252"
nord2 = "#434c5e"
nord3 = "#4c566a"
-- Snow Storm
nord4 = "#d8dee9"
nord5 = "#e5e9f0"
nord6 = "#e5e9f0"
-- Frost
nord7 = "#8fbcbb"
nord8 = "#88c0d0"
nord9 = "#81a1c1"
nord10 = "#5e81ac"
-- Aurora
nord11 = "#bf616a"
nord12 = "#d08770"
nord13 = "#ebcb8b"
nord14 = "#a3be8c"
nord15 = "#b48ead"
