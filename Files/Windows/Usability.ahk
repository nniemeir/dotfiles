#Requires AutoHotkey v2.0

; GENERAL
SetWinDelay 2
CoordMode "Mouse"

g_DoubleAlt := false

; ENVIRONMENT VARIABLES
hdrive := EnvGet("Homedrive")
hpath := EnvGet("Homepath")
userHome := hdrive . hpath

; PREVENT AUTO REPEAT FOR ALT AND DETECT DOUBLE ALT
~Alt::
{
    global g_DoubleAlt := (A_PriorHotkey = "~Alt" && A_TimeSincePriorHotkey < 400)
    KeyWait "Alt"  ; Prevents keyboard auto-repeat from interfering
}

; REMAPPINGS
#f::F11
#+c::!F4

; APPLICATIONS
#+f::Run "C:\Program Files\Mozilla Firefox\firefox.exe"
#+Enter::Run "C:\Program Files\WindowsApps\TheDebianProject.DebianGNULinux_1.15.0.0_x64__76v4gfsz19hv4\debian.exe"
#+v::Run "C:\Windows\System32\SndVol.exe"
#Enter::Run userHome "\AppData\Local\Microsoft\WindowsApps\wt.exe"

#+e::Run userHome "\AppData\Local\Microsoft\WinGet\Packages\gokcehan.lf_Microsoft.Winget.Source_8wekyb3d8bbwe\lf.exe"
#Del::FileRecycleEmpty  ; Win + Del

; WINDOW CONTROL
#m::WinMaximize "A"
#n::WinMinimize "A"
#t::WinSetAlwaysOnTop -1, "A"

; DOUBLE ALT + LButton: Minimize (with PostMessage for compatibility)
#LButton::
{
    global g_DoubleAlt
    if g_DoubleAlt
    {
        MouseGetPos ,, &kde_id
        ; Equivalent to WinMinimize but avoids bugs in some apps (e.g., PSPad)
        PostMessage 0x0112, 0xF020,,, "ahk_id " kde_id
        g_DoubleAlt := false
        return
    }

    ; Otherwise: Drag to move window
    MouseGetPos &kde_x1, &kde_y1, &kde_id
    if WinGetMinMax("ahk_id " kde_id)
        return  ; Abort if window is maximized

    WinGetPos &kde_winX1, &kde_winY1,,, "ahk_id " kde_id

    while GetKeyState("LButton", "P")
    {
        MouseGetPos &kde_x2, &kde_y2
        kde_x2 -= kde_x1
        kde_y2 -= kde_y1
        kde_winX2 := kde_winX1 + kde_x2
        kde_winY2 := kde_winY1 + kde_y2
        WinMove kde_winX2, kde_winY2,,, "ahk_id " kde_id
    }
}

; DOUBLE ALT + RButton: Toggle maximize/restore
#RButton::
{
    global g_DoubleAlt
    if g_DoubleAlt
    {
        MouseGetPos ,, &kde_id
        if WinGetMinMax("ahk_id " kde_id)
            WinRestore "ahk_id " kde_id
        else
            WinMaximize "ahk_id " kde_id
        g_DoubleAlt := false
        return
    }

    ; Otherwise: Drag to resize window
    MouseGetPos &kde_x1, &kde_y1, &kde_id
    if WinGetMinMax("ahk_id " kde_id)
        return  ; Abort if window is maximized

    WinGetPos &kde_winX1, &kde_winY1, &kde_winW, &kde_winH, "ahk_id " kde_id

    kde_winLeft := (kde_x1 < kde_winX1 + kde_winW / 2) ? 1 : -1
    kde_winUp   := (kde_y1 < kde_winY1 + kde_winH / 2) ? 1 : -1

    while GetKeyState("RButton", "P")
    {
        MouseGetPos &kde_x2, &kde_y2

        WinGetPos &kde_winX1, &kde_winY1, &kde_winW, &kde_winH, "ahk_id " kde_id

        kde_x2 -= kde_x1
        kde_y2 -= kde_y1

        WinMove kde_winX1 + (kde_winLeft + 1)/2 * kde_x2
              , kde_winY1 + (kde_winUp + 1)/2 * kde_y2
              , kde_winW - kde_winLeft * kde_x2
              , kde_winH - kde_winUp * kde_y2
              , "ahk_id " kde_id

        kde_x1 += kde_x2
        kde_y1 += kde_y2
    }
}
