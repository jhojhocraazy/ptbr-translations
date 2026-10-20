# 🛠️ Scripts do hub ptbr-translations

Ferramentas de apoio ao ciclo de tradução. Nenhum script publica no GitHub:
para projetos em Crowdin/Weblate a entrega termina na plataforma
(ver [`../metodologia.md`](../metodologia.md)).

---

## Requisitos

- PowerShell 7+
- Token pessoal da API do Crowdin (apenas para `crowdin-sync.ps1`)
- Token pessoal da API do Weblate (apenas para `weblate-sync.ps1`)

```powershell
$env:CROWDIN_TOKEN = 'seu-token'
$env:WEBLATE_TOKEN = 'seu-token'
```

> Os tokens nunca devem ser commitados. Os scripts leem apenas as variáveis de ambiente
> `CROWDIN_TOKEN`/`WEBLATE_TOKEN` (ou o parâmetro `-Token`).

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

## `weblate-sync.ps1`

Ciclo completo de um projeto Weblate: status, exportação, envio, auditoria e backup.

### Status — cobertura por componente

```powershell
./scripts/weblate-sync.ps1 -Action Status -Project elowry
./scripts/weblate-sync.ps1 -Action Status -Project elowry -Component dnstoggle-strings
```

Saída: traduzidas/total, pendentes, checagens falhando e última alteração.

### Export — unidades de um componente

```powershell
./scripts/weblate-sync.ps1 -Action Export -Project elowry -Component dnstoggle-strings -Tsv strings.tsv
./scripts/weblate-sync.ps1 -Action Export -Project elowry -Component dnstoggle-strings -All -Tsv todas.tsv
./scripts/weblate-sync.ps1 -Action Export -Project ytdlnis -Component strings -All -Format json -OutFile unidades.json
```

TSV (padrão) gera `id<TAB>contexto<TAB>fonte<TAB>destino`. Sem `-All`, exporta apenas pendentes.
JSON preserva `source` e `target` como arrays — necessário para plurais.

### Push — envio de strings de forma única

```powershell
./scripts/weblate-sync.ps1 -Action Push -Project elowry -Component dnstoggle-strings -Tsv lote.tsv
```

Formato: `id<TAB>texto` (2 colunas). `\n` literal vira quebra de linha. Saída: `OK=n FALHAS=0`.
Aceita apenas strings de forma única: **recusa unidades plurais** e orienta usar `PushJson`.

### PushJson — envio de plurais e lotes em JSON

```json
[
  { "id": 197849591, "context": "every_days", "target": ["Todo dia", "A cada %d dias", "A cada %d dias"] }
]
```

```powershell
./scripts/weblate-sync.ps1 -Action PushJson -Project ytdlnis -Component strings -Json lote.json
```

O payload aceita `id`, `context` (opcional) e `target` como string ou array. O `context` ajuda a
conferir a unidade. Preencha `many` com o mesmo conteúdo de `other` quando o Weblate exigir três formas.

### Check — auditoria de integridade

```powershell
./scripts/weblate-sync.ps1 -Action Check -Project elowry -Component dnstoggle-strings -Tsv divergencias.tsv
```

Compara placeholders, argumentos ICU e balanceamento de chaves. Critério: `divergências: 0`.

### Checks — checks nativos do Weblate

```powershell
./scripts/weblate-sync.ps1 -Action Checks -Project ytdlnis -Component strings -Tsv checks.tsv
```

Lista as unidades com `has_failing_check` e grava TSV. Use para revisar falsos positivos;
não substitui o `Check` de placeholders/ICU/chaves.

### Backup — arquivo traduzido

```powershell
./scripts/weblate-sync.ps1 -Action Backup -Project elowry -Component dnstoggle-strings -OutFile DNSToggle/dnstoggle_strings_pt_BR.xml
```

Baixa o arquivo no formato nativo do componente (XML/JSON/etc.). Unidades read-only podem ser
omitidas do arquivo — isso é esperado. Após baixar, escaneie escapes duplicados (`\\'`/`\\\"`)
e valide antes de commitar.

### Parâmetros comuns

| Parâmetro | Padrão | Descrição |
| :--- | :--- | :--- |
| `-Project` | — | Slug do projeto (ex.: `elowry`) |
| `-Component` | — | Slug do componente (obrigatório em Export/Push/PushJson/Check/Checks/Backup) |
| `-Language` | `pt_BR` | Código do idioma no Weblate |
| `-Format` | `tsv` | Formato do Export (`tsv` ou `json`) |
| `-Tsv` | — | Entrada (Push) ou saída (Status/Export/Check/Checks) |
| `-Json` | — | Entrada do PushJson (arquivo JSON) |
| `-OutFile` | — | Saída do Export JSON e do Backup |
| `-All` | — | Exporta também unidades já traduzidas |
| `-Force` | — | Em `PushJson`, permite divergência na quantidade de formas plurais |
| `-DelayMs` | `150` | Intervalo entre envios |

> O Weblate pode estar atrás do Anubis. O script usa um User-Agent de navegador;
> se ainda assim a API retornar HTML, verifique o token e o acesso à instância.

---

## ⚠️ Armadilhas

- **Target cru:** o Weblate recebe texto cru. Não envie `\'`/`\"` manualmente; o exportador
  Android adiciona os escapes e o XML final deve ter escapes simples.
- **Plurais:** `target` é array; não concatenar formas. Use `Export -Format json` + `PushJson`;
  `Push -Tsv` recusa plurais.
- **Read-only:** `state=100`, target vazio e `PATCH 403` são esperados; a unidade é omitida do
  backup e o Android usa o fallback da fonte.
- **Over-escape:** `\\'`/`\\\"` no XML final é defeito; escaneie o backup antes de commitar.
- **Checks falsos positivos:** `multiple_capital` (`JSON`/`Info-JSONs`) e `same` (`Nightly`) podem
  permanecer; documente a justificativa no `README.md` do projeto.
- **Token:** use `WEBLATE_TOKEN`/`CROWDIN_TOKEN` ou `-Token`; nunca versionar e apagar temporários
  que contenham token.

---

## `validate-ptbr.ps1`

Validador local para arquivos já traduzidos (fora de plataforma ou snapshots).

```powershell
./scripts/validate-ptbr.ps1 -Path BetterLyrics/better_lyrics_messages_pt_BR.json -Source BetterLyrics/better_lyrics_messages_en.json -Format chrome
./scripts/validate-ptbr.ps1 -Path NuvioMobile/NuvioMobile_strings_pt_BR.xml -Source NuvioMobile/repo/app/src/main/res/values/strings.xml -Escape cmp
```

Verifica strings vazias, placeholders ausentes/desconhecidos, escapes Android,
duplicatas em XML, BOM e strings idênticas à fonte.

No modo Android (`-Format xml -Escape android`), também detecta escapes duplicados
(`\\'`/`\\\"`), que indicam over-escaping. As 2 aspas externas de `downloaded` e
`process_downloads_background` no YTDLnis são falsos positivos intencionais (as aspas fazem
parte do texto exibido) e não devem ser "corrigidas".

Saída: `OK` (exit 0) ou `FALHA` (exit 1) com a lista de achados.

---

## Fluxos resumidos

**Crowdin:**

```text
Status  ->  Export  ->  traduzir em lotes  ->  Push  ->  Check  ->  Status (0 pendentes)
                                                                    |
                                                          Backup + READMEs + commit
```

**Weblate:**

```text
Status  ->  Export (TSV ou JSON)  ->  traduzir em lotes  ->  Push / PushJson  ->  Check + Checks  ->  Status (0 pendentes)
                                                                                                          |
                                                                                         Backup + validação + READMEs + commit
```
