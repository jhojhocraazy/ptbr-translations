# 🎵 BitChord — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) do
> [BitChord](https://github.com/kushagrasinghx/BitChord).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | Kotlin Multiplatform (**KMP** — um código-fonte, vários apps) + Compose Multiplatform |
| **Catálogos de string** | **3**: `app/` (Android e Android Auto), `sharedUi/` (UI compartilhada) e `wearos/` (relógio) |
| **Paridade de chaves** | 🟢 **100%** nos 3 catálogos — 0 chaves faltando, 0 sobrando (`validate-ptbr.ps1`, 02/11/2026) |
| **Unidades verificadas** | **1.448** (1.159 no `app/` + 249 no `sharedUi/` + 40 no `wearos/`) |
| **Pull Request** | [#1204](https://github.com/kushagrasinghx/BitChord/pull/1204) — `OPEN`, base `main`, `MERGEABLE` |
| **CI da PR** | 🟢 `Android`, `Android TV` e `Backend · Go` com `SUCCESS` |
| **Testes nativos** | 🟢 passaram no CI: o job `Android` roda `./gradlew testDevDebugUnitTest` (`.github/workflows/check.yml:45-46`) |
| **O que falta para mergear** | Revisão do mantenedor (`mergeState=BLOCKED`, `review=REVIEW_REQUIRED`) |
| **Branch de trabalho** | `i18n/pt-br-182`, commit `706ccb0` (30/10/2026 18:20) |
| **Versão no clone** | `1.9` / `versionCode 36` (`build.gradle.kts:44-45`) |
| **Upstream** | [`kushagrasinghx/BitChord`](https://github.com/kushagrasinghx/BitChord) — 5.312 estrelas em 02/11/2026 |

A PR está verde de CI e pronta tecnicamente. O bloqueio é revisão, não código — a falha de build na
base que estava registrada nas notas de trabalho (`Unresolved reference 'SfSymbols'`) **não aparece
mais** nos checks de 02/11/2026.

---

## 🎧 O que é o BitChord

Cliente de **YouTube Music** para Android, com estética inspirada no Apple Music. O que interessa para
a tradução é o que o app **faz**, porque cada recurso tem vocabulário próprio:

- **Áudio de alta fidelidade:** saída bit-perfect para **DAC** (conversor digital-analógico),
  reamostragem, equalizador de 7 bandas, normalização de volume e áudio espacial.
- **Android Auto:** painel do carro, com telas próprias de escolhas rápidas, recentes e curtidas.
- **Wear OS:** app de relógio, com player e fila próprios — e um catálogo de strings separado.
- **Android TV:** módulo `tv/` que **reaproveita** os recursos do `app/` (`tv/README.md:7-9`), então
  não tem catálogo de strings próprio.
- **Ouvir junto:** sessão sincronizada entre dispositivos, chamada de "festa" na interface.
- **Fontes externas:** **addons** (catálogos de terceiros), **WebDAV** e **SMB**.

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 🗂️ Onde a tradução vive

| Módulo | Fonte EN (a referência) | Tradução pt-BR | `<string>` | `<plurals>` | `<string-array>` |
| :--- | :--- | :--- | :---: | :---: | :---: |
| **Android** (`app/`) | `app/src/main/res/values/strings.xml` | `app/src/main/res/values-pt/strings.xml` | 1.112 de 1.138 | 23 | — |
| **UI compartilhada** (`sharedUi/`) | `sharedUi/src/commonMain/composeResources/values/strings.xml` | `.../values-pt/strings.xml` | 249 | — | 2 |
| **Wear OS** (`wearos/`) | `wearos/src/main/res/values/strings.xml` | `wearos/src/main/res/values-pt/strings.xml` | 40 | — | — |

**Por que 1.112 e não 1.138 no `app/`:** 26 das 1.138 strings da fonte carregam
`translatable="false"` — marca que diz "não traduza" (nome próprio, marca, termo técnico). O teste
nativo ignora essas chaves dos dois lados (`LocaleStringsTest.kt:44`), então 1.138 − 26 = **1.112** é
o total correto.

**Onde o pt-BR é o primeiro:** em `wearos/` a pasta `values-pt` **não existe no upstream** — nem em
`v1.8.2`, nem em `main` (verificado com a API do GitHub em 02/11/2026). Esta entrega cria a tradução
do relógio do zero.

O `app/` tem 20 pastas de locale: `values` (inglês) e 19 traduções (`de`, `es`, `fr`, `he`, `hi`,
`id`, `it`, `ja`, `ko`, `pl`, `pt`, `ru`, `th`, `tr`, `vi`, `zh`, `zh-rHK`, `zh-rTW`, `zh+Hant`).
Nenhuma delas serve de origem — a fonte é sempre o inglês do mesmo módulo.

**Não há tradução em `web/`.** O app web (`web/app/`) e a extensão (`web/extension/`) são TypeScript
sem arquivo de locale: nenhum `i18n`, `locales` ou `messages` no repositório. Quem usa o BitChord no
navegador vê inglês.

---

## 📦 O que a entrega contém

Tudo abaixo foi lido da PR [#1204](https://github.com/kushagrasinghx/BitChord/pull/1204) (`gh pr view 1204`) e dos catálogos nas tags, em 02/11/2026 — não é
resumo de memória.

| # | O que | Evidência |
| :---: | :--- | :--- |
| 1 | **6 commits**, de 30/10/2026 17:15 a 21:20 | `gh pr view 1204 --json commits` |
| 2 | **`app/` reescrito:** 189 linhas adicionadas, 189 removidas | arquivos da PR |
| 3 | **`sharedUi/` completado:** 106 adicionadas, 27 removidas | arquivos da PR |
| 4 | **`wearos/` criado:** 43 linhas adicionadas, 0 removidas | arquivos da PR |
| 5 | **145 strings novas do upstream traduzidas** | EN de `v1.8.1` ➔ `v1.8.2`: `app` 1.063 ➔ 1.138 (**+75**) e `sharedUi` 179 ➔ 249 (**+70**) |
| 6 | **Nada ficou pendente após a `v1.8.2`** | EN de `v1.8.2`, `v1.9` e `main` têm o mesmo catálogo (1.138 + 23 plurais no `app`; 249 + 2 arrays no `sharedUi`) — no `app`, os arquivos são byte a byte iguais |

O item 6 fecha uma dúvida que estava aberta: o rebase para a `main` **não trouxe string nova**, então
não houve retradução depois do rebase.

---

## 🧪 Como conferir

O hub não compila o app. O passo equivalente é o validador, rodado contra o EN do clone:

```powershell
./scripts/validate-ptbr.ps1 -Path BitChord/snapshots/bitchord_strings_pt_BR.xml `
  -Source BitChord/repo/app/src/main/res/values/strings.xml -Format xml -Escape android
```

Resultado de 02/11/2026:

```text
OK   bitchord_strings_pt_BR.xml  (1159 strings, perfil=xml, escape=android)
     avisos: 38 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
OK   sharedUi_strings_pt_BR.xml  (249 strings, perfil=xml, escape=android)
     avisos: 10 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
OK   wearos_strings_pt_BR.xml    (40 strings, perfil=xml, escape=android)
     avisos: 2 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

As 1.159 "strings" do relatório são **1.112 `<string>` + 47 `<item>` de plural** — o validador conta
cada forma de plural como uma unidade.

> **Cuidado:** o validador compara o snapshot com o EN **do clone**. Clone velho, resultado velho.
> Rode `git -C BitChord/repo fetch upstream` antes de confiar no número.

O snapshot versionado em [`snapshots/`](./snapshots/) é cópia exata dos três catálogos. Quem entrega é
a branch, via PR; o snapshot sobrevive se a branch for fechada ou rebaseada.

---

## 🛠️ Trabalhar no clone (`repo/`)

A pasta [`repo/`](./repo/) é um clone do fork, raso (`--depth 1`) e na branch da PR.

| Remoto | URL |
| :--- | :--- |
| `origin` | `https://github.com/jhojhocraazy/BitChord.git` (fork pessoal) |
| `upstream` | `https://github.com/kushagrasinghx/BitChord.git` (projeto original — só leitura) |

**Qual branch usar como base.** O `CONTRIBUTING.md:12` pede a branch do ciclo de release ativo, não a
`main`. A branch `v1.8.2` existe no upstream, mas **as duas PRs desta tradução apontam para `main`**
([#952](https://github.com/kushagrasinghx/BitChord/pull/952) fechada em 28/10/2026, [#1204](https://github.com/kushagrasinghx/BitChord/pull/1204) aberta) e o catálogo EN de `v1.8.2` é **idêntico** ao de `main`
hoje. Ou seja: a divergência de regra existe, mas não muda nenhuma string. Se o mantenedor pedir a
troca de base, o diff é o mesmo.

---

## ⚠️ Lacunas

1. **Revisão do mantenedor.** A PR está `MERGEABLE` e com CI verde; falta o `review` exigido pelo
   repositório. Nada mais depende do hub.
2. **Plurais incompletos.** 22 dos 23 blocos `<plurals>` do `app/` têm só `one` e `other` — falta a
   forma `many` do pt-BR. O CI não acusa, porque o teste compara nomes de chave, não formas de
   quantidade (`LocaleStringsTest.kt:38-48`). Decisão pendente: completar as 22 ou aceitar.
3. **`web/` sem tradução.** O app web e a extensão não têm arquivo de locale. Não há entrega pt-BR
   para eles.
4. **`tv/` sem catálogo próprio.** Reaproveita o `app/` (`tv/README.md:7-9`), então herda a tradução
   — mas nada verifica o Android TV separadamente além do CI, que compila o módulo.
5. **Nada foi rodado em aparelho.** O hub não compila nem instala o app. Nenhuma regra de espaço de
   tela (Android Auto, Wear OS) foi conferida em dispositivo real.
6. **Testes nativos só no CI.** `LocaleStringsTest` e `LocalizationTest` rodaram no job `Android` do
   CI da PR (`check.yml:45-46`, `SUCCESS` em 30/10/2026) — não foram executados neste hub, que não tem
   Gradle configurado. Eles comparam **chaves**, não texto: trocar `%1$s` por `%2$s` passaria.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método de tradução aplicado ao BitChord:
  chave ➔ inglês ➔ o que o usuário vê ➔ pt-BR ➔ regras do projeto. XML, placeholders, plurais,
  testes e o comando de validação.
- 📗 [**Glossário de termos**](./glossario.md) — o vocabulário: o que fica em inglês, o que se traduz
  e por quê, com `chave:linha` em cada linha.
- 🗂️ [**Snapshots**](./snapshots/) — cópia versionada dos três catálogos pt-BR.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 1.112 `<string>` + 23 `<plurals>` (47 itens) no `app/` | `values-pt/strings.xml`, contagem de 02/11/2026 |
| 1.138 `<string>` e 26 `translatable="false"` na fonte | `values/strings.xml`, contagem de 02/11/2026 |
| 249 `<string>` + 2 arrays (12 itens cada) no `sharedUi/` | `values-pt/strings.xml` |
| 40 `<string>` no `wearos/` | `values-pt/strings.xml` |
| 1.159 + 249 + 40 = 1.448 unidades | saída do `validate-ptbr.ps1` em 02/11/2026 |
| 145 strings novas entre `v1.8.1` e `v1.8.2` | conteúdo de `values/strings.xml` e `composeResources/values/strings.xml` nas duas tags, via API do GitHub |
| `v1.8.2` e `main` com catálogo idêntico | comparação byte a byte dos dois arquivos EN em 02/11/2026 |
| `wearos/values-pt` ausente no upstream | API do GitHub em `v1.8.2` e `main` devolve 404 |
| PR [#1204](https://github.com/kushagrasinghx/BitChord/pull/1204): estado, base, commits, arquivos, checks | `gh pr view 1204 --repo kushagrasinghx/BitChord` em 02/11/2026 |
| Testes nativos no CI | `check.yml:45-46` (`./gradlew testDevDebugUnitTest`) no job `Android`, com `SUCCESS` |
| 5.312 estrelas, release `v1.9` de 30/10/2026 | `gh repo view` e `gh release list` em 02/11/2026 |
| Versão `1.9` / `versionCode 36` | `build.gradle.kts:44-45` |
| 19 locales no `app/` | `git ls-files` filtrando `values*/strings.xml`: 20 pastas (`values` + 19 traduções) |
