@echo off
setlocal enabledelayedexpansion

echo ========================================
echo 批量给文件添加前缀或后缀（后缀加在扩展名前）
echo ========================================
echo.

set /p "prefix=请输入前缀（不需要请直接回车）: "
set /p "suffix=请输入后缀（不需要请直接回车）: "

if "%prefix%"=="" if "%suffix%"=="" (
    echo 错误：前缀和后缀不能同时为空！
    pause
    exit /b
)

echo 正在处理当前目录下的文件...

for %%f in (*.*) do (
    REM 跳过脚本自身
    if not "%%f"=="%~nx0" (
        set "basename=%%~nf"
        set "ext=%%~xf"
        set "newname=!prefix!!basename!!suffix!!ext!"
        if not "%%f"=="!newname!" (
            ren "%%f" "!newname!" 2>nul
            if errorlevel 1 (
                echo 失败：%%f -^> !newname! (可能目标已存在或名称无效)
            ) else (
                echo 成功：%%f -^> !newname!
            )
        ) else (
            echo 跳过：%%f (新名称与原名称相同)
        )
    )
)

echo.
echo 操作完成！
pause