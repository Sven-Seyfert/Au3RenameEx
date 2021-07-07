; compiler information for AutoIt
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\build\Au3RenameEx.exe
#AutoIt3Wrapper_Res_Description=Au3RenameEx (2021-07-07)
#AutoIt3Wrapper_Res_Fileversion=0.16
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt( 'MustDeclareVars', 1 )
Global $aInst = ProcessList( 'Au3RenameEx.exe' )
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <Date.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <GuiButton.au3>
#include <GuiConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <StaticConstants.au3>
#include <String.au3>
#include <WindowsConstants.au3>



; references -------------------------------------------------------------------
#include "Language.au3"
#include "Enum.au3"
#include "..\utilities\GuiCtrlOnHover.au3"
#include "Declaration.au3"
#include "Init.au3"
#include "Gui.au3"
#include "GuiFunctions.au3"
#include "BasicFunctions.au3"
#include "Functions.au3"
#include "HotKeyFunctions.au3"



; processing -------------------------------------------------------------------
If Not FileExists( $aFile[$eConfig] ) Then _createIniConfigFile()
_writeIni( 'UndoStep', 0 )

While 1
    Switch GUIGetMsg()
        Case -3, $cBtnClose
            If _myMsgBoxGui( _getResxValue( 'MsgBoxQuestion' ), _getResxValue( 'MsgBoxQuestionCloseProgram' ), 'YesNo' ) Then _disposeAndExit()

        Case $cBtnMinimize
            WinSetState( $hMainGui, '', @SW_MINIMIZE )

        Case $cBtnChooseFolder
            _myDragAndDropBoxGui( _getResxValue( 'DragAndDropText' ) )
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

        Case $cBtnRdoRegExReplace
            If $bIsBtnRdoRegExReplaceEnabled Then
                _uncheckAllRadioButtons()
                _disableAllInputs()
                _resetPreview()
                _enableRegExReplace()
                _loadGuiIcon( $cBtnPreview,         'preview' )
                _loadGuiIcon( $cBtnRdoRegExReplace, 'radioButtonChecked' )
            EndIf

        Case $cBtnRdoTimestamp
            If $bIsBtnRdoTimestampEnabled Then
                _uncheckAllRadioButtons()
                _disableAllInputs()
                _resetPreview()
                _enableTimestamp()
                _loadGuiIcon( $cBtnPreview,      'preview' )
                _loadGuiIcon( $cBtnRdoTimestamp, 'radioButtonChecked' )
            EndIf
    EndSwitch
WEnd
