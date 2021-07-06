#####

<p align="center">
    <img src="images/icon.png" width="80" />
    <h2 align="center">Welcome to <code>Au3RenameEx</code>【ツ】</h2>
</p>

![license](https://img.shields.io/badge/license-MIT-ff69b4.svg?style=flat-square&logo=spdx)
![contributors](https://img.shields.io/github/contributors/Sven-Seyfert/Au3RenameEx.svg?style=flat-square&logo=github)
![repo size](https://img.shields.io/github/repo-size/Sven-Seyfert/Au3RenameEx.svg?style=flat-square&logo=github)
![last commit](https://img.shields.io/github/last-commit/Sven-Seyfert/Au3RenameEx.svg?style=flat-square&logo=github)
![release](https://img.shields.io/github/release/Sven-Seyfert/Au3RenameEx.svg?style=flat-square&logo=github)
![os](https://img.shields.io/badge/os-windows-yellow.svg?style=flat-square&logo=windows)
![editor](https://img.shields.io/badge/editor-VSCode-blueviolet.svg?style=flat-square&logo=visual-studio-code)

[Description](#description) | [Features](#features) | [Getting started](#getting-started) | [Configuration](#configuration) | [Keyboard shortcuts](#keyboard-shortcuts) | [Contributing](#contributing) | [License](#license) | [Acknowledgements](#acknowledgements)

## Description

Au3RenameEx is a multiple files renaming tool. It's for structured renaming of files in the same way.
Common use cases are music files, audio books, ebooks or other types of collections which should be renamed.

## Features

1. Multilingualism is possible.
    - Already available languages are *en* <img src="https://github.com/lipis/flag-icon-css/blob/master/flags/4x3/gb.svg" alt="en" width="18px"/> and *de* <img src="https://github.com/lipis/flag-icon-css/blob/master/flags/4x3/de.svg" alt="de" width="18px"/>
    - Easy extendable through file `config\language.ini`

2. Simultaneously renaming of files in multiple folders are possible.

<details>
<summary>3. Numeration with several digit size</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/numeration.gif" /></p>
</details>

<details>
<summary>4. Replace characters (with case sensitive option)</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/replaceCharacter.gif" /></p>
</details>

<details>
<summary>5. Paste characters to position</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/pasteCharacter.gif" /></p>
</details>

<details>
<summary>6. Move character to position</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/moveCharacter.gif" /></p>
</details>

<details>
<summary>7. Delete characters</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/deleteCharacter.gif" /></p>
</details>

<details>
<summary>8. Replace by RegEx pattern (most powerful)</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/regexReplace.gif" /></p>
</details>

<details>
<summary>9. Timestamp as filename</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/timestampAsFilename.gif" /></p>
</details>

<details>
<summary>10. Undo and Redo your changes</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/undoRedo.gif" /></p>
</details>

<details>
<summary>11. Input exception handling prevents false renaming</summary>
<p><br><img src="https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/screenshots/inputHandling.gif" /></p>
</details>

## Getting started

#### *Preconditions*

Please ensure you have access to your default TEMP directory, because two files will be saved there.
Adjustable in `src\Declaration.au3` file.

#### *Installation*

**Variant 1 - Run the EXE**

Starting the EXE `src\Au3RenameEx.exe` which is compiled with `#AutoIt3Wrapper_UseX64=y` and `#AutoIt3Wrapper_UseUpx=n` (the default expected system is x64).

**Variant 2 - Compile it on your own**

Open file `src\Au3RenameEx.au3`, adjust the *#AutoIt3Wrapper compiler information* if you want to (for example `#AutoIt3Wrapper_UseX64=y`) and run the program or compile the program.

## Configuration

- You can adjust the language of the program by file `config\language.ini`. Just edit the key `ChosenLanguage = 'en'` to maybe 'de'.
- If you need an other language please add a new INI section in this file.
    - For example spanish (español) section `[es]` with all the key-value structure.
    - I appreciate when you share your language by pull request, thanks.

## Keyboard shortcuts

| Action        | Shortcut |
| :---          | :---     |
| Open Folder   | `Ctrl+O` |
| Undo          | `Ctrl+Z` |
| Redo          | `Ctrl+Y` |
| Preview       | `Ctrl+P` |
| Reset preview | `Ctrl+R` |
| Rename/Save   | `Ctrl+S` |

## Contributing

Just look at [CONTRIBUTING](https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/docs/CONTRIBUTING.md), thank you!

## License

Distributed under the MIT License. See [LICENSE](https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/LICENSE.md) for more information.

## Acknowledgements

- Opportunity by [GitHub](https://github.com)
- Badges by [Shields](https://shields.io)
- Utilities components by
  - [MrCreatoR](https://www.autoitscript.com/forum/files/file/179-guictrlonhover/) (UDF GuiCtrlOnHover.au3); [LICENSE](https://github.com/Sven-Seyfert/Au3RenameEx/blob/master/utilities/GuiCtrlOnHover.LICENSE.md)

##

[To the top](#)
