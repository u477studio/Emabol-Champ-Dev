# ============================================================
#  EMABOL CHAMP - Deploy al entorno de DESARROLLO
#  URL dev: https://u477studio.github.io/Emabol-Champ-Dev/
# ============================================================

param(
    [string]$Message = "Deploy dev - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
)

# Verificar que estamos en la carpeta correcta
if (-not (Test-Path "index.html")) {
    Write-Error "No se encontro index.html. Ejecuta este script desde D:\emabol-champ"
    exit 1
}

Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "  DEPLOY A DESARROLLO" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Guardar contenidos originales
$swOriginal       = Get-Content "sw.js"       -Raw
$manifestOriginal = Get-Content "manifest.json" -Raw

# Modificar sw.js para apuntar al repo de dev
$swDev = $swOriginal `
    -replace "const CACHE_NAME = 'emabol-v2'",         "const CACHE_NAME = 'emabol-dev-v1'" `
    -replace "const BASE = '/Emabol-Champ'",            "const BASE = '/Emabol-Champ-Dev'"

# Modificar manifest.json para apuntar al repo de dev
$manifestDev = $manifestOriginal -replace "/Emabol-Champ/", "/Emabol-Champ-Dev/"

# Escribir archivos modificados
Set-Content "sw.js"        $swDev        -NoNewline
Set-Content "manifest.json" $manifestDev -NoNewline

Write-Host "Archivos adaptados para entorno de desarrollo" -ForegroundColor Green

# Commit y push al repo de desarrollo
git add -A
git commit -m "[DEV] $Message"

Write-Host "Subiendo al repositorio de desarrollo..." -ForegroundColor Yellow
git push dev main

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Error al hacer push. Revisa la conexion o el remote 'dev'." -ForegroundColor Red
    # Revertir cambios antes de salir
    Set-Content "sw.js"        $swOriginal        -NoNewline
    Set-Content "manifest.json" $manifestOriginal -NoNewline
    git checkout -- sw.js manifest.json
    exit 1
}

Write-Host ""
Write-Host "Deploy a DESARROLLO exitoso!" -ForegroundColor Green
Write-Host "URL: https://u477studio.github.io/Emabol-Champ-Dev/" -ForegroundColor Yellow
Write-Host ""

# Revertir archivos a configuracion de produccion
Set-Content "sw.js"        $swOriginal        -NoNewline
Set-Content "manifest.json" $manifestOriginal -NoNewline
git checkout -- sw.js manifest.json

Write-Host "Archivos revertidos a configuracion de produccion" -ForegroundColor Cyan
Write-Host ""
