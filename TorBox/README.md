# 📦 TorBox — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) do
> [TorBox App](https://github.com/jittarao/torbox-app).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | Next.js (App Router) + next-intl + Tauri (desktop) |
| **Sistemas** | Web (Docker) e desktop (Windows, macOS, Linux) |
| **Fonte canônica** | `src/i18n/messages/en.json` — **1.592** chaves |
| **Delta pt-BR** | `src/i18n/messages/pt-BR.json` — **1.466** chaves traduzidas |
| **Herdadas do EN** | **126** chaves fora do delta (`Admin.*`, `CustomViews.presets.*` e termos técnicos) |
| **Cobertura** | 🟢 **1.466/1.466 (100%)** do delta traduzível |
| **Validação** | 🔴 `bun scripts/i18n.js verify` falha em 03/11/2026: chaves não ordenadas nos 7 locales; testes 13/14 |
| **Pull Request** | [#125](https://github.com/jittarao/torbox-app/pull/125) — `OPEN`, `CONFLICTING`, base `main` |
| **Branch** | `i18n/pt-br`, commit `ef25451` (30/10/2026) |
| **Última release** | `v0.1.2` (02/11/2026) — anterior ao PR |
| **Upstream** | [`jittarao/torbox-app`](https://github.com/jittarao/torbox-app) |

A tradução do delta está completa e o pipeline do projeto passou. O que falta é a revisão e o merge do
mantenedor.

---

## 🧩 O que é o TorBox App

Alternativa moderna e focada em usuários avançados para a interface padrão do TorBox, em **Next.js**,
com versão desktop via **Tauri**. Reúne downloads, torrents, Usenet, WebDAV, RSS, automações,
estatísticas e player de vídeo.

O projeto usa um pipeline de i18n próprio, baseado em **deltas**: `en.json` é a fonte canônica e cada
idioma guarda apenas as chaves cujo texto difere do inglês. Chaves ausentes herdam o inglês em tempo de
execução (`deepmerge`).

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 🗂️ Onde a tradução vive

| Item | Caminho | Conteúdo |
| :--- | :--- | :--- |
| Fonte canônica | `src/i18n/messages/en.json` | 1.592 chaves |
| Delta pt-BR | `src/i18n/messages/pt-BR.json` | 1.466 chaves |
| Herdadas do inglês | — | 126 chaves fora do delta |
| Snapshot EN | [`snapshots/torbox_messages_en.json`](./snapshots/torbox_messages_en.json) | 1.592 chaves |
| Snapshot pt-BR | [`snapshots/torbox_messages_pt_BR.json`](./snapshots/torbox_messages_pt_BR.json) | 1.466 chaves |
| Registro de locales | `src/i18n/settings.ts` | `pt-BR` adicionado |
| Loader | `src/i18n/request.ts` | importa `./messages/pt-BR.json` |
| Seletor de idioma | `src/components/LanguageSwitcher.js` | "Português" + bandeira |
| Estilo do pipeline | `scripts/i18n/lib/style.js` | dicas de estilo para `pt-BR` |
| Teste de invariantes | `scripts/__tests__/i18n.test.js` | inclui `pt-BR` |
| Documentação | `src/i18n/README.md` | locales suportados |

### O que fica de fora

- **`Admin.*`** — a UI administrativa permanece em inglês por regra do projeto.
- **`CustomViews.presets.*`** — presets não entram em deltas.
- **Termos idênticos ao inglês** — `TorBox`, `API`, `ID`, `Peers`, `Seeds`, `Tags`, `Hash`, `WebDL`.

As 126 chaves ausentes do delta são exatamente essas; não são pendência de tradução.

---

## ✅ Validação

Executado dentro do clone em 30/10/2026:

| Comando | Resultado |
| :--- | :--- |
| `bun scripts/i18n.js verify` | ✅ `i18n verify passed.` |
| `bun test scripts/__tests__/i18n.test.js` | ✅ 14 testes, 0 falhas |
| `bunx prettier --check <arquivos alterados>` | ✅ todos no estilo do projeto |
| `bun scripts/i18n.js translate --json --locale pt-BR` | ✅ 0 pendentes |

O verificador do próprio projeto confere sintaxe ICU, nomes de placeholders, chaves órfãs, chaves
redundantes e ordenação.

> **O validador do hub não roda neste projeto.** `All` e `all` no mesmo JSON quebram o
> `ConvertFrom-Json` do `validate-ptbr.ps1`. A régua é o `verify` do projeto. Em 03/11/2026 ele
> executou com um `bun` temporário e **falhou**: o `en.json` não está ordenado; `bun i18n:sync`
> reordena os 6 locales, mas não o `en.json`. O teste `verifyLocales` falha (13/14). Não é erro de
> tradução; é falha do pipeline.

---

## 🛠️ Trabalhar no clone (`repo/`)

A pasta [`repo/`](./repo/) é um clone raso (`--depth 1`) do fork, na branch `i18n/pt-br`.

| Remoto | URL |
| :--- | :--- |
| `origin` | `https://github.com/jhojhocraazy/torbox-app.git` (fork) |
| `upstream` | `https://github.com/jittarao/torbox-app.git` (projeto original — só leitura) |

```bash
cd TorBox/repo
git fetch upstream main
git switch i18n/pt-br
git rebase upstream/main

bun scripts/i18n.js translate --json --locale pt-BR > work.json
# traduzir os valores pendentes
bun scripts/i18n.js translate --apply work.json --locale pt-BR
bun scripts/i18n.js verify
bunx prettier --check src/i18n
```

O projeto é voltado a agentes: o próprio `src/i18n/README.md` manda usar o CLI e nunca editar deltas à
mão sem rodar `verify`.

---

## ⚠️ Lacunas

1. **PR conflitante.** O #125 está `OPEN`, mas `CONFLICTING` com a `main`; precisa de rebase antes da revisão.
2. **Validador do hub não roda.** `All`/`all` quebra o `ConvertFrom-Json`; a validação é o `verify` do
   projeto.
3. **126 chaves herdadas.** Não estão no delta por regra; não são pendência.
4. **Nada foi rodado no app.** O hub não instala web/desktop; nenhuma regra de espaço de tela foi
   conferida.
5. **Release desatualizada.** `v0.1.2` é de 02/11/2026, anterior ao PR.
6. **Snapshot e clone podem divergir.** Se o upstream avançar, o snapshot fica velho.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método aplicado ao delta + ICU: chave ➔
  inglês ➔ tela ➔ pt-BR ➔ regras. `verify`, testes, Prettier e o que fica fora do delta.
- 📗 [**Glossário de termos**](./glossario.md) — torrents, Usenet, planos e ações.
- 📙 [**i18n do projeto**](https://github.com/jittarao/torbox-app/blob/main/src/i18n/README.md) —
  invariantes, comandos e protocolo de tradução.
- 🗂️ [**Snapshots**](./snapshots/) — cópia EN e pt-BR.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 1.592 chaves EN | `en.json` em 02/11/2026 |
| 1.466 chaves no delta pt-BR | `pt-BR.json` em 02/11/2026 |
| 126 chaves ausentes do delta | diferença `en.json` × `pt-BR.json` em 02/11/2026 |
| `verify`, 14 testes, Prettier, 0 pendentes | execução registrada em 30/10/2026 |
| PR #125: aberto, `CONFLICTING`, base `main` | `gh pr view 125` em 03/11/2026 |
| Branch `i18n/pt-br`, commit `ef25451` | `git branch` e `git log -1` em 02/11/2026 |
| Release `v0.1.2` (02/11/2026) | `gh release view --repo jittarao/torbox-app` |
