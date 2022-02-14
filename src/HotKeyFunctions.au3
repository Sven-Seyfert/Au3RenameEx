Func _OpenFolderHotKey()
    If _IsFocusOnGui($hMainGui) Then _OpenFolder()
EndFunc

Func _UndoRenameFilesHotKey()
    If _IsFocusOnGui($hMainGui) Then _UndoRenameFiles()
EndFunc

Func _RedoRenameFilesHotKey()
    If _IsFocusOnGui($hMainGui) Then _RedoRenameFiles()
EndFunc

Func _PreviewFilesHotKey()
    If _IsFocusOnGui($hMainGui) Then _PreviewFiles()
EndFunc

Func _ResetPreviewHotKey()
    If _IsFocusOnGui($hMainGui) Then _ResetPreview()
EndFunc

Func _RenameFilesHotKey()
    If _IsFocusOnGui($hMainGui) Then _RenameFiles()
EndFunc
