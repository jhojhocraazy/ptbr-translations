# 🎵 Better Lyrics — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) da extensão
> [Better Lyrics](https://github.com/better-lyrics/better-lyrics) para YouTube Music.**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | [Crowdin — projeto **863186** (`better-lyrics`)](https://crowdin.com/project/better-lyrics/pt-BR) |
| **Entrega** | 🟢 **Crowdin** — o bot abre PR `chore(i18n): sync translations` no upstream. Não há PR manual |
| **Catálogo (snapshot)** | **638** chaves EN e **638** pt-BR — 0 faltando, 0 sobrando (02/11/2026) |
| **Validação** | 🟢 `validate-ptbr.ps1 -Format chrome`: `OK`, 638 strings, 28 avisos de texto idêntico ao EN |
| **Aprovação formal** | 🟡 **0%** — a conta não tem permissão de *proofreader*; a aprovação depende do mantenedor |
| **Upstream hoje** | `master` em `f77dcc2` (02/11/2026), com **643** chaves EN e **637** no `pt_BR` |
| **Sync pendente** | PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019), criado em 20/10/2026 — leva o `pt_BR` a **638** |
| **Estado da PR** | 🟢 checks verdes · 🟡 `mergeState=BEHIND` (precisa de update) · 🟡 `review=REVIEW_REQUIRED` |
| **Ainda sem tradução** | **0 na plataforma**; 6 no `master` = sync do bot |
| **Clone no hub** | **não existe** — removido em 02/11/2026 (seção "Por que não há clone") |

O Crowdin está em **638/638** — 100% do traduzível. O `master` tem 643 chaves EN e 637 no `pt_BR`: as
6 que faltam são **sync do bot**, não pendência nossa (`metodologia.md` §7.2). São elas:

- `options_provider_spicylyrics` = `Spicy Lyrics`
- `lyrics_syncedBy` = `Synced by`
- `lyrics_syncedAndUploadedBy` = `Synced and uploaded by`
- `unison_detectedFromLyrics` = `Lyrics have`
- `unison_detectedUse` = `Use`
- `options_display_fullscreenControlsTooltipStates` — está no PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019), mas **em inglês**

Elas não podem ser entregues por PR manual: o texto tem de nascer no Crowdin, senão o próximo sync do
bot sobrescreve.

---

## 🎧 O que é o Better Lyrics

Extensão de navegador para **YouTube Music** — Chrome, Edge e Firefox. O que interessa para a
tradução é o que a extensão **faz**, porque cada recurso tem vocabulário próprio:

- **Letras sincronizadas** em tempo real, com destaque por linha, palavra ou sílaba.
- **Romanização** (transliteração de japonês, coreano e chinês) e tradução da letra.
- **Picture-in-Picture:** janela flutuante com a letra, sobre a arte do álbum.
- **Theme Marketplace:** loja de temas e editor de estilos, com "Playground".
- **Unison:** acervo colaborativo de letras, com votação, revisões e denúncias.

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

> ⚠️ **Nota de escopo:** este módulo cobre **só** a extensão do YouTube Music (Crowdin **863186**).
> O aplicativo desktop homônimo, para Spotify e Apple Music, é outro projeto e não faz parte deste hub.

---

## 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Plataforma (fonte de verdade)** | Crowdin 863186, idioma `pt-BR` |
| **Arquivo no upstream** | `_locales/en/messages.json` → `_locales/pt_BR/messages.json` |
| **Snapshot EN (fonte fixa)** | [`snapshots/better_lyrics_messages_en.json`](./snapshots/better_lyrics_messages_en.json) |
| **Snapshot pt-BR (estado atual)** | [`snapshots/better_lyrics_messages_pt_BR.json`](./snapshots/better_lyrics_messages_pt_BR.json) |

**A pasta no upstream é `pt_BR`, com underscore; o idioma no Crowdin é `pt-BR`, com hífen.** O
`crowdin.yml:14` faz esse mapeamento porque o Chrome exige o nome da pasta no formato dele. Uma pasta
`pt-BR` produziria uma tradução que a extensão nunca carrega.

O upstream tem 24 pastas de locale (`en` + 23 traduções). Nenhuma delas serve de origem — e a
armadilha específica deste projeto é o **`pt_PT`**, que existe, é português e não é brasileiro.

**O snapshot pt-BR não é cópia do PR.** Ele é o estado mais recente do Crowdin; o PR é o que foi
exportado em 20–21/10. A diferença é real e está medida na seção "O que a PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) carrega".

---

## 📁 Arquitetura dos arquivos locais

```text
BetterLyrics/
├── snapshots/
│   ├── better_lyrics_messages_en.json     # espelho fixo da fonte EN (638 chaves)
│   └── better_lyrics_messages_pt_BR.json  # estado mais recente do Crowdin em pt-BR
├── README.md                  # este documento
├── diretrizes-tecnicas.md     # o método aplicado ao formato Chrome i18n
└── glossario.md               # o vocabulário
```

O EN é **fixo de propósito**: é a régua do validador, e uma régua que muda a cada sync transforma
"string nova no upstream" em "tradução faltando". Quem detecta novidade é a comparação com o
`master`, não o validador.

---

## 🔄 Como a entrega funciona

1. O mantenedor do upstream adiciona ou edita strings em `_locales/en/messages.json`.
2. O bot do Crowdin leva a fonte nova para a plataforma.
3. A tradução é feita no **editor do Crowdin** — projeto 863186, idioma `pt-BR`
   (`CONTRIBUTING.md:146-148`).
4. O bot abre um PR automático no upstream com o título `chore(i18n): sync translations`
   (`crowdin.yml:2`), com as labels `i18n` e `crowdin`.
5. O PR roda as checagens do projeto e é mergeado no `master`.

**Este hub não commita em `_locales/`.** O snapshot é o registro; a entrega é da plataforma.

### Por que não há clone

A regra do hub é clone só onde o clone é o veículo de entrega
([`organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md)). Better Lyrics entrega por
Crowdin, então o clone não entregava nada — era uma cópia de leitura, parada em 20/10/2026 e
**6 chaves** atrás do `master` (637 contra 643).

O que ele dava e o que ficou no lugar:

| O clone servia para | Substituto |
| :--- | :--- |
| Ler o EN mais recente | `gh api` no `master`, ou o `curl.exe` da seção de snapshots |
| Ler `CONTRIBUTING.md` e `crowdin.yml` | `gh api` |
| Rodar as checagens do projeto | o CI do upstream, no PR do bot |
| Dar contexto de tela | o campo `description` de cada chave |

O custo foi **7,9 MB** a menos. O preço: as checagens do projeto não rodam mais aqui.

---

## 📦 O que a PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) carrega

Medido com `gh pr view 1019` em 02/11/2026:

| Item | Valor |
| :--- | :--- |
| Commits | **27**, de 20/10 17:55 a 21/10 22:48 |
| Arquivos | **23** — todos em `_locales/` |
| Linhas | **+204 / −112** no total |
| Só o `pt_BR` | **+64 / −60** |
| Estado | `mergeable=MERGEABLE`, `mergeState=BEHIND`, `review=REVIEW_REQUIRED` |
| Checks | 🟢 `brand-check`, `stale-check`, `CodeQL`, `Socket Security` — todos `SUCCESS` |

`BEHIND` significa que a PR está atrás do `master`: precisa de update antes do merge, e o merge não
vai acontecer sozinho.

**A armadilha: a PR está mais velha que o Crowdin.** Comparando as 638 chaves do PR com as 638 do
snapshot, **7 strings** divergem — e o snapshot é o lado novo. A pior:

| Chave | No PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) | No Crowdin hoje (snapshot) |
| :--- | :--- | :--- |
| `options_display_fullscreenControlsTooltipStates` (`:112`) | `Auto hides the controls while the player bar is showing. On keeps them visible.` — **em inglês** | `Automático oculta os controles enquanto a barra do player estiver visível. Ligado mantém os controles visíveis.` |

As outras 6 são redações anteriores, corrigidas depois no Crowdin:

- `options_pipTransition_crossfade` (`:222`): `Fade cruzado` → **`Crossfade`**
- `marketplace_shortcutsInstallUrl` (`:1080`): `Instalar de URL` → **`Instalar por URL`**
- `marketplace_tooltipRating` (`:1286`): `Média de $AVERAGE$ de $COUNT$ avaliações` → **`Média de $AVERAGE$ em $COUNT$ avaliações`**
- `options_general_clearCachedLyricsHint` (`:46`): `Elas baixam de novo…` → **`Elas são baixadas de novo…`**
- `options_display_letterWaveTooltip` (`:136`): `rolagem parecer travada` → **`rolagem das letras ficar aos trancos`**
- `unison_sortAscendingClearLabel` (`:1384`): `$LABEL$, crescente` → **`$LABEL$, ordem crescente`**

**Consequência prática:** mergear a [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) hoje publicaria **uma string em inglês** e seis redações
antigas. O `stale-check` não pega esse caso — ele acusa tradução que ficou presa numa versão **antiga**
do inglês, não tradução que é o inglês **atual**. O próximo sync do bot corrige tudo, porque o Crowdin
já tem o texto certo.

---

## 🧪 Como conferir

```powershell
./scripts/validate-ptbr.ps1 `
  -Path   BetterLyrics/snapshots/better_lyrics_messages_pt_BR.json `
  -Source BetterLyrics/snapshots/better_lyrics_messages_en.json `
  -Format chrome
```

Resultado de 02/11/2026:

```text
OK   better_lyrics_messages_pt_BR.json  (638 strings, perfil=chrome, escape=none)
     avisos: 28 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

As 29 strings idênticas ao EN são marca, sigla, nome de formato ou string composta só de
placeholders — nenhuma é frase esquecida em inglês. O validador avisa 28 porque uma delas
(`options_general_segment`, `$LABEL$: $VALUE$`) não tem nenhuma palavra.

### Atualizar os snapshots

```powershell
# EN (espelho fixo) — só quando a tradução for refeita contra uma fonte nova
curl.exe -sL "https://raw.githubusercontent.com/better-lyrics/better-lyrics/master/_locales/en/messages.json" `
  -o BetterLyrics/snapshots/better_lyrics_messages_en.json

# pt-BR — o estado que a extensão entrega depois do merge do PR de sync
curl.exe -sL "https://raw.githubusercontent.com/better-lyrics/better-lyrics/master/_locales/pt_BR/messages.json" `
  -o BetterLyrics/snapshots/better_lyrics_messages_pt_BR.json
```

`curl.exe` grava os bytes como vêm. `Set-Content` e `>` trocam o fim de linha para CRLF e o arquivo
deixa de bater com o do upstream.

> **Rode o comando do pt-BR só depois do merge.** Hoje o `master` tem **637** chaves e o snapshot tem
> **638** — o snapshot está à frente, não atrás. Rodar agora rebaixaria o arquivo.

Cobertura e pendências no Crowdin exigem token:

```powershell
./scripts/crowdin-sync.ps1 -Action Status -ProjectId 863186
```

---

## ⚠️ Lacunas

1. **6 chaves ausentes no `master`** (5 novas + a que o PR carrega em inglês). Dependem do Crowdin/sync.
2. **A PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) está `BEHIND` e carrega 7 strings desatualizadas**, uma delas em inglês. Falta: o bot
   rodar de novo — ou o mantenedor mergear e aceitar que o próximo sync corrige.
3. **Estado do Crowdin não reverificado.** Sem `CROWDIN_TOKEN` nesta sessão, a última medição local é
   de 30/10/2026 (638/638). Falta rodar `Status`.
4. **0% aprovado.** O catálogo está traduzido, mas a conta não tem permissão de *proofreader*.
5. **As checagens do projeto só rodam no CI do upstream** — sem clone, não há checkout local.
6. **21 chaves têm EN de uma palavra e pt-BR de duas ou mais**, contra a regra
   `CONTRIBUTING.md:156`. Algumas são inevitáveis; outras poderiam encurtar.
7. **Nomes de tipo de sincronização em aberto** (`Richsync`, `Linesync`, `Plain`) — o mesmo texto vira
   badge em card. Decisão pendente no glossário.
8. **Nada foi aberto no navegador.** Nenhuma regra de espaço de tela foi conferida em popup, opções
   ou Picture-in-Picture reais.
9. **O snapshot está 5 chaves atrás do EN do `master`** — de propósito, porque o espelho é fixo.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método de tradução aplicado ao Better
  Lyrics: chave ➔ inglês ➔ o que o usuário vê ➔ pt-BR ➔ regras do projeto. Formato Chrome i18n,
  placeholders `$NOME$`, plurais por par de chaves e o comando de validação.
- 📗 [**Glossário de termos**](./glossario.md) — o vocabulário: o que fica em inglês, o que se traduz
  e por quê, com `chave:linha` em cada decisão.
- 🗂️ [**Snapshots**](./snapshots/) — cópia versionada dos dois catálogos.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 638 chaves EN e 638 pt-BR | contagem em `BetterLyrics/snapshots/*.json` em 02/11/2026 |
| `OK`, 638 strings, 28 avisos | `validate-ptbr.ps1 -Format chrome` em 02/11/2026 |
| 29 strings idênticas ao EN | comparação chave a chave EN × PT |
| 643 EN / 637 PT no `master`; 638 no PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) | API do GitHub em 02/11/2026 (`contents?ref=master`, `?ref=refs/pull/1019/head`) |
| 5 chaves novas sem tradução | diferença de chaves `master` EN × PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) PT |
| PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019): 27 commits, 23 arquivos, +204/−112, `pt_BR` +64/−60 | `gh pr view 1019 --json commits,files,additions,deletions` |
| `mergeState=BEHIND`, `mergeable=MERGEABLE`, `review=REVIEW_REQUIRED` | `gh pr view 1019 --json mergeStateStatus,mergeable,reviewDecision` |
| `brand-check`, `stale-check`, `CodeQL`, `Socket` = `SUCCESS` | `gh pr view 1019 --json statusCheckRollup` |
| 7 strings divergentes entre PR e snapshot | comparação chave a chave do `pt_BR` do PR × snapshot |
| HEAD do `master` = `f77dcc2` (02/11/2026) | `gh api repos/better-lyrics/better-lyrics/commits/master` |
| PRs [#975](https://github.com/better-lyrics/better-lyrics/pull/975)/[#994](https://github.com/better-lyrics/better-lyrics/pull/994)/[#1001](https://github.com/better-lyrics/better-lyrics/pull/1001)/[#1010](https://github.com/better-lyrics/better-lyrics/pull/1010) mergeados, [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) aberto | `gh pr list --search "i18n in:title" --state all` |
| 24 pastas de locale | `contents/_locales` na API do GitHub |
| `pt-BR` → `pt_BR` | `crowdin.yml:14` |
| Clone removido: 7,9 MB, 0 commits locais | `Measure-Object` e `git log` antes da remoção, em 02/11/2026 |
| 0% aprovado | última leitura do projeto no Crowdin, 30/10/2026 — **não reverificada** |
