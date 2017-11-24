@echo off
set DOWNLOAD_DIR=%USERPROFILE%\Downloads
set DST_DIR=%USERPROFILE%\Desktop\tools
set REPO=https://github.com/t1ngyu/portable-tools.git
set WINRAR="C:\Program Files (x86)\WinRAR\winrar.exe"
set CHROME="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"


del %DOWNLOAD_DIR%\PortableGit-2.15.0-64-bit.7z.exe
del /s /q %DST_DIR%


echo Download PortableGit-2.15.0-64-bit.7z.exe
call :download PortableGit-2.15.0-64-bit.7z.exe


echo Install git
%WINRAR% x %DOWNLOAD_DIR%\PortableGit-2.15.0-64-bit.7z.exe %DST_DIR%\git\


echo Clone other tools
%DST_DIR%\git\bin\git.exe clone %REPO% %DST_DIR%\repo


echo Install 7z
%WINRAR% x %DOWNLOAD_DIR%\7z1604-extra.7z %DST_DIR%\7z\


echo Install Notepad++
%WINRAR% x %DST_DIR%\repo\npp.7.5.1.bin.zip %DST_DIR%\notepad\


echo Install python
%WINRAR% x %DST_DIR%\repo\python-3.7.0a2-embed-win32.zip %DST_DIR%\python\


echo Install MobaXterm
%WINRAR% x %DST_DIR%\repo\MobaXterm_Portable_v10.4.zip %DST_DIR%\MobaXterm\


echo Install VSCode
%WINRAR% x %DST_DIR%\repo\VSCode-win32-ia32-1.18.1.zip %DST_DIR%\vscode\


echo Done!
goto :EOF



:: Functions
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