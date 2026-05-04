@echo off
setlocal enabledelayedexpansion

echo ========================================
echo 批量给文件夹添加前缀或后缀（只处理当前目录下的直接子文件夹）
echo ========================================
echo.

set /p "prefix=请输入前缀（不需要请直接回车）: "
set /p "suffix=请输入后缀（不需要请直接回车）: "

if "%prefix%"=="" if "%suffix%"=="" (
    echo 错误：前缀和后缀不能同时为空！
    pause
    exit /b
)

echo 正在处理当前目录下的文件夹...

for /d %%d in (*) do (
    REM 跳过脚本自身（脚本是文件，不会匹配到，但保留判断以防万一）
    if not "%%d"=="%~nx0" (
        set "oldname=%%d"
        set "newname=!prefix!%%d!suffix!"
        if not "%%d"=="!newname!" (
            ren "%%d" "!newname!" 2>nul
            if errorlevel 1 (
                echo 失败：%%d -^> !newname! (可能目标已存在或名称无效)
            ) else (
                echo 成功：%%d -^> !newname!
            )
        ) else (
            echo 跳过：%%d (新名称与原名称相同)
        )
    )
)

echo.
echo 操作完成！
pause