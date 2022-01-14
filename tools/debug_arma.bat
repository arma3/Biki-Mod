set "arma_path=D:\SteamLibraryM\steamapps\common\Arma 3"
set arma_exe=arma3diag_x64.exe
set "mods="!Workshop\@CBA_A3;P:\BIKI-Mod""

cd /d %arma_path%
start %arma_exe% -debug -filePatching -noSplash -mod=%mods% -skipIntro -world=empty
exit
