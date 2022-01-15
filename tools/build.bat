@echo off
pushd P:\BIKI-Mod
python tools\generate_cfgfunctions.py functions
hemtt build
popd
