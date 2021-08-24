Global $sDropText                  = @CRLF & _StringRepeat( ' ', 6 ) & ChrW( 0x2193 ) & @CRLF & _StringRepeat( ' ', 5 ) & ChrW( 0x203E ) & ChrW( 0x203E ) & ChrW( 0x203E )
Global $sFolderList                = ''
Global $sNoPropertyFoundMessage    = ''
Global $sProgramTitle              = 'Au3RenameEx'
Global $sSectionName               = 'SAVE'

Global $iButtons                   = 32
Global $iControlId
Global $iCounter                   = 1
Global $iGutter                    = $iButtons * 0.66

Global $vImageStyle                = 0x2000

Global $aFileList, $aEdit

Global $aGui[$iMaxEnumIndex]
       $aGui[$eWidth]              = 1300
       $aGui[$eHeight]             = 650
       $aGui[$eXPosition]          = Default
       $aGui[$eYPosition]          = Default

Global $aColor[$iMaxEnumIndex]
       $aColor[$ePrimary]          = 0x282C34
       $aColor[$eSecondary]        = 0xC3C3C3
       $aColor[$eTitleBkg]         = 0x21252B
       $aColor[$eTitleFont]        = 0x35635B

Global $aListView[$iMaxEnumIndex]
       $aListView[$eStyle]         = $LVS_SHOWSELALWAYS + $LVS_REPORT + $LVS_NOSORTHEADER
       $aListView[$eExStyle]       = $LVS_EX_GRIDLINES + $LVS_EX_FULLROWSELECT
       $aListView[$eColumnOneText] = _getResxValue( 'ListViewColumnOneText' )
       $aListView[$eColumnTwoText] = _getResxValue( 'ListViewColumnTwoText' )

Global $aPath[$iMaxEnumIndex]
       $aPath[$eImages]            = _PathFull( @ScriptDir & '..\..\images\' )

Global $aFile[$iMaxEnumIndex]
       $aFile[$eConfig]            = @TempDir & '\' & $sProgramTitle & '\config.ini'
       $aFile[$eSaveForUndo]       = @TempDir & '\' & $sProgramTitle & '\saveForUndo_.txt'
       $aFile[$eLog]               = @TempDir & '\' & $sProgramTitle & '\log.txt'

Global $aSave[$iMaxEnumIndex]
       $aSave[$eDay]               = ''
       $aSave[$eMonth]             = ''
       $aSave[$eYear]              = ''
       $aSave[$eHour]              = ''
       $aSave[$eMinute]            = ''
