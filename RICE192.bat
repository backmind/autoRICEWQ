@echo off
set /p halt= "Halt on errors (y/n) (default = y): "
python.exe RICE192.py %halt%
pause