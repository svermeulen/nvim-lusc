@echo off
mkdir lua 2>nul
mkdir lua\lusc 2>nul
mkdir lua\lusc\internal 2>nul
set TL_BUILD=D:\svkj1\scripts\run_teal.bat
set PLUGIN_ROOT=%~dp0..\..
call %TL_BUILD% gen %PLUGIN_ROOT%\src\lusc\init.tl -o %PLUGIN_ROOT%\lua\lusc\init.lua
call %TL_BUILD% gen %PLUGIN_ROOT%\src\lusc\internal\util.tl -o %PLUGIN_ROOT%\lua\lusc\internal\util.lua
copy %PLUGIN_ROOT%\src\lusc\internal\queue.lua %PLUGIN_ROOT%\lua\lusc\internal\queue.lua
call %TL_BUILD% gen %PLUGIN_ROOT%\src\lusc\luv_async.tl -o %PLUGIN_ROOT%\lua\lusc\luv_async.lua
call %TL_BUILD% gen %PLUGIN_ROOT%\src\nvim-lusc.tl -o %PLUGIN_ROOT%\lua\nvim-lusc.lua
