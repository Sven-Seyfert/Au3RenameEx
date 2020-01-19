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
Global $bIsBtnRdoTimestampEnabled

Global $bSectionNumeration
Global $bSectionSearchAndReplace
Global $bSectionPasteCharacters
Global $bSectionMoveCharacter
Global $bSectionDeleteCharacters
Global $bSectionRegExReplace
Global $bSectionTimestamp
