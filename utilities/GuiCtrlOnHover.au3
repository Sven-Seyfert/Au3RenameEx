#include-once

; Internal Global Variables
Global $a__GUICtrl_SOH_Ctrls[1][1]
Global $a__GUICtrl_SOH_LastHoveredElements[2]  = [-1, -1]
Global $a__GUICtrl_SOH_LastHoveredElementsMark = -1
Global $h__GUICtrl_SOH_LastClickedElementMark  = -1
Global $i__GUICtrl_SOH_CtrlsModified           = 0
Global $i__GUICtrl_SOH_HoverOnBackWin          = 1
Global $i__GUICtrl_SOH_LastPrimaryDownCtrlID   = 0
Global $p__GUICtrl_SOH_TimerProc               = 0
Global $i__GUICtrl_SOH_TimerID                 = 0
Global $s__GUICtrl_SOH_User32_Dll              = @SystemDir & '\User32.dll'
Global $s__GUICtrl_SOH_OnExitFunc              = ''
Global Const $n__GUICtrl_SOH_WM_COMMAND        = 0x0111
Global Const $n__GUICtrl_SOH_WM_LBUTTONDOWN    = 0x0201

Execute('OnAutoItExitRegister("__GUICtrl_SOH_Exit")')



; Public Functions
Func _OnHoverRegister($iCtrlID, $sHover_Func = '', $sLeaveHover_Func = -1, $sPrimaryDownFunc = -1, $sPrimaryUpFunc = -1, $iKeepCall_PrDn_Func = 1, $iKeepCall_Hover_Func = 0)
    Local $hCtrlID = GUICtrlGetHandle($iCtrlID)
    If Not $hCtrlID Then Return SetError(1, 0, 0)

    If $p__GUICtrl_SOH_TimerProc = 0 Then
        $p__GUICtrl_SOH_TimerProc = DllCallbackRegister('__GUICtrl_SOH_CALLBACK', 'none', 'hwnd;int;uint_ptr;dword')
        $i__GUICtrl_SOH_TimerID   = DllCall($s__GUICtrl_SOH_User32_Dll, 'int', 'SetTimer', _
            'hwnd', 0, 'uint_ptr', Round(TimerInit()), 'uint', 30, 'ptr', DllCallbackGetPtr($p__GUICtrl_SOH_TimerProc))

        GUIRegisterMsg($n__GUICtrl_SOH_WM_COMMAND, '__GUICtrl_SOH_WM_COMMAND')
        GUIRegisterMsg($n__GUICtrl_SOH_WM_LBUTTONDOWN, '__GUICtrl_SOH_WM_LBUTTONDOWN')

        If IsArray($i__GUICtrl_SOH_TimerID) Then $i__GUICtrl_SOH_TimerID = $i__GUICtrl_SOH_TimerID[0]
    EndIf

    If $sHover_Func = '' And @NumParams <= 2 Then
        Local $a__GUICtrl_SOH_Ctrls_Tmp[1][1]
        Local $a__GUICtrl_SOH_Ctrls_Swap = $a__GUICtrl_SOH_Ctrls

        For $i = 1 To $a__GUICtrl_SOH_Ctrls_Swap[0][0]
            If $hCtrlID <> $a__GUICtrl_SOH_Ctrls_Swap[$i][0] Then
                $a__GUICtrl_SOH_Ctrls_Tmp[0][0] += 1
                ReDim $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]+1][7]

                $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]][0] = $a__GUICtrl_SOH_Ctrls_Swap[$i][0]
                $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]][1] = $a__GUICtrl_SOH_Ctrls_Swap[$i][1]
                $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]][2] = $a__GUICtrl_SOH_Ctrls_Swap[$i][2]
                $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]][3] = $a__GUICtrl_SOH_Ctrls_Swap[$i][3]
                $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]][4] = $a__GUICtrl_SOH_Ctrls_Swap[$i][4]
                $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]][5] = $a__GUICtrl_SOH_Ctrls_Swap[$i][5]
                $a__GUICtrl_SOH_Ctrls_Tmp[$a__GUICtrl_SOH_Ctrls_Tmp[0][0]][6] = $a__GUICtrl_SOH_Ctrls_Swap[$i][6]
            EndIf
        Next

        If $a__GUICtrl_SOH_Ctrls_Tmp[0][0] < 1 Then
            __GUICtrl_SOH_ReleaseResources()
        Else
            $i__GUICtrl_SOH_CtrlsModified = 1
            $a__GUICtrl_SOH_Ctrls = $a__GUICtrl_SOH_Ctrls_Tmp
        EndIf

        Return 1
    EndIf

    For $i = 1 To $a__GUICtrl_SOH_Ctrls[0][0]
        If $hCtrlID = $a__GUICtrl_SOH_Ctrls[$i][0] Then
            $a__GUICtrl_SOH_Ctrls[$i][0] = $hCtrlID
            $a__GUICtrl_SOH_Ctrls[$i][1] = $sHover_Func
            $a__GUICtrl_SOH_Ctrls[$i][2] = $sLeaveHover_Func
            $a__GUICtrl_SOH_Ctrls[$i][3] = $sPrimaryDownFunc
            $a__GUICtrl_SOH_Ctrls[$i][4] = $sPrimaryUpFunc
            $a__GUICtrl_SOH_Ctrls[$i][5] = $iKeepCall_PrDn_Func
            $a__GUICtrl_SOH_Ctrls[$i][6] = $iKeepCall_Hover_Func

            Return 2
        EndIf
    Next

    $a__GUICtrl_SOH_Ctrls[0][0] += 1
    ReDim $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]+1][7]

    $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]][0] = $hCtrlID
    $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]][1] = $sHover_Func
    $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]][2] = $sLeaveHover_Func
    $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]][3] = $sPrimaryDownFunc
    $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]][4] = $sPrimaryUpFunc
    $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]][5] = $iKeepCall_PrDn_Func
    $a__GUICtrl_SOH_Ctrls[$a__GUICtrl_SOH_Ctrls[0][0]][6] = $iKeepCall_Hover_Func

    Return 1
EndFunc

Func _GUICtrl_SetHoverOnBackWindow($iSetBackWin)
    $i__GUICtrl_SOH_HoverOnBackWin = Number($iSetBackWin = 1)
EndFunc

Func _GUICtrl_OnHoverReleaseResources()
    __GUICtrl_SOH_ReleaseResources()
EndFunc



; Backwards Compatibility Functions
Func _GUICtrl_SetOnHover($iCtrlID, $sHover_Func = '', $sLeaveHover_Func = -1, $sPrimaryDownFunc = -1, $sPrimaryUpFunc = -1, $iKeepCall_PrDn_Func = 1, $iKeepCall_Hover_Func = 0)
    _OnHoverRegister($iCtrlID, $sHover_Func, $sLeaveHover_Func, $sPrimaryDownFunc, $sPrimaryUpFunc, $iKeepCall_PrDn_Func, $iKeepCall_Hover_Func)
EndFunc

Func GUICtrl_SetOnHover($iCtrlID, $sHover_Func = '', $sLeaveHover_Func = -1, $sPrimaryDownFunc = -1, $sPrimaryUpFunc = -1, $iKeepCall_PrDn_Func = 1, $iKeepCall_Hover_Func = 0)
    _OnHoverRegister($iCtrlID, $sHover_Func, $sLeaveHover_Func, $sPrimaryDownFunc, $sPrimaryUpFunc, $iKeepCall_PrDn_Func, $iKeepCall_Hover_Func)
EndFunc

Func GUICtrlSetOnHover($iCtrlID, $sHover_Func = '', $sLeaveHover_Func = -1, $sPrimaryDownFunc = -1, $sPrimaryUpFunc = -1, $iKeepCall_PrDn_Func = 1, $iKeepCall_Hover_Func = 0)
    _OnHoverRegister($iCtrlID, $sHover_Func, $sLeaveHover_Func, $sPrimaryDownFunc, $sPrimaryUpFunc, $iKeepCall_PrDn_Func, $iKeepCall_Hover_Func)
EndFunc

Func _GUICtrlSetOnHover($iCtrlID, $sHover_Func = '', $sLeaveHover_Func = -1, $sPrimaryDownFunc = -1, $sPrimaryUpFunc = -1, $iKeepCall_PrDn_Func = 1, $iKeepCall_Hover_Func = 0)
    _OnHoverRegister($iCtrlID, $sHover_Func, $sLeaveHover_Func, $sPrimaryDownFunc, $sPrimaryUpFunc, $iKeepCall_PrDn_Func, $iKeepCall_Hover_Func)
EndFunc



; Internal Functions
Func __GUICtrl_SOH_CALLBACK($hWnd, $uiMsg, $idEvent, $dwTime)
    $i__GUICtrl_SOH_CtrlsModified = 0

    If $a__GUICtrl_SOH_Ctrls[0][0] < 1 Then Return

    If $i__GUICtrl_SOH_HoverOnBackWin Then
        Local $iControl_Hovered = __GUICtrl_SOH_ControlGetHovered()
    Else
        Local $iControl_Hovered = GUIGetCursorInfo()

        If Not IsArray($iControl_Hovered) Then Return

        $iControl_Hovered = GUICtrlGetHandle($iControl_Hovered[4])
    EndIf

    Local $sCheck_LHE  = $a__GUICtrl_SOH_LastHoveredElements[1]
    Local $iCheck_LCEM = $h__GUICtrl_SOH_LastClickedElementMark
    Local $iCtrlID

    If Not $iControl_Hovered Or ($sCheck_LHE <> -1 And $iControl_Hovered <> $sCheck_LHE) Then
        If $a__GUICtrl_SOH_LastHoveredElementsMark = -1 Then Return

        Local $a__Tmp_GUICtrl_SOH_LastHoveredElements[2] = [$a__GUICtrl_SOH_LastHoveredElements[0], $a__GUICtrl_SOH_LastHoveredElements[1]]

        $a__GUICtrl_SOH_LastHoveredElements[0]  = -1
        $a__GUICtrl_SOH_LastHoveredElements[1]  = -1
        $a__GUICtrl_SOH_LastHoveredElementsMark = -1
        $h__GUICtrl_SOH_LastClickedElementMark  = -1

        If $a__Tmp_GUICtrl_SOH_LastHoveredElements[0] <> -1 Then
            $iCtrlID = DllCall($s__GUICtrl_SOH_User32_Dll, 'int', 'GetDlgCtrlID', 'hwnd', $a__Tmp_GUICtrl_SOH_LastHoveredElements[1])

            If IsArray($iCtrlID) Then $iCtrlID = $iCtrlID[0]

            __GUICtrl_SOH_Call($a__Tmp_GUICtrl_SOH_LastHoveredElements[0], $iCtrlID, 2, $iControl_Hovered)
        EndIf
    Else
        If $i__GUICtrl_SOH_CtrlsModified = 1 Then
            $i__GUICtrl_SOH_CtrlsModified = 0
            Return
        EndIf

        Local $iUbound = UBound($a__GUICtrl_SOH_Ctrls) - 1

        For $i = 1 To $a__GUICtrl_SOH_Ctrls[0][0]
            If $i > $iUbound Then ExitLoop

            If $a__GUICtrl_SOH_Ctrls[$i][0] = $iControl_Hovered Then
                $iCtrlID = DllCall($s__GUICtrl_SOH_User32_Dll, 'int', 'GetDlgCtrlID', 'hwnd', $iControl_Hovered)

                If IsArray($iCtrlID) Then $iCtrlID = $iCtrlID[0]

                If ($a__GUICtrl_SOH_Ctrls[$i][3] <> '' Or $a__GUICtrl_SOH_Ctrls[$i][4] <> '') And ($iCheck_LCEM = -1 Or $iCheck_LCEM = $iControl_Hovered) Then
                    Local $aCursorInfo = 0
                    Local $hParent_Wnd = DllCall($s__GUICtrl_SOH_User32_Dll, 'hwnd', 'GetParent', 'hwnd', $iControl_Hovered)

                    If Not @error And IsArray($hParent_Wnd) Then
                        $hParent_Wnd = $hParent_Wnd[0]
                        $aCursorInfo = GUIGetCursorInfo($hParent_Wnd)
                    Else
                        $aCursorInfo = GUIGetCursorInfo()
                    EndIf

                    If IsArray($aCursorInfo) Then
                        If ($i__GUICtrl_SOH_LastPrimaryDownCtrlID = $iControl_Hovered Or $i__GUICtrl_SOH_LastPrimaryDownCtrlID = 0) And WinActive($hParent_Wnd) And _
                            $aCursorInfo[2] = 1 And $a__GUICtrl_SOH_Ctrls[$i][3] <> -1 And _
                            (($a__GUICtrl_SOH_Ctrls[$i][5] < 1 And $iCheck_LCEM <> $iControl_Hovered) Or $a__GUICtrl_SOH_Ctrls[$i][5] > 0) Then

                            __GUICtrl_SOH_Call($a__GUICtrl_SOH_Ctrls[$i][3], $iCtrlID, 1)

                            $h__GUICtrl_SOH_LastClickedElementMark = $iControl_Hovered
                        ElseIf $aCursorInfo[2] = 0 And $a__GUICtrl_SOH_Ctrls[$i][4] <> -1 And $iCheck_LCEM = $iControl_Hovered Then
                            __GUICtrl_SOH_Call($a__GUICtrl_SOH_Ctrls[$i][4], $iCtrlID, 2)

                            $h__GUICtrl_SOH_LastClickedElementMark = -1
                        EndIf
                    EndIf
                EndIf

                If $i__GUICtrl_SOH_CtrlsModified = 1 Then ExitLoop

                If $a__GUICtrl_SOH_Ctrls[$i][6] < 1 And $a__GUICtrl_SOH_LastHoveredElementsMark = $a__GUICtrl_SOH_Ctrls[$i][0] Then
                    ExitLoop
                Else
                    $a__GUICtrl_SOH_LastHoveredElementsMark = $a__GUICtrl_SOH_Ctrls[$i][0]
                EndIf

                If $a__GUICtrl_SOH_Ctrls[$i][2] <> -1 Then
                    $a__GUICtrl_SOH_LastHoveredElements[0] = $a__GUICtrl_SOH_Ctrls[$i][2]
                    $a__GUICtrl_SOH_LastHoveredElements[1] = $iControl_Hovered
                EndIf

                __GUICtrl_SOH_Call($a__GUICtrl_SOH_Ctrls[$i][1], $iCtrlID, 1, 0)

                If $i__GUICtrl_SOH_CtrlsModified = 1 Then ExitLoop

                ExitLoop
            EndIf
        Next
    EndIf

    $i__GUICtrl_SOH_CtrlsModified = 0
EndFunc

Func __GUICtrl_SOH_WM_COMMAND($hWndGUI, $MsgID, $WParam, $LParam)
    $i__GUICtrl_SOH_LastPrimaryDownCtrlID = $LParam

    Local $iRet = Execute('CP_WM_COMMAND($hWndGUI, $MsgID, $WParam, $LParam)')
    If $iRet <> '' Then Return $iRet
EndFunc

Func __GUICtrl_SOH_WM_LBUTTONDOWN($hWndGUI, $MsgID, $WParam, $LParam)
    $i__GUICtrl_SOH_LastPrimaryDownCtrlID = 0
EndFunc

Func __GUICtrl_SOH_ControlGetHovered()
    Local $iOld_Opt_MCM = Opt('MouseCoordMode', 1)
    Local $tPoint       = DllStructCreate('int X;int Y')
    Local $aMPos        = MouseGetPos()

    DllStructSetData($tPoint, 'x', $aMPos[0])
    DllStructSetData($tPoint, 'y', $aMPos[1])

    Local $tPointCast = DllStructCreate('int64', DllStructGetPtr($tPoint))
    Local $aRet = DllCall($s__GUICtrl_SOH_User32_Dll, 'hwnd', 'WindowFromPoint', 'int64', DllStructGetData($tPointCast, 1))

    Opt('MouseCoordMode', $iOld_Opt_MCM)

    If @error Or Not IsArray($aRet) Then Return SetError(@error, @extended, 0)

    Return $aRet[0]
EndFunc

Func __GUICtrl_SOH_Call($sFunction, $sParam1 = '', $sParam2 = '', $sParam3 = '', $sParam4 = '', $sParam5 = '')
    Local $iRet = Call($sFunction)
    If @error <> 0xDEAD Then Return $iRet

    $iRet = Call($sFunction, $sParam1)
    If @error <> 0xDEAD Then Return $iRet

    $iRet = Call($sFunction, $sParam1, $sParam2)
    If @error <> 0xDEAD Then Return $iRet

    $iRet = Call($sFunction, $sParam1, $sParam2, $sParam3)
    If @error <> 0xDEAD Then Return $iRet

    $iRet = Call($sFunction, $sParam1, $sParam2, $sParam3, $sParam4)
    If @error <> 0xDEAD Then Return $iRet

    $iRet = Call($sFunction, $sParam1, $sParam2, $sParam3, $sParam4, $sParam5)
    If @error <> 0xDEAD Then Return $iRet

    Return SetError(1, 0, 0)
EndFunc

Func __GUICtrl_SOH_ReleaseResources()
    If $p__GUICtrl_SOH_TimerProc > 0 Then DllCallbackFree($p__GUICtrl_SOH_TimerProc)
    If $i__GUICtrl_SOH_TimerID   > 0 Then DllCall($s__GUICtrl_SOH_User32_Dll, 'int', 'KillTimer', 'hwnd', 0, 'uint_ptr', $i__GUICtrl_SOH_TimerID)

    GUIRegisterMsg($n__GUICtrl_SOH_WM_COMMAND, '')
    GUIRegisterMsg($n__GUICtrl_SOH_WM_LBUTTONDOWN, '')

    $a__GUICtrl_SOH_Ctrls = 0
    Dim $a__GUICtrl_SOH_Ctrls[1][1]

    $p__GUICtrl_SOH_TimerProc = 0
    $i__GUICtrl_SOH_TimerID = 0
EndFunc

Func __GUICtrl_SOH_Exit()
    If $s__GUICtrl_SOH_OnExitFunc <> '' Then Call($s__GUICtrl_SOH_OnExitFunc)
    __GUICtrl_SOH_ReleaseResources()
EndFunc
