# ============================================================
#  EMABOL CHAMP - Setup inicial de entornos
#  Ejecutar UNA SOLA VEZ despues de crear el repo de dev en GitHub
# ============================================================

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  SETUP DE ENTORNOS - EMABOL CHAMP" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que estamos en la carpeta correcta
if (-not (Test-Path "index.html")) {
    Write-Error "No se encontro index.html. Ejecuta este script desde D:\emabol-champ"
    exit 1
}

# Verificar si el remote 'dev' ya existe
$remotes = git remote
if ($remotes -contains "dev") {
    Write-Host "El remote 'dev' ya esta configurado." -ForegroundColor Yellow
} else {
    # Agregar el remote de desarrollo
    git remote add dev https://github.com/u477studio/Emabol-Champ-Dev.git
    Write-Host "Remote 'dev' agregado correctamente." -ForegroundColor Green
}

# Verificar el remote 'origin'
$originUrl = git remote get-url origin
Write-Host ""
Write-Host "Remotes configurados:" -ForegroundColor Cyan
Write-Host "  origin (PRODUCCION) -> $originUrl" -ForegroundColor White
Write-Host "  dev    (DESARROLLO) -> https://github.com/u477studio/Emabol-Champ-Dev.git" -ForegroundColor White
Write-Host ""

# Copiar los scripts de deploy a la carpeta del proyecto si no existen
$scriptDir = $PSScriptRoot

Write-Host "Setup completado!" -ForegroundColor Green
Write-Host ""
Write-Host "PROXIMOS PASOS:" -ForegroundColor Yellow
Write-Host "  1. Copia los 3 scripts .ps1 a D:\emabol-champ\" -ForegroundColor White
Write-Host "  2. Para subir cambios a DEV:  .\deploy-dev.ps1" -ForegroundColor White
Write-Host "  3. Para subir a PRODUCCION:   .\promote-to-prod.ps1" -ForegroundColor White
Write-Host ""
