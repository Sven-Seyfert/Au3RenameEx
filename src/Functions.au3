Func _DisposeAndExit()
    OnAutoItExitUnRegister('_DisposeAndExit')

    For $i = 0 To 50 Step 1
        FileDelete(_RenameFilenameWithNumber($i))
    Next

    GUIDelete($hMainGui)
    Exit
EndFunc

Func _CreateIniConfigFile()
    _WriteFile($aFile[$eConfig], '[' & $sSectionName & ']')
EndFunc

Func _RenameFilenameWithNumber($iNumber)
    Return StringReplace($aFile[$eSaveForUndo], '_.txt', '_' & $iNumber & '.txt')
EndFunc

Func _GetChosenFolderPath()
    If $sFolderList == '' Then
        _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxWarningNoFolder'))
        _DefaultState()

        Return False
    EndIf

    Local $aFolderList = StringSplit($sFolderList, @LF, 1)
    _ArraySort($aFolderList)

    Return $aFolderList
EndFunc

Func _UncheckAllRadioButtons()
    $bSectionNumeration               = False
    $bSectionSearchAndReplace         = False
    $bSectionPasteCharacters          = False
    $bSectionMoveCharacter            = False
    $bSectionDeleteCharacters         = False
    $bSectionRegExReplace             = False
    $bSectionTimestamp                = False

    $bIsBtnCbxSearchAndReplaceEnabled = False

    _LoadGuiIcon($cBtnRdoNumeration,       'radioButtonUnchecked')
    _LoadGuiIcon($cBtnRdoSearchAndReplace, 'radioButtonUnchecked')
    _LoadGuiIcon($cBtnRdoPasteCharacters,  'radioButtonUnchecked')
    _LoadGuiIcon($cBtnRdoMoveCharacter,    'radioButtonUnchecked')
    _LoadGuiIcon($cBtnRdoDeleteCharacters, 'radioButtonUnchecked')
    _LoadGuiIcon($cBtnRdoRegExReplace,     'radioButtonUnchecked')
    _LoadGuiIcon($cBtnRdoTimestamp,        'radioButtonUnchecked')

    _LoadGuiIcon($cBtnCbxSearchAndReplace, 'checkboxUnchecked', $iButtons / 1.6, $iButtons / 1.6)
EndFunc

Func _DisableAllInputs()
    _Disable($cNumerationStart)
    _Disable($cNumerationDigits)
    _Disable($cSearch)
    _Disable($cReplace)
    _Disable($cText)
    _Disable($cPosition)
    _Disable($cFromPos)
    _Disable($cToPos)
    _Disable($cAmount)
    _Disable($cAtPosition)
    _Disable($cPattern)
    _Disable($cReplaceRegEx)
    _Disable($cProperty)
EndFunc

Func _EnableNumeration()
    $bSectionNumeration   = True
    $bIsBtnPreviewEnabled = True

    _Enable($cNumerationStart)
    _Enable($cNumerationDigits)
EndFunc

Func _EnableSearchAndReplace()
    $bSectionSearchAndReplace         = True
    $bIsBtnPreviewEnabled             = True
    $bIsBtnCbxSearchAndReplaceEnabled = True

    _Enable($cSearch)
    _Enable($cReplace)
EndFunc

Func _EnablePasteCharacters()
    $bSectionPasteCharacters = True
    $bIsBtnPreviewEnabled    = True

    _Enable($cText)
    _Enable($cPosition)
EndFunc

Func _EnableMoveCharacter()
    $bSectionMoveCharacter = True
    $bIsBtnPreviewEnabled  = True

    _Enable($cFromPos)
    _Enable($cToPos)
EndFunc

Func _EnableDeleteCharacters()
    $bSectionDeleteCharacters = True
    $bIsBtnPreviewEnabled     = True

    _Enable($cAmount)
    _Enable($cAtPosition)
EndFunc

Func _EnableRegExReplace()
    $bSectionRegExReplace = True
    $bIsBtnPreviewEnabled = True

    _Enable($cPattern)
    _Enable($cReplaceRegEx)
EndFunc

Func _EnableTimestamp()
    $bSectionTimestamp    = True
    $bIsBtnPreviewEnabled = True

    _Enable($cProperty)
EndFunc

Func _SetBooleansToFalse()
    $bIsBtnUndoEnabled                = False
    $bIsBtnRedoEnabled                = False
    $bIsBtnPreviewEnabled             = False
    $bIsBtnResetEnabled               = False
    $bIsBtnRenameEnabled              = False

    $bIsBtnRdoNumerationEnabled       = False
    $bIsBtnRdoSearchAndReplaceEnabled = False
    $bIsBtnCbxSearchAndReplaceEnabled = False
    $bIsBtnCbxSearchAndReplaceSet     = False
    $bIsBtnRdoPasteCharactersEnabled  = False
    $bIsBtnRdoMoveCharacterEnabled    = False
    $bIsBtnRdoDeleteCharactersEnabled = False
    $bIsBtnRdoRegExReplaceEnabled     = False
    $bIsBtnRdoTimestampEnabled        = False

    $bSectionNumeration               = False
    $bSectionSearchAndReplace         = False
    $bSectionPasteCharacters          = False
    $bSectionMoveCharacter            = False
    $bSectionDeleteCharacters         = False
    $bSectionRegExReplace             = False
    $bSectionTimestamp                = False
EndFunc

Func _DefaultState()
    _UncheckAllRadioButtons()
    _DisableAllInputs()

    _GUICtrlListView_DeleteAllItems($hListView)
    _GUICtrlListView_SetColumn($hListView, 0, $aListView[$eColumnOneText])

    _SetBooleansToFalse()

    _LoadGuiIcon($cBtnUndo,    'undo_disable')
    _LoadGuiIcon($cBtnRedo,    'redo_disable')
    _LoadGuiIcon($cBtnPreview, 'preview_disable')
    _LoadGuiIcon($cBtnReset,   'reset_disable')
    _LoadGuiIcon($cBtnRename,  'save_disable')
EndFunc

Func _GetFolderContentAsFileList($sPath, $sFileExtensionFilter = '*')
    Local $aList = _FileListToArray(StringReplace($sPath, @CR, ''), $sFileExtensionFilter, 1, True)
    If Not IsArray($aList) Then
        Local $sFolder  = StringRegExpReplace($sPath, '.+\\', '')
        Local $sMessage = StringTrimRight(_GetResxValue('MsgBoxWarningNoFolderContent'), 1) & ' "' & $sFolder & '".'

        _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), $sMessage)

        Return False
    EndIf

    _ArrayDelete($aList, 0)
    Return $aList
EndFunc

Func _SaveFileList($aList)
    Local $sList     = _ArrayToString($aList, @CRLF)
    Local $iUndoStep = _ReadIni('UndoStep')

    _WriteFile(_RenameFilenameWithNumber($iUndoStep), $sList)
EndFunc

Func _FillListView($aList)
    _GUICtrlListView_DeleteAllItems($hListView)
    For $i = 0 To UBound($aList) - 1 Step 1
        _GUICtrlListView_AddItem($hListView, _GetJustFileName($aList[$i]))
        _GUICtrlListView_AddSubItem($hListView, $i, _GetJustPathOfFile($aList[$i]), 1)
    Next
EndFunc

Func _AreInputsValidNumeration($iStart, $iDigits)
    If Not StringRegExp($iStart,  '^\d{1,}$', 0) Then Return -1
    If Not StringRegExp($iDigits, '^\d{1,}$', 0) Then Return -1

    If $iStart < 1    Then Return -2
    If $iStart > 5000 Then Return -2

    If $iDigits < 1   Then Return -3
    If $iDigits > 4   Then Return -3

    Return 0
EndFunc

Func _AreInputsValidSearchAndReplace($sSearch, $sReplace)
    If $sSearch == '' Then Return -1
    If _ExistsSpecialCharacters($sReplace) Then Return -2

    Return 0
EndFunc

Func _AreInputsValidPasteCharacters($sText, $iPosition)
    If Not StringRegExp($iPosition,  '^\d{1,}$', 0) Then Return -1

    If _ExistsSpecialCharacters($sText) Then Return -2

    If $iPosition < 0   Then Return -3
    If $iPosition > 500 Then Return -3

    Return 0
EndFunc

Func _AreInputsValidMoveCharacter($iFromPos, $iToPos)
    If Not StringRegExp($iFromPos,  '^\d{1,}$', 0) Then Return -1
    If Not StringRegExp($iToPos,  '^\d{1,}$', 0)   Then Return -1

    If $iFromPos < 1   Then Return -2
    If $iFromPos > 500 Then Return -2

    If $iToPos < 0   Then Return -3
    If $iToPos > 500 Then Return -3

    Return 0
EndFunc

Func _AreInputsValidDeleteCharacters($iAmount, $iAtPosition)
    If Not StringRegExp($iAmount,  '^\d{1,}$', 0) Then Return -1
    If Not StringRegExp($iAtPosition,  '^\d{1,}$', 0)   Then Return -1

    If $iAmount < 1   Then Return -2
    If $iAmount > 500 Then Return -2

    If $iAtPosition < 1   Then Return -3
    If $iAtPosition > 500 Then Return -3

    Return 0
EndFunc

Func _AreInputsValidRegExReplace($sPattern, $sReplaceRegEx)
    If $sPattern == '' Then Return -1
    If _ExistsSpecialCharacters($sReplaceRegEx) Then Return -2

    Return 0
EndFunc

Func _IsInputValidTimestamp($sProperty)
    If $sProperty == '' Then Return -1
    Local $aProperty = _StringBetween($sProperty, '"', '"')
    If Not IsArray($aProperty) Then Return -2

    Return 0
EndFunc

Func _ExistsSpecialCharacters($sString)
    If StringInStr($sString, '\') <> 0 Then Return True
    If StringInStr($sString, '/') <> 0 Then Return True
    If StringInStr($sString, ':') <> 0 Then Return True
    If StringInStr($sString, '*') <> 0 Then Return True
    If StringInStr($sString, '?') <> 0 Then Return True
    If StringInStr($sString, '"') <> 0 Then Return True
    If StringInStr($sString, '<') <> 0 Then Return True
    If StringInStr($sString, '>') <> 0 Then Return True
    If StringInStr($sString, '|') <> 0 Then Return True
    Return False
EndFunc

Func _MoveCharInString($sString, $iFrom, $iTo)
    Local $sCharsOfString  = StringMid($sString, $iFrom, 1)
    Local $iLengthOfString = StringLen($sString)
    Local $sNewString      = StringLeft($sString, $iFrom - 1) & StringRight($sString, $iLengthOfString - $iFrom)

    Return StringLeft($sNewString, $iTo - 1) & $sCharsOfString & StringRight($sNewString, $iLengthOfString - $iTo)
EndFunc

Func _LoadFromFileContent($iNumber)
    _WriteIni('UndoStep', $iNumber)

    Local $sList = _GetFileContent(_RenameFilenameWithNumber($iNumber))
    Local $aList = StringSplit($sList, @CRLF, 1)

    _ArrayDelete($aList, 0)

    _SaveFileList($aList)
    _FillListView($aList)

    Return $aList
EndFunc

Func _RenameFilesPhysically($aOldList, $aNewList)
    For $i = 0 To UBound($aOldList) - 1 Step 1
        Local $sFromFile = $aOldList[$i]
        Local $sToFile   = $aNewList[$i]
        FileMove($sFromFile, $sToFile, 1)
    Next

    $aFileList = $aNewList
EndFunc

Func _ShowPreview()
    _FillListView($aEdit)

    $bIsBtnResetEnabled  = True
    $bIsBtnRenameEnabled = True

    _LoadGuiIcon($cBtnReset,  'reset')
    _LoadGuiIcon($cBtnRename, 'save')
EndFunc

Func _DoNumeration($aList)
    Local $iStart  = _ReadInput($cNumerationStart)
    Local $iDigits = _ReadInput($cNumerationDigits)

    Local $iReturn = _AreInputsValidNumeration($iStart, $iDigits)
    If $iReturn   == -1 Then Return -1
    If $iReturn   == -2 Then Return -2
    If $iReturn   == -3 Then Return -3

    For $i = 0 To UBound($aList) - 1 Step 1
        Local $sPath = _GetJustPathOfFile($aList[$i])
        Local $sFile = _GetJustFileName($aList[$i])
        $aList[$i]   = $sPath & _SetZeroPrefix($iStart + $i, $iDigits) & $iStart + $i & ' ' & $sFile
    Next

    $aEdit = $aList
    Return True
EndFunc

Func _DoSearchAndReplace($aList)
    Local $sSearch  = _ReadInput($cSearch)
    Local $sReplace = _ReadInput($cReplace)

    Local $iReturn  = _AreInputsValidSearchAndReplace($sSearch, $sReplace)
    If $iReturn    == -1 Then Return -1
    If $iReturn    == -2 Then Return -2

    For $i = 0 To UBound($aList) - 1 Step 1
        Local $sPath = _GetJustPathOfFile($aList[$i])
        Local $sFile = _GetJustFileName($aList[$i])
        If Not $bIsBtnCbxSearchAndReplaceSet Then $aList[$i] = $sPath & StringReplace($sFile, $sSearch, $sReplace)
        If $bIsBtnCbxSearchAndReplaceSet     Then $aList[$i] = $sPath & StringReplace($sFile, $sSearch, $sReplace, 0, 1)
    Next

    $aEdit = $aList

    Return True
EndFunc

Func _DoPasteCharacters($aList)
    Local $sText     = _ReadInput($cText)
    Local $iPosition = _ReadInput($cPosition)

    Local $iReturn   = _AreInputsValidPasteCharacters($sText, $iPosition)
    If $iReturn     == -1 Then Return -1
    If $iReturn     == -2 Then Return -2
    If $iReturn     == -3 Then Return -3

    For $i = 0 To UBound($aList) - 1 Step 1
        Local $sPath   = _GetJustPathOfFile($aList[$i])
        Local $sFile   = _GetJustFileName($aList[$i])
        Local $sPrefix = StringMid($sFile, 1, $iPosition)
        Local $sSuffix = StringTrimLeft($sFile, $iPosition)
        $aList[$i] = $sPath & $sPrefix & $sText & $sSuffix
    Next

    $aEdit = $aList

    Return True
EndFunc

Func _DoMoveCharacter($aList)
    Local $iFromPos = _ReadInput($cFromPos)
    Local $iToPos   = _ReadInput($cToPos)

    Local $iReturn  = _AreInputsValidMoveCharacter($iFromPos, $iToPos)
    If $iReturn    == -1 Then Return -1
    If $iReturn    == -2 Then Return -2
    If $iReturn    == -3 Then Return -3

    For $i = 0 To UBound($aList) - 1 Step 1
        Local $sPath = _GetJustPathOfFile($aList[$i])
        Local $sFile = _GetJustFileName($aList[$i])
        $aList[$i]   = $sPath & _MoveCharInString($sFile, $iFromPos, $iToPos)
    Next

    $aEdit = $aList

    Return True
EndFunc

Func _DoDeleteCharacters($aList)
    Local $iAmount     = _ReadInput($cAmount)
    Local $iAtPosition = _ReadInput($cAtPosition)

    Local $iReturn     = _AreInputsValidDeleteCharacters($iAmount, $iAtPosition)
    If $iReturn       == -1 Then Return -1
    If $iReturn       == -2 Then Return -2
    If $iReturn       == -3 Then Return -3

    For $i = 0 To UBound($aList) - 1 Step 1
        Local $sPath          = _GetJustPathOfFile($aList[$i])
        Local $sFile          = _GetJustFileName($aList[$i])
        Local $aCharacterList = StringSplit($sFile, '', 0)
        For $j = 1 To $iAmount Step 1
            _ArrayDelete($aCharacterList, $iAtPosition)
        Next
        $aList[$i] = $sPath & _ArrayToString($aCharacterList, '', 1)
    Next

    $aEdit = $aList

    Return True
EndFunc

Func _DoRegExReplace($aList)
    Local $sPattern      = _ReadInput($cPattern)
    Local $sReplaceRegEx = _ReadInput($cReplaceRegEx)

    Local $iReturn       = _AreInputsValidRegExReplace($sPattern, $sReplaceRegEx)
    If $iReturn         == -1 Then Return -1
    If $iReturn         == -2 Then Return -2

    For $i = 0 To UBound($aList) - 1 Step 1
        Local $sPath = _GetJustPathOfFile($aList[$i])
        Local $sFile = _GetJustFileName($aList[$i])
        $aList[$i]   = $sPath & StringRegExpReplace($sFile, $sPattern, $sReplaceRegEx)
    Next

    $aEdit = $aList

    Return True
EndFunc

Func _DoTimestamp($aList)
    Local $sProperty = _ReadInput($cProperty)

    Local $iReturn  = _IsInputValidTimestamp($sProperty)
    If $iReturn    == -1 Then Return -1
    If $iReturn    == -2 Then Return -2

    Local $sPropertyKey = _StringBetween($sProperty, '"', '"')[0]

    FileDelete($aFile[$eLog])
    $sNoPropertyFoundMessage = ''

    For $i = 0 To UBound($aList) - 1 Step 1
        Local $sPropertyValue = _GetFilePropertyValue($aList[$i], $sPropertyKey)
        Local $sPath          = _GetJustPathOfFile($aList[$i])
        Local $sFile          = _GetJustFileName($aList[$i])
        Local $sExtension     = '.' & _GetJustFileExtension($aList[$i])

        If $sPropertyValue <> '-' Then
            $aList[$i] = $sPath & _BuildTimestamp($sPropertyKey, $sPropertyValue) & $sExtension
        Else
            $sNoPropertyFoundMessage &= _GetResxValue('NoPropertyFoundMessagePartOne') & ' "' & $sPropertyKey & '" ' & _GetResxValue('NoPropertyFoundMessagePartTwo') & ' "' & $sPath & $sFile & '".' & @CRLF
        EndIf
    Next

    If $sNoPropertyFoundMessage <> '' Then _WriteFile($aFile[$eLog], $sNoPropertyFoundMessage)

    $aEdit = $aList

    Return True
EndFunc

Func _BuildTimestamp($sKey, $sValue)
    Switch $sKey
        Case _GetResxValue('PartialTimestampRecordingDate')
            Local $iDay    = StringMid($sValue, 2, 2)
            Local $iMonth  = StringMid($sValue, 6, 2)
            Local $iYear   = StringMid($sValue, 10, 4)
            Local $iHour   = StringMid($sValue, 17, 2)
            Local $iMinute = StringMid($sValue, 20, 2)

        Case _GetResxValue('PartialTimestampChangeDate'), _GetResxValue('PartialTimestampCreationDate')
            Local $iDay    = StringMid($sValue, 1, 2)
            Local $iMonth  = StringMid($sValue, 4, 2)
            Local $iYear   = StringMid($sValue, 7, 4)
            Local $iHour   = StringMid($sValue, 12, 2)
            Local $iMinute = StringMid($sValue, 15, 2)
    EndSwitch

    If  $iDay    == $aSave[$eDay]    And _
        $iMonth  == $aSave[$eMonth]  And _
        $iYear   == $aSave[$eYear]   And _
        $iHour   == $aSave[$eHour]   And _
        $iMinute == $aSave[$eMinute] Then
        $iCounter += 1
    Else
        $iCounter = 1
    EndIf

    $aSave[$eDay]    = $iDay
    $aSave[$eMonth]  = $iMonth
    $aSave[$eYear]   = $iYear
    $aSave[$eHour]   = $iHour
    $aSave[$eMinute] = $iMinute

    Local $sDay          = $iYear & '-' & $iMonth & '-' & $iDay & ' '
    Local $sTime         = $iHour & "'" & $iMinute & "'" & _GetCounter()
    Local $sDayShortName = ' (' &_DateDayOfWeek(_DateToDayOfWeek($iYear, $iMonth, $iDay), 3) & ')'

    Return $sDay & $sTime & $sDayShortName
EndFunc

Func _GetCounter()
    If StringLen($iCounter) == 1 Then Return '0' & $iCounter
    If StringLen($iCounter) == 2 Then Return $iCounter
EndFunc

Func _OpenFolder()
    Local $aFolderList = _GetChosenFolderPath()
    If $aFolderList <> False Then
        For $i = 1 To $aFolderList[0] Step 1
            If $i == 1 Then
                $aFileList = _GetFolderContentAsFileList($aFolderList[$i])
            Else
                Local $aList = _GetFolderContentAsFileList($aFolderList[$i])
                _ArrayConcatenate($aFileList, $aList)
            EndIf
        Next

        If $aFileList <> False Then
            _SaveFileList($aFileList)
            _FillListView($aFileList)

            $bIsBtnRdoNumerationEnabled       = True
            $bIsBtnRdoSearchAndReplaceEnabled = True
            $bIsBtnRdoPasteCharactersEnabled  = True
            $bIsBtnRdoMoveCharacterEnabled    = True
            $bIsBtnRdoDeleteCharactersEnabled = True
            $bIsBtnRdoRegExReplaceEnabled     = True
            $bIsBtnRdoTimestampEnabled        = True
        EndIf
    EndIf
EndFunc

Func _UndoRenameFiles()
    If $bIsBtnUndoEnabled Then
        Local $iUndoStep = _ReadIni('UndoStep') - 1
        If $iUndoStep > -1 Then
            Local $aOldFileList = _LoadFromFileContent($iUndoStep)
            _RenameFilesPhysically($aFileList, $aOldFileList)
        EndIf

        If $iUndoStep - 1 < 0 Then
            $bIsBtnUndoEnabled = False
            _LoadGuiIcon($cBtnUndo, 'undo_disable')
        EndIf

        $bIsBtnRedoEnabled = True
        _LoadGuiIcon($cBtnRedo, 'redo')
    EndIf
EndFunc

Func _RedoRenameFiles()
    If $bIsBtnRedoEnabled Then
        Local $iUndoStep    = _ReadIni('UndoStep') + 1
        Local $aNewFileList = _LoadFromFileContent($iUndoStep)

        _RenameFilesPhysically($aFileList, $aNewFileList)

        Local $sFileContent    = _GetFileContent(_RenameFilenameWithNumber($iUndoStep + 1))
        If $sFileContent      == '' Then
            $bIsBtnRedoEnabled = False
            _LoadGuiIcon($cBtnRedo, 'redo_disable')
        EndIf

        $bIsBtnUndoEnabled = True
        _LoadGuiIcon($cBtnUndo, 'undo')
    EndIf
EndFunc

Func _PreviewFiles()
    If $bIsBtnPreviewEnabled Then
        Select
            Case $bSectionNumeration
                Local $iReturn   = _DoNumeration($aFileList)
                If $iReturn     == -1 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxOnlyNumbers'))
                ElseIf $iReturn == -2 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNumberForStart'))
                ElseIf $iReturn == -3 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNumberForDigits'))
                Else
                    _ShowPreview()
                EndIf

            Case $bSectionSearchAndReplace
                Local $iReturn   = _DoSearchAndReplace($aFileList)
                If $iReturn     == -1 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxAtLeastOneCharaterForSearch'))
                ElseIf $iReturn == -2 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNotAllowedCharaters'))
                Else
                    _ShowPreview()
                EndIf

            Case $bSectionPasteCharacters
                Local $iReturn   = _DoPasteCharacters($aFileList)
                If $iReturn     == -1 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxOnlyNumbersForPosition'))
                ElseIf $iReturn == -2 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNotAllowedCharatersText'))
                ElseIf $iReturn == -3 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNumberForPosition'))
                Else
                    _ShowPreview()
                EndIf

            Case $bSectionMoveCharacter
                Local $iReturn   = _DoMoveCharacter($aFileList)
                If $iReturn     == -1 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxOnlyNumbers'))
                ElseIf $iReturn == -2 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNumberToPosition'))
                ElseIf $iReturn == -3 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNumberFromPosition'))
                Else
                    _ShowPreview()
                EndIf

            Case $bSectionDeleteCharacters
                Local $iReturn   = _DoDeleteCharacters($aFileList)
                If $iReturn     == -1 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxOnlyNumbers'))
                ElseIf $iReturn == -2 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNumberForAmount'))
                ElseIf $iReturn == -3 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNumberForPositionOne'))
                Else
                    _ShowPreview()
                EndIf

            Case $bSectionRegExReplace
                Local $iReturn   = _DoRegExReplace($aFileList)
                If $iReturn     == -1 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxAtLeastOneCharaterForRegExPattern'))
                ElseIf $iReturn == -2 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNotAllowedCharaters'))
                Else
                    _ShowPreview()
                EndIf

            Case $bSectionTimestamp
                Local $iReturn   = _DoTimestamp($aFileList)
                If $iReturn     == -1 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxChooseAProperty'))
                ElseIf $iReturn == -2 Then
                    _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNoPropertyRecognition'))
                Else
                    _ShowPreview()
                    If $sNoPropertyFoundMessage <> '' Then _MyMsgBoxGui(_GetResxValue('MsgBoxWarning'), _GetResxValue('MsgBoxNoPropertyFound'), 'ShowLog')
                EndIf
        EndSelect
    EndIf
EndFunc

Func _ResetPreview()
    If $bIsBtnResetEnabled Then
        _FillListView($aFileList)

        $bIsBtnResetEnabled  = False
        $bIsBtnRenameEnabled = False

        _LoadGuiIcon($cBtnReset,  'reset_disable')
        _LoadGuiIcon($cBtnRename, 'save_disable')
    EndIf
EndFunc

Func _RenameFiles()
    If $bIsBtnRenameEnabled Then
        _PreviewFiles()

        _WriteIni('UndoStep', _ReadIni('UndoStep') + 1)
        _SaveFileList($aEdit)
        _FillListView($aEdit)

        _RenameFilesPhysically($aFileList, $aEdit)
        $aFileList = $aEdit

        $bIsBtnUndoEnabled   = True
        $bIsBtnRedoEnabled   = False
        $bIsBtnResetEnabled  = False
        $bIsBtnRenameEnabled = False

        _LoadGuiIcon($cBtnUndo,   'undo')
        _LoadGuiIcon($cBtnRedo,   'redo_disable')
        _LoadGuiIcon($cBtnReset,  'reset_disable')
        _LoadGuiIcon($cBtnRename, 'save_disable')
    EndIf
EndFunc
