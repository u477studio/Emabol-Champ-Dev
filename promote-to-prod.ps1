# ============================================================
#  EMABOL CHAMP - Promover cambios a PRODUCCION
#  URL prod: https://u477studio.github.io/Emabol-Champ/
#  ATENCION: Los jugadores veran los cambios inmediatamente!
# ============================================================

param(
    [string]$Message = "Release - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
)

# Verificar que estamos en la carpeta correcta
if (-not (Test-Path "index.html")) {
    Write-Error "No se encontro index.html. Ejecuta este script desde D:\emabol-champ"
    exit 1
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Red
Write-Host "  PROMOVER A PRODUCCION" -ForegroundColor Red
Write-Host "======================================" -ForegroundColor Red
Write-Host ""
Write-Host "Esto actualizara la app en vivo que usan los jugadores." -ForegroundColor Yellow
Write-Host ""
Write-Host "Descripcion del cambio: $Message" -ForegroundColor White
Write-Host ""

$confirm = Read-Host "Confirmar deploy a produccion? (escribe 'si' para continuar)"

if ($confirm -ne "si") {
    Write-Host ""
    Write-Host "Deploy cancelado." -ForegroundColor Gray
    exit 0
}

Write-Host ""
Write-Host "Subiendo a produccion..." -ForegroundColor Yellow

git add -A
git commit -m "[PROD] $Message"
git push origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Error al hacer push a produccion. Revisa la conexion." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Green
Write-Host "  DEPLOY A PRODUCCION EXITOSO!" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "URL: https://u477studio.github.io/Emabol-Champ/" -ForegroundColor Green
Write-Host "Los jugadores veran los cambios en unos minutos." -ForegroundColor White
Write-Host ""
