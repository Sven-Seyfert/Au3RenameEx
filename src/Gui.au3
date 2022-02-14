Global $hMainGui                = GUICreate($sProgramTitle, $aGui[$eWidth], $aGui[$eHeight], $aGui[$eXPosition], $aGui[$eYPosition], $WS_POPUP)
                                  GUISetBkColor($aColor[$ePrimary], $hMainGui)
                                  GUISetFont(11, 400)

; title
Global $cLblProgram             = GUICtrlCreateLabel($sProgramTitle, $aGui[$eWidth] / 4, 0, $aGui[$eWidth] / 2, 40, $SS_CENTER + $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
                                  GUICtrlSetBkColor($cLblProgram, $aColor[$eTitleBkg])
                                  GUICtrlSetColor($cLblProgram, $aColor[$eTitleFont])
                                  GUICtrlSetFont($cLblProgram, 11, 600)

; buttons
Global $cBtnChooseFolder        = GUICtrlCreateButton('', $aGui[$eWidth] * 0.005, $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)
Global $cBtnUndo                = GUICtrlCreateButton('', $aGui[$eWidth] * 0.015 + ($iGutter * 1), $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)
Global $cBtnRedo                = GUICtrlCreateButton('', $aGui[$eWidth] * 0.025 + ($iGutter * 2), $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)
Global $cBtnPreview             = GUICtrlCreateButton('', $aGui[$eWidth] * 0.035 + ($iGutter * 3), $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)
Global $cBtnReset               = GUICtrlCreateButton('', $aGui[$eWidth] * 0.045 + ($iGutter * 4), $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)
Global $cBtnRename              = GUICtrlCreateButton('', $aGui[$eWidth] * 0.055 + ($iGutter * 5), $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)
Global $cBtnMinimize            = GUICtrlCreateButton('', $aGui[$eWidth] * 0.975 - ($iGutter * 2), $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)
Global $cBtnClose               = GUICtrlCreateButton('', $aGui[$eWidth] * 0.985 - ($iGutter * 1), $aGui[$eWidth] * 0.005, $iButtons, $iButtons, $vImageStyle)

; numeration section
Global $cBtnRdoNumeration       = GUICtrlCreateButton('', $aGui[$eWidth] * 0.02, $aGui[$eWidth] * 0.05, $iButtons, $iButtons, $vImageStyle)
Global $cLblNumeration          = GUICtrlCreateLabel(_GetResxValue('LblNumeration'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.0565, 150)
                                  GUICtrlSetColor($cLblNumeration, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblNumeration, 11, 600)

Global $cLblNumerationStart     = GUICtrlCreateLabel(_GetResxValue('LblNumerationStart'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.0775)
                                  GUICtrlSetColor($cLblNumerationStart, $aColor[$eSecondary])
Global $cNumerationStart        = GUICtrlCreateInput(1, $aGui[$eWidth] * 0.1, $aGui[$eWidth] * 0.075, 100)
                                  GUICtrlCreateUpdown($cNumerationStart)
                                  GUICtrlSetLimit(-1, 5000, 1)

Global $cLblNumerationDigits    = GUICtrlCreateLabel(_GetResxValue('LblNumerationDigits'), $aGui[$eWidth] * 0.2, $aGui[$eWidth] * 0.0775)
                                  GUICtrlSetColor($cLblNumerationDigits, $aColor[$eSecondary])
Global $cNumerationDigits       = GUICtrlCreateInput(1, $aGui[$eWidth] * 0.255, $aGui[$eWidth] * 0.075, 100)
                                  GUICtrlCreateUpdown($cNumerationDigits)
                                  GUICtrlSetLimit(-1, 4, 1)

; search and replace section
Global $cBtnRdoSearchAndReplace = GUICtrlCreateButton('', $aGui[$eWidth] * 0.02, $aGui[$eWidth] * 0.11, $iButtons, $iButtons, $vImageStyle)
Global $cLblSearchAndReplace    = GUICtrlCreateLabel(_GetResxValue('LblSearchAndReplace'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.1165, 150)
                                  GUICtrlSetColor($cLblSearchAndReplace, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblSearchAndReplace, 11, 600)

Global $cLblSearch              = GUICtrlCreateLabel(_GetResxValue('LblSearch'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.1375)
                                  GUICtrlSetColor($cLblSearch, $aColor[$eSecondary])
Global $cSearch                 = GUICtrlCreateInput('', $aGui[$eWidth] * 0.1, $aGui[$eWidth] * 0.135, 100)

Global $cLblReplace             = GUICtrlCreateLabel(_GetResxValue('LblReplace'), $aGui[$eWidth] * 0.2, $aGui[$eWidth] * 0.1375)
                                  GUICtrlSetColor($cLblReplace, $aColor[$eSecondary])
Global $cReplace                = GUICtrlCreateInput('', $aGui[$eWidth] * 0.255, $aGui[$eWidth] * 0.135, 100)

Global $cBtnCbxSearchAndReplace = GUICtrlCreateButton('', $aGui[$eWidth] * 0.097, $aGui[$eWidth] * 0.155, $iButtons / 1.6, $iButtons / 1.6, $vImageStyle)
Global $cLblCaseSensitive       = GUICtrlCreateLabel(_GetResxValue('LblCaseSensitive'), $aGui[$eWidth] * 0.113, $aGui[$eWidth] * 0.158)
                                  GUICtrlSetColor($cLblCaseSensitive, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblCaseSensitive, 8.5)

; paste characters section
Global $cBtnRdoPasteCharacters  = GUICtrlCreateButton('', $aGui[$eWidth] * 0.02, $aGui[$eWidth] * 0.17, $iButtons, $iButtons, $vImageStyle)
Global $cLblPasteCharacters     = GUICtrlCreateLabel(_GetResxValue('LblPasteCharacters'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.1765, 150)
                                  GUICtrlSetColor($cLblPasteCharacters, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblPasteCharacters, 11, 600)

Global $cLblText                = GUICtrlCreateLabel(_GetResxValue('LblText'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.1975)
                                  GUICtrlSetColor($cLblText, $aColor[$eSecondary])
Global $cText                   = GUICtrlCreateInput('', $aGui[$eWidth] * 0.1, $aGui[$eWidth] * 0.195, 100)

Global $cLblPosition            = GUICtrlCreateLabel(_GetResxValue('LblPosition'), $aGui[$eWidth] * 0.2, $aGui[$eWidth] * 0.1975)
                                  GUICtrlSetColor($cLblPosition, $aColor[$eSecondary])
Global $cPosition               = GUICtrlCreateInput(0, $aGui[$eWidth] * 0.255, $aGui[$eWidth] * 0.195, 100)
                                  GUICtrlCreateUpdown($cPosition)
                                  GUICtrlSetLimit(-1, 500, 0)

; move character section
Global $cBtnRdoMoveCharacter    = GUICtrlCreateButton('', $aGui[$eWidth] * 0.02, $aGui[$eWidth] * 0.23, $iButtons, $iButtons, $vImageStyle)
Global $cLblMoveCharacter       = GUICtrlCreateLabel(_GetResxValue('LblMoveCharacter'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.2365, 150)
                                  GUICtrlSetColor($cLblMoveCharacter, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblMoveCharacter, 11, 600)

Global $cLblFromPos             = GUICtrlCreateLabel(_GetResxValue('LblFromPos'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.2575)
                                  GUICtrlSetColor($cLblFromPos, $aColor[$eSecondary])
Global $cFromPos                = GUICtrlCreateInput(1, $aGui[$eWidth] * 0.1, $aGui[$eWidth] * 0.255, 100)
                                  GUICtrlCreateUpdown($cFromPos)
                                  GUICtrlSetLimit(-1, 500, 1)

Global $cLblToPos               = GUICtrlCreateLabel(_GetResxValue('LblToPos'), $aGui[$eWidth] * 0.2, $aGui[$eWidth] * 0.2575)
                                  GUICtrlSetColor($cLblToPos, $aColor[$eSecondary])
Global $cToPos                  = GUICtrlCreateInput(2, $aGui[$eWidth] * 0.255, $aGui[$eWidth] * 0.255, 100)
                                  GUICtrlCreateUpdown($cToPos)
                                  GUICtrlSetLimit(-1, 500, 0)

; delete characters section
Global $cBtnRdoDeleteCharacters = GUICtrlCreateButton('', $aGui[$eWidth] * 0.02, $aGui[$eWidth] * 0.29, $iButtons, $iButtons, $vImageStyle)
Global $cLblDeleteCharacters    = GUICtrlCreateLabel(_GetResxValue('LblDeleteCharacters'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.2965, 150)
                                  GUICtrlSetColor($cLblDeleteCharacters, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblDeleteCharacters, 11, 600)

Global $cLblAmount              = GUICtrlCreateLabel(_GetResxValue('LblAmount'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.3175)
                                  GUICtrlSetColor($cLblAmount, $aColor[$eSecondary])
Global $cAmount                 = GUICtrlCreateInput(1, $aGui[$eWidth] * 0.1, $aGui[$eWidth] * 0.315, 100)
                                  GUICtrlCreateUpdown($cAmount)
                                  GUICtrlSetLimit(-1, 500, 1)

Global $cLblAtPosition          = GUICtrlCreateLabel(_GetResxValue('LblAtPosition'), $aGui[$eWidth] * 0.2, $aGui[$eWidth] * 0.3175)
                                  GUICtrlSetColor($cLblAtPosition, $aColor[$eSecondary])
Global $cAtPosition             = GUICtrlCreateInput(1, $aGui[$eWidth] * 0.255, $aGui[$eWidth] * 0.315, 100)
                                  GUICtrlCreateUpdown($cAtPosition)
                                  GUICtrlSetLimit(-1, 500, 1)

; regex replace section
Global $cBtnRdoRegExReplace     = GUICtrlCreateButton('', $aGui[$eWidth] * 0.02, $aGui[$eWidth] * 0.35, $iButtons, $iButtons, $vImageStyle)
Global $cLblRegExReplace        = GUICtrlCreateLabel(_GetResxValue('LblRegExReplace'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.3565, 150)
                                  GUICtrlSetColor($cLblRegExReplace, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblRegExReplace, 11, 600)

Global $cLblPattern             = GUICtrlCreateLabel(_GetResxValue('LblPattern'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.3775)
                                  GUICtrlSetColor($cLblPattern, $aColor[$eSecondary])
Global $cPattern                = GUICtrlCreateInput('', $aGui[$eWidth] * 0.1, $aGui[$eWidth] * 0.375, 100)

Global $cLblReplaceRegEx        = GUICtrlCreateLabel(_GetResxValue('LblReplaceRegEx'), $aGui[$eWidth] * 0.2, $aGui[$eWidth] * 0.3775)
                                  GUICtrlSetColor($cLblReplaceRegEx, $aColor[$eSecondary])
Global $cReplaceRegEx           = GUICtrlCreateInput('', $aGui[$eWidth] * 0.255, $aGui[$eWidth] * 0.375, 100)

; timestamp section
Global $cBtnRdoTimestamp        = GUICtrlCreateButton('', $aGui[$eWidth] * 0.02, $aGui[$eWidth] * 0.41, $iButtons, $iButtons, $vImageStyle)
Global $cLblTimestamp           = GUICtrlCreateLabel(_GetResxValue('LblTimestamp'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.4165, 200)
                                  GUICtrlSetColor($cLblTimestamp, $aColor[$eSecondary])
                                  GUICtrlSetFont($cLblTimestamp, 11, 600)

Global $cLblChoice              = GUICtrlCreateLabel(_GetResxValue('LblChoice'), $aGui[$eWidth] * 0.045, $aGui[$eWidth] * 0.4375)
                                  GUICtrlSetColor($cLblChoice, $aColor[$eSecondary])
Global $cProperty               = GUICtrlCreateCombo('', $aGui[$eWidth] * 0.1, $aGui[$eWidth] * 0.435, 300)
                                  GUICtrlSetData($cProperty, _GetResxValue('LblChoiceData'))

; listview
Global $hListView               = GUICtrlCreateListView('', $aGui[$eWidth] * 0.36, $aGui[$eWidth] * 0.057, $aGui[$eWidth] * 0.61, $aGui[$eHeight] * 0.83, $aListView[$eStyle], $aListView[$eExStyle])
                                  GUICtrlSetFont($hListView, 10, 400, 0, 'Consolas')
                                  _GUICtrlListView_AddColumn($hListView, $aListView[$eColumnOneText], $aGui[$eWidth] * 0.4)
                                  _GUICtrlListView_AddColumn($hListView, $aListView[$eColumnTwoText], $aGui[$eWidth] * 0.8)

; tooltip
GUICtrlSetTip($cBtnChooseFolder,            _GetResxValue('BtnChooseFolder'))
GUICtrlSetTip($cBtnUndo,                    _GetResxValue('BtnUndo'))
GUICtrlSetTip($cBtnRedo,                    _GetResxValue('BtnRedo'))
GUICtrlSetTip($cBtnPreview,                 _GetResxValue('BtnPreview'))
GUICtrlSetTip($cBtnReset,                   _GetResxValue('BtnReset'))
GUICtrlSetTip($cBtnRename,                  _GetResxValue('BtnRename'))
GUICtrlSetTip($cBtnMinimize,                _GetResxValue('BtnMinimize'))
GUICtrlSetTip($cBtnClose,                   _GetResxValue('BtnClose'))

; cursor
GUICtrlSetCursor($cLblProgram,              9)
GUICtrlSetCursor($cBtnChooseFolder,         0)
GUICtrlSetCursor($cBtnUndo,                 0)
GUICtrlSetCursor($cBtnRedo,                 0)
GUICtrlSetCursor($cBtnPreview,              0)
GUICtrlSetCursor($cBtnReset,                0)
GUICtrlSetCursor($cBtnRename,               0)
GUICtrlSetCursor($cBtnMinimize,             0)
GUICtrlSetCursor($cBtnClose,                0)
GUICtrlSetCursor($cBtnRdoNumeration,        0)
GUICtrlSetCursor($cBtnRdoSearchAndReplace,  0)
GUICtrlSetCursor($cBtnCbxSearchAndReplace,  0)
GUICtrlSetCursor($cBtnRdoPasteCharacters,   0)
GUICtrlSetCursor($cBtnRdoMoveCharacter,     0)
GUICtrlSetCursor($cBtnRdoDeleteCharacters,  0)
GUICtrlSetCursor($cBtnRdoRegExReplace,      0)
GUICtrlSetCursor($cBtnRdoTimestamp,         0)

; button image
_LoadGuiIcon($cBtnChooseFolder,             'open')
_LoadGuiIcon($cBtnUndo,                     'undo_disable')
_LoadGuiIcon($cBtnRedo,                     'redo_disable')
_LoadGuiIcon($cBtnPreview,                  'preview_disable')
_LoadGuiIcon($cBtnReset,                    'reset_disable')
_LoadGuiIcon($cBtnRename,                   'save_disable')
_LoadGuiIcon($cBtnMinimize,                 'minimize')
_LoadGuiIcon($cBtnClose,                    'close')
_LoadGuiIcon($cBtnRdoNumeration,            'radioButtonUnchecked')
_LoadGuiIcon($cBtnRdoSearchAndReplace,      'radioButtonUnchecked')
_LoadGuiIcon($cBtnCbxSearchAndReplace,      'checkboxUnchecked', $iButtons / 1.6, $iButtons / 1.6)
_LoadGuiIcon($cBtnRdoPasteCharacters,       'radioButtonUnchecked')
_LoadGuiIcon($cBtnRdoMoveCharacter,         'radioButtonUnchecked')
_LoadGuiIcon($cBtnRdoDeleteCharacters,      'radioButtonUnchecked')
_LoadGuiIcon($cBtnRdoRegExReplace,          'radioButtonUnchecked')
_LoadGuiIcon($cBtnRdoTimestamp,             'radioButtonUnchecked')

; register hover action
_OnHoverRegister($cBtnChooseFolder,         '_Mouseover', '_Mouseleave')
_OnHoverRegister($cBtnUndo,                 '_Mouseover', '_Mouseleave')
_OnHoverRegister($cBtnRedo,                 '_Mouseover', '_Mouseleave')
_OnHoverRegister($cBtnPreview,              '_Mouseover', '_Mouseleave')
_OnHoverRegister($cBtnReset,                '_Mouseover', '_Mouseleave')
_OnHoverRegister($cBtnRename,               '_Mouseover', '_Mouseleave')
_OnHoverRegister($cBtnMinimize,             '_Mouseover', '_Mouseleave')
_OnHoverRegister($cBtnClose,                '_Mouseover', '_Mouseleave')

; disable
_DisableAllInputs()

GUISetState(@SW_SHOW, $hMainGui)
