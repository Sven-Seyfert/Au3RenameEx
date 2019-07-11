OnAutoItExitRegister( '_disposeAndExit' )

HotKeySet( '^o', '_openFolderHotKey' )
HotKeySet( '^z', '_undoRenameFilesHotKey' )
HotKeySet( '^y', '_redoRenameFilesHotKey' )
HotKeySet( '^p', '_previewFilesHotKey' )
HotKeySet( '^r', '_resetPreviewHotKey' )
HotKeySet( '^s', '_renameFilesHotKey' )

Global $bIsBtnUndoEnabled
Global $bIsBtnRedoEnabled
Global $bIsBtnPreviewEnabled
Global $bIsBtnResetEnabled
Global $bIsBtnRenameEnabled
Global $bIsBtnRdoNumerationEnabled
Global $bIsBtnRdoSearchAndReplaceEnabled
Global $bIsBtnCbxSearchAndReplaceEnabled
Global $bIsBtnCbxSearchAndReplaceSet
Global $bIsBtnRdoPasteCharactersEnabled
Global $bIsBtnRdoMoveCharacterEnabled
Global $bIsBtnRdoDeleteCharactersEnabled
Global $bIsBtnRdoRegExReplaceEnabled

Global $bSectionNumeration
Global $bSectionSearchAndReplace
Global $bSectionPasteCharacters
Global $bSectionMoveCharacter
Global $bSectionDeleteCharacters
Global $bSectionRegExReplace

Func _setBooleansToFalse()
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

    $bSectionNumeration               = False
    $bSectionSearchAndReplace         = False
    $bSectionPasteCharacters          = False
    $bSectionMoveCharacter            = False
    $bSectionDeleteCharacters         = False
    $bSectionRegExReplace             = False
EndFunc
