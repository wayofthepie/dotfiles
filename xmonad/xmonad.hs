import XMonad
import XMonad.Config.Gnome (gnomeConfig,gnomeRun)
import XMonad.Hooks.DynamicLog
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace (onWorkspace) 
import XMonad.Layout.SimpleFloat
import XMonad.Hooks.EwmhDesktops
import qualified Data.Map as M

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey (ewmh myConfig)

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

tall = ResizableTall 1 (3/100) (1/2) []

myKeys x = M.fromList (newKeys x) `M.union` keys def x
newKeys conf@(XConfig {XMonad.modMask = modm}) =
  [ ((modm, xK_Left),  sendMessage MirrorExpand)
  , ((modm, xK_Up),    sendMessage MirrorExpand)
  , ((modm, xK_Right), sendMessage MirrorShrink)
  , ((modm, xK_Down),  sendMessage MirrorShrink)
  ]

-- Main configuration, override the defaults to your liking.
myConfig = def 
  { layoutHook = myLayouts
  , modMask = mod4Mask 
  , terminal    = "gnome-terminal" -- for Mod + Shift + Enter
  , keys = myKeys
  , handleEventHook = fullscreenEventHook
  }

defaultLayouts = smartBorders $ Full ||| tall
myLayouts = defaultLayouts -- onWorkspace "3" simpleFloat $ defaultLayouts

