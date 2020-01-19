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

Func _getJustFileName( $sFilePath )
    Return StringRegExpReplace( $sFilePath, '(.+?)\\', '', 0 )
EndFunc

Func _getJustPathOfFile( $sFilePath )
    Return StringTrimRight( $sFilePath, StringLen( _getJustFileName( $sFilePath ) ) )
EndFunc

Func _getJustFileExtension( $sFileName )
    Return StringReverse( _StringBetween( StringReverse( $sFileName ), '', '.' )[0] )
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

Func _getFilePropertyValue( $sFile, $sPropertyKey )
    Local $oShellApp      = ObjCreate( 'Shell.Application' )
    Local $oFolder        = $oShellApp.NameSpace( _getJustPathOfFile( $sFile ) )
    Local $oFileName      = $oFolder.Parsename( _getJustFileName( $sFile ) )
    Local $sPropertyValue = ''

    For $i = 0 To 400 Step 1
        If $oFolder.GetDetailsOf( $oFolder.Items, $i ) == $sPropertyKey Then
            $sPropertyValue = $oFolder.GetDetailsOf( $oFileName, $i )
            ExitLoop
        EndIf
    Next

    Return $sPropertyValue == '' ? '-' : $sPropertyValue
EndFunc
