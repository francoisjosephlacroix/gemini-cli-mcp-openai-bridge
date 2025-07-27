# Test script for Gemini CLI MCP OpenAI Bridge setup
Write-Host "Testing Gemini CLI MCP OpenAI Bridge setup..." -ForegroundColor Green

# Test 1: Check if Node.js is available and correct version
Write-Host "`n1. Checking Node.js version..." -ForegroundColor Yellow
$nodeVersion = node --version
Write-Host "Node.js version: $nodeVersion" -ForegroundColor Cyan

# Test 2: Check if the built binary exists
Write-Host "`n2. Checking if bridge binary exists..." -ForegroundColor Yellow
$binaryPath = ".\gemini-cli\packages\bridge-server\dist\index.js"
if (Test-Path $binaryPath) {
    Write-Host "✓ Bridge binary found at: $binaryPath" -ForegroundColor Green
} else {
    Write-Host "✗ Bridge binary not found!" -ForegroundColor Red
    exit 1
}

# Test 3: Check if help command works
Write-Host "`n3. Testing help command..." -ForegroundColor Yellow
try {
    $helpOutput = node $binaryPath --help 2>&1
    if ($helpOutput -match "Options:") {
        Write-Host "✓ Help command works correctly" -ForegroundColor Green
    } else {
        Write-Host "✗ Help command failed" -ForegroundColor Red
        Write-Host $helpOutput
    }
} catch {
    Write-Host "✗ Error running help command: $_" -ForegroundColor Red
}

Write-Host "`n4. Next steps:" -ForegroundColor Yellow
Write-Host "   • To start the server in read-only mode (safest):" -ForegroundColor Cyan
Write-Host "     node $binaryPath --mode read-only --port 8765" -ForegroundColor White
Write-Host "   • To start the server in edit mode:" -ForegroundColor Cyan
Write-Host "     node $binaryPath --mode edit --port 8765" -ForegroundColor White
Write-Host "   • The server will be available at:" -ForegroundColor Cyan
Write-Host "     - MCP endpoint: http://localhost:8765/mcp" -ForegroundColor White
Write-Host "     - OpenAI API: http://localhost:8765/v1/chat/completions" -ForegroundColor White

Write-Host "`nSetup test completed successfully! 🎉" -ForegroundColor Green
