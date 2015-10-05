-- 
-- Required:  
--   * Screen Lock: i3lock scrot imagemagick xautolock
--

import qualified Data.Map as M
import System.IO

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.CustomKeys
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops -- fullScreenEventHook
import XMonad.Layout.NoBorders

-- For matlab
import XMonad.Hooks.SetWMName

import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CopyWindow(copy)
import XMonad.Prompt
import qualified XMonad.StackSet as W
import qualified Data.Map        as M


main = do
  xmproc <- spawnPipe myStatusBar -- Status bar
  xmonad $ defaultConfig
   { 
     handleEventHook    = fullscreenEventHook, -- Fix fullscreen behavior
     startupHook = myStartupHook,
     manageHook = manageDocks <+> manageHook defaultConfig,
     layoutHook = lessBorders OnlyFloat $ avoidStruts  $  layoutHook defaultConfig,
     logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        },
     keys = customKeys delKeys insKeys, 
     modMask            = cModMask,  -- Rebind Mod 
     terminal           = "urxvt",
     borderWidth        = 2,
     normalBorderColor  = "#cccccc",
     focusedBorderColor = "#cd8b00"
   }
   where
     cModMask = mod4Mask -- Rebind MOD to the Windows key
     myStatusBar = "~/.cabal/bin/xmobar"
     -- For Matlab
     myStartupHook = do
      spawn "herp" 
      spawn "derp"
      setWMName "LG3D"

     -- Keys to unmap
     delKeys :: XConfig l -> [(KeyMask, KeySym)]
     delKeys XConfig {modMask = modm} =
         [ 
           (modm .|. shiftMask, xK_q) -- Unmap kill X session
         ] 

     -- New keys to map
     insKeys :: XConfig l -> [((KeyMask, KeySym), X ())]
     insKeys conf@(XConfig {modMask = modm}) =
         [ ((mod1Mask,                   xK_F2  ), spawn $ terminal conf)
         , ((cModMask .|. controlMask,   xK_l), spawn myLock)
         -- Screenshot
         , ((0,                          xK_Print), spawn "scrot")
         , ((cModMask,                   xK_Print), spawn "sleep 0.2; scrot -s")
         -- Volume control
         , ((cModMask,                   xK_Down), spawn "amixer set Master 1-")
         , ((cModMask,                   xK_Up  ), spawn "amixer set Master 1+")

         -- Dynamic workspace
         -- Delete Workspace
         , ((modm .|. shiftMask, xK_BackSpace), removeWorkspace)
         , ((modm .|. shiftMask, xK_v      ), selectWorkspace defaultXPConfig)
         -- Move window to named worskpace        
         , ((modm, xK_m                    ), withWorkspace defaultXPConfig (windows . W.shift))
         -- Copy window to named workspace (window will be in both workspaces)
         , ((modm .|. shiftMask, xK_m      ), withWorkspace defaultXPConfig (windows . copy))
         -- Rename a workspace
         , ((modm .|. shiftMask, xK_r      ), renameWorkspace defaultXPConfig)
         ]
         -- mod-[1..9]       %! Switch to workspace N
         -- mod-shift-[1..9] %! Move client to workspace N
         ++ zip (zip (repeat (modm)) [xK_1..xK_9]) (map (withNthWorkspace W.greedyView) [0..])
         ++ zip (zip (repeat (modm .|. shiftMask)) [xK_1..xK_9]) (map (withNthWorkspace W.shift) [0..])
         where myLock = "~/.xmonad/lock"

