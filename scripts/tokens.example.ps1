# Exemplo de tokens locais do hub ptbr-translations.
# Copie para scripts/tokens.ps1 (ignorado pelo Git), preencha e carregue na sessão:
#   Copy-Item scripts/tokens.example.ps1 scripts/tokens.ps1
#   . .\scripts\tokens.ps1
# Nunca versione o arquivo real.

$env:CROWDIN_TOKEN = 'seu-token-crowdin'
$env:WEBLATE_TOKEN = 'seu-token-weblate'
