Global $hMainGui                = GUICreate( $sProgramTitle, $iWGui, $iHGui, $iXGui, $iYGui, $WS_POPUP )
                                  GUISetBkColor( $vColorPrimary, $hMainGui )
                                  GUISetFont( 11, 400 )

; title
Global $cLblProgram             = GUICtrlCreateLabel( $sProgramTitle, $iWGui / 4, 0, $iWGui / 2, 40, $SS_CENTER + $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG )
                                  GUICtrlSetBkColor( $cLblProgram, $vColorTitleBkg )
                                  GUICtrlSetColor( $cLblProgram, $vColorTitleFont )
                                  GUICtrlSetFont( $cLblProgram, 11, 600 )

; buttons
Global $cBtnChooseFolder        = GUICtrlCreateButton( '', $iWGui * 0.005, $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )
Global $cBtnUndo                = GUICtrlCreateButton( '', $iWGui * 0.015 + ( $iGutter * 1 ), $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )
Global $cBtnRedo                = GUICtrlCreateButton( '', $iWGui * 0.025 + ( $iGutter * 2 ), $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )
Global $cBtnPreview             = GUICtrlCreateButton( '', $iWGui * 0.035 + ( $iGutter * 3 ), $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )
Global $cBtnReset               = GUICtrlCreateButton( '', $iWGui * 0.045 + ( $iGutter * 4 ), $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )
Global $cBtnRename              = GUICtrlCreateButton( '', $iWGui * 0.055 + ( $iGutter * 5 ), $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )
Global $cBtnMinimize            = GUICtrlCreateButton( '', $iWGui * 0.975 - ( $iGutter * 2 ), $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )
Global $cBtnClose               = GUICtrlCreateButton( '', $iWGui * 0.985 - ( $iGutter * 1 ), $iWGui * 0.005, $iButtons, $iButtons, $vImageStyle )

; numeration section
Global $cBtnRdoNumeration       = GUICtrlCreateButton( '', $iWGui * 0.02, $iWGui * 0.05, $iButtons, $iButtons, $vImageStyle )
Global $cLblNumeration          = GUICtrlCreateLabel( _getResxValue( 'LblNumeration' ), $iWGui * 0.045, $iWGui * 0.0565, 150 )
                                  GUICtrlSetColor( $cLblNumeration, $vColorSecondary )
                                  GUICtrlSetFont( $cLblNumeration, 11, 600 )

Global $cLblNumerationStart     = GUICtrlCreateLabel( _getResxValue( 'LblNumerationStart' ), $iWGui * 0.045, $iWGui * 0.0775 )
                                  GUICtrlSetColor( $cLblNumerationStart, $vColorSecondary )
Global $cNumerationStart        = GUICtrlCreateInput( 1, $iWGui * 0.1, $iWGui * 0.075, 100 )
                                  GUICtrlCreateUpdown( $cNumerationStart )
                                  GUICtrlSetLimit( -1, 5000, 1 )

Global $cLblNumerationDigits    = GUICtrlCreateLabel( _getResxValue( 'LblNumerationDigits' ), $iWGui * 0.2, $iWGui * 0.0775 )
                                  GUICtrlSetColor( $cLblNumerationDigits, $vColorSecondary )
Global $cNumerationDigits       = GUICtrlCreateInput( 1, $iWGui * 0.255, $iWGui * 0.075, 100 )
                                  GUICtrlCreateUpdown( $cNumerationDigits )
                                  GUICtrlSetLimit( -1, 4, 1 )

; search and replace section
Global $cBtnRdoSearchAndReplace = GUICtrlCreateButton( '', $iWGui * 0.02, $iWGui * 0.11, $iButtons, $iButtons, $vImageStyle )
Global $cLblSearchAndReplace    = GUICtrlCreateLabel( _getResxValue( 'LblSearchAndReplace' ), $iWGui * 0.045, $iWGui * 0.1165, 150 )
                                  GUICtrlSetColor( $cLblSearchAndReplace, $vColorSecondary )
                                  GUICtrlSetFont( $cLblSearchAndReplace, 11, 600 )

Global $cLblSearch              = GUICtrlCreateLabel( _getResxValue( 'LblSearch' ), $iWGui * 0.045, $iWGui * 0.1375 )
                                  GUICtrlSetColor( $cLblSearch, $vColorSecondary )
Global $cSearch                 = GUICtrlCreateInput( '', $iWGui * 0.1, $iWGui * 0.135, 100 )

Global $cLblReplace             = GUICtrlCreateLabel( _getResxValue( 'LblReplace' ), $iWGui * 0.2, $iWGui * 0.1375 )
                                  GUICtrlSetColor( $cLblReplace, $vColorSecondary )
Global $cReplace                = GUICtrlCreateInput( '', $iWGui * 0.255, $iWGui * 0.135, 100 )

Global $cBtnCbxSearchAndReplace = GUICtrlCreateButton( '', $iWGui * 0.097, $iWGui * 0.155, $iButtons / 1.6, $iButtons / 1.6, $vImageStyle )
Global $cLblCaseSensitive       = GUICtrlCreateLabel( _getResxValue( 'LblCaseSensitive' ), $iWGui * 0.113, $iWGui * 0.158 )
                                  GUICtrlSetColor( $cLblCaseSensitive, $vColorSecondary )
                                  GUICtrlSetFont( $cLblCaseSensitive, 8.5 )

; paste characters
Global $cBtnRdoPasteCharacters  = GUICtrlCreateButton( '', $iWGui * 0.02, $iWGui * 0.17, $iButtons, $iButtons, $vImageStyle )
Global $cLblPasteCharacters     = GUICtrlCreateLabel( _getResxValue( 'LblPasteCharacters' ), $iWGui * 0.045, $iWGui * 0.1765, 150 )
                                  GUICtrlSetColor( $cLblPasteCharacters, $vColorSecondary )
                                  GUICtrlSetFont( $cLblPasteCharacters, 11, 600 )

Global $cLblText                = GUICtrlCreateLabel( _getResxValue( 'LblText' ), $iWGui * 0.045, $iWGui * 0.1975 )
                                  GUICtrlSetColor( $cLblText, $vColorSecondary )
Global $cText                   = GUICtrlCreateInput( '', $iWGui * 0.1, $iWGui * 0.195, 100 )

Global $cLblPosition            = GUICtrlCreateLabel( _getResxValue( 'LblPosition' ), $iWGui * 0.2, $iWGui * 0.1975 )
                                  GUICtrlSetColor( $cLblPosition, $vColorSecondary )
Global $cPosition               = GUICtrlCreateInput( 0, $iWGui * 0.255, $iWGui * 0.195, 100 )
                                  GUICtrlCreateUpdown( $cPosition )
                                  GUICtrlSetLimit( -1, 500, 0 )

; move character
Global $cBtnRdoMoveCharacter    = GUICtrlCreateButton( '', $iWGui * 0.02, $iWGui * 0.23, $iButtons, $iButtons, $vImageStyle )
Global $cLblMoveCharacter       = GUICtrlCreateLabel( _getResxValue( 'LblMoveCharacter' ), $iWGui * 0.045, $iWGui * 0.2365, 150 )
                                  GUICtrlSetColor( $cLblMoveCharacter, $vColorSecondary )
                                  GUICtrlSetFont( $cLblMoveCharacter, 11, 600 )

Global $cLblFromPos             = GUICtrlCreateLabel( _getResxValue( 'LblFromPos' ), $iWGui * 0.045, $iWGui * 0.2575 )
                                  GUICtrlSetColor( $cLblFromPos, $vColorSecondary )
Global $cFromPos                = GUICtrlCreateInput( 1, $iWGui * 0.1, $iWGui * 0.255, 100 )
                                  GUICtrlCreateUpdown( $cFromPos )
                                  GUICtrlSetLimit( -1, 500, 1 )

Global $cLblToPos               = GUICtrlCreateLabel( _getResxValue( 'LblToPos' ), $iWGui * 0.2, $iWGui * 0.2575 )
                                  GUICtrlSetColor( $cLblToPos, $vColorSecondary )
Global $cToPos                  = GUICtrlCreateInput( 2, $iWGui * 0.255, $iWGui * 0.255, 100 )
                                  GUICtrlCreateUpdown( $cToPos )
                                  GUICtrlSetLimit( -1, 500, 0 )

; delete characters
Global $cBtnRdoDeleteCharacters = GUICtrlCreateButton( '', $iWGui * 0.02, $iWGui * 0.29, $iButtons, $iButtons, $vImageStyle )
Global $cLblDeleteCharacters    = GUICtrlCreateLabel( _getResxValue( 'LblDeleteCharacters' ), $iWGui * 0.045, $iWGui * 0.2965, 150 )
                                  GUICtrlSetColor( $cLblDeleteCharacters, $vColorSecondary )
                                  GUICtrlSetFont( $cLblDeleteCharacters, 11, 600 )

Global $cLblAmount              = GUICtrlCreateLabel( _getResxValue( 'LblAmount' ), $iWGui * 0.045, $iWGui * 0.3175 )
                                  GUICtrlSetColor( $cLblAmount, $vColorSecondary )
Global $cAmount                 = GUICtrlCreateInput( 1, $iWGui * 0.1, $iWGui * 0.315, 100 )
                                  GUICtrlCreateUpdown( $cAmount )
                                  GUICtrlSetLimit( -1, 500, 1 )

Global $cLblAtPosition          = GUICtrlCreateLabel( _getResxValue( 'LblAtPosition' ), $iWGui * 0.2, $iWGui * 0.3175 )
                                  GUICtrlSetColor( $cLblAtPosition, $vColorSecondary )
Global $cAtPosition             = GUICtrlCreateInput( 1, $iWGui * 0.255, $iWGui * 0.315, 100 )
                                  GUICtrlCreateUpdown( $cAtPosition )
                                  GUICtrlSetLimit( -1, 500, 1 )

; listview
Global $hListView               = GUICtrlCreateListView( '', $iWGui * 0.36, $iWGui * 0.057, $iWGui * 0.61, $iHGui * 0.83, $vListViewStyle, $vListViewExStyle )
                                  GUICtrlSetFont( $hListView, 10, 400, 0, 'Consolas' )
                                  _GUICtrlListView_AddColumn( $hListView, $sListViewColumnText, $iWGui * 0.8 )

; tooltip
GUICtrlSetTip( $cBtnChooseFolder,            _getResxValue( 'BtnChooseFolder' ) )
GUICtrlSetTip( $cBtnUndo,                    _getResxValue( 'BtnUndo' ) )
GUICtrlSetTip( $cBtnRedo,                    _getResxValue( 'BtnRedo' ) )
GUICtrlSetTip( $cBtnPreview,                 _getResxValue( 'BtnPreview' ) )
GUICtrlSetTip( $cBtnReset,                   _getResxValue( 'BtnReset' ) )
GUICtrlSetTip( $cBtnRename,                  _getResxValue( 'BtnRename' ) )
GUICtrlSetTip( $cBtnMinimize,                _getResxValue( 'BtnMinimize' ) )
GUICtrlSetTip( $cBtnClose,                   _getResxValue( 'BtnClose' ) )

; cursor
GUICtrlSetCursor( $cLblProgram,              9 )
GUICtrlSetCursor( $cBtnChooseFolder,         0 )
GUICtrlSetCursor( $cBtnUndo,                 0 )
GUICtrlSetCursor( $cBtnRedo,                 0 )
GUICtrlSetCursor( $cBtnPreview,              0 )
GUICtrlSetCursor( $cBtnReset,                0 )
GUICtrlSetCursor( $cBtnRename,               0 )
GUICtrlSetCursor( $cBtnMinimize,             0 )
GUICtrlSetCursor( $cBtnClose,                0 )
GUICtrlSetCursor( $cBtnRdoNumeration,        0 )
GUICtrlSetCursor( $cBtnRdoSearchAndReplace,  0 )
GUICtrlSetCursor( $cBtnCbxSearchAndReplace,  0 )
GUICtrlSetCursor( $cBtnRdoPasteCharacters,   0 )
GUICtrlSetCursor( $cBtnRdoMoveCharacter,     0 )
GUICtrlSetCursor( $cBtnRdoDeleteCharacters,  0 )

; button image
_loadGuiIcon( $cBtnChooseFolder,             'open' )
_loadGuiIcon( $cBtnUndo,                     'undo_disable' )
_loadGuiIcon( $cBtnRedo,                     'redo_disable' )
_loadGuiIcon( $cBtnPreview,                  'preview_disable' )
_loadGuiIcon( $cBtnReset,                    'reset_disable' )
_loadGuiIcon( $cBtnRename,                   'save_disable' )
_loadGuiIcon( $cBtnMinimize,                 'minimize' )
_loadGuiIcon( $cBtnClose,                    'close' )
_loadGuiIcon( $cBtnRdoNumeration,            'radioButtonUnchecked' )
_loadGuiIcon( $cBtnRdoSearchAndReplace,      'radioButtonUnchecked' )
_loadGuiIcon( $cBtnCbxSearchAndReplace,      'checkboxUnchecked', $iButtons / 1.6, $iButtons / 1.6 )
_loadGuiIcon( $cBtnRdoPasteCharacters,       'radioButtonUnchecked' )
_loadGuiIcon( $cBtnRdoMoveCharacter,         'radioButtonUnchecked' )
_loadGuiIcon( $cBtnRdoDeleteCharacters,      'radioButtonUnchecked' )

; register hover action
_onHoverRegister( $cBtnChooseFolder,         '_mouseover', '_mouseleave' )
_onHoverRegister( $cBtnUndo,                 '_mouseover', '_mouseleave' )
_onHoverRegister( $cBtnRedo,                 '_mouseover', '_mouseleave' )
_onHoverRegister( $cBtnPreview,              '_mouseover', '_mouseleave' )
_onHoverRegister( $cBtnReset,                '_mouseover', '_mouseleave' )
_onHoverRegister( $cBtnRename,               '_mouseover', '_mouseleave' )
_onHoverRegister( $cBtnMinimize,             '_mouseover', '_mouseleave' )
_onHoverRegister( $cBtnClose,                '_mouseover', '_mouseleave' )

; disable
_disableAllInputs()

GUISetState( @SW_SHOW, $hMainGui )
