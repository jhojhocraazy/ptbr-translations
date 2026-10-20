# 🛠️ Scripts do hub ptbr-translations

Ferramentas de apoio ao ciclo de tradução. Nenhum script publica no GitHub:
para projetos em Crowdin/Weblate a entrega termina na plataforma
(ver [`../metodologia.md`](../metodologia.md)).

---

## Requisitos

- PowerShell 7+
- Token pessoal da API do Crowdin (apenas para `crowdin-sync.ps1`)

```powershell
$env:CROWDIN_TOKEN = 'seu-token'
```

> O token nunca deve ser commitado. Os scripts leem apenas a variável de ambiente
> `CROWDIN_TOKEN` (ou o parâmetro `-Token`).

---

## `crowdin-sync.ps1`

Ciclo completo de um projeto Crowdin: status, exportação, envio, auditoria e backup.

### Status — pendências por arquivo

```powershell
./scripts/crowdin-sync.ps1 -Action Status -ProjectId 31
./scripts/crowdin-sync.ps1 -Action Status -ProjectId 31 -Tsv pendencias.tsv
```

Saída: total de strings, total de pendentes e uma linha por arquivo.

### Export — strings pendentes de um arquivo

```powershell
./scripts/crowdin-sync.ps1 -Action Export -ProjectId 31 -FileId 31090 -Tsv backend.tsv
```

Gera TSV com `id<TAB>texto<TAB>contexto`. Quebras de linha viram `\n` literal.

### Push — envio de traduções

```powershell
./scripts/crowdin-sync.ps1 -Action Push -ProjectId 31 -Tsv lote.tsv
```

Formato: `id<TAB>texto` (2 colunas). `\n` literal é convertido em quebra de linha.
Tradução idêntica à existente é tratada como sucesso (*duplicate*).
Saída esperada: `OK=n FALHAS=0`.

### Check — auditoria de integridade

```powershell
./scripts/crowdin-sync.ps1 -Action Check -ProjectId 31 -Tsv divergencias.tsv
./scripts/crowdin-sync.ps1 -Action Check -ProjectId 31 -FileId 32199
```

Verifica, para todas as strings traduzidas:

- placeholders (`%s`, `{var}`, `{{var}}`, `${var}`, `:name`, `@string/...`)
- argumentos ICU (`plural`/`select`/`selectordinal` e seus nomes)
- balanceamento de chaves

Critério de aceite: `divergências: 0`.

### Backup — snapshot JSON de um arquivo

```powershell
./scripts/crowdin-sync.ps1 -Action Backup -ProjectId 31 -FileId 32447 -OutFile Crowdin/crowdin_translations_pt_BR.json
```

Gera `{ source, target }` por string + metadados (projeto, arquivo, idioma, data).

### Parâmetros comuns

| Parâmetro | Padrão | Descrição |
| :--- | :--- | :--- |
| `-ProjectId` | — | ID do projeto (31 = Crowdin, 863186 = Better Lyrics) |
| `-LanguageId` | `pt-BR` | Idioma de destino |
| `-FileId` | `0` | Arquivo específico (Export/Backup; filtro opcional no Check) |
| `-Tsv` | — | Entrada (Push) ou saída (Status/Export/Check) |
| `-DelayMs` | `120` | Intervalo entre envios |

---

## `validate-ptbr.ps1`

Validador local para arquivos já traduzidos (fora de plataforma ou snapshots).

```powershell
./scripts/validate-ptbr.ps1 -Path BetterLyrics/better_lyrics_messages_pt_BR.json -Source BetterLyrics/better_lyrics_messages_en.json -Format chrome
./scripts/validate-ptbr.ps1 -Path NuvioMobile/NuvioMobile_strings_pt_BR.xml -Source NuvioMobile/repo/app/src/main/res/values/strings.xml -Escape cmp
```

Verifica strings vazias, placeholders ausentes/desconhecidos, escapes Android,
duplicatas em XML, BOM e strings idênticas à fonte.

Saída: `OK` (exit 0) ou `FALHA` (exit 1) com a lista de achados.

---

## Fluxo resumido (Crowdin)

```text
Status  ->  Export  ->  traduzir em lotes  ->  Push  ->  Check  ->  Status (0 pendentes)
                                                                    |
                                                          Backup + READMEs + commit
```
