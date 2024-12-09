# Abilita il logging colorato
Write-Host "`nStarting Python Application..." -ForegroundColor Green

# Check per Python
if (-Not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python non è installato o non è configurato nel PATH." -ForegroundColor Red
    exit 1
}

# Crea un virtual environment
if (-Not (Test-Path -Path "./venv")) {
    Write-Host "Creazione di un virtual environment..." -ForegroundColor Cyan
    python -m venv venv
}

# Attiva il virtual environment
Write-Host "Attivazione del virtual environment..." -ForegroundColor Yellow
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\venv\Scripts\Activate.ps1

# Avvia l'applicazione Streamlit con gestione sicura del virtual environment
try {
    # Installa i requirements
    Write-Host "Installazione dei requirements..." -ForegroundColor Cyan
    pip install -r requirements.txt

    # Avvia l'applicazione Streamlit
    Write-Host "Avvio dell'applicazione Streamlit..." -ForegroundColor Green
    streamlit run main.py
} finally {
    # Disattiva il virtual environment
    Write-Host "Disattivazione dell'ambiente virtuale..." -ForegroundColor Yellow
    if ($env:VIRTUAL_ENV) {
        deactivate
        Remove-Item -Path Function:\Activate -ErrorAction SilentlyContinue
        Remove-Variable -Name VIRTUAL_ENV -Scope Global -ErrorAction SilentlyContinue
        Write-Host "Virtual environment disattivato con successo." -ForegroundColor Green
    } else {
        Write-Host "Nessun ambiente virtuale attivo." -ForegroundColor Cyan
    }
}
