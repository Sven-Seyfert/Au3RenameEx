Func _openFolderHotKey()
    If _isFocusOnGui($hMainGui) Then _openFolder()
EndFunc

Func _undoRenameFilesHotKey()
    If _isFocusOnGui($hMainGui) Then _undoRenameFiles()
EndFunc

Func _redoRenameFilesHotKey()
    If _isFocusOnGui($hMainGui) Then _redoRenameFiles()
EndFunc

Func _previewFilesHotKey()
    If _isFocusOnGui($hMainGui) Then _previewFiles()
EndFunc

Func _resetPreviewHotKey()
    If _isFocusOnGui($hMainGui) Then _resetPreview()
EndFunc

Func _renameFilesHotKey()
    If _isFocusOnGui($hMainGui) Then _renameFiles()
EndFunc
