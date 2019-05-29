; compiler information for AutoIt
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\favicon.ico
#AutoIt3Wrapper_Res_Description=Au3RenameEx (2019-05-29)
#AutoIt3Wrapper_Res_Fileversion=0.6
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
#include "Language.au3"
#include "..\utilities\GuiCtrlOnHover.au3"



; opt and just singleton -------------------------------------------------------
Opt( 'MustDeclareVars', 1 )
Global $aInst = ProcessList( 'Au3RenameEx.exe' )
If $aInst[0][0] > 1 Then Exit



; declaration ------------------------------------------------------------------
Global $sProgramTitle           = 'Au3RenameEx'
Global $iButtons                = 32
Global $iGutter                 = $iButtons * 0.66
Global $vImageStyle             = 0x2000
Global $sSectionName            = 'SAVE'
Global $aFileList, $iControlId, $aEdit

Global Enum $eWidth, $eHeight, $eXPosition, $eYPosition
Global $aGui[4]
       $aGui[$eWidth]           = 1300
       $aGui[$eHeight]          = 650
       $aGui[$eXPosition]       = Default
       $aGui[$eYPosition]       = Default

Global Enum $ePrimary, $eSecondary, $eTitleBkg, $eTitleFont
Global $aColor[4]
       $aColor[$ePrimary]       = 0x282C34
       $aColor[$eSecondary]     = 0xC3C3C3
       $aColor[$eTitleBkg]      = 0x21252B
       $aColor[$eTitleFont]     = 0x35635B

Global Enum $eStyle, $eExStyle, $eColumnText
Global $aListView[3]
       $aListView[$eStyle]      = $LVS_SHOWSELALWAYS + $LVS_REPORT + $LVS_NOSORTHEADER
       $aListView[$eExStyle]    = $LVS_EX_GRIDLINES + $LVS_EX_FULLROWSELECT
       $aListView[$eColumnText] = _getResxValue( 'ListViewColumnText' )

Global Enum $eLastUsed, $eChosenFolder, $eImages
Global $aPath[3]
       $aPath[$eImages]         = _PathFull( @ScriptDir & '..\..\images\' )
       $aPath[$eLastUsed]       = ''
       $aPath[$eChosenFolder]   = ''

Global Enum $eConfig, $eSaveForUndo
Global $aFile[2]
       $aFile[$eConfig]         = @TempDir & '\' & $sProgramTitle & '\' & $sProgramTitle & '_Config.ini'
       $aFile[$eSaveForUndo]    = @TempDir & '\' & $sProgramTitle & '\' & $sProgramTitle & '_SaveForUndo_.txt'



; references -------------------------------------------------------------------
#include "Init.au3"
#include "Gui.au3"
#include "GuiFunctions.au3"
#include "Functions.au3"
#include "HotKeyFunctions.au3"



; processing -------------------------------------------------------------------
If Not FileExists( $aFile[$eConfig] ) Then _createIniConfigFile()
_writeIni( 'UndoStep', 0 )

While 1
    Switch GUIGetMsg()
        Case -3, $cBtnClose
            If _myMsgBox( _getResxValue( 'MsgBoxQuestion' ), _getResxValue( 'MsgBoxQuestionCloseProgram' ), 'YesNo' ) Then _disposeAndExit()

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
