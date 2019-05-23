Func _isFocusOnGui( $hGuiOrTitle )
    Local $iState = WinGetState( $hGuiOrTitle )
    If $iState == 15 Then Return True
    Return False
EndFunc

Func _loadGuiIcon( $cBtn, $sBitmapName, $iWidth = $iButtons, $iHeight = $iButtons )
    Local $hImg = _GUIImageList_Create( $iWidth, $iHeight, 5, 3 )
    _GUIImageList_AddBitmap( $hImg, $sPathImages & $sBitmapName & '.bmp' )
    _GUICtrlButton_SetImageList( $cBtn, $hImg, 4 )
EndFunc

Func _mouseover( $iControlId )
    Switch $iControlId
        Case $cBtnChooseFolder
            _loadGuiIcon( $cBtnChooseFolder, 'open_hover' )
        Case $cBtnUndo
            If $bIsBtnUndoEnabled    Then _loadGuiIcon( $cBtnUndo,    'undo_hover' )
        Case $cBtnRedo
            If $bIsBtnRedoEnabled    Then _loadGuiIcon( $cBtnRedo,    'redo_hover' )
        Case $cBtnPreview
            If $bIsBtnPreviewEnabled Then _loadGuiIcon( $cBtnPreview, 'preview_hover' )
        Case $cBtnReset
            If $bIsBtnResetEnabled   Then _loadGuiIcon( $cBtnReset,   'reset_hover' )
        Case $cBtnRename
            If $bIsBtnRenameEnabled  Then _loadGuiIcon( $cBtnRename,  'save_hover' )
        Case $cBtnMinimize
            _loadGuiIcon( $cBtnMinimize, 'minimize_hover' )
        Case $cBtnClose
            _loadGuiIcon( $cBtnClose,    'close_hover' )
    EndSwitch
EndFunc

Func _mouseleave( $iControlId )
    Switch $iControlId
        Case $cBtnChooseFolder
            _loadGuiIcon( $cBtnChooseFolder, 'open' )
        Case $cBtnUndo
            If $bIsBtnUndoEnabled    Then _loadGuiIcon( $cBtnUndo,    'undo' )
        Case $cBtnRedo
            If $bIsBtnRedoEnabled    Then _loadGuiIcon( $cBtnRedo,    'redo' )
        Case $cBtnPreview
            If $bIsBtnPreviewEnabled Then _loadGuiIcon( $cBtnPreview, 'preview' )
        Case $cBtnReset
            If $bIsBtnResetEnabled   Then _loadGuiIcon( $cBtnReset,   'reset' )
        Case $cBtnRename
            If $bIsBtnRenameEnabled  Then _loadGuiIcon( $cBtnRename,  'save' )
        Case $cBtnMinimize
            _loadGuiIcon( $cBtnMinimize, 'minimize' )
        Case $cBtnClose
            _loadGuiIcon( $cBtnClose,    'close' )
    EndSwitch
EndFunc

Func _readInput( $iControlId )
    Return GUICtrlRead( $iControlId )
EndFunc

Func _disable( $iControlId )
    GUICtrlSetState( $iControlId, $GUI_DISABLE )
EndFunc

Func _enable( $iControlId )
    GUICtrlSetState( $iControlId, $GUI_ENABLE )
EndFunc

Func _myMsgBox( $sTitle, $sMessage, $sMode = 'Ok' )
    Local $iWMsgBox        = 700
    Local $iHMsgBox        = 200
    Local $iXMsgBox        = Default
    Local $iYMsgBox        = Default
    Local $iBorderSize     = 2
    Local $vBorderColor    = $vColorTitleFont
    Local $vBorderColor    = $vColorTitleBkg

    Local $hSubGui         = GUICreate( '', $iWMsgBox, $iHMsgBox, $iXMsgBox, $iYMsgBox, $WS_POPUP + $WS_EX_TOPMOST )
                             GUISetBkColor( $vColorPrimary, $hSubGui )
                             GUISetFont( 11, 600 )

    Local $cLblTitle       = GUICtrlCreateLabel( $sTitle, 0, 0, $iWMsgBox - $iButtons - $iBorderSize, 35, $SS_CENTER + $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG )
                             GUICtrlSetBkColor( $cLblTitle, $vColorTitleBkg )
                             GUICtrlSetColor( $cLblTitle, $vColorTitleFont )

    Local $cBtnCloseMsgBox = GUICtrlCreateButton( '', $iWMsgBox - $iButtons - $iBorderSize, $iBorderSize, $iButtons, $iButtons, $vImageStyle )
    Local $cLblMessage     = GUICtrlCreateLabel( $sMessage, 50, 65, $iWMsgBox - 85, $iHMsgBox - ( 65 * 2 ), $SS_CENTER + $SS_CENTERIMAGE )
                             GUICtrlSetColor( $cLblMessage, $vColorSecondary )
                             GUICtrlSetFont( $cLblMessage, 11, 600 )

    Local $cLblYes         = GUICtrlCreateLabel( 'Ja', $iWMsgBox - 50 - 85 - 115, $iHMsgBox - 50, 100, 32, $SS_CENTER + $SS_CENTERIMAGE )
                             GUICtrlSetBkColor( $cLblYes, $vColorTitleFont )
                             GUICtrlSetColor( $cLblYes, $vColorSecondary )
                             GUICtrlSetFont( $cLblYes, 11, 600 )
                             GUICtrlSetCursor( $cLblYes, 0 )

    Local $cLblNo          = GUICtrlCreateLabel( 'Nein', $iWMsgBox - 50 - 85, $iHMsgBox - 50, 100, 32, $SS_CENTER + $SS_CENTERIMAGE )
                             GUICtrlSetBkColor( $cLblNo, $vColorTitleFont )
                             GUICtrlSetColor( $cLblNo, $vColorSecondary )
                             GUICtrlSetFont( $cLblNo, 11, 600 )
                             GUICtrlSetCursor( $cLblNo, 0 )

    Local $cLblOk          = GUICtrlCreateLabel( 'OK', $iWMsgBox - 50 - 85, $iHMsgBox - 50, 100, 32, $SS_CENTER + $SS_CENTERIMAGE )
                             GUICtrlSetBkColor( $cLblOk, $vColorTitleFont )
                             GUICtrlSetColor( $cLblOk, $vColorSecondary )
                             GUICtrlSetFont( $cLblOk, 11, 600 )
                             GUICtrlSetCursor( $cLblOk, 0 )

                             GUICtrlCreateLabel( '', 0, 0, $iWMsgBox, $iBorderSize )                        ; border top
                             GUICtrlSetBkColor( -1, $vBorderColor )
                             GUICtrlCreateLabel( '', 0, 0, $iBorderSize, $iHMsgBox )                        ; border right
                             GUICtrlSetBkColor( -1, $vBorderColor )
                             GUICtrlCreateLabel( '', 0, $iHMsgBox - $iBorderSize, $iWMsgBox, $iBorderSize ) ; border bottom
                             GUICtrlSetBkColor( -1, $vBorderColor )
                             GUICtrlCreateLabel( '', $iWMsgBox - $iBorderSize, 0, $iBorderSize, $iHMsgBox ) ; border left
                             GUICtrlSetBkColor( -1, $vBorderColor )

    If $sMode == 'Ok' Then
        GUICtrlSetState( $cLblYes, $GUI_HIDE )
        GUICtrlSetState( $cLblNo, $GUI_HIDE )
    ElseIf $sMode == 'YesNo' Then
        GUICtrlSetState( $cLblOk, $GUI_HIDE )
    EndIf

    GUICtrlSetCursor( $cBtnCloseMsgBox, 0 )
    _loadGuiIcon( $cBtnCloseMsgBox, 'close_msgbox' )

    GUISetState( @SW_SHOW, $hSubGui )
    WinSetOnTop( $hSubGui, '', 1 )

    While 1
        Switch GUIGetMsg()
            Case -3, $cBtnCloseMsgBox
                GUIDelete( $hSubGui )
                Return False
            Case $cLblYes
                GUIDelete( $hSubGui )
                Return True
            Case $cLblNo
                GUIDelete( $hSubGui )
                Return False
            Case $cLblOk
                GUIDelete( $hSubGui )
                Return True
        EndSwitch
    WEnd
EndFunc
