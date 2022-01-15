@echo off
:: Project related setup
cd P:\BIKI-Mod
python tools\generate_cfgfunctions.py functions
hemtt build

:: Start Arma 3 (diag)
set "arma_path=D:\SteamLibrary\steamapps\common\Arma 3"
set arma_exe=arma3diag_x64.exe
set "mods="!Workshop\@CBA_A3;!Workshop\@Advanced Developer Tools;!Workshop\@Pythia;!Workshop\@7erra's Editing Extensions;!Workshop\@3den Enhanced;P:\BIKI-Mod""
cd /d "%arma_path%"
start %arma_exe% -debug -filePatching -noSplash -mod=%mods% -skipIntro -world=empty
exit
