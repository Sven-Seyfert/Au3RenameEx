OnAutoItExitRegister('_DisposeAndExit')

HotKeySet('^o', '_OpenFolderHotKey')
HotKeySet('^z', '_UndoRenameFilesHotKey')
HotKeySet('^y', '_RedoRenameFilesHotKey')
HotKeySet('^p', '_PreviewFilesHotKey')
HotKeySet('^r', '_ResetPreviewHotKey')
HotKeySet('^s', '_RenameFilesHotKey')

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
Global $bIsBtnRdoTimestampEnabled

Global $bSectionNumeration
Global $bSectionSearchAndReplace
Global $bSectionPasteCharacters
Global $bSectionMoveCharacter
Global $bSectionDeleteCharacters
Global $bSectionRegExReplace
Global $bSectionTimestamp
