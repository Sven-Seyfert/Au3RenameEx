Global $sFileConfigLanguage = '..\config\language.ini'

_setUnicodeFile( $sFileConfigLanguage )

Global $sChosenLanguage = IniRead( $sFileConfigLanguage, 'language', 'ChosenLanguage', 'eng' )
Global $aLanguageValues = IniReadSection( $sFileConfigLanguage, $sChosenLanguage )

Func _setUnicodeFile( $sFile )
    Local $iEncoding = FileGetEncoding( $sFile )
    If Not ( $iEncoding = $FO_UNICODE ) Then
        Local $sData = _getFile( $sFile, $iEncoding )
        _setFile( $sData, $sFile, $FO_APPEND + $FO_UNICODE )
    EndIf
EndFunc

Func _getFile( $sFile, $sFormat = $FO_READ )
    Local $hFile = FileOpen( $sFile, $sFormat )
    Local $sData = FileRead( $hFile )
    FileClose( $hFile )
    Return $sData
EndFunc

Func _setFile( $sString, $sFile, $iOverwrite = $FO_READ )
    Local $hFile = FileOpen( $sFile, $iOverwrite + $FO_APPEND )
    FileWrite( $hFile, $sString )
    FileClose( $hFile )
EndFunc

Func _getResxValue( $sKey )
    For $i = 1 To $aLanguageValues[0][0] Step 1
        If $aLanguageValues[$i][0] == 'Resx' & $sKey Then
            Local $sLanguageValue = $aLanguageValues[$i][1]
            Return StringTrimRight( StringTrimLeft( $sLanguageValue, 1 ), 1 )
        EndIf
    Next
    Return '-'
EndFunc
