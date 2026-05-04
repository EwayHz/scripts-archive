@echo off
setlocal enabledelayedexpansion

REM 设置输出文件路径和名称，可根据需求修改
set "outputFile=filenames.txt"

REM 清空或创建输出文件（覆盖模式）
type nul > "%outputFile%"

REM 遍历当前目录下的所有项目
for %%f in (*) do (
    REM 判断是否为文件（排除目录）
    if not exist "%%f\*" (
        REM 排除脚本自身
        if not "%%f"=="%~nx0" (
            REM 排除输出文件本身
            if not "%%f"=="%outputFile%" (
                REM 提取文件名（不含扩展名）并写入
                echo %%~nf>>"%outputFile%"
            )
        )
    )
)

echo 文件名提取完成！