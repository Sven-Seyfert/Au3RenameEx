Func _GetFileContent($sFile)
    Local $hFile        = FileOpen($sFile, 256)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc

Func _WriteFile($sFile, $sText)
    Local $hFile = FileOpen($sFile, 2 + 8 + 256)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _ReadIni($sKey)
    Return IniRead($aFile[$eConfig], $sSectionName, $sKey, '')
EndFunc

Func _WriteIni($sKey, $sValue)
    IniWrite($aFile[$eConfig], $sSectionName, $sKey, $sValue)
EndFunc

Func _GetJustFileName($sFilePath)
    Return StringRegExpReplace($sFilePath, '(.+?)\\', '', 0)
EndFunc

Func _GetJustPathOfFile($sFilePath)
    Return StringTrimRight($sFilePath, StringLen(_GetJustFileName($sFilePath)))
EndFunc

Func _GetJustFileExtension($sFileName)
    Return StringReverse(_StringBetween(StringReverse($sFileName), '', '.')[0])
EndFunc

Func _SetZeroPrefix($iNumber, $iDigits)
    Switch $iDigits
        Case 2
            If StringLen($iNumber) == 1 Then Return '0'
        Case 3
            If StringLen($iNumber) == 1 Then Return '00'
            If StringLen($iNumber) == 2 Then Return '0'
        Case 4
            If StringLen($iNumber) == 1 Then Return '000'
            If StringLen($iNumber) == 2 Then Return '00'
            If StringLen($iNumber) == 3 Then Return '0'
    EndSwitch

    Return ''
EndFunc

Func _GetFilePropertyValue($sFile, $sPropertyKey)
    Local $oShellApp      = ObjCreate('Shell.Application')
    Local $oFolder        = $oShellApp.NameSpace(_GetJustPathOfFile($sFile))
    Local $oFileName      = $oFolder.Parsename(_GetJustFileName($sFile))
    Local $sPropertyValue = ''

    For $i = 0 To 400 Step 1
        If $oFolder.GetDetailsOf($oFolder.Items, $i) == $sPropertyKey Then
            $sPropertyValue = $oFolder.GetDetailsOf($oFileName, $i)
            ExitLoop
        EndIf
    Next

    Return $sPropertyValue == '' ? '-' : $sPropertyValue
EndFunc
