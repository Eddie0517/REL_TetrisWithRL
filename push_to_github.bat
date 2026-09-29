@echo off
chcp 65001 > nul
echo ========================================================
echo   Đang chuẩn bị đẩy mã nguồn lên GitHub...
echo   Repository: https://github.com/Eddie0517/REL_TetrisWithRL.git
echo ========================================================

git init
git remote remove origin 2>nul
git remote add origin https://github.com/Eddie0517/REL_TetrisWithRL.git
git branch -M main
git add .
git commit -m "Complete RL Tetris project: DDQN agent, Gym env, training pipeline, checkpoints, benchmark reports, and Cyberpunk Web UI"
echo.
echo Đang push lên branch main...
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [THÀNH CÔNG] Đã đẩy toàn bộ file lên https://github.com/Eddie0517/REL_TetrisWithRL !
) else (
    echo.
    echo [LƯU Ý] Nếu gặp lỗi xác thực, vui lòng kiểm tra đăng nhập GitHub CLI hoặc Personal Access Token (PAT).
)
pause
