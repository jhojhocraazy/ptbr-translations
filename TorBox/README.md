# 📦 TorBox — Central de Localização pt-BR

> **Módulo de Localização & Engenharia de Internacionalização (i18n & l10n) para o [TorBox App](https://github.com/jittarao/torbox-app).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma Tecnológica** | Next.js (App Router) + next-intl + Tauri (desktop) |
| **Sistemas Alvo** | Web (Docker) e Desktop (Windows, macOS, Linux) |
| **Repositório Upstream** | [`jittarao/torbox-app`](https://github.com/jittarao/torbox-app) (187 stars) |
| **Idioma Alvo** | Português do Brasil (`pt-BR`) |
| **Cobertura** | 🟢 **100%** — 1.536 chaves traduzíveis |
| **Entrega** | 🚀 [PR #125](https://github.com/jittarao/torbox-app/pull/125) |
| **Branch de Trabalho** | `i18n/pt-br` |
| **Última Versão** | `v0.1.1` (19/07/2026) — anterior ao lote |

---

## 🧩 Sobre o Projeto

O **TorBox App** é uma alternativa moderna e focada em usuários avançados para a interface padrão do TorBox, construída em **Next.js**. Ele reúne downloads, torrents, Usenet, WebDAV, RSS, automações, estatísticas e um player de vídeo em uma única interface, com versão desktop via **Tauri**.

O projeto usa um pipeline de i18n próprio, baseado em **deltas**: `en.json` é a fonte canônica e cada idioma guarda apenas as chaves cujo texto difere do inglês. Chaves ausentes herdam o inglês em tempo de execução (`deepmerge`).

---

## 🗂️ Arquitetura da Tradução

| Item | Caminho | Conteúdo |
| :--- | :--- | :--- |
| Fonte canônica | `src/i18n/messages/en.json` | 1.592 chaves no total |
| Delta pt-BR | `src/i18n/messages/pt-BR.json` | **1.454 chaves** traduzidas |
| Herdadas do inglês | `src/i18n/messages/inherited.json` | **82 chaves** registradas como idênticas |
| Registro de locales | `src/i18n/settings.ts` | `pt-BR` adicionado |
| Loader | `src/i18n/request.ts` | importa `./messages/pt-BR.json` |
| Seletor de idioma | `src/components/LanguageSwitcher.js` | "Português" + bandeira |
| Estilo do pipeline | `scripts/i18n/lib/style.js` | dicas de estilo para `pt-BR` |
| Teste de invariantes | `scripts/__tests__/i18n.test.js` | inclui `pt-BR` |
| Documentação | `src/i18n/README.md` | lista de locales suportados |

### O que fica de fora

- **`Admin.*`** — a UI administrativa permanece em inglês por regra do próprio projeto.
- **`CustomViews.presets.*`** — presets não entram em deltas de idioma.
- **Termos idênticos ao inglês** — nomes próprios e técnicos (`TorBox`, `API`, `ID`, `Peers`, `Seeds`, `Tags`, `Hash`, `Webdl`) ficam em `inherited.json`, não no delta.

---

## ✅ Validação

Executado dentro do clone:

| Comando | Resultado |
| :--- | :--- |
| `bun scripts/i18n.js verify` | ✅ `i18n verify passed.` |
| `bun test scripts/__tests__/i18n.test.js` | ✅ 14 testes, 0 falhas |
| `bunx prettier --check <arquivos alterados>` | ✅ todos no estilo do projeto |
| `bun scripts/i18n.js translate --json --locale pt-BR` | ✅ 0 pendentes |

O verificador do próprio projeto confere sintaxe ICU, nomes de placeholders, chaves órfãs, chaves redundantes e ordenação.

---

## 🛠️ Como Trabalhar no Repositório Local (`repo/`)

A pasta [`repo/`](./repo/) é um clone do fork [`jhojhocraazy/torbox-app`](https://github.com/jhojhocraazy/torbox-app).

### Remotos Configurados

- **`origin`**: `https://github.com/jhojhocraazy/torbox-app.git` (fork)
- **`upstream`**: `https://github.com/jittarao/torbox-app.git` (oficial)

### Fluxo do pipeline

```bash
bun scripts/i18n.js translate --json --locale pt-BR > work.json
# traduzir os valores pendentes
bun scripts/i18n.js translate --apply work.json --locale pt-BR
bun scripts/i18n.js verify
bunx prettier --check src/i18n
```

> O projeto é voltado a agentes: o próprio `src/i18n/README.md` manda usar o CLI e nunca editar deltas à mão sem rodar `verify`.

---

## 📖 Documentos Complementares

- 📘 [**i18n do projeto**](https://github.com/jittarao/torbox-app/blob/main/src/i18n/README.md): invariantes, comandos e protocolo de tradução.
- 📗 [**README oficial**](https://github.com/jittarao/torbox-app#readme): instalação, Docker e arquitetura.
