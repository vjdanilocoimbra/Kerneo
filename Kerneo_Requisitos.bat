@echo off
title KERNEO - Instalador de Requisitos
color 0B

:: Auto-elevacao para administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo   Solicitando permissao de administrador...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo   KERNEO - Instalador de Requisitos
echo   ========================================
echo.

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0kerneo_requisitos.ps1"

if %errorlevel% neq 0 (
    echo.
    echo   [ERRO] O instalador encontrou um problema.
    echo   Tente executar manualmente:
    echo   powershell -ExecutionPolicy Bypass -File "%~dp0kerneo_requisitos.ps1"
    echo.
)

pause
