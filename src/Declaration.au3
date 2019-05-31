Global $sProgramTitle           = 'Au3RenameEx'
Global $sSectionName            = 'SAVE'
Global $iButtons                = 32
Global $iGutter                 = $iButtons * 0.66
Global $vImageStyle             = 0x2000
Global $iControlId
Global $aFileList, $aEdit

Global $aGui[$iEnumVariables]
       $aGui[$eWidth]           = 1300
       $aGui[$eHeight]          = 650
       $aGui[$eXPosition]       = Default
       $aGui[$eYPosition]       = Default

Global $aColor[$iEnumVariables]
       $aColor[$ePrimary]       = 0x282C34
       $aColor[$eSecondary]     = 0xC3C3C3
       $aColor[$eTitleBkg]      = 0x21252B
       $aColor[$eTitleFont]     = 0x35635B

Global $aListView[$iEnumVariables]
       $aListView[$eStyle]      = $LVS_SHOWSELALWAYS + $LVS_REPORT + $LVS_NOSORTHEADER
       $aListView[$eExStyle]    = $LVS_EX_GRIDLINES + $LVS_EX_FULLROWSELECT
       $aListView[$eColumnText] = _getResxValue( 'ListViewColumnText' )

Global $aPath[$iEnumVariables]
       $aPath[$eImages]         = _PathFull( @ScriptDir & '..\..\images\' )
       $aPath[$eLastUsed]       = ''
       $aPath[$eChosenFolder]   = ''

Global $aFile[$iEnumVariables]
       $aFile[$eConfig]         = @TempDir & '\' & $sProgramTitle & '\' & $sProgramTitle & '_Config.ini'
       $aFile[$eSaveForUndo]    = @TempDir & '\' & $sProgramTitle & '\' & $sProgramTitle & '_SaveForUndo_.txt'
