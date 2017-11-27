@echo off
set DOWNLOAD_DIR=%USERPROFILE%\Downloads
set DST_DIR=%USERPROFILE%\Desktop\tools
set REPO=https://github.com/t1ngyu/portable-tools.git
set WINRAR="C:\Program Files (x86)\WinRAR\winrar.exe"
set CHROME="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"


if exist "%DST_DIR%" (
    del /s /q "%DST_DIR%"
)


echo Download PortableGit-2.15.0-64-bit.7z.exe
call :download PortableGit-2.15.0-64-bit.7z.exe


echo Install git
%WINRAR% x "%DOWNLOAD_DIR%\PortableGit-2.15.0-64-bit.7z.exe" "%DST_DIR%\git\"
call :makelink Git "%DST_DIR%\git\git-cmd.exe"
setx GIT_PATH "%DST_DIR%\git\bin"
setx PATH "%PATH%;%%GIT_PATH%%"


echo Clone other tools
"%DST_DIR%\git\bin\git.exe" clone %REPO% "%DST_DIR%\repo"


echo Install 7z
%WINRAR% x "%DST_DIR%\repo\7z1604-extra.7z" "%DST_DIR%\7z\"


echo Install Notepad++
%WINRAR% x "%DST_DIR%\repo\npp.7.5.1.bin.zip" "%DST_DIR%\notepad\"
call :makelink Notepad++ "%DST_DIR%\notepad\notepad++.exe"


echo Install python
%WINRAR% x "%DST_DIR%\repo\python-3.7.0a2-embed-win32.zip" "%DST_DIR%\python\"
setx PYTHON_PATH "%DST_DIR%\python"
setx PATH "%PATH%;%%PYTHON_PATH%%"


echo Install MobaXterm
%WINRAR% x "%DST_DIR%\repo\MobaXterm_Portable_v10.4.zip" "%DST_DIR%\MobaXterm\"
call :makelink MobaXterm "%DST_DIR%\MobaXterm\MobaXterm_Personal_10.4.exe"


echo Install VSCode
%WINRAR% x "%DST_DIR%\repo\VSCode-win32-ia32-1.18.1.zip" "%DST_DIR%\vscode\"
call :makelink VSCode "%DST_DIR%\vscode\code.exe"


echo Done!
goto :EOF


:: Functions

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
    start %CHROME% https://github.com/t1ngyu/portable-tools/raw/master/%1
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