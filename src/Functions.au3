Func _disposeAndExit()
    OnAutoItExitUnRegister( '_disposeAndExit' )

    For $i = 0 To 30 Step 1
        FileDelete( _renameFilenameWithNumber( $i ) )
    Next

    GUIDelete( $hMainGui )
    Exit
EndFunc

Func _getFileContent( $sFile )
    Local $hFile        = FileOpen( $sFile, 256 )
    Local $sFileContent = FileRead( $hFile )
    FileClose( $hFile )
    Return $sFileContent
EndFunc

Func _writeFile( $sFile, $sText )
    Local $hFile = FileOpen( $sFile, 2 + 8 + 256 )
    FileWrite( $hFile, $sText )
    FileClose( $hFile )
EndFunc

Func _readIni( $sKey )
    Return IniRead( $aFile[$eConfig], $sSectionName, $sKey, '' )
EndFunc

Func _writeIni( $sKey, $sValue )
    IniWrite( $aFile[$eConfig], $sSectionName, $sKey, $sValue )
EndFunc

Func _createIniConfigFile()
    _writeFile( $aFile[$eConfig], '[' & $sSectionName & ']' )
EndFunc

Func _renameFilenameWithNumber( $iNumber )
    Return StringReplace( $aFile[$eSaveForUndo], '_.txt', '_' & $iNumber & '.txt' )
EndFunc

Func _getChosenFolderPath( $sPath )
    $aPath[$eChosenFolder] = FileSelectFolder( _getResxValue( 'PathChosenFolder' ), $sPath )

    If $aPath[$eChosenFolder] == '' Then
        _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxWarningNoFolder' ) )
        _defaultState()
        Return False
    EndIf

    Return $aPath[$eChosenFolder]
EndFunc

Func _uncheckAllRadioButtons()
    $bSectionNumeration               = False
    $bSectionSearchAndReplace         = False
    $bSectionPasteCharacters          = False
    $bSectionMoveCharacter            = False
    $bSectionDeleteCharacters         = False
    $bSectionRegExReplace             = False
    $bIsBtnCbxSearchAndReplaceEnabled = False

    _loadGuiIcon( $cBtnRdoNumeration,       'radioButtonUnchecked' )
    _loadGuiIcon( $cBtnRdoSearchAndReplace, 'radioButtonUnchecked' )
    _loadGuiIcon( $cBtnRdoPasteCharacters,  'radioButtonUnchecked' )
    _loadGuiIcon( $cBtnRdoMoveCharacter,    'radioButtonUnchecked' )
    _loadGuiIcon( $cBtnRdoDeleteCharacters, 'radioButtonUnchecked' )
    _loadGuiIcon( $cBtnRdoRegExReplace,     'radioButtonUnchecked' )
    _loadGuiIcon( $cBtnCbxSearchAndReplace, 'checkboxUnchecked', $iButtons / 1.6, $iButtons / 1.6 )
EndFunc

Func _disableAllInputs()
    _disable( $cNumerationStart )
    _disable( $cNumerationDigits )
    _disable( $cSearch )
    _disable( $cReplace )
    _disable( $cText )
    _disable( $cPosition )
    _disable( $cFromPos )
    _disable( $cToPos )
    _disable( $cAmount )
    _disable( $cAtPosition )
    _disable( $cPattern )
    _disable( $cReplaceRegEx )
EndFunc

Func _enableNumeration()
    $bSectionNumeration   = True
    $bIsBtnPreviewEnabled = True

    _enable( $cNumerationStart )
    _enable( $cNumerationDigits )
EndFunc

Func _enableSearchAndReplace()
    $bSectionSearchAndReplace         = True
    $bIsBtnPreviewEnabled             = True
    $bIsBtnCbxSearchAndReplaceEnabled = True

    _enable( $cSearch )
    _enable( $cReplace )
EndFunc

Func _enablePasteCharacters()
    $bSectionPasteCharacters = True
    $bIsBtnPreviewEnabled    = True

    _enable( $cText )
    _enable( $cPosition )
EndFunc

Func _enableMoveCharacter()
    $bSectionMoveCharacter = True
    $bIsBtnPreviewEnabled  = True

    _enable( $cFromPos )
    _enable( $cToPos )
EndFunc

Func _enableDeleteCharacters()
    $bSectionDeleteCharacters = True
    $bIsBtnPreviewEnabled     = True

    _enable( $cAmount )
    _enable( $cAtPosition )
EndFunc

Func _enableRegExReplace()
    $bSectionRegExReplace = True
    $bIsBtnPreviewEnabled = True

    _enable( $cPattern )
    _enable( $cReplaceRegEx )
EndFunc

Func _defaultState()
    _uncheckAllRadioButtons()
    _disableAllInputs()

    _GUICtrlListView_DeleteAllItems( $hListView )
    _GUICtrlListView_SetColumn( $hListView, 0, $aListView[$eColumnText] )

    _setBooleansToFalse()

    _loadGuiIcon( $cBtnUndo,    'undo_disable' )
    _loadGuiIcon( $cBtnRedo,    'redo_disable' )
    _loadGuiIcon( $cBtnPreview, 'preview_disable' )
    _loadGuiIcon( $cBtnReset,   'reset_disable' )
    _loadGuiIcon( $cBtnRename,  'save_disable' )
EndFunc

Func _getFolderContentAsFileList( $sPath, $sFileExtensionFilter = '*' )
    Local $aList = _FileListToArray( $sPath, $sFileExtensionFilter, 1, False )

    If Not IsArray( $aList ) Then
        _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxWarningNoFolder' ) )
        Return False
    EndIf

    Return $aList
EndFunc

Func _saveFileList( $aList )
    _ArrayDelete( $aList, 0 )

    Local $sList     = _ArrayToString( $aList, @CRLF )
    Local $iUndoStep = _readIni( 'UndoStep' )

    _writeFile( _renameFilenameWithNumber( $iUndoStep ), $sList )
EndFunc

Func _fillListView( $aList )
    _GUICtrlListView_SetColumn( $hListView, 0, $aPath[$eChosenFolder] )
    _GUICtrlListView_DeleteAllItems( $hListView )

    For $i = 1 To $aList[0] Step 1
        _GUICtrlListView_AddItem( $hListView, $aList[$i] )
    Next
EndFunc

Func _areInputsValidNumeration( $iStart, $iDigits )
    If Not StringRegExp( $iStart,  '^\d{1,}$', 0 ) Then Return -1
    If Not StringRegExp( $iDigits, '^\d{1,}$', 0 ) Then Return -1

    If $iStart < 1    Then Return -2
    If $iStart > 5000 Then Return -2

    If $iDigits < 1   Then Return -3
    If $iDigits > 4   Then Return -3

    Return 0
EndFunc

Func _areInputsValidSearchAndReplace( $sSearch, $sReplace )
    If $sSearch == '' Then Return -1
    If _existsSpecialCharacters( $sReplace ) Then Return -2

    Return 0
EndFunc

Func _areInputsValidPasteCharacters( $sText, $iPosition )
    If Not StringRegExp( $iPosition,  '^\d{1,}$', 0 ) Then Return -1

    If _existsSpecialCharacters( $sText ) Then Return -2

    If $iPosition < 0   Then Return -3
    If $iPosition > 500 Then Return -3

    Return 0
EndFunc

Func _areInputsValidMoveCharacter( $iFromPos, $iToPos )
    If Not StringRegExp( $iFromPos,  '^\d{1,}$', 0 ) Then Return -1
    If Not StringRegExp( $iToPos,  '^\d{1,}$', 0 )   Then Return -1

    If $iFromPos < 1   Then Return -2
    If $iFromPos > 500 Then Return -2

    If $iToPos < 0   Then Return -3
    If $iToPos > 500 Then Return -3

    Return 0
EndFunc

Func _areInputsValidDeleteCharacters( $iAmount, $iAtPosition )
    If Not StringRegExp( $iAmount,  '^\d{1,}$', 0 ) Then Return -1
    If Not StringRegExp( $iAtPosition,  '^\d{1,}$', 0 )   Then Return -1

    If $iAmount < 1   Then Return -2
    If $iAmount > 500 Then Return -2

    If $iAtPosition < 1   Then Return -3
    If $iAtPosition > 500 Then Return -3

    Return 0
EndFunc

Func _areInputsValidRegExReplace( $sPattern, $sReplaceRegEx )
    If $sPattern == '' Then Return -1
    If _existsSpecialCharacters( $sReplaceRegEx ) Then Return -2

    Return 0
EndFunc

Func _setZeroPrefix( $iNumber, $iDigits )
    Switch $iDigits
        Case 2
            If StringLen( $iNumber ) == 1 Then Return '0'
        Case 3
            If StringLen( $iNumber ) == 1 Then Return '00'
            If StringLen( $iNumber ) == 2 Then Return '0'
        Case 4
            If StringLen( $iNumber ) == 1 Then Return '000'
            If StringLen( $iNumber ) == 2 Then Return '00'
            If StringLen( $iNumber ) == 3 Then Return '0'
    EndSwitch

    Return ''
EndFunc

Func _existsSpecialCharacters( $sString )
    If StringInStr( $sString, '\' ) <> 0 Then Return True
    If StringInStr( $sString, '/' ) <> 0 Then Return True
    If StringInStr( $sString, ':' ) <> 0 Then Return True
    If StringInStr( $sString, '*' ) <> 0 Then Return True
    If StringInStr( $sString, '?' ) <> 0 Then Return True
    If StringInStr( $sString, '"' ) <> 0 Then Return True
    If StringInStr( $sString, '<' ) <> 0 Then Return True
    If StringInStr( $sString, '>' ) <> 0 Then Return True
    If StringInStr( $sString, '|' ) <> 0 Then Return True
    Return False
EndFunc

Func _moveCharInString( $sString, $iFrom, $iTo )
    Local $sCharsOfString  = StringMid( $sString, $iFrom, 1 )
    Local $iLengthOfString = StringLen( $sString )
    Local $sNewString      = StringLeft( $sString, $iFrom - 1 ) & StringRight( $sString, $iLengthOfString - $iFrom )

    Return StringLeft( $sNewString, $iTo - 1 ) & $sCharsOfString & StringRight( $sNewString, $iLengthOfString - $iTo )
EndFunc

Func _loadFromFileContent( $iNumber )
    _writeIni( 'UndoStep', $iNumber )

    Local $sList = _getFileContent( _renameFilenameWithNumber( $iNumber ) )
    Local $aList = StringSplit( $sList, @CRLF, 1 )

    _saveFileList( $aList )
    _fillListView( $aList )

    Return $aList
EndFunc

Func _renameFilesPhysically( $aOldList, $aNewList )
    For $i = 1 To $aOldList[0] Step 1
        Local $sFromFile = $aPath[$eChosenFolder] & '\' & $aOldList[$i]
        Local $sToFile   = $aPath[$eChosenFolder] & '\' & $aNewList[$i]
        FileMove( $sFromFile, $sToFile, 1 )
    Next

    $aFileList = $aNewList
EndFunc

Func _showPreview()
    _fillListView( $aEdit )

    $bIsBtnResetEnabled  = True
    $bIsBtnRenameEnabled = True

    _loadGuiIcon( $cBtnReset,  'reset' )
    _loadGuiIcon( $cBtnRename, 'save' )
EndFunc

Func _doNumeration( $aList )
    Local $iStart  = _readInput( $cNumerationStart )
    Local $iDigits = _readInput( $cNumerationDigits )

    Local $iReturn = _areInputsValidNumeration( $iStart, $iDigits )
    If $iReturn   == -1 Then Return -1
    If $iReturn   == -2 Then Return -2
    If $iReturn   == -3 Then Return -3

    _ArrayDelete( $aList, 0 )

    For $i = 0 To UBound( $aList ) - 1 Step 1
        $aList[$i] = _setZeroPrefix( $iStart + $i, $iDigits ) & $iStart + $i & ' ' & $aList[$i]
    Next

    $aEdit = $aList
    Return True
EndFunc

Func _doSearchAndReplace( $aList )
    Local $sSearch  = _readInput( $cSearch )
    Local $sReplace = _readInput( $cReplace )

    Local $iReturn  = _areInputsValidSearchAndReplace( $sSearch, $sReplace )
    If $iReturn    == -1 Then Return -1
    If $iReturn    == -2 Then Return -2

    For $i = 1 To $aList[0] Step 1
        If Not $bIsBtnCbxSearchAndReplaceSet Then $aList[$i] = StringReplace( $aList[$i], $sSearch, $sReplace )
        If $bIsBtnCbxSearchAndReplaceSet     Then $aList[$i] = StringReplace( $aList[$i], $sSearch, $sReplace, 0, 1 )
    Next

    $aEdit = $aList
    Return True
EndFunc

Func _doPasteCharacters( $aList )
    Local $sText     = _readInput( $cText )
    Local $iPosition = _readInput( $cPosition )

    Local $iReturn   = _areInputsValidPasteCharacters( $sText, $iPosition )
    If $iReturn     == -1 Then Return -1
    If $iReturn     == -2 Then Return -2
    If $iReturn     == -3 Then Return -3

    For $i = 1 To $aList[0] Step 1
        Local $sPrefix = StringMid( $aList[$i], 1, $iPosition )
        Local $sSuffix = StringTrimLeft( $aList[$i], $iPosition )
        $aList[$i] = $sPrefix & $sText & $sSuffix
    Next

    $aEdit = $aList
    Return True
EndFunc

Func _doMoveCharacter( $aList )
    Local $iFromPos = _readInput( $cFromPos )
    Local $iToPos   = _readInput( $cToPos )

    Local $iReturn  = _areInputsValidMoveCharacter( $iFromPos, $iToPos )
    If $iReturn    == -1 Then Return -1
    If $iReturn    == -2 Then Return -2
    If $iReturn    == -3 Then Return -3

    For $i = 1 To $aList[0] Step 1
        $aList[$i] = _moveCharInString( $aList[$i], $iFromPos, $iToPos )
    Next

    $aEdit = $aList
    Return True
EndFunc

Func _doDeleteCharacters( $aList )
    Local $iAmount     = _readInput( $cAmount )
    Local $iAtPosition = _readInput( $cAtPosition )

    Local $iReturn     = _areInputsValidDeleteCharacters( $iAmount, $iAtPosition )
    If $iReturn       == -1 Then Return -1
    If $iReturn       == -2 Then Return -2
    If $iReturn       == -3 Then Return -3

    For $i = 1 To $aList[0] Step 1
        Local $aCharacterList = StringSplit( $aList[$i], '', 0 )
        For $j = 1 To $iAmount Step 1
            _ArrayDelete( $aCharacterList, $iAtPosition )
        Next
        $aList[$i] = _ArrayToString( $aCharacterList, '', 1 )
    Next

    $aEdit = $aList
    Return True
EndFunc

Func _doRegExReplace( $aList )
    Local $sPattern      = _readInput( $cPattern )
    Local $sReplaceRegEx = _readInput( $cReplaceRegEx )

    Local $iReturn       = _areInputsValidRegExReplace( $sPattern, $sReplaceRegEx )
    If $iReturn         == -1 Then Return -1
    If $iReturn         == -2 Then Return -2

    For $i = 1 To $aList[0] Step 1
        $aList[$i] = StringRegExpReplace( $aList[$i], $sPattern, $sReplaceRegEx )
    Next

    $aEdit = $aList
    Return True
EndFunc

Func _openFolder()
    $aPath[$eLastUsed]     = _readIni( 'LastUsedPath' )
    $aPath[$eChosenFolder] = _getChosenFolderPath( $aPath[$eLastUsed] )

    If $aPath[$eChosenFolder] <> False Then
        _writeIni( 'LastUsedPath', $aPath[$eChosenFolder] )

        $aFileList = _getFolderContentAsFileList( $aPath[$eChosenFolder] )
        If $aFileList <> False Then
            _saveFileList( $aFileList )
            _fillListView( $aFileList )

            $bIsBtnRdoNumerationEnabled       = True
            $bIsBtnRdoSearchAndReplaceEnabled = True
            $bIsBtnRdoPasteCharactersEnabled  = True
            $bIsBtnRdoMoveCharacterEnabled    = True
            $bIsBtnRdoDeleteCharactersEnabled = True
            $bIsBtnRdoRegExReplaceEnabled     = True
        EndIf
    EndIf
EndFunc

Func _undoRenameFiles()
    If $bIsBtnUndoEnabled Then
        Local $iUndoStep = _readIni( 'UndoStep' ) - 1
        If $iUndoStep > -1 Then
            Local $aOldFileList = _loadFromFileContent( $iUndoStep )
            _renameFilesPhysically( $aFileList, $aOldFileList )
        EndIf

        If $iUndoStep - 1 < 0 Then
            $bIsBtnUndoEnabled = False
            _loadGuiIcon( $cBtnUndo, 'undo_disable' )
        EndIf

        $bIsBtnRedoEnabled = True
        _loadGuiIcon( $cBtnRedo, 'redo' )
    EndIf
EndFunc

Func _redoRenameFiles()
    If $bIsBtnRedoEnabled Then
        Local $iUndoStep    = _readIni( 'UndoStep' ) + 1
        Local $aNewFileList = _loadFromFileContent( $iUndoStep )

        _renameFilesPhysically( $aFileList, $aNewFileList )

        Local $sFileContent    = _getFileContent( _renameFilenameWithNumber( $iUndoStep + 1 ) )
        If $sFileContent      == '' Then
            $bIsBtnRedoEnabled = False
            _loadGuiIcon( $cBtnRedo, 'redo_disable' )
        EndIf

        $bIsBtnUndoEnabled = True
        _loadGuiIcon( $cBtnUndo, 'undo' )
    EndIf
EndFunc

Func _previewFiles()
    If $bIsBtnPreviewEnabled Then
        Select
            Case $bSectionNumeration
                Local $iReturn   = _doNumeration( $aFileList )
                If $iReturn     == -1 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxOnlyNumbers' ) )
                ElseIf $iReturn == -2 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNumberForStart' ) )
                ElseIf $iReturn == -3 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNumberForDigits' ) )
                Else
                    _ArrayInsert( $aEdit, 0, UBound( $aEdit ) )
                    _showPreview()
                EndIf

            Case $bSectionSearchAndReplace
                Local $iReturn   = _doSearchAndReplace( $aFileList )
                If $iReturn     == -1 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxAtLeastOneCharaterForSearch' ) )
                ElseIf $iReturn == -2 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNotAllowedCharaters' ) )
                Else
                    _showPreview()
                EndIf

            Case $bSectionPasteCharacters
                Local $iReturn   = _doPasteCharacters( $aFileList )
                If $iReturn     == -1 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxOnlyNumbersForPosition' ) )
                ElseIf $iReturn == -2 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNotAllowedCharatersText' ) )
                ElseIf $iReturn == -3 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNumberForPosition' ) )
                Else
                    _showPreview()
                EndIf

            Case $bSectionMoveCharacter
                Local $iReturn   = _doMoveCharacter( $aFileList )
                If $iReturn     == -1 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxOnlyNumbers' ) )
                ElseIf $iReturn == -2 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNumberToPosition' ) )
                ElseIf $iReturn == -3 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNumberFromPosition' ) )
                Else
                    _showPreview()
                EndIf

            Case $bSectionDeleteCharacters
                Local $iReturn   = _doDeleteCharacters( $aFileList )
                If $iReturn     == -1 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxOnlyNumbers' ) )
                ElseIf $iReturn == -2 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNumberForAmount' ) )
                ElseIf $iReturn == -3 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNumberForPositionOne' ) )
                Else
                    _showPreview()
                EndIf

            Case $bSectionRegExReplace
                Local $iReturn   = _doRegExReplace( $aFileList )
                If $iReturn     == -1 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxAtLeastOneCharaterForRegExPattern' ) )
                ElseIf $iReturn == -2 Then
                    _myMsgBox( _getResxValue( 'MsgBoxWarning' ), _getResxValue( 'MsgBoxNotAllowedCharaters' ) )
                Else
                    _showPreview()
                EndIf
        EndSelect
    EndIf
EndFunc

Func _resetPreview()
    If $bIsBtnResetEnabled Then
        _fillListView( $aFileList )

        $bIsBtnResetEnabled  = False
        $bIsBtnRenameEnabled = False

        _loadGuiIcon( $cBtnReset,  'reset_disable' )
        _loadGuiIcon( $cBtnRename, 'save_disable' )
    EndIf
EndFunc

Func _renameFiles()
    If $bIsBtnRenameEnabled Then
        _previewFiles()

        _writeIni( 'UndoStep', _readIni( 'UndoStep' ) + 1 )
        _saveFileList( $aEdit )
        _fillListView( $aEdit )

        _renameFilesPhysically( $aFileList, $aEdit )
        $aFileList = $aEdit

        $bIsBtnUndoEnabled   = True
        $bIsBtnRedoEnabled   = False
        $bIsBtnResetEnabled  = False
        $bIsBtnRenameEnabled = False

        _loadGuiIcon( $cBtnUndo,   'undo' )
        _loadGuiIcon( $cBtnRedo,   'redo_disable' )
        _loadGuiIcon( $cBtnReset,  'reset_disable' )
        _loadGuiIcon( $cBtnRename, 'save_disable' )
    EndIf
EndFunc
