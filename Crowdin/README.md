# 🌐 Crowdin Platform — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) da plataforma oficial do
> [Crowdin](https://crowdin.com).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | Crowdin — projeto **31** (`crowdin`), idioma `pt-BR` |
| **Entrega** | 🟢 **Crowdin** — submissão direta na plataforma; não há PR de tradução |
| **Escopo** | **18.823** strings visíveis em **214** arquivos |
| **Cobertura** | 🟡 **18.479/18.823 (98,2%)** — **344 pendentes** em 1 arquivo (03/11/2026) |
| **Pendências por arquivo** | `backend.en_US.csv` 344/4.329 · `auth.php` 69/69 · `workspace.php` 41/41 · `en.json` 3.643/3.643 |
| **Snapshot local** | `snapshots/crowdin_translations_pt_BR.json` — só `en.json` (3.639 strings, 03/11/2026) |
| **Auditoria** | **17.542 verificadas, 0 divergências** (03/11/2026); lote de 10 fechou 41+69+3.639 com 0 divergências |
| **Integração** | Crowdin REST API v2 (`https://api.crowdin.com/api/v2/`) |
| **Clone no hub** | **não existe** — projeto de plataforma |

O projeto **não está 100%**: restam 344 strings em `backend.en_US.csv`. O snapshot local cobre
apenas o `en.json`; os outros 213 arquivos só existem na plataforma.

---

## 🌐 O que é o Crowdin

Plataforma global de gerenciamento contínuo de localização (**TMS / CAT tool**), usada por milhares de
empresas e projetos de código aberto. A interface combina:

- **Web app moderno** (`src/i18n/locales/en.json`): painel, projetos, estimativas, memórias, IA e
  relatórios.
- **Backend e autenticação** (`resources/lang/en/`): login, 2FA, SSO e configurações de equipe.
- **E-mails e notificações** (`email_templates/`): comunicações transacionais.
- **CSV e PHP/Blade:** editor, frontend, backend, escopos, MFA e workspace.

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Plataforma (fonte de verdade)** | Crowdin, projeto **31**, idioma `pt-BR` |
| **Arquivos** | 214, incluindo `en.json` (32447), `editor.csv`, `dynamic.csv`, `backend.csv`, `frontend.csv`, `auth.php`, `workspace.php`, `scopes.php`, `mfa.php` |
| **Snapshot do hub** | [`snapshots/crowdin_translations_pt_BR.json`](./snapshots/crowdin_translations_pt_BR.json) |
| **Entrega** | submissão direta na plataforma |
| **Clone no hub** | **não existe** |

O snapshot é um recorte do `en.json`: 3.639 strings com `source`/`target`, gerado em 03/11/2026. Ele
**não** representa os 18.823 do projeto; 4 das 3.643 strings não aparecem no backup.

---

## 📦 O que foi entregue

| Data | Lote | Resultado |
| :--- | :--- | :--- |
| 22/10/2026 | 286 strings | 157 em `en.json`, 110 em `editor.csv`, 12 em `backend.csv`, 7 em `dynamic.csv`; 8 divergências antigas corrigidas |
| 26/10/2026 | 51 strings | 18 em `backend.csv`, 14 em `auth.php`, 7 em `dynamic.csv`, 7 em `workspace.php`, 5 em `scopes.php` |
| 28/10/2026 | 55 strings | 27 em `dynamic.csv`, 19 em `backend.csv`, 7 em `en.json`, 2 em `scopes.php` |
| 30/10/2026 | 62 strings + 17 correções | 27 em `editor.csv`, 11 em `backend.csv`, 10 em `frontend.csv`, 7 em `dynamic.csv`, 1 em `mfa.php`, 6 em `en.json`; TM ≠ MT, AI → IA, workflow → fluxo de trabalho, engines → motores |
| 03/11/2026 | 10 strings | 2 em `workspace.php`, 6 em `auth.php`, 2 em `en.json`; os três arquivos ficaram com 0 pendentes |
| 03/11/2026 | 4 strings | 4 erros do DeepL Translator em `backend.en_US.csv` (18.819 → 18.823 strings) |

A auditoria de 30/10/2026 fechou 17.515 strings com 0 divergências. Em 03/11/2026 a plataforma
mostra 18.823 strings e 344 pendentes; o `Check` completo fechou 17.542 com 0 divergências.

A varredura semântica de 03/11/2026 encontrou três problemas graves, **corrigidos via `Push`**:
`profile.crowdinApps.allUsersIncludeGuests` (“Portuese ”), a headline `alternatives.lokalise.hero.title`
(em inglês) e `generic.integrationTool` (em inglês). Também corrigiu “vá para a aba… baixar a fatura”,
“Traduzir arquivo: {file}” e “As taxas não foram salvas”.

Em 03/11/2026 (07:46) o typo “aquivos” de
`learn.mobileAppEbook.whatIsLocalization.paragraph2` (`en.json`) foi corrigido. O typo “aquivo”
(`activity.userDeletedFileFromProject`, `backend.en_US.csv`) e o espaço final em
`settings.betaFeatures` (`frontend.en_US.csv`) **não** foram corrigidos: a API recusa substituir
tradução de outro usuário (“Duplicate translation. Please vote or approve the original”) e não expõe
edição de tradução existente (`PATCH` → 405). Precisam de edição na interface do Crowdin.

---

## 🧪 Como conferir

Precisa de `CROWDIN_TOKEN` no ambiente (ou `scripts/tokens.ps1`, ignorado pelo Git):

```powershell
./scripts/crowdin-sync.ps1 -Action Status -ProjectId 31
./scripts/crowdin-sync.ps1 -Action Check  -ProjectId 31 -Tsv divergencias.tsv
```

Resultado de 02/11/2026:

```text
Projeto 31 | 18819 strings | 344 pendentes
  31090  backend.en_US.csv  344/4325
  32187  auth.php             6/69
  32219  workspace.php        2/41
  32447  en.json              2/3643
```

`Check` audita placeholders, ICU e balanceamento; critério: **0 divergências**. Ele não mede fluência
nem espaço de tela.

---

## 🔄 Como a entrega funciona

1. A string é traduzida **no editor do Crowdin** (projeto 31, idioma `pt-BR`).
2. O mantenedor publica na plataforma; o Crowdin sincroniza com o produto.
3. Este hub registra o estado em `snapshots/` e nos READMEs. **Não há PR, branch ou merge aqui.**

O commit no hub é documentação, não entrega. Ele não substitui nem antecede a plataforma.

---

## ⚠️ Lacunas

1. **344 pendentes.** Restam só no `backend.en_US.csv`; `auth.php`, `workspace.php` e `en.json` fecharam em 03/11/2026.
2. **Snapshot parcial.** Só o `en.json` está versionado, e com 3.639 das 3.643 strings.
3. **Sem validação de todos os arquivos.** `Check` cobre integridade, não fluência.
4. **Sem interface aberta.** Nenhuma regra de espaço de tela foi conferida na UI real.
5. **Crescimento semanal.** O `en.json` e o `backend.csv` recebem strings novas toda semana; meça
   antes de citar um número.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método aplicado a ICU, chaves, CSV e
  PHP/Blade; placeholders, HTML, validação e espaço de tela.
- 📗 [**Glossário de termos**](./glossario.md) — TMS, TM × MT, workflow, vendor e o vocabulário da
  interface.
- 🗂️ [**Snapshot**](./snapshots/) — recorte do `en.json` em 30/10/2026.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 18.823 strings, 344 pendentes | `crowdin-sync.ps1 -Action Status -ProjectId 31` em 03/11/2026, após o `Push` das 10 |
| 344/4.329; 69/69; 41/41; 3.643/3.643 | mesma execução, por arquivo |
| 3.639 strings no snapshot | `total_submitted` do JSON, gerado em 03/11/2026 04:16 |
| 214 arquivos | `research/README.md` e dashboard |
| 17.542 verificadas, 0 divergências; 18.823 exportadas | `Check` + export da API em 03/11/2026 |
| 41, 69 e 3.639 verificadas com 0 divergências | `crowdin-sync.ps1 -Action Check -FileId 32219/32187/32447` em 03/11/2026 |
| 9 correções aplicadas (7 efetivas, 2 pendentes) | `crowdin-sync.ps1 -Action Push -ProjectId 31` em 03/11/2026 |
| 286/51/55/62 strings por lote | histórico do README anterior, mantido |
