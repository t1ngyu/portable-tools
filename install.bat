@echo off
set DOWNLOAD_DIR=%USERPROFILE%\Downloads
set DST_DIR=%USERPROFILE%\Desktop\tools
set REPO=https://github.com/t1ngyu/portable-tools.git
set BUDDLE=https://github.com/t1ngyu/portable-tools/archive/master.zip
set WINRAR="C:\Program Files (x86)\WinRAR\winrar.exe"
set CHROME="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
set _PATH=""

if exist "%DST_DIR%" (
    rd /s /q "%DST_DIR%"
)


if not exist "%DOWNLOAD_DIR%\portable-tools-master.zip" (
    echo Download tools.
    call :download portable-tools-master.zip
)
call :uncompress "%DOWNLOAD_DIR%\portable-tools-master.zip" "%DST_DIR%\"


echo Install git
call :uncompress "%DST_DIR%\portable-tools-master\PortableGit-2.15.0-64-bit.7z.exe" "%DST_DIR%\git\"
call :makelink Git "%DST_DIR%\git\git-cmd.exe"
call :add_env GIT_PATH "%DST_DIR%\git\bin"
call :add_to_path "%DST_DIR%\git\bin"


echo Install 7z
call :uncompress "%DST_DIR%\portable-tools-master\7z1604-extra.7z" "%DST_DIR%\7z\"


echo Install Notepad++
call :uncompress "%DST_DIR%\portable-tools-master\npp.7.5.1.bin.zip" "%DST_DIR%\notepad\"
call :makelink Notepad++ "%DST_DIR%\notepad\notepad++.exe"


echo Install python
call :uncompress "%DST_DIR%\portable-tools-master\python-3.7.0a2-embed-win32.7z" "%DST_DIR%\python\"
call :add_env PYTHON_PATH "%DST_DIR%\python"
call :add_to_path "%DST_DIR%\python"
call :add_to_path "%DST_DIR%\python\Scripts"


echo Install MobaXterm
call :uncompress "%DST_DIR%\portable-tools-master\MobaXterm_Portable_v10.4.zip" "%DST_DIR%\MobaXterm\"
call :makelink MobaXterm "%DST_DIR%\MobaXterm\MobaXterm_Personal_10.4.exe"


echo Install VSCode
call :uncompress "%DST_DIR%\portable-tools-master\VSCode-win32-x64-1.18.1.7z" "%DST_DIR%\vscode\"
call :makelink VSCode "%DST_DIR%\vscode\code.exe"
call :add_to_path "%DST_DIR%\vscode"


setx PATH "%PATH%%_PATH:~1,-1%"

echo Install completed!


echo Clone other tools
"%DST_DIR%\git\bin\git.exe" clone %REPO% "%DST_DIR%\repo"

echo Done!
pause
goto :EOF


:: Functions
:uncompress
    %WINRAR% x %1 %2
goto :EOF


:add_env
    setx %1 %2
goto :EOF


:add_to_path
    set _PATH="%_PATH:~1,-1%;%~1"
    dir > nul
goto :EOF


:makelink
    (echo Set WshShell=CreateObject("WScript.Shell"^)
    echo strDesKtop=WshShell.SpecialFolders("DesKtop"^)
    echo Set oShellLink=WshShell.CreateShortcut(strDesKtop^&"\%1.lnk"^)
    echo oShellLink.TargetPath="%~2"
    echo oShellLink.WorkingDirectory="%~dp2"
    echo oShellLink.WindowStyle=1
    echo oShellLink.Description=""
    echo oShellLink.Save) > _makelnk.vbs
    _makelnk.vbs
    del /f /q _makelnk.vbs
goto :EOF



:download
    start %CHROME% %BUDDLE%
    :wait-download
    if not exist %DOWNLOAD_DIR%\%1 (
        set /p=. < nul
        call :delay
        goto wait-download
    )
    echo .
    goto :EOF


:delay
    ping www.baidu.com > nul
    goto :EOF