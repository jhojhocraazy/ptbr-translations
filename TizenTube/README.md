# 📺 TizenTube & TizenTube Cobalt — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) do ecossistema
> [TizenTube](https://github.com/reisxd/TizenTube) e
> [TizenTube Cobalt](https://github.com/reisxd/TizenTubeCobalt).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | JavaScript (ESM / Rollup) + Cobalt (Chromium/Starboard) |
| **Dispositivos** | Samsung Tizen OS, Android TV, Google TV e Fire TV |
| **Catálogo** | `mods/translations/resources/pt-BR.json` — **198** chaves de interface + `__contributors` |
| **Paridade** | 🟢 100% — 198/198 chaves do EN, 0 faltando, 0 sobrando |
| **Validação** | 🟢 `validate-ptbr.ps1 -Format nested`: `OK`, 199 strings, 4 avisos de texto idêntico |
| **Pull Request** | [#718](https://github.com/reisxd/TizenTube/pull/718) — `OPEN`, base `main`, `CLEAN`, 9 commits |
| **Branch** | `i18n/portuguese-complete-pt-br`, commit `187586f` (03/11/2026) |
| **Última release** | `v2.1.1` (13/09/2026) — anterior ao PR |
| **Upstream** | [`reisxd/TizenTube`](https://github.com/reisxd/TizenTube) |

A tradução está completa e o PR está verde. O que falta é a revisão e o merge do mantenedor.

---

## 🎬 O que é o TizenTube

Camada de melhorias para o YouTube em TVs:

- **Bloqueio de anúncios** nativo.
- **SponsorBlock:** pula patrocínios, intros, encerramentos, avisos de inscrição e piadas.
- **DeArrow:** substitui títulos e miniaturas sensacionalistas por versões da comunidade.
- **Controle de velocidade e resolução**, com taxa de quadros automática (AFR).
- **Relógio em tela** e personalização da barra lateral.
- **Atualizador automático** no TizenTube Cobalt.

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Fonte EN** | `TizenTube/repo/mods/translations/resources/en.json` |
| **Tradução pt-BR** | `.../pt-BR.json` |
| **Snapshot do hub** | [`snapshots/tizentube_pt_BR.json`](./snapshots/tizentube_pt_BR.json) |
| **Entrega** | PR no repositório `reisxd/TizenTube` |
| **Branch** | `i18n/portuguese-complete-pt-br` |

O catálogo é um JSON aninhado com 8 seções (`common`, `settings`, `welcomeMsg`, `sponsorblock`,
`player`, `videoMenu`, `toasts`, `__contributors`). A última não é interface: é a lista de créditos,
onde Joseph Alves aparece oficialmente.

O bundle `@foxreis/tizentube` é consumido por Tizen e Cobalt; uma tradução atende os dois.

---

## 📦 O que a entrega contém

| # | O que | Evidência |
| :-: | :--- | :--- |
| 1 | **92 strings que estavam em inglês traduzidas** | `pt-BR.json` contra `en.json` |
| 2 | **96 strings refinadas** em 20/10/2026 | Sentence Case, D-Pad, QR Code e naturalidade |
| 3 | **Barra lateral e categorias completas** | Início, Pesquisar, Filmes e TV, Ao Vivo, Jogos, Inscrições, Shorts |
| 4 | **Atualizador do Cobalt traduzido** | diálogos de verificação, download e notas |
| 5 | **Placeholders preservados** | `{{count}}`, `{{name}}`, `{{version}}`, `{{date}}`, `{{segment}}` |
| 6 | **Crédito oficial** | `__contributors` inclui `Joseph Alves` |
| 7 | **4 strings mantidas em inglês** | `GitHub Sponsors`, `Podcasts`, `Shorts` e uma URL de patrocínio |
| 8 | **5 strings alinhadas ao glossário** | “player de vídeo” (4) e reticência `…` (1), em 03/11/2026 |

---

## 🧪 Como conferir

```powershell
./scripts/validate-ptbr.ps1 `
  -Path   TizenTube/snapshots/tizentube_pt_BR.json `
  -Source TizenTube/repo/mods/translations/resources/en.json `
  -Format nested
```

Resultado de 02/11/2026:

```text
OK   tizentube_pt_BR.json  (199 strings, perfil=nested, escape=none)
     avisos: 4 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

As 199 "strings" são **198 chaves de interface + 1 entrada de créditos**. As 4 idênticas são marca,
nome de formato ou URL — nenhuma é frase esquecida em inglês.

> **Cuidado:** o validador compara o snapshot com o EN **do clone**. Clone velho, resultado velho.
> Rode `git -C TizenTube/repo fetch upstream` antes de confiar no número.

---

## 🛠️ Trabalhar no clone (`repo/`)

A pasta [`repo/`](./repo/) é um clone raso (`--depth 1`) do fork, na branch da PR.

| Remoto | URL |
| :--- | :--- |
| `origin` | `https://github.com/jhojhocraazy/TizenTube.git` (fork) |
| `upstream` | `https://github.com/reisxd/TizenTube.git` (projeto original — só leitura) |

```bash
cd TizenTube/repo
git fetch upstream main
git switch i18n/portuguese-complete-pt-br
git rebase upstream/main
```

A branch padrão do upstream é `main`. O PR [#718](https://github.com/reisxd/TizenTube/pull/718) aponta para ela.

---

## ⚠️ Lacunas

1. **Revisão do mantenedor.** O PR está `CLEAN` e completo; falta o merge.
2. **Sem CI de tradução no upstream.** A validação é local + revisão manual.
3. **Nada foi rodado em TV.** O hub não instala o app; nenhuma regra de espaço de tela foi conferida
   em Tizen, Android TV ou Fire TV.
4. **`pt-PT` existe no repositório.** É a armadilha de origem; nunca use como fonte.
5. **Release desatualizada.** `v2.1.1` é de 13/09/2026, anterior ao PR.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método aplicado ao JSON aninhado:
  chave ➔ inglês ➔ tela ➔ pt-BR ➔ regras. `{{placeholders}}`, emojis, D-Pad e validação.
- 📗 [**Glossário de termos**](./glossario.md) — o vocabulário de TV, SponsorBlock e DeArrow.
- 🗂️ [**Snapshot**](./snapshots/) — cópia versionada do catálogo.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 198 chaves de interface + 1 crédito | contagem em `en.json`/`pt-BR.json` em 02/11/2026 |
| `OK`, 199 strings, 4 avisos | `validate-ptbr.ps1 -Format nested` em 03/11/2026 |
| PR [#718](https://github.com/reisxd/TizenTube/pull/718): aberto, `CLEAN`, 9 commits, base `main` | `gh pr view 718` em 03/11/2026 |
| Branch `i18n/portuguese-complete-pt-br`, commit `187586f` | `git log -1` em 03/11/2026 |
| Release `v2.1.1` (13/09/2026) | `gh release view --repo reisxd/TizenTube` |
