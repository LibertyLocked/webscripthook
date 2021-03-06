rmdir Release /s /q
mkdir Release\WebScriptHook
rem Build plugin
C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe .\webscripthook-plugin\WebScriptHook-plugin.csproj /P:Configuration=Release
robocopy .\webscripthook-plugin\bin\Release\ .\Release\WebScriptHook *.ini *.dll /xf ScriptHookVDotNet.dll
rem Build example extensions
mkdir Release\WebScriptHook\extensions
C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe .\webscripthook-extensions\WebScriptHook-extensions.csproj /P:Configuration=Release
copy .\webscripthook-extensions\bin\Release\extension-examples.dll .\Release\WebScriptHook\extensions

rem Build server
cd webscripthook-server
copy ..\webscripthook-plugin\WebScriptHook.ini .\WebScriptHook.ini
go build
cd ..
robocopy .\webscripthook-server\ .\Release\WebScriptHook /E /xf *.go .vscode build.bat
rem Copy license and readme
copy README.md .\Release\README.txt
copy LICENSE .\Release\LICENSE.txt

pause
