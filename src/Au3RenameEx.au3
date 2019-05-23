; compiler information for AutoIt
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\favicon.ico
#AutoIt3Wrapper_Res_Description=Au3RenameEx (2019-05-23)
#AutoIt3Wrapper_Res_Fileversion=0.5
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; includes ---------------------------------------------------------------------
#include-once
#include <File.au3>
#include <GuiButton.au3>
#include <GuiConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "..\utilities\GuiCtrlOnHover.au3"



; opt and just singleton -------------------------------------------------------
Opt( 'MustDeclareVars', 1 )
Global $aInst = ProcessList( 'Au3RenameEx.exe' )
If $aInst[0][0] > 1 Then Exit



; declaration ------------------------------------------------------------------
Global $sProgramTitle                    = 'Au3RenameEx'
Global $iWGui                            = 1300
Global $iHGui                            = 650
Global $iXGui                            = Default
Global $iYGui                            = Default
Global $iButtons                         = 32
Global $iGutter                          = $iButtons * 0.66
Global $vImageStyle                      = 0x2000
Global $vColorPrimary                    = 0x282C34
Global $vColorSecondary                  = 0xC3C3C3
Global $vColorTitleBkg                   = 0x21252B
Global $vColorTitleFont                  = 0x35635B
Global $vListViewStyle                   = $LVS_SHOWSELALWAYS + $LVS_REPORT + $LVS_NOSORTHEADER
Global $vListViewExStyle                 = $LVS_EX_GRIDLINES + $LVS_EX_FULLROWSELECT
Global $sListViewColumnText              = 'Dateien'

Global $sPathLastUsed, $sPathChosenFolder, $aFileList, $iControlId, $aEdit

Global $sFileConfig                      = @TempDir & '\' & $sProgramTitle & '\' & $sProgramTitle & '_Config.ini'
Global $sFileSaveForUndo                 = @TempDir & '\' & $sProgramTitle & '\' & $sProgramTitle & '_SaveForUndo_.txt'
Global $sPathImages                      = _PathFull( @ScriptDir & '..\..\images\' )
Global $sSectionName                     = 'SAVE'



; references -------------------------------------------------------------------
#include "Init.au3"
#include "Gui.au3"
#include "GuiFunctions.au3"
#include "Functions.au3"
#include "HotKeyFunctions.au3"



; processing -------------------------------------------------------------------
If Not FileExists( $sFileConfig ) Then _createIniConfigFile()
_writeIni( 'UndoStep', 0 )

While 1
    Switch GUIGetMsg()
        Case -3, $cBtnClose
            If _myMsgBox( 'Frage', 'Soll das Programm wirklich beendet werden?', 'YesNo' ) Then _disposeAndExit()

        Case $cBtnMinimize
            WinSetState( $hMainGui, '', @SW_MINIMIZE )

        Case $cBtnChooseFolder
            _openFolder()

        Case $cBtnUndo
            _undoRenameFiles()

        Case $cBtnRedo
            _redoRenameFiles()

        Case $cBtnPreview
            _previewFiles()

        Case $cBtnReset
            _resetPreview()

        Case $cBtnRename
            _renameFiles()

        Case $cBtnRdoNumeration
            If $bIsBtnRdoNumerationEnabled Then
                _uncheckAllRadioButtons()
                _disableAllInputs()
                _resetPreview()
                _enableNumeration()
                _loadGuiIcon( $cBtnPreview,       'preview' )
                _loadGuiIcon( $cBtnRdoNumeration, 'radioButtonChecked' )
            EndIf

        Case $cBtnRdoSearchAndReplace
            If $bIsBtnRdoSearchAndReplaceEnabled Then
                _uncheckAllRadioButtons()
                _disableAllInputs()
                _resetPreview()
                _enableSearchAndReplace()
                _loadGuiIcon( $cBtnPreview,             'preview' )
                _loadGuiIcon( $cBtnRdoSearchAndReplace, 'radioButtonChecked' )
            EndIf

        Case $cBtnCbxSearchAndReplace
            If $bIsBtnCbxSearchAndReplaceEnabled Then
                If Not $bIsBtnCbxSearchAndReplaceSet Then
                    _loadGuiIcon( $cBtnCbxSearchAndReplace, 'checkboxChecked', $iButtons / 1.6, $iButtons / 1.6 )
                    $bIsBtnCbxSearchAndReplaceSet = True
                Else
                    _loadGuiIcon( $cBtnCbxSearchAndReplace, 'checkboxUnchecked', $iButtons / 1.6, $iButtons / 1.6 )
                    $bIsBtnCbxSearchAndReplaceSet = False
                EndIf
            EndIf

        Case $cBtnRdoPasteCharacters
            If $bIsBtnRdoPasteCharactersEnabled Then
                _uncheckAllRadioButtons()
                _disableAllInputs()
                _resetPreview()
                _enablePasteCharacters()
                _loadGuiIcon( $cBtnPreview,            'preview' )
                _loadGuiIcon( $cBtnRdoPasteCharacters, 'radioButtonChecked' )
            EndIf

        Case $cBtnRdoMoveCharacter
            If $bIsBtnRdoMoveCharacterEnabled Then
                _uncheckAllRadioButtons()
                _disableAllInputs()
                _resetPreview()
                _enableMoveCharacter()
                _loadGuiIcon( $cBtnPreview,          'preview' )
                _loadGuiIcon( $cBtnRdoMoveCharacter, 'radioButtonChecked' )
            EndIf

        Case $cBtnRdoDeleteCharacters
            If $bIsBtnRdoDeleteCharactersEnabled Then
                _uncheckAllRadioButtons()
                _disableAllInputs()
                _resetPreview()
                _enableDeleteCharacters()
                _loadGuiIcon( $cBtnPreview,             'preview' )
                _loadGuiIcon( $cBtnRdoDeleteCharacters, 'radioButtonChecked' )
            EndIf
    EndSwitch
WEnd
