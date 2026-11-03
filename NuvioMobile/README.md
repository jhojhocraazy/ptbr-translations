# 📱 Nuvio Mobile — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) do
> [Nuvio Mobile](https://github.com/NuvioMedia/NuvioMobile).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | Kotlin Multiplatform (**KMP** — um código-fonte, Android e iOS) + Compose Multiplatform |
| **Catálogos** | **7** arquivos em `composeApp/src/commonMain/composeResources/values-pt-rBR/` |
| **Entradas** | **2.707** no total — 2.496 no principal + 84 + 60 + 52 + 1 + 10 + 4 |
| **Paridade** | 🟢 100% nos 7 arquivos; `validate-ptbr.ps1` `OK` (02/11/2026) |
| **Pull Requests** | [#2234](https://github.com/NuvioMedia/NuvioMobile/pull/2234), [#2288](https://github.com/NuvioMedia/NuvioMobile/pull/2288), [#2338](https://github.com/NuvioMedia/NuvioMobile/pull/2338), [#2402](https://github.com/NuvioMedia/NuvioMobile/pull/2402), [#2435](https://github.com/NuvioMedia/NuvioMobile/pull/2435) e [#2455](https://github.com/NuvioMedia/NuvioMobile/pull/2455) — todos **MERGED**; [#2506](https://github.com/NuvioMedia/NuvioMobile/pull/2506) **aberto** (pontuação) |
| **Último merge** | [#2455](https://github.com/NuvioMedia/NuvioMobile/pull/2455) em 01/11/2026 (`cmp-rewrite`) |
| **Última release** | `0.6.6-beta` (31/10/2026) — inclui o [#2435](https://github.com/NuvioMedia/NuvioMobile/pull/2435); o [#2455](https://github.com/NuvioMedia/NuvioMobile/pull/2455) ainda não saiu em release |
| **Branch de trabalho** | `fix/pt-br-pontuacao`, commit `5fd3361e` (03/11/2026), a partir de `cmp-rewrite` `0377f86e` |
| **Upstream** | [`NuvioMedia/NuvioMobile`](https://github.com/NuvioMedia/NuvioMobile) |

A tradução está completa e mergeada. O que resta não é código: é release e verificação em aparelho.

---

## 🎬 O que é o Nuvio Mobile

Aplicativo de streaming de mídia em **Compose Multiplatform**, para Android e iOS. O que interessa
para a tradução é o que o app **faz**, porque cada recurso tem vocabulário próprio:

- **Catálogo e metadados:** filmes, séries, elenco, avaliações e integração MDBList/TMDB/IMDb.
- **Player:** faixas de áudio e legenda, modos de renderização (incluindo ASS), troca automática de
  motor e Picture-in-Picture.
- **Watch Party:** sessão em grupo com anfitrião, sincronia, sala e chat.
- **Servidores remotos:** endereço, porta, latência e credenciais.
- **AutoSync de legendas:** correspondência automática da legenda ao vídeo, com tolerância e modo.
- **Addons e Debrid:** catálogos de terceiros e serviços de download em nuvem.

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 🗂️ Onde a tradução vive

| Arquivo | Domínio | Entradas |
| :--- | :--- | ---: |
| `strings.xml` | catálogo, player, configurações, Debrid e Stremio | 2.496 |
| `strings_party.xml` | Watch Party: sessões, sincronia, salas e chat | 84 |
| `strings_servers.xml` | servidores remotos, portas e latência | 60 |
| `strings_mdblist.xml` | MDBList: filtros, listas e notas | 52 |
| `strings_pip.xml` | Picture-in-Picture e mini-player | 1 |
| `autosync_strings.xml` | sincronização automática de legendas | 10 |
| `autosync_toast_strings.xml` | mensagens voláteis de sucesso/erro | 4 |
| **Total** | | **2.707** |

As 2.496 entradas do principal são **2.488 `<string>` + 4 `<plurals>` (8 formas)**. O validador conta
cada forma de plural como uma unidade.

O snapshot versionado em [`snapshots/`](./snapshots/) é cópia dos sete catálogos. Quem entrega é a
branch, via PR; o snapshot sobrevive se a branch for fechada ou rebaseada.

---

## 📦 Histórico de entregas

### [#2234](https://github.com/NuvioMedia/NuvioMobile/pull/2234) — Tradução principal
- **Volume:** 2.410 strings + 4 plurais.
- **Resultado:** publicado em `0.6.0-beta` e `0.6.1-beta`.

### [#2288](https://github.com/NuvioMedia/NuvioMobile/pull/2288) — Módulos adicionais
- **Volume:** 208 entradas novas em 5 módulos + 92 refinadas no principal e no PiP.
- **Resultado:** `MERGED`, publicado em `0.6.3-beta`; CI `Build fullDebug APK` verde (6m49s).

### [#2338](https://github.com/NuvioMedia/NuvioMobile/pull/2338) — Player e Watch Party
- **Volume:** 9 entradas novas (7 em `strings.xml`, 2 em `strings_party.xml`) + 1 descrição.
- **Resultado:** `MERGED` em 23/10/2026, publicado em `0.6.4-beta`.

### [#2402](https://github.com/NuvioMedia/NuvioMobile/pull/2402) — Renderização de legendas e avaliações no destaque
- **Volume:** 4 entradas novas.
- **Resultado:** `MERGED` em 26/10/2026, publicado em `0.6.5-beta`.

### [#2435](https://github.com/NuvioMedia/NuvioMobile/pull/2435) — Configurações, aparência de legendas e modos ASS
- **Volume:** 62 entradas novas + 1 descrição atualizada.
- **Resultado:** `MERGED` em 30/10/2026 na `cmp-rewrite`, incluído em `0.6.6-beta`.
- **Observação:** o check `Build fullDebug APK` falhava por erro pré-existente na base
  (`Unresolved reference 'updateAssMargins'`), não pela tradução.

### [#2455](https://github.com/NuvioMedia/NuvioMobile/pull/2455) — `Minha lista`, Sentence Case e scrobble
- **Volume:** 3 correções que ficaram fora do [#2435](https://github.com/NuvioMedia/NuvioMobile/pull/2435).
- **Resultado:** `MERGED` em 01/11/2026; ainda não há release com esse merge.

### [#2506](https://github.com/NuvioMedia/NuvioMobile/pull/2506) — pontuação de duas descrições
- **Volume:** 2 strings, só o ponto final removido.
- **Resultado:** `OPEN` em 03/11/2026, base `cmp-rewrite`; `PR Template Check` e `Build fullDebug APK` verdes, `CLEAN`.

---

## 🧪 Como conferir

O hub não compila o app. O passo equivalente é o validador, contra o EN do clone:

```powershell
./scripts/validate-ptbr.ps1 `
  -Path   NuvioMobile/snapshots/NuvioMobile_strings_pt_BR.xml `
  -Source NuvioMobile/repo/composeApp/src/commonMain/composeResources/values/strings.xml `
  -Format xml
```

Resultado de 02/11/2026:

```text
OK   NuvioMobile_strings_pt_BR.xml  (2496 strings, perfil=xml, escape=none)
     avisos: 111 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

**Não use `-Escape android` neste projeto.** Compose Resources aceita apóstrofo e aspas literais; a
flag Android reporta 11 falsos positivos (medido em 02/11/2026). O EN tem 31 apóstrofos e só 2 aspas
escapadas.

> **Cuidado:** o validador compara o snapshot com o EN **do clone**. Clone velho, resultado velho.
> Rode `git -C NuvioMobile/repo fetch upstream` antes de confiar no número.

---

## 🛠️ Trabalhar no clone (`repo/`)

A pasta [`repo/`](./repo/) é um clone raso (`--depth 1`) do fork, na branch `cmp-rewrite`.

| Remoto | URL |
| :--- | :--- |
| `origin` | `https://github.com/jhojhocraazy/NuvioMobile.git` (fork) |
| `upstream` | `https://github.com/NuvioMedia/NuvioMobile.git` (projeto original — só leitura) |

```bash
cd NuvioMobile/repo
git fetch upstream cmp-rewrite
git switch cmp-rewrite
git merge --ff-only upstream/cmp-rewrite
git push origin cmp-rewrite
git switch -c i18n/nome-da-melhoria
```

A branch padrão do upstream é `cmp-rewrite`, não `main`. Um PR para `main` seria recusado.

---

## ⚠️ Lacunas

1. **[#2455](https://github.com/NuvioMedia/NuvioMobile/pull/2455) fora de release.** O merge está na `cmp-rewrite`, mas a última release (`0.6.6-beta`) é
   anterior. Falta: a próxima release.
2. **Nada foi rodado em aparelho.** O hub não compila nem instala o app; nenhuma regra de espaço de
   tela foi conferida em Android Auto, PiP ou celular real.
3. **Plurais sem `many`.** Os 4 blocos usam só `one` e `other`; o efeito para milhões exatos não foi
   medido.
4. **Build da base instável.** O job `Build fullDebug APK` já falhou por erro que não era da tradução.
   Falta: acompanhar a correção no upstream.
5. **Snapshot e clone podem divergir.** Se o upstream avançar, o validador continua verde contra o EN
   velho. Falta: refazer o snapshot a cada rodada.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método aplicado ao Compose
  Multiplatform: chave ➔ inglês ➔ tela ➔ pt-BR ➔ regras. XML, plurais, `-Escape none` e CI.
- 📗 [**Glossário de termos**](./glossario.md) — o vocabulário: o que fica em inglês, o que se traduz
  e as decisões que não são óbvias.
- 🗂️ [**Snapshots**](./snapshots/) — cópia versionada dos sete catálogos.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 2.496 entradas no principal | `validate-ptbr.ps1` em 02/11/2026 |
| 2.707 entradas no total | soma dos 7 arquivos |
| `OK`, 111 avisos | `validate-ptbr.ps1 -Escape none` em 02/11/2026 |
| 11 falsos positivos com `-Escape android` | mesma execução com a flag Android |
| PRs [#2234](https://github.com/NuvioMedia/NuvioMobile/pull/2234)–[#2455](https://github.com/NuvioMedia/NuvioMobile/pull/2455) e estados | `gh pr view` em 02/11/2026 |
| Release `0.6.6-beta` (31/10/2026) | `gh release view --repo NuvioMedia/NuvioMobile` |
| Branch `cmp-rewrite`, commit `46febb5` | `git branch --show-current` e `git log -1` em 02/11/2026 |
