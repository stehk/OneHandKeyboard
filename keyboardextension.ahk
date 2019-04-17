;;;;;Thanks to gwarble for notify, Mr. A.N.Other for groupbox and Megan Strickland for the Hand design of the icon, 

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.


SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode 2
Process, Priority, , High


#Include notify.ahk
#include groupbox.ahk 


SysGet, Mon2, MonitorWorkArea, 1   ;determines size of monitorworkarea for picture placement
OnMessage(0x0020, "WM_SETCURSOR") 			;when mouse hovers over cheat sheet


SetTitleMatchMode RegEx

SetCapsLockState, alwaysoff

sendmode event        ;Important for internal sticky shift, which uses input command


;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  gui ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;---------------------------------------------------------------------------------


Loop 12					;;This one reads all the information from the ini
	{
IniRead, Check%A_Index%, settings.ini, SavedState, Check%A_Index% , 0 ;Default 0
	 If (Check%A_Index% = 1)
	 	Check%A_Index% = Checked
	 Else
	 	Check%A_Index% =	
	}
	



;---- Alter the tray icon menu:
;Menu Tray, Add, %k_MenuItemHide%, k_ShowHide
Menu Tray, icon, icon.ico
Menu Tray, Add, Einstellungen, Showgui 
Menu Tray, Add, &Exit Application , k_MenuExit
Menu Tray, Default, Einstellungen						;doubleclick opens preferences
Menu Tray, NoStandard


	GBTHeight:=10
	Gui, Add, text,w220 y20 vk_Suspendtext, Beim betätigen dieser Taste wird die neue Tastaturbelegung aufgehoben (etwa um Strg 2 wie gewohnt zu verwenden) ;	When you press this key the whole Keyboard modification is suspended (e.g. if you want to use Ctrl + 2, like you used to)
	Gui, Add, Checkbox, gsubmit x40 y70 vCheck1 %Check1%, Strg ;Ctrl
	Gui, Add, Checkbox, gsubmit x140 y70 vCheck2 %Check2%, Alt
	GroupBox("suspend", "Tastaturbelegung aufheben:", GBTHeight, 10, "k_suspendtext|Check1|Check2") ;Suspend Keyboard Layout

	Gui, Add, text, x260 y20 w200 vStickyshifttext, Programminternes Sticksshift aktivieren (leider funktionieren die Windows Sticky Tasten mit dem Programm nicht) ;Use internal Stickyshift (Windows OS sticky shift don't yet works for poliunmk - keys)
	Gui, Add, Checkbox, x270 y70 vCheck3 %Check3%, Stickyshift aktivieren
	GroupBox("sticky", "Stickyshift:", GBTHeight, 10, "stickyshifttext|Check3")


	Gui, Add, Checkbox, gsubmitimage x0 y120 h32 vCheck4 %Check4%, Aktiviere die OnScreen Tastatur ;Activate OnScreen keyboard
	Gui, Add, Text,
	Gui, Add, Radio, gsubmitimage w150 h32 vCheck5 %Check5%, Immer ;Always
	Gui, Add, Radio, gsubmitimage w150 h32 vCheck6 %Check6%, Nur wenn Modifikatortasten gedrückt werden ; Only when modifier keys are pressed
	Gui, Add, Radio, gsubmitimage w150 h32 vCheck7 %Check7%, Nur Ebene 2 (Caps) zeigen ;Only show layer 2 (Caps)
	Gui, Add, Radio, gsubmitimage w150 h32 vCheck8 %Check8%, Nur den Nummer Modifikator zeigen ;Only show number modifier
	GroupBox("GB1", "OnScreen Tastatur zeigen:", GBTHeight, 10, "Check5|Check6|Check7|Check8")
	Gui, Add, Radio, gsubmitimage x190 y177 w150 h32 vCheck9 %Check9%, Klein ;Small
	Gui, Add, Radio, gsubmitimage h32 vCheck10 %Check10%, Mittel ;Medium
	Gui, Add, Radio, gsubmitimage h32 vCheck11 %Check11%, Groß ;Large
	GroupBox("GB2", "Größe der OnScreen Tastatur", GBTHeight, 10, "Check9|Check10|Check11")
	/*
	Gui, Add, Radio, gsubmitimage x250 y178 w150 h32 vCheck12 %Check12%, Left
	Gui, Add, Radio, gsubmitimage h32 vCheck13 %Check13%, Middle
	Gui, Add, Radio, gsubmitimage h32 vCheck14 %Check14%, Right
	GroupBox("Pos", "Position of OnScreen Keyboard", GBTHeight, 10, "Check9|Check10|Check11")
	*/
	GroupBox("GB3", "OnScreen Tastatur", GBTHeight, 10, "Check4|Check5|Check6|Check7|Check8|GB1|Check9|Check10|Check11|GB2")
;	Gui, Add, Control, gsavesettings, Click here to save Settingsg
;	Gui, Add, Checkbox, gsubmit vCheck12 %Check12%, Use shift & Space for Backspace
	Gui, Add, Button, gsavesettings, Einstellungen speichern ;Click here to save settings permanently

goto submitimage
return

;----------------------------------------------------------------------------
;---------------------------------end of autoexec Section
;-----------------------------------------------------------------------------



showgui:
	guistat=1						;This deactivates the WMsetcursor to not interfere with the onscreen keyboard (dirty solution - better to work with gui id or something
	Gui, Show, ; , GroupBox Test
Return

GuiClose:
guistat=
Gui, Hide
Return	


submit:
Gui, Submit, NoHide ;this command submits the guis' datas' state
return

savesettings:		;to ini file
Gui, Submit, NoHide ;this command submits the guis' datas' state
loop 12
{
 If (Check%A_Index% = 1)
	 	IniWrite, 1, settings.ini, SavedState, Check%A_Index%
	Else
	IniWrite, %empty%, settings.ini, SavedState, Check%A_Index%
}	
return

/*		maybe to use another sendmode in the future
changesendmode:
Gui, Submit, NoHide ;this command submits the guis' datas' state
if Check3=1
sendmode event
Else
sendmode Input
return
*/

submitimage:
Gui, Submit, NoHide ;this command submits the guis' datas' state
gui +disabled			;disables gui until submitimage is executed
if check9=1 
{
height :=110
basesize := "base110.jpg"
capssize := "caps110.jpg"
numberssize := "numbers110.jpg"
}
if check10=1 
{
basesize := "base150.jpg"
capssize := "caps150.jpg"
numberssize := "numbers150.jpg"
height :=150
}
if check11=1 
{
height :=200 
basesize := "base200.jpg"
capssize := "caps200.jpg"
numberssize := "numbers200.jpg"
}
a := Mon2Bottom - Height
sleep 100
if check4=1
{
	if check5=1			;only show modifier
	{
	base := basesize
	numbers:= numberssize
	capsimage := capssize
	}
	if check6=1			;only show modifier
	{
	base := 
	numbers:= numberssize
	capsimage := capssize
	}
	if check7 = 1		;only show caps
	{
	numbers :=
	base := 
	capsimage := capssize
	}
	if check8 = 1			;only show numbers
	{
	capsimage :=
	base:=
	numbers:= numberssize
	}

}
Else
{
capsimage :=
base:=
numbers :=
}
gui -disabled			
goto activatecheat
return


activatecheat:
picture = %base%
makestat()
	Loop
	{
	Sleep 30
		Getkeystate, caps, CapsLock, P
		Getkeystate, modi, <, P
		if caps <> %modi%				;;;if the caps and the num modifier are not equal
			{
			if modvar=
				{
				if caps=D
					{
					picture = %capsimage%
					makestat()
					modvar=1
					}
				Else
					{
					picture = %numbers%
					makestat()
					modvar=1
					}
				}
			}
		Else if modvar=1
			{
			picture = %base%
			makestat()
			modvar=
			}
	}
	
return
	


;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Onscreenkeyboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;---------------------------------------------------------------------------------

SplashImage, show


make()			;is called by wmsetcursor, let's picture jump when mouse hovers over it
{
global
If tog =
{
SplashImage,  %picture%, b Y%a% ;H%Height%
	tog = 1
}
Else
{
SplashImage,  %picture%, b Y0 ;H%Height%
tog = 
}
}


makestat()                 ;This function changes the picture without changing the placement
{
global
If tog = 1
{
SplashImage,  %picture%, b Y%a% 
}
Else
{
SplashImage,  %picture%, b Y0 ;H%Height%
}
return
}



WM_SETCURSOR(wParam, lParam)
{
global
if guistat =
{
  ;  X := lParam & 0xFFFF
   ; Y := lParam >> 16
    if A_GuiControl
        Control := "`n(in control " . A_GuiControl . ")"			;notify("now")
	 make()	  %Control%
  ;  ToolTip You left-clicked in Gui window #%A_Gui% at client coordinates %X%x%Y%.%Control%
}
}



;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    Capslock - modfication (suspend keyboard)  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;---------------------------------------------------------------------------------

CapsLock::
suspend permit
SetCapsLockState, AlwaysOff
;RapidHotkey("setcaps", 3, 0.12, 1)  ;activate caps when it's presses 3 times 
Return

^Capslock::			;ctrl&caps
suspend permit
Notify(" Capslock","ON",1,"TS=55 MS=20")
SetCapsLockState, On
return

#Capslock::					;suspends all hotkeys
suspend permit
if kvar=1
{
kvar = 		;suspends all hotkeys with no "suspend permit"
Notify("ON","keyboard modify",1,"TS=55 MS=20")
suspend off
}
else
{
suspend permit
Notify("OFF","keyboard modify",1,"TS=55 MS=20")
suspend on
kvar = 1
;cvar = 1
}
return


CapsLock & space::
if Lshift_var=1
Send {del}
Else
send {bs}
return

/*
CapsLock & space::		for another layer with caps and space as modifiers
suspend permit
lasts = 1
if qvar=1
	{
	picture:="space.jpg"
	makestat()
	keywait, space
	picture:="caps.jpg"
	makestat()
	lasts = 0
	}
Else
	{
	keywait, space
	lasts = 0
	}
return
*/
;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    other special keys  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;--------------------------------------------------------------------------------

CapsLock & BS::
suspend permit
sendinput {Del}
Return

CapsLock & lalt::
suspend permit
sendinput {return}
return

/*
Lshift & space::
if check12=1
send {BS}
return
*/
;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    keys where keyboard  modification is suspended    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;---------------------------------------------------------------------------------

~rshift::
suspend on
keywait, rshift
if kvar = 
suspend off
return

~ctrl::
if Check1 = 1   ;;;check with gui
{
suspend on
keywait, ctrl
if kvar = 
suspend off
}
return

~lalt::
if Check2 = 1 ;;;check with gui
{
	suspend on
	keywait, lalt
	if kvar = 
	suspend off
}
return


;---------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Stickyshift ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;---------------------------------------------------------------------------------

~Lshift::
Suspend permit
;RapidHotkey("setdouble",2 , 0.12, 1)
Lshift_var=1
if Check3 = 1
	{
	Input, keysh, l1 t1 m, {space}{LShift}
	;notify(key)
	Send +%keysh%
	keysh =
	}
keywait LShift
Lshift_var=0
return


;-------------------------------------------------------------------------------------------------
;;;--------------------------- Base modification-------------------------------------------
;-------------------------------------------------------------------------------


    ^::p
;	sendinput p
;	Return
	
	1::o
	2::l
	3::i
	4::u
	5::n
	6::m
	7::k

;-------------------------------------------------------------------------------------------------
;;;--------------------------- CAPSLOCK MODIFICATION------------------------------------------
;-------------------------------------------------------------------------------;---------------------------------------
;---------------------------------------------------------


----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    caps/win asdf

/*
CapsLock & s::
suspend permit
if lasts = 1
sendinput {_}
else
	if lalts = 1
	sendinput {down}
	else
sendinput ß
Return
*/


CapsLock & a::
suspend permit
if lasts = 1
sendinput {left}
else
send ä
Return

CapsLock & s::
suspend permit
if lasts = 1
sendinput {down}
else
sendinput ß
Return

CapsLock & d::
suspend permit
if lasts = 1
sendinput {right}
else
send {,}
Return


CapsLock & f::
suspend permit
send {.}
return



CapsLock & g::
suspend permit
send {\}
return

CapsLock & h::
suspend permit
send {´}
return


;----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    caps/win qwert



CapsLock & q::
suspend permit
if lasts = 1
sendinput {home}
else
send ö ;{(}
return

;#w::send >

CapsLock & w::
suspend permit
if lasts = 1
	sendinput {up}
	else
send ü ;{)}
return


CapsLock & e::
suspend permit
if lasts = 1
	sendinput {end}
	else
sendinput {;}
return


CapsLock & r::
suspend permit
sendinput {:}
return


CapsLock & t::
suspend permit
sendinput {'}
return

CapsLock & z::
suspend permit
sendinput ``
return


;----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    yxcv



CapsLock & y::
suspend permit
sendinput @
return

CapsLock & x::
suspend permit
sendinput {_}
return

CapsLock & c::
suspend permit
sendinput {#}
return

CapsLock & v::
suspend permit
sendinput {?}
return

CapsLock & b::
suspend permit
sendinput {^}
return

CapsLock & n::
suspend permit
sendinput {|}
return

;----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    caps/win 12345

CapsLock & ^::
suspend permit
send {^}
return

CapsLock & 1::
suspend permit
send {!}
return


CapsLock & 2::
suspend permit
sendinput {"} ;"
return


CapsLock & 3::
suspend permit
sendinput {§}
return


CapsLock & 4::
suspend permit
sendinput {$}
return


CapsLock & 5::
suspend permit
sendinput `%
return


CapsLock & 6::
suspend permit
sendinput &
return

CapsLock & 7::
suspend permit
sendinput {/}
return


;----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   <-Modification
;-----------------------------------------------------------
;----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;
;-----------------------------------------------------------

< & ^::
sendinput {^}
return

< & 1::
sendinput {<}
return

< & 2::
sendinput {>}
return

< & 3::
sendinput {(}
return

< & 4::
sendinput {)}
return

< & 5::
sendinput {{}
return

< & 6::
sendinput {}}
return




< & q::
send 7
return

< & w::
send 8
return

< & e::
send 9
return

< & r::
sendinput {-}
return

< & t::
sendinput {*}
return

< & z::
sendinput {[}
return

< & a::
send 4
return


< & s::
send 5
return


< & d::
send 6
return

< & f::
sendinput {+}
return

< & g::
sendinput {/}
return

< & h::
sendinput {]}
return


< & y::
sendinput 1
return

< & x::
sendinput 2
return

< & c::
sendinput 3
return

< & v::
sendinput {=} 
return

< & b::
sendinput  {~}
return

< & n::
sendinput  {.}
return

< & space::
sendinput  0
return

< & alt::
sendinput  {,}
return


;----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Special modifications (hotkeys)
;-----------------------------------------------------------
;----------------------------------------------------------------


;;;;;;;;;;;;;;;;;;;;;;volume

CapsLock & f1::
suspend permit
Send {Volume_Down}
return  ; Raise the master volume by 1 interval (typically 5%).

CapsLock & f2::
suspend permit
Send {Volume_Up}
return  ; Lower the master volume

CapsLock & f3::
suspend permit
Send {Volume_Mute}  ; Mute/unmute the master volume.
return

;;;;;;;;;;;;;;;;;;;date
 
CapsLock & f4::
suspend permit
Send %A_YYYY%-%A_MM%-%A_DD%
return


;----------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Capslock ARROW keys
;-----------------------------------------------------------

CapsLock & ö::
workoe = on
KeyWait, ö
workoe = off
return

CapsLock & i::
suspend permit
if workoe = on
sendinput {blind}+{Up}
else
sendinput {blind}{Up}
return

CapsLock & k::
suspend permit
if workoe = on
sendinput {blind}+{Down}
else
sendinput {blind}{Down}
return

CapsLock & j::
suspend permit
if workoe = on
sendinput {blind}+{Left}
else
sendinput {blind}{Left}
return

CapsLock & l::
suspend permit
if workoe = on
sendinput {blind}+{Right}
else
sendinput {blind}{Right}
return

CapsLock & u::
suspend permit
if workoe = on
sendinput {blind}+{home}
else
sendinput {blind}{home}
return

CapsLock & o::
suspend permit
if workoe = on
sendinput {blind}+{end}
else
sendinput {blind}{end}
return

k_MenuExit:
ExitApp