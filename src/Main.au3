#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 1.4.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, Au3RenameEx)
#pragma compile(ProductVersion, 1.4.0 - 2022-02-14)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\icons\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\build\Au3RenameEx.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt('MustDeclareVars', 1)
Global $aInst = ProcessList('Au3RenameEx.exe')
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
#include "..\utilities\GuiCtrlOnHover.au3"



; modules ----------------------------------------------------------------------
#include "Language.au3"
#include "Enum.au3"
#include "Initializer.au3"
#include "Init.au3"
#include "Gui.au3"
#include "GuiFunctions.au3"
#include "BasicFunctions.au3"
#include "Functions.au3"
#include "HotKeyFunctions.au3"



; processing -------------------------------------------------------------------
If Not FileExists($aFile[$eConfig]) Then _CreateIniConfigFile()
_WriteIni('UndoStep', 0)

While True
    Switch GUIGetMsg()
        Case -3, $cBtnClose
            If _MyMsgBoxGui(_GetResxValue('MsgBoxQuestion'), _GetResxValue('MsgBoxQuestionCloseProgram'), 'YesNo') Then _DisposeAndExit()

        Case $cBtnMinimize
            WinSetState($hMainGui, '', @SW_MINIMIZE)

        Case $cBtnChooseFolder
            _MyDragAndDropBoxGui(_GetResxValue('DragAndDropText'))
            _OpenFolder()

        Case $cBtnUndo
            _UndoRenameFiles()

        Case $cBtnRedo
            _RedoRenameFiles()

        Case $cBtnPreview
            _PreviewFiles()

        Case $cBtnReset
            _ResetPreview()

        Case $cBtnRename
            _RenameFiles()

        Case $cBtnRdoNumeration
            If $bIsBtnRdoNumerationEnabled Then
                _UncheckAllRadioButtons()
                _DisableAllInputs()
                _ResetPreview()
                _EnableNumeration()
                _LoadGuiIcon($cBtnPreview,       'preview')
                _LoadGuiIcon($cBtnRdoNumeration, 'radioButtonChecked')
            EndIf

        Case $cBtnRdoSearchAndReplace
            If $bIsBtnRdoSearchAndReplaceEnabled Then
                _UncheckAllRadioButtons()
                _DisableAllInputs()
                _ResetPreview()
                _EnableSearchAndReplace()
                _LoadGuiIcon($cBtnPreview,             'preview')
                _LoadGuiIcon($cBtnRdoSearchAndReplace, 'radioButtonChecked')
            EndIf

        Case $cBtnCbxSearchAndReplace
            If $bIsBtnCbxSearchAndReplaceEnabled Then
                If Not $bIsBtnCbxSearchAndReplaceSet Then
                    _LoadGuiIcon($cBtnCbxSearchAndReplace, 'checkboxChecked', $iButtons / 1.6, $iButtons / 1.6)
                    $bIsBtnCbxSearchAndReplaceSet = True
                Else
                    _LoadGuiIcon($cBtnCbxSearchAndReplace, 'checkboxUnchecked', $iButtons / 1.6, $iButtons / 1.6)
                    $bIsBtnCbxSearchAndReplaceSet = False
                EndIf
            EndIf

        Case $cBtnRdoPasteCharacters
            If $bIsBtnRdoPasteCharactersEnabled Then
                _UncheckAllRadioButtons()
                _DisableAllInputs()
                _ResetPreview()
                _EnablePasteCharacters()
                _LoadGuiIcon($cBtnPreview,            'preview')
                _LoadGuiIcon($cBtnRdoPasteCharacters, 'radioButtonChecked')
            EndIf

        Case $cBtnRdoMoveCharacter
            If $bIsBtnRdoMoveCharacterEnabled Then
                _UncheckAllRadioButtons()
                _DisableAllInputs()
                _ResetPreview()
                _EnableMoveCharacter()
                _LoadGuiIcon($cBtnPreview,          'preview')
                _LoadGuiIcon($cBtnRdoMoveCharacter, 'radioButtonChecked')
            EndIf

        Case $cBtnRdoDeleteCharacters
            If $bIsBtnRdoDeleteCharactersEnabled Then
                _UncheckAllRadioButtons()
                _DisableAllInputs()
                _ResetPreview()
                _EnableDeleteCharacters()
                _LoadGuiIcon($cBtnPreview,             'preview')
                _LoadGuiIcon($cBtnRdoDeleteCharacters, 'radioButtonChecked')
            EndIf

        Case $cBtnRdoRegExReplace
            If $bIsBtnRdoRegExReplaceEnabled Then
                _UncheckAllRadioButtons()
                _DisableAllInputs()
                _ResetPreview()
                _EnableRegExReplace()
                _LoadGuiIcon($cBtnPreview,         'preview')
                _LoadGuiIcon($cBtnRdoRegExReplace, 'radioButtonChecked')
            EndIf

        Case $cBtnRdoTimestamp
            If $bIsBtnRdoTimestampEnabled Then
                _UncheckAllRadioButtons()
                _DisableAllInputs()
                _ResetPreview()
                _EnableTimestamp()
                _LoadGuiIcon($cBtnPreview,      'preview')
                _LoadGuiIcon($cBtnRdoTimestamp, 'radioButtonChecked')
            EndIf
    EndSwitch
WEnd
