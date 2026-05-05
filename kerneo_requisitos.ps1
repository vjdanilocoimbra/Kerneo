# ==================================================================
# KERNEO - Instalador de Requisitos
# Instala: Python 3.12+  |  Node.js 20+  |  ffmpeg
# Windows Forms - robusto, funciona em qualquer Windows
# ==================================================================

try {
    Add-Type -AssemblyName System.Windows.Forms, System.Drawing
} catch {
    Write-Host "`n  ERRO: Nao foi possivel carregar Windows Forms." -ForegroundColor Red
    Write-Host "  Este script requer Windows 7+ com .NET Framework.`n" -ForegroundColor Yellow
    Read-Host "  ENTER para fechar"
    exit 1
}

$ErrorActionPreference = "SilentlyContinue"
[System.Windows.Forms.Application]::EnableVisualStyles()

# ==================================================================
# CORES
# ==================================================================
$C_BG     = [System.Drawing.Color]::FromArgb(10, 18, 32)
$C_CYAN   = [System.Drawing.Color]::FromArgb(0, 200, 240)
$C_TEAL   = [System.Drawing.Color]::FromArgb(29, 233, 182)
$C_DIM    = [System.Drawing.Color]::FromArgb(70, 100, 130)
$C_PANEL  = [System.Drawing.Color]::FromArgb(14, 26, 48)
$C_LINE   = [System.Drawing.Color]::FromArgb(25, 55, 85)
$C_BTN    = [System.Drawing.Color]::FromArgb(0, 55, 110)
$C_RED    = [System.Drawing.Color]::FromArgb(255, 85, 85)
$C_WHITE  = [System.Drawing.Color]::White
$C_LOG_BG = [System.Drawing.Color]::FromArgb(6, 12, 24)

# ==================================================================
# JANELA PRINCIPAL
# ==================================================================
$form = [System.Windows.Forms.Form]::new()
$form.Text            = "KERNEO - Instalador de Requisitos"
$form.ClientSize      = [System.Drawing.Size]::new(720, 530)
$form.StartPosition   = "CenterScreen"
$form.BackColor       = $C_BG
$form.ForeColor       = $C_CYAN
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox     = $false
$form.Font            = [System.Drawing.Font]::new("Consolas", 9)

# -- Titulo --
$lblTitle = [System.Windows.Forms.Label]::new()
$lblTitle.Text      = "N . E . X . U . S ."
$lblTitle.Font      = [System.Drawing.Font]::new("Consolas", 20, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = $C_CYAN
$lblTitle.BackColor = $C_BG
$lblTitle.AutoSize  = $true
$lblTitle.Location  = [System.Drawing.Point]::new(24, 14)
$form.Controls.Add($lblTitle)

$lblSub = [System.Windows.Forms.Label]::new()
$lblSub.Text      = "Instalador de Requisitos  -  Python | Node.js | ffmpeg"
$lblSub.ForeColor = $C_DIM
$lblSub.BackColor = $C_BG
$lblSub.AutoSize  = $true
$lblSub.Location  = [System.Drawing.Point]::new(26, 52)
$form.Controls.Add($lblSub)

# Separador
$sep1 = [System.Windows.Forms.Panel]::new()
$sep1.BackColor = $C_LINE
$sep1.Size      = [System.Drawing.Size]::new(680, 1)
$sep1.Location  = [System.Drawing.Point]::new(20, 78)
$form.Controls.Add($sep1)

# ==================================================================
# PAINEL DE STATUS - 3 linhas (Python, Node, ffmpeg)
# ==================================================================
$statusPanel = [System.Windows.Forms.Panel]::new()
$statusPanel.BackColor   = $C_PANEL
$statusPanel.Size        = [System.Drawing.Size]::new(680, 115)
$statusPanel.Location    = [System.Drawing.Point]::new(20, 88)
$statusPanel.BorderStyle = "None"
$form.Controls.Add($statusPanel)

# Cabecalho
foreach ($h in @(
    @{ T="COMPONENTE"; X=44 },
    @{ T="VERSAO MINIMA"; X=280 },
    @{ T="STATUS"; X=470 }
)) {
    $lbl = [System.Windows.Forms.Label]::new()
    $lbl.Text      = $h.T
    $lbl.ForeColor = $C_DIM
    $lbl.BackColor = $C_PANEL
    $lbl.Font      = [System.Drawing.Font]::new("Consolas", 8)
    $lbl.AutoSize  = $true
    $lbl.Location  = [System.Drawing.Point]::new($h.X, 8)
    $statusPanel.Controls.Add($lbl)
}

# Funcao para criar linha de status
function New-StatusRow {
    param($parent, $y, $name, $minVer)

    $dot = [System.Windows.Forms.Label]::new()
    $dot.Text      = ">>>"
    $dot.ForeColor = $C_DIM
    $dot.BackColor = $C_PANEL
    $dot.Font      = [System.Drawing.Font]::new("Consolas", 9, [System.Drawing.FontStyle]::Bold)
    $dot.AutoSize  = $true
    $dot.Location  = [System.Drawing.Point]::new(12, $y)
    $parent.Controls.Add($dot)

    $lbl = [System.Windows.Forms.Label]::new()
    $lbl.Text      = $name
    $lbl.ForeColor = $C_WHITE
    $lbl.BackColor = $C_PANEL
    $lbl.AutoSize  = $true
    $lbl.Location  = [System.Drawing.Point]::new(44, $y)
    $parent.Controls.Add($lbl)

    $min = [System.Windows.Forms.Label]::new()
    $min.Text      = $minVer
    $min.ForeColor = $C_DIM
    $min.BackColor = $C_PANEL
    $min.AutoSize  = $true
    $min.Location  = [System.Drawing.Point]::new(280, $y)
    $parent.Controls.Add($min)

    $st = [System.Windows.Forms.Label]::new()
    $st.Text      = "Verificando..."
    $st.ForeColor = $C_DIM
    $st.BackColor = $C_PANEL
    $st.AutoSize  = $false
    $st.Size      = [System.Drawing.Size]::new(200, 18)
    $st.Location  = [System.Drawing.Point]::new(470, $y)
    $parent.Controls.Add($st)

    return @{ Dot = $dot; Status = $st }
}

$pyRow   = New-StatusRow $statusPanel 32  "Python"    "3.10+"
$nodeRow = New-StatusRow $statusPanel 58  "Node.js"   "18+"
$ffRow   = New-StatusRow $statusPanel 84  "ffmpeg"    "qualquer"

# ==================================================================
# AREA DE LOG
# ==================================================================
$sep2 = [System.Windows.Forms.Panel]::new()
$sep2.BackColor = $C_LINE
$sep2.Size      = [System.Drawing.Size]::new(680, 1)
$sep2.Location  = [System.Drawing.Point]::new(20, 212)
$form.Controls.Add($sep2)

$logBox = [System.Windows.Forms.RichTextBox]::new()
$logBox.BackColor   = $C_LOG_BG
$logBox.ForeColor   = $C_CYAN
$logBox.Font        = [System.Drawing.Font]::new("Consolas", 9)
$logBox.ReadOnly    = $true
$logBox.BorderStyle = "None"
$logBox.Size        = [System.Drawing.Size]::new(680, 224)
$logBox.Location    = [System.Drawing.Point]::new(20, 220)
$logBox.ScrollBars  = "Vertical"
$form.Controls.Add($logBox)

# ==================================================================
# BARRA DE PROGRESSO (custom - Panel dentro de Panel)
# ==================================================================
$pBarBg = [System.Windows.Forms.Panel]::new()
$pBarBg.BackColor = [System.Drawing.Color]::FromArgb(12, 28, 50)
$pBarBg.Size      = [System.Drawing.Size]::new(580, 10)
$pBarBg.Location  = [System.Drawing.Point]::new(20, 454)
$form.Controls.Add($pBarBg)

$pBarFill = [System.Windows.Forms.Panel]::new()
$pBarFill.BackColor = $C_CYAN
$pBarFill.Size      = [System.Drawing.Size]::new(0, 10)
$pBarFill.Location  = [System.Drawing.Point]::new(0, 0)
$pBarBg.Controls.Add($pBarFill)

$lblPct = [System.Windows.Forms.Label]::new()
$lblPct.Text      = ""
$lblPct.ForeColor = $C_DIM
$lblPct.BackColor = $C_BG
$lblPct.AutoSize  = $true
$lblPct.Location  = [System.Drawing.Point]::new(610, 452)
$form.Controls.Add($lblPct)

# ==================================================================
# BOTOES
# ==================================================================
$btnInstall = [System.Windows.Forms.Button]::new()
$btnInstall.Text      = "INSTALAR REQUISITOS"
$btnInstall.Size      = [System.Drawing.Size]::new(250, 40)
$btnInstall.Location  = [System.Drawing.Point]::new(220, 480)
$btnInstall.BackColor = $C_BTN
$btnInstall.ForeColor = $C_WHITE
$btnInstall.FlatStyle = "Flat"
$btnInstall.FlatAppearance.BorderColor = $C_CYAN
$btnInstall.FlatAppearance.BorderSize  = 1
$btnInstall.Font      = [System.Drawing.Font]::new("Consolas", 11, [System.Drawing.FontStyle]::Bold)
$btnInstall.Cursor    = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnInstall)

$btnClose = [System.Windows.Forms.Button]::new()
$btnClose.Text      = "FECHAR"
$btnClose.Size      = [System.Drawing.Size]::new(100, 40)
$btnClose.Location  = [System.Drawing.Point]::new(490, 480)
$btnClose.BackColor = [System.Drawing.Color]::FromArgb(40, 15, 15)
$btnClose.ForeColor = $C_DIM
$btnClose.FlatStyle = "Flat"
$btnClose.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(70, 35, 35)
$btnClose.FlatAppearance.BorderSize  = 1
$btnClose.Cursor    = [System.Windows.Forms.Cursors]::Hand
$form.Controls.Add($btnClose)

# ==================================================================
# FUNCOES AUXILIARES
# ==================================================================
function Log($msg) {
    $logBox.AppendText("  > $msg`r`n")
    $logBox.SelectionStart = $logBox.TextLength
    $logBox.ScrollToCaret()
    [System.Windows.Forms.Application]::DoEvents()
}

function Log-Blank { $logBox.AppendText("`r`n"); [System.Windows.Forms.Application]::DoEvents() }

function SetProgress($pct) {
    $w = [int]([Math]::Min($pct, 100) * $pBarBg.Width / 100)
    $pBarFill.Width = $w
    $lblPct.Text = "$pct%"
    [System.Windows.Forms.Application]::DoEvents()
}

function SetStatus($row, $text, $color) {
    $row.Status.Text      = $text
    $row.Status.ForeColor = $color
    $row.Dot.ForeColor    = $color
    [System.Windows.Forms.Application]::DoEvents()
}

function Refresh-EnvPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Busca executavel no PATH e em diretorios conhecidos de instalacao
function Find-Exe($name, $knownPaths) {
    Refresh-EnvPath
    # 1. Tenta where.exe (mais confiavel que chamar direto)
    try {
        $psi = [System.Diagnostics.ProcessStartInfo]::new()
        $psi.FileName = "where.exe"
        $psi.Arguments = $name
        $psi.UseShellExecute = $false
        $psi.RedirectStandardOutput = $true
        $psi.CreateNoWindow = $true
        $p = [System.Diagnostics.Process]::Start($psi)
        $out = $p.StandardOutput.ReadToEnd().Trim()
        $p.WaitForExit(5000)
        if ($p.ExitCode -eq 0 -and $out) {
            $first = ($out -split "`n")[0].Trim()
            # Ignora alias do Microsoft Store
            if ($first -and ($first -notlike "*WindowsApps*")) {
                return $first
            }
        }
    } catch {}
    # 2. Busca em diretorios conhecidos
    foreach ($dir in $knownPaths) {
        $full = Join-Path $dir $name
        if (Test-Path $full) { return $full }
    }
    return $null
}

function Get-CmdOutput($exePath, $arguments) {
    try {
        if (-not $exePath) { return $null }
        if (-not (Test-Path $exePath)) {
            # Pode ser nome simples - tenta achar
            $found = $null
            try {
                $psi2 = [System.Diagnostics.ProcessStartInfo]::new()
                $psi2.FileName = "where.exe"
                $psi2.Arguments = $exePath
                $psi2.UseShellExecute = $false
                $psi2.RedirectStandardOutput = $true
                $psi2.CreateNoWindow = $true
                $p2 = [System.Diagnostics.Process]::Start($psi2)
                $found = $p2.StandardOutput.ReadToEnd().Trim()
                $p2.WaitForExit(5000)
                if ($p2.ExitCode -ne 0) { $found = $null }
            } catch {}
            if (-not $found) { return $null }
            $exePath = ($found -split "`n")[0].Trim()
        }
        $psi = [System.Diagnostics.ProcessStartInfo]::new()
        $psi.FileName               = $exePath
        $psi.Arguments              = $arguments
        $psi.UseShellExecute        = $false
        $psi.RedirectStandardOutput = $true
        $psi.RedirectStandardError  = $true
        $psi.CreateNoWindow         = $true
        $p = [System.Diagnostics.Process]::Start($psi)
        $out = $p.StandardOutput.ReadToEnd()
        if (-not $p.WaitForExit(10000)) { try { $p.Kill() } catch {} }
        if ($out) { return $out.Trim() }
        return $null
    } catch {
        return $null
    }
}

function Wait-Process-Responsive($proc) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    while (-not $proc.HasExited) {
        [System.Windows.Forms.Application]::DoEvents()
        Start-Sleep -Milliseconds 300
        # Timeout de 10 minutos para evitar travamento
        if ($sw.Elapsed.TotalMinutes -gt 10) {
            try { $proc.Kill() } catch {}
            return -1
        }
    }
    return $proc.ExitCode
}

function Run-Silent($exe, $arguments) {
    try {
        $psi = [System.Diagnostics.ProcessStartInfo]::new()
        $psi.FileName        = $exe
        $psi.Arguments       = $arguments
        $psi.UseShellExecute = $true
        $psi.WindowStyle     = "Hidden"
        $p = [System.Diagnostics.Process]::Start($psi)
        return (Wait-Process-Responsive $p)
    } catch {
        Log "  Erro ao executar: $exe"
        return -1
    }
}

function Has-Winget {
    try {
        $r = Get-CmdOutput "winget.exe" "--version"
        return ($r -and $r -match "\d+\.\d+")
    } catch { return $false }
}

# ==================================================================
# DIRETORIOS CONHECIDOS DE INSTALACAO
# ==================================================================
$PYTHON_DIRS = @(
    "C:\Python312", "C:\Python311", "C:\Python310",
    "$env:LOCALAPPDATA\Programs\Python\Python312",
    "$env:LOCALAPPDATA\Programs\Python\Python311",
    "$env:LOCALAPPDATA\Programs\Python\Python310",
    "C:\Program Files\Python312", "C:\Program Files\Python311",
    "$env:ProgramFiles\Python312", "$env:ProgramFiles\Python311"
)

$NODE_DIRS = @(
    "C:\Program Files\nodejs",
    "$env:ProgramFiles\nodejs",
    "C:\Program Files (x86)\nodejs"
)

# ==================================================================
# VERIFICACAO DE COMPONENTES
# ==================================================================
function Check-Python {
    try {
        Refresh-EnvPath
        # Tenta python no PATH (ignorando WindowsApps)
        $exe = Find-Exe "python.exe" $PYTHON_DIRS
        if ($exe) {
            $v = Get-CmdOutput $exe "--version"
            if ($v -and ($v -match "Python\s+3\.(\d+)")) {
                if ($Matches -and $Matches[1]) {
                    $minor = [int]$Matches[1]
                    if ($minor -ge 10) { return $v.Trim() }
                }
            }
        }
        # Tenta py launcher
        $py = Find-Exe "py.exe" @("C:\Windows")
        if ($py) {
            $v = Get-CmdOutput $py "-3 --version"
            if ($v -and ($v -match "Python\s+3\.(\d+)")) {
                if ($Matches -and $Matches[1]) {
                    $minor = [int]$Matches[1]
                    if ($minor -ge 10) { return $v.Trim() }
                }
            }
        }
        # Busca direta nos diretorios conhecidos
        foreach ($dir in $PYTHON_DIRS) {
            $pyExe = Join-Path $dir "python.exe"
            if (Test-Path $pyExe) {
                $v = Get-CmdOutput $pyExe "--version"
                if ($v -and ($v -match "Python\s+3\.(\d+)")) {
                    if ($Matches -and $Matches[1]) {
                        $minor = [int]$Matches[1]
                        if ($minor -ge 10) {
                            # Adiciona ao PATH se nao esta
                            $curPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
                            if ($curPath -notlike "*$dir*") {
                                [System.Environment]::SetEnvironmentVariable("Path", "$curPath;$dir;$dir\Scripts", "Machine")
                                Log "  Python encontrado em $dir - adicionado ao PATH"
                            }
                            Refresh-EnvPath
                            return $v.Trim()
                        }
                    }
                }
            }
        }
    } catch {}
    return $null
}

function Check-Node {
    try {
        Refresh-EnvPath
        $exe = Find-Exe "node.exe" $NODE_DIRS
        if ($exe) {
            $v = Get-CmdOutput $exe "--version"
            if ($v -and ($v -match "v(\d+)\.")) {
                if ($Matches -and $Matches[1]) {
                    $major = [int]$Matches[1]
                    if ($major -ge 18) { return "Node.js $v".Trim() }
                }
            }
        }
        # Busca direta nos diretorios conhecidos
        foreach ($dir in $NODE_DIRS) {
            $nodeExe = Join-Path $dir "node.exe"
            if (Test-Path $nodeExe) {
                $v = Get-CmdOutput $nodeExe "--version"
                if ($v -and ($v -match "v(\d+)\.")) {
                    if ($Matches -and $Matches[1]) {
                        $major = [int]$Matches[1]
                        if ($major -ge 18) {
                            $curPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
                            if ($curPath -notlike "*$dir*") {
                                [System.Environment]::SetEnvironmentVariable("Path", "$curPath;$dir", "Machine")
                                Log "  Node.js encontrado em $dir - adicionado ao PATH"
                            }
                            Refresh-EnvPath
                            return "Node.js $v".Trim()
                        }
                    }
                }
            }
        }
    } catch {}
    return $null
}

function Check-FFmpeg {
    try {
        Refresh-EnvPath
        $exe = Find-Exe "ffmpeg.exe" @("C:\ffmpeg\bin", "C:\ProgramData\chocolatey\bin")
        if ($exe) {
            $v = Get-CmdOutput $exe "-version"
            if ($v -and ($v -match "ffmpeg version")) { return "Instalado" }
        }
        if (Test-Path "C:\ffmpeg\bin\ffmpeg.exe") { return "Instalado (C:\ffmpeg)" }
    } catch {}
    return $null
}

# ==================================================================
# INSTALACAO DE COMPONENTES
# ==================================================================
function Install-PythonNow {
    Log "Instalando Python 3.12..."

    # Remove alias do Microsoft Store que interfere
    $aliases = "$env:LOCALAPPDATA\Microsoft\WindowsApps\python*.exe"
    Remove-Item $aliases -Force -ErrorAction SilentlyContinue
    $aliases3 = "$env:LOCALAPPDATA\Microsoft\WindowsApps\python3*.exe"
    Remove-Item $aliases3 -Force -ErrorAction SilentlyContinue

    $useWinget = Has-Winget
    if ($useWinget) {
        Log "  Usando winget (pode demorar 1-3 min)..."
        $code = Run-Silent "winget" "install Python.Python.3.12 --silent --accept-source-agreements --accept-package-agreements"
        Log "  winget finalizado (codigo: $code). Aguardando..."
        Start-Sleep -Seconds 5
        Refresh-EnvPath
        $check = Check-Python
        if ($check) { return $check }
        Log "  winget nao confirmou no PATH. Tentando download direto..."
    }

    Log "  Baixando Python 3.12.7 do site oficial..."
    $url = "https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe"
    $tmp = "$env:TEMP\python-3.12.7-amd64.exe"
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $wc = [System.Net.WebClient]::new()
        $wc.DownloadFile($url, $tmp)
        Log "  Download OK. Instalando (aguarde ~1 min)..."
        $code = Run-Silent $tmp "/quiet InstallAllUsers=1 PrependPath=1 Include_pip=1 Include_launcher=1"
        Remove-Item $tmp -Force -ErrorAction SilentlyContinue
    } catch {
        Log "  ERRO no download: $($_.Exception.Message)"
        return $null
    }

    # Espera o instalador finalizar e verifica varias vezes
    Log "  Verificando instalacao..."
    for ($i = 1; $i -le 5; $i++) {
        Start-Sleep -Seconds 3
        Refresh-EnvPath
        [System.Windows.Forms.Application]::DoEvents()
        $check = Check-Python
        if ($check) { return $check }
        Log "  Tentativa $i/5 - ainda nao encontrado..."
    }
    return $null
}

function Install-NodeNow {
    Log "Instalando Node.js LTS..."

    $useWinget = Has-Winget
    if ($useWinget) {
        Log "  Usando winget (pode demorar 1-3 min)..."
        $code = Run-Silent "winget" "install OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements"
        Log "  winget finalizado (codigo: $code). Aguardando..."
        Start-Sleep -Seconds 5
        Refresh-EnvPath
        $check = Check-Node
        if ($check) { return $check }
        Log "  winget nao confirmou no PATH. Tentando download direto..."
    }

    Log "  Baixando Node.js 20 LTS do site oficial..."
    $url = "https://nodejs.org/dist/v20.18.0/node-v20.18.0-x64.msi"
    $tmp = "$env:TEMP\node-v20.18.0-x64.msi"
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $wc = [System.Net.WebClient]::new()
        $wc.DownloadFile($url, $tmp)
        Log "  Download OK. Instalando (aguarde ~1 min)..."
        $code = Run-Silent "msiexec" "/i `"$tmp`" /quiet /norestart"
        Remove-Item $tmp -Force -ErrorAction SilentlyContinue
    } catch {
        Log "  ERRO no download: $($_.Exception.Message)"
        return $null
    }

    # Espera e verifica varias vezes
    Log "  Verificando instalacao..."
    for ($i = 1; $i -le 5; $i++) {
        Start-Sleep -Seconds 3
        Refresh-EnvPath
        [System.Windows.Forms.Application]::DoEvents()
        $check = Check-Node
        if ($check) { return $check }
        Log "  Tentativa $i/5 - ainda nao encontrado..."
    }
    return $null
}

function Install-FFmpegNow {
    Log "Instalando ffmpeg..."

    $useWinget = Has-Winget
    if ($useWinget) {
        Log "  Usando winget..."
        $code = Run-Silent "winget" "install Gyan.FFmpeg --silent --accept-source-agreements --accept-package-agreements"
        Start-Sleep -Seconds 3
        Refresh-EnvPath
        $check = Check-FFmpeg
        if ($check) { return $check }
        Log "  winget nao confirmou. Tentando download direto..."
    }

    Log "  Baixando ffmpeg do GitHub (pode demorar)..."
    $url = "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip"
    $zipPath = "$env:TEMP\ffmpeg.zip"
    $extractPath = "C:\ffmpeg"
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $wc = [System.Net.WebClient]::new()
        $wc.DownloadFile($url, $zipPath)
        Log "  Download OK. Extraindo..."

        $tmpExtract = "$env:TEMP\ffmpeg_extract"
        if (Test-Path $tmpExtract) { Remove-Item $tmpExtract -Recurse -Force }
        Expand-Archive -Path $zipPath -DestinationPath $tmpExtract -Force

        $inner = Get-ChildItem $tmpExtract -Directory | Select-Object -First 1
        if (Test-Path $extractPath) { Remove-Item $extractPath -Recurse -Force }
        Move-Item $inner.FullName $extractPath -Force

        Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
        Remove-Item $tmpExtract -Recurse -Force -ErrorAction SilentlyContinue

        # Adiciona ao PATH do sistema
        $binPath = "$extractPath\bin"
        $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
        if ($currentPath -notlike "*$binPath*") {
            [System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$binPath", "Machine")
            Log "  ffmpeg adicionado ao PATH do sistema"
        }
        Refresh-EnvPath
        return Check-FFmpeg
    } catch {
        Log "  ERRO: $($_.Exception.Message)"
        return $null
    }
}

# ==================================================================
# FLUXO PRINCIPAL DE INSTALACAO
# ==================================================================
function Run-Installation {
    $btnInstall.Enabled = $false
    $btnClose.Enabled   = $false
    $script:allOK       = $true

    Log-Blank
    Log "Iniciando instalacao de requisitos..."
    Log "========================================"
    Log-Blank
    SetProgress 5

    # -- Python --
    SetProgress 10
    $pyVer = Check-Python
    if ($pyVer) {
        Log "Python ja instalado: $pyVer"
        SetStatus $pyRow $pyVer $C_TEAL
    } else {
        SetStatus $pyRow "Instalando..." $C_CYAN
        $result = Install-PythonNow
        if ($result) {
            Log "Python instalado com sucesso: $result"
            SetStatus $pyRow $result $C_TEAL
        } else {
            Log "FALHA ao instalar Python!"
            Log "  Instale manualmente: https://python.org/downloads/"
            SetStatus $pyRow "FALHA" $C_RED
            $script:allOK = $false
        }
    }
    SetProgress 35

    # -- Node.js --
    $ndVer = Check-Node
    if ($ndVer) {
        Log "Node.js ja instalado: $ndVer"
        SetStatus $nodeRow $ndVer $C_TEAL
    } else {
        SetStatus $nodeRow "Instalando..." $C_CYAN
        $result = Install-NodeNow
        if ($result) {
            Log "Node.js instalado com sucesso: $result"
            SetStatus $nodeRow $result $C_TEAL
        } else {
            Log "FALHA ao instalar Node.js!"
            Log "  Instale manualmente: https://nodejs.org/"
            SetStatus $nodeRow "FALHA" $C_RED
            $script:allOK = $false
        }
    }
    SetProgress 65

    # -- ffmpeg --
    $ffVer = Check-FFmpeg
    if ($ffVer) {
        Log "ffmpeg ja instalado."
        SetStatus $ffRow "Instalado" $C_TEAL
    } else {
        SetStatus $ffRow "Instalando..." $C_CYAN
        $result = Install-FFmpegNow
        if ($result) {
            Log "ffmpeg instalado com sucesso."
            SetStatus $ffRow "Instalado" $C_TEAL
        } else {
            Log "FALHA ao instalar ffmpeg!"
            Log "  Instale manualmente: https://ffmpeg.org/download.html"
            SetStatus $ffRow "FALHA" $C_RED
            $script:allOK = $false
        }
    }
    SetProgress 90

    # -- Verificacao final --
    Log-Blank
    Refresh-EnvPath
    Log "Verificacao final..."

    try { $pyOK = Check-Python } catch { $pyOK = $null }
    try { $ndOK = Check-Node }   catch { $ndOK = $null }
    try { $ffOK = Check-FFmpeg } catch { $ffOK = $null }

    try {
        $pipOK = Get-CmdOutput "pip" "--version"
        if ($pipOK) { Log "pip: $pipOK" } else { Log "pip: nao encontrado" }
    } catch { Log "pip: nao disponivel" }

    try {
        $npmOK = Get-CmdOutput "npm" "--version"
        if ($npmOK) { Log "npm: v$npmOK" } else { Log "npm: nao encontrado" }
    } catch { Log "npm: nao disponivel" }

    SetProgress 100
    Log-Blank

    if ($pyOK -and $ndOK -and $ffOK) {
        Log "========================================"
        Log "TODOS OS REQUISITOS INSTALADOS!"
        Log "========================================"
        Log-Blank
        Log "Proximo passo: Execute KERNEO_Instalar.bat"
        $btnInstall.Text      = "CONCLUIDO"
        $btnInstall.BackColor = [System.Drawing.Color]::FromArgb(0, 60, 45)
        $btnInstall.FlatAppearance.BorderColor = $C_TEAL
        $pBarFill.BackColor = $C_TEAL
    } else {
        Log "========================================"
        Log "ALGUNS REQUISITOS FALHARAM"
        Log "Verifique os erros acima e tente novamente."
        Log "========================================"
        $btnInstall.Text    = "TENTAR NOVAMENTE"
        $btnInstall.Enabled = $true
        $pBarFill.BackColor = $C_RED
    }

    $btnClose.Enabled = $true
}

# ==================================================================
# EVENTOS
# ==================================================================
$btnInstall.Add_Click({ Run-Installation })
$btnClose.Add_Click({ $form.Close() })

# ==================================================================
# AO ABRIR - verifica estado atual
# ==================================================================
$form.Add_Shown({
    Log "KERNEO - Instalador de Requisitos v1.0"
    Log "Verificando estado atual do sistema..."
    Log-Blank

    Refresh-EnvPath

    $py = Check-Python
    $nd = Check-Node
    $ff = Check-FFmpeg

    if ($py) { SetStatus $pyRow $py $C_TEAL; Log "Python:  $py" }
    else     { SetStatus $pyRow "Nao encontrado" $C_RED; Log "Python:  nao encontrado" }

    if ($nd) { SetStatus $nodeRow $nd $C_TEAL; Log "Node.js: $nd" }
    else     { SetStatus $nodeRow "Nao encontrado" $C_RED; Log "Node.js: nao encontrado" }

    if ($ff) { SetStatus $ffRow "Instalado" $C_TEAL; Log "ffmpeg:  encontrado" }
    else     { SetStatus $ffRow "Nao encontrado" $C_RED; Log "ffmpeg:  nao encontrado" }

    Log-Blank

    if ($py -and $nd -and $ff) {
        Log "Todos os requisitos ja estao instalados!"
        Log "Execute KERNEO_Instalar.bat para instalar o sistema."
        $btnInstall.Text      = "TUDO INSTALADO"
        $btnInstall.BackColor = [System.Drawing.Color]::FromArgb(0, 60, 45)
        $btnInstall.FlatAppearance.BorderColor = $C_TEAL
    } else {
        Log "Clique em INSTALAR REQUISITOS para instalar os que faltam."
    }
})

# ==================================================================
# EXECUTA
# ==================================================================
try {
    [System.Windows.Forms.Application]::Run($form)
} catch {
    [System.Windows.Forms.MessageBox]::Show(
        "Erro inesperado: $($_.Exception.Message)`n`nTente executar novamente como Administrador.",
        "KERNEO - Erro",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
}
