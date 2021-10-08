Func _isFocusOnGui($hGuiOrTitle)
    Local $iState = WinGetState($hGuiOrTitle)
    If $iState == 15 Then Return True

    Return False
EndFunc

Func _loadGuiIcon($cBtn, $sBitmapName, $iWidth = $iButtons, $iHeight = $iButtons)
    Local $hImg = _GUIImageList_Create($iWidth, $iHeight, 5, 3)
    _GUIImageList_AddBitmap($hImg, $aPath[$eImages] & $sBitmapName & '.bmp')
    _GUICtrlButton_SetImageList($cBtn, $hImg, 4)
EndFunc

Func _mouseover($iControlId)
    Switch $iControlId
        Case $cBtnChooseFolder
            _loadGuiIcon($cBtnChooseFolder, 'open_hover')

        Case $cBtnUndo
            If $bIsBtnUndoEnabled    Then _loadGuiIcon($cBtnUndo,    'undo_hover')

        Case $cBtnRedo
            If $bIsBtnRedoEnabled    Then _loadGuiIcon($cBtnRedo,    'redo_hover')

        Case $cBtnPreview
            If $bIsBtnPreviewEnabled Then _loadGuiIcon($cBtnPreview, 'preview_hover')

        Case $cBtnReset
            If $bIsBtnResetEnabled   Then _loadGuiIcon($cBtnReset,   'reset_hover')

        Case $cBtnRename
            If $bIsBtnRenameEnabled  Then _loadGuiIcon($cBtnRename,  'save_hover')

        Case $cBtnMinimize
            _loadGuiIcon($cBtnMinimize, 'minimize_hover')

        Case $cBtnClose
            _loadGuiIcon($cBtnClose,    'close_hover')
    EndSwitch
EndFunc

Func _mouseleave($iControlId)
    Switch $iControlId
        Case $cBtnChooseFolder
            _loadGuiIcon($cBtnChooseFolder, 'open')
        Case $cBtnUndo
            If $bIsBtnUndoEnabled    Then _loadGuiIcon($cBtnUndo,    'undo')

        Case $cBtnRedo
            If $bIsBtnRedoEnabled    Then _loadGuiIcon($cBtnRedo,    'redo')

        Case $cBtnPreview
            If $bIsBtnPreviewEnabled Then _loadGuiIcon($cBtnPreview, 'preview')

        Case $cBtnReset
            If $bIsBtnResetEnabled   Then _loadGuiIcon($cBtnReset,   'reset')

        Case $cBtnRename
            If $bIsBtnRenameEnabled  Then _loadGuiIcon($cBtnRename,  'save')

        Case $cBtnMinimize
            _loadGuiIcon($cBtnMinimize, 'minimize')

        Case $cBtnClose
            _loadGuiIcon($cBtnClose,    'close')
    EndSwitch
EndFunc

Func _readInput($iControlId)
    Return GUICtrlRead($iControlId)
EndFunc

Func _disable($iControlId)
    GUICtrlSetState($iControlId, $GUI_DISABLE)
EndFunc

Func _enable($iControlId)
    GUICtrlSetState($iControlId, $GUI_ENABLE)
EndFunc

Func _myDragAndDropBoxGui($sTitle)
    Local $iWDragAndDropBox        = 300
    Local $iHDragAndDropBox        = 200
    Local $iXDragAndDropBox        = Default
    Local $iYDragAndDropBox        = Default
    Local $iBorderSize             = 2
    Local $vBorderColor            = $aColor[$eTitleFont]
    Local $vBorderColor            = $aColor[$eTitleBkg]

    Local $hSubGuiDragAndDrop      = GUICreate('', $iWDragAndDropBox, $iHDragAndDropBox, $iXDragAndDropBox, $iYDragAndDropBox, $WS_POPUP + $WS_EX_TOPMOST, $WS_EX_ACCEPTFILES)
                                     GUISetBkColor($aColor[$ePrimary], $hSubGuiDragAndDrop)
                                     GUISetFont(11, 600)

    Local $cLblTitle               = GUICtrlCreateLabel($sTitle, 0, 0, $iWDragAndDropBox - $iButtons - $iBorderSize, 35, $SS_CENTER + $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
                                     GUICtrlSetBkColor($cLblTitle, $aColor[$eTitleBkg])
                                     GUICtrlSetColor($cLblTitle, $aColor[$eTitleFont])

    Local $cBtnCloseDragAndDropBox = GUICtrlCreateButton('', $iWDragAndDropBox - $iButtons - $iBorderSize, $iBorderSize, $iButtons, $iButtons, $vImageStyle)
    Local $cEditBox                = GUICtrlCreateEdit($sDropText, 50, 65, $iWDragAndDropBox - 95, $iHDragAndDropBox - (50 * 2), $ES_WANTRETURN + $ES_READONLY, $WS_EX_TRANSPARENT)
                                     GUICtrlSetBkColor($cEditBox, $aColor[$eTitleFont])
                                     GUICtrlSetColor($cEditBox, $aColor[$eSecondary])
                                     GUICtrlSetFont($cEditBox, 20, 400, Default, 'Consolas')
                                     GUICtrlSetState($cEditBox, $GUI_DROPACCEPTED)

                                     GUICtrlCreateLabel('', 0, 0, $iWDragAndDropBox, $iBorderSize)                                ; border top
                                     GUICtrlSetBkColor(-1, $vBorderColor)
                                     GUICtrlCreateLabel('', 0, 0, $iBorderSize, $iHDragAndDropBox)                                ; border right
                                     GUICtrlSetBkColor(-1, $vBorderColor)
                                     GUICtrlCreateLabel('', 0, $iHDragAndDropBox - $iBorderSize, $iWDragAndDropBox, $iBorderSize) ; border bottom
                                     GUICtrlSetBkColor(-1, $vBorderColor)
                                     GUICtrlCreateLabel('', $iWDragAndDropBox - $iBorderSize, 0, $iBorderSize, $iHDragAndDropBox) ; border left
                                     GUICtrlSetBkColor(-1, $vBorderColor)

    GUICtrlSetCursor($cBtnCloseDragAndDropBox, 0)
    _loadGuiIcon($cBtnCloseDragAndDropBox, 'close_dialog')

    GUISetState(@SW_HIDE, $hMainGui)
    GUISetState(@SW_SHOW, $hSubGuiDragAndDrop)
    WinSetOnTop($hSubGuiDragAndDrop, '', 1)

    While 1
        Local $sEditBoxContent = StringReplace(GUICtrlRead($cEditBox), $sDropText, '')
        If $sEditBoxContent <> '' Then
            $sFolderList = $sEditBoxContent
            GUIDelete($hSubGuiDragAndDrop)
            GUISetState(@SW_SHOW, $hMainGui)

            Return
        EndIf

        Switch GUIGetMsg()
            Case -3, $cBtnCloseDragAndDropBox
                GUIDelete($hSubGuiDragAndDrop)
                GUISetState(@SW_SHOW, $hMainGui)

                Return
        EndSwitch
    WEnd
EndFunc

Func _myMsgBoxGui($sTitle, $sMessage, $sMode = 'Ok')
    Local $iWMsgBox        = $aGui[$eWidth] * 0.6
    Local $iHMsgBox        = $aGui[$eHeight] * 0.4
    Local $iXMsgBox        = Default
    Local $iYMsgBox        = Default
    Local $iBorderSize     = 2
    Local $vBorderColor    = $aColor[$eTitleFont]
    Local $vBorderColor    = $aColor[$eTitleBkg]

    Local $hSubGuiMsgBox   = GUICreate('', $iWMsgBox, $iHMsgBox, $iXMsgBox, $iYMsgBox, $WS_POPUP + $WS_EX_TOPMOST)
                             GUISetBkColor($aColor[$ePrimary], $hSubGuiMsgBox)
                             GUISetFont(11, 600)

    Local $cLblTitle       = GUICtrlCreateLabel($sTitle, 0, 0, $iWMsgBox - $iButtons - $iBorderSize, 35, $SS_CENTER + $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
                             GUICtrlSetBkColor($cLblTitle, $aColor[$eTitleBkg])
                             GUICtrlSetColor($cLblTitle, $aColor[$eTitleFont])

    Local $cBtnCloseMsgBox = GUICtrlCreateButton('', $iWMsgBox - $iButtons - $iBorderSize, $iBorderSize, $iButtons, $iButtons, $vImageStyle)
    Local $cLblMessage     = GUICtrlCreateLabel($sMessage, 50, 65, $iWMsgBox - 95, $iHMsgBox - (65 * 2), $SS_CENTER + $SS_CENTERIMAGE)
                             GUICtrlSetColor($cLblMessage, $aColor[$eSecondary])
                             GUICtrlSetFont($cLblMessage, 11, 600)

    Local $cLblYes         = GUICtrlCreateLabel(_getResxValue('LblYes'), $iWMsgBox - 50 - 85 - 115, $iHMsgBox - 50, 100, 32, $SS_CENTER + $SS_CENTERIMAGE)
                             GUICtrlSetBkColor($cLblYes, $aColor[$eTitleFont])
                             GUICtrlSetColor($cLblYes, $aColor[$eSecondary])
                             GUICtrlSetFont($cLblYes, 11, 600)
                             GUICtrlSetCursor($cLblYes, 0)

    Local $cLblNo          = GUICtrlCreateLabel(_getResxValue('LblNo'), $iWMsgBox - 50 - 85, $iHMsgBox - 50, 100, 32, $SS_CENTER + $SS_CENTERIMAGE)
                             GUICtrlSetBkColor($cLblNo, $aColor[$eTitleFont])
                             GUICtrlSetColor($cLblNo, $aColor[$eSecondary])
                             GUICtrlSetFont($cLblNo, 11, 600)
                             GUICtrlSetCursor($cLblNo, 0)

    Local $cLblShowLog     = GUICtrlCreateLabel(_getResxValue('LblShowLog'), $iWMsgBox - 50 - 85 - 115, $iHMsgBox - 50, 100, 32, $SS_CENTER + $SS_CENTERIMAGE)
                             GUICtrlSetBkColor($cLblShowLog, $aColor[$eTitleFont])
                             GUICtrlSetColor($cLblShowLog, $aColor[$eSecondary])
                             GUICtrlSetFont($cLblShowLog, 11, 600)
                             GUICtrlSetCursor($cLblShowLog, 0)

    Local $cLblOk          = GUICtrlCreateLabel(_getResxValue('LblOk'), $iWMsgBox - 50 - 85, $iHMsgBox - 50, 100, 32, $SS_CENTER + $SS_CENTERIMAGE)
                             GUICtrlSetBkColor($cLblOk, $aColor[$eTitleFont])
                             GUICtrlSetColor($cLblOk, $aColor[$eSecondary])
                             GUICtrlSetFont($cLblOk, 11, 600)
                             GUICtrlSetCursor($cLblOk, 0)

                             GUICtrlCreateLabel('', 0, 0, $iWMsgBox, $iBorderSize)                        ; border top
                             GUICtrlSetBkColor(-1, $vBorderColor)
                             GUICtrlCreateLabel('', 0, 0, $iBorderSize, $iHMsgBox)                        ; border right
                             GUICtrlSetBkColor(-1, $vBorderColor)
                             GUICtrlCreateLabel('', 0, $iHMsgBox - $iBorderSize, $iWMsgBox, $iBorderSize) ; border bottom
                             GUICtrlSetBkColor(-1, $vBorderColor)
                             GUICtrlCreateLabel('', $iWMsgBox - $iBorderSize, 0, $iBorderSize, $iHMsgBox) ; border left
                             GUICtrlSetBkColor(-1, $vBorderColor)

    If $sMode == 'Ok' Then
        GUICtrlSetState($cLblYes, $GUI_HIDE)
        GUICtrlSetState($cLblNo, $GUI_HIDE)
        GUICtrlSetState($cLblShowLog, $GUI_HIDE)
    ElseIf $sMode == 'YesNo' Then
        GUICtrlSetState($cLblOk, $GUI_HIDE)
        GUICtrlSetState($cLblShowLog, $GUI_HIDE)
    ElseIf $sMode == 'ShowLog' Then
        GUICtrlSetState($cLblYes, $GUI_HIDE)
        GUICtrlSetState($cLblNo, $GUI_HIDE)
    EndIf

    GUICtrlSetCursor($cBtnCloseMsgBox, 0)
    _loadGuiIcon($cBtnCloseMsgBox, 'close_dialog')

    GUISetState(@SW_SHOW, $hSubGuiMsgBox)
    WinSetOnTop($hSubGuiMsgBox, '', 1)

    While 1
        Switch GUIGetMsg()
            Case -3, $cBtnCloseMsgBox
                GUIDelete($hSubGuiMsgBox)

                Return False

            Case $cLblYes
                GUIDelete($hSubGuiMsgBox)

                Return True

            Case $cLblNo
                GUIDelete($hSubGuiMsgBox)

                Return False

            Case $cLblShowLog
                Run('notepad.exe "' & $aFile[$eLog] & '"')
                GUIDelete($hSubGuiMsgBox)

                Return True

            Case $cLblOk
                GUIDelete($hSubGuiMsgBox)

                Return True
        EndSwitch
    WEnd
EndFunc
