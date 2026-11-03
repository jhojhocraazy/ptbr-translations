# 📘 Diretrizes Técnicas de Localização — TorBox

> **O que é este documento:** o método de tradução do TorBox aplicado às regras que só valem nele.
> Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem [`README.md`](./README.md)
> (o status).
>
> **Contra o que foi escrito:** clone em `TorBox/repo`, branch `i18n/pt-br`, commit `ef25451`
> (30/10/2026), e os snapshots `TorBox/snapshots/torbox_messages_en.json` (1.592 chaves) e
> `torbox_messages_pt_BR.json` (1.466 chaves). Contagens medidas em **02/11/2026**.
>
> **O que ele não cobre:** rodar o app web/desktop, testar downloads reais e julgar fluência — ver
> seção 7.

---

## 1. 🔁 O método: cinco etapas, sempre na mesma ordem

1. **Ler a chave interna**
2. **Ler a string em inglês**
3. **Entender o que o usuário vê**
4. **Escrever em pt-BR**
5. **Conferir contra as regras do projeto**

### 1.1. Etapa 1 — Ler a chave interna

O catálogo é um JSON aninhado. A chave é o caminho (`Settings.downloads.path`), e o primeiro segmento
diz a área:

| Prefixo | Onde vive |
| :--- | :--- |
| `ActionButtons.` | ações de item: arquivar, excluir, retry, tags |
| `Columns.` | cabeçalhos e filtros da tabela (`peers`, `ratio`, `stalled`) |
| `Statuses.` | estados de download/upload (`stalled`, `seeding`) |
| `DownloadsFilters.` | filtros da lista de downloads |
| `ArchivedDownloads.` | estado vazio e ações dos arquivados |
| `AutomationRules.` | regras, condições e presets de automação |
| `ApiKeyInput.` / `ApiKeyManager.` | chave de API e gerenciamento |
| `VideoPlayer.` | player de vídeo |
| `User.plans.` | nomes de plano (`free`, `essential`, `standard`, `pro`) |
| `Admin.` | UI administrativa — **fora do escopo** |
| `CustomViews.presets.` | presets — **fora do escopo** |

### 1.2. Etapa 2 — Ler a string em inglês

A fonte canônica é `src/i18n/messages/en.json`. O projeto usa **deltas**: cada idioma guarda apenas as
chaves cujo texto difere do inglês, e as ausentes herdam o EN em tempo de execução (`deepmerge`).
Nunca use outro locale como origem; `es`, `de` e `fr` servem de referência, não de fonte.

### 1.3. Etapa 3 — Entender o que o usuário vê

O TorBox App é uma interface para usuários avançados, com downloads, torrents, Usenet, WebDAV, RSS e
player:

- **Botão e ação:** imperativo curto (*"Arquivar"*, *"Excluir"*, *"Tentar novamente"*).
- **Tabela e lista:** coluna curta; o detalhe vai em tooltip ou painel.
- **Configuração:** rótulo + descrição; o usuário espera o termo técnico.
- **Erro:** direto e acionável (*"Não foi possível conectar aos servidores do TorBox."*).
- **Mobile/desktop:** o layout é responsivo; o texto não pode quebrar a tabela.

### 1.4. Etapa 4 — Escrever em pt-BR

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| definições | **configurações** |

Sentence Case; nome de recurso e marca mantêm a grafia. O vocabulário vem do
[`glossario.md`](./glossario.md). O que **não** se traduz:
`TorBox` · `TBM` · `Airlock` · `WebDL` · `Usenet` · `Torrent` · `Magnet` · `Hash` · `API` · `ID`.

### 1.5. Etapa 5 — Conferir contra as regras do projeto

1. **O JSON** — chaves, ICU e placeholders (seção 3).
2. **O pipeline do projeto** — `bun scripts/i18n.js verify` e os testes (seção 4).
3. **O PR** — `verify`, testes e Prettier no CI (seção 5).

### 1.6. O método aplicado a uma string real

`ArchivedDownloads.emptyState.title`:

1. **Chave:** `ArchivedDownloads.emptyState.title` → título do estado vazio dos downloads arquivados.
2. **EN:** `No Archived Downloads`.
3. **O que o usuário vê:** um título centralizado no painel vazio, com passos logo abaixo.
4. **pt-BR:** `Nenhum download arquivado`.
5. **Regras:** sem placeholder, chave no delta, `verify` sem erro.

---

## 2. 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Fonte canônica** | `src/i18n/messages/en.json` — 1.592 chaves |
| **Delta pt-BR** | `src/i18n/messages/pt-BR.json` — 1.466 chaves |
| **Herdadas do EN** | 126 chaves fora do delta (`Admin.*`, `CustomViews.presets.*` e termos técnicos) |
| **Snapshot EN** | [`snapshots/torbox_messages_en.json`](./snapshots/torbox_messages_en.json) |
| **Snapshot pt-BR** | [`snapshots/torbox_messages_pt_BR.json`](./snapshots/torbox_messages_pt_BR.json) |
| **Entrega** | PR no repositório `jittarao/torbox-app` |
| **Branch** | `i18n/pt-br` |

O delta tem 1.466 chaves traduzidas; as 126 ausentes são herdadas do inglês por regra do projeto. O
total de 1.592 é a soma das duas.

---

## 3. 🧩 O formato: next-intl + ICU

### 3.1. JSON aninhado

- UTF-8 sem BOM; indentação do projeto.
- Chaves em inglês, nunca traduzidas.
- O delta só contém o que difere do EN; não copie chave idêntica para o delta.

### 3.2. Placeholders e ICU

O projeto usa **ICU MessageFormat** via `next-intl`:

```json
"files": "{count, plural, one {# arquivo} other {# arquivos}}"
```

- Mantenha o argumento (`count`) e as categorias (`one`/`other`).
- `#` é o número; preserve.
- Não renomeie `{count}` para `{quantidade}`.
- Chaves balanceadas.

### 3.3. Escapes

- Aspas duplas dentro do texto: `\"`.
- Barra invertida literal: `\\`.
- `\n` só se a string precisar de quebra de linha.
- Não escape apóstrofo: JSON não exige.

### 3.4. O que fica fora do delta

- **`Admin.*`** — a UI administrativa permanece em inglês por regra do projeto.
- **`CustomViews.presets.*`** — presets não entram em deltas.
- **Termos idênticos ao inglês** — `TorBox`, `API`, `ID`, `Peers`, `Seeds`, `Tags`, `Hash`, `WebDL`.

---

## 4. 🧪 Validação no hub

O validador genérico **não roda** neste projeto: `All` e `all` no mesmo JSON quebram o
`ConvertFrom-Json` do `validate-ptbr.ps1` (documentado em
[`../organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md)). A validação é a do próprio
projeto, dentro do clone:

```bash
cd TorBox/repo
bun scripts/i18n.js verify
bun test scripts/__tests__/i18n.test.js
bunx prettier --check src/i18n
bun scripts/i18n.js translate --json --locale pt-BR
```

Resultado registrado em 30/10/2026:

```text
i18n verify passed.
14 testes, 0 falhas
todos os arquivos no estilo do projeto
0 pendentes
```

O `verify` confere sintaxe ICU, nomes de placeholders, chaves órfãs, chaves redundantes e ordenação.

> **Execução de 03/11/2026:** com um `bun` 1.4.4 temporário, o `verify` roda, mas **falha**: o
> `en.json` não está ordenado. `bun i18n:sync` reordena os 6 locales, mas **não o `en.json`**; o teste
> `verifyLocales` continua falhando (13/14). Não é erro de tradução; é falha do pipeline.

### 4.1. Por que o validador do hub não serve

`validate-ptbr.ps1` usa `ConvertFrom-Json`, que rejeita chaves que diferem só por caixa (`All`/`all`).
O JSON do TorBox tem as duas. Até o validador aprender esse caso, a régua é o `verify` do projeto.

---

## 5. 🚀 Entrega e revisão

O PR [#125](https://github.com/jittarao/torbox-app/pull/125) está aberto contra `main`, mas `CONFLICTING` em 03/11/2026; precisa de rebase antes da revisão.
O projeto tem pipeline próprio:

- `i18n:verify` — invariantes do catálogo.
- 14 testes de i18n — chaves, placeholders e deltas.
- Prettier — estilo.

Antes de atualizar o PR:

- [ ] `git fetch upstream main` e rebase se a base avançou.
- [ ] Rodar `verify`, testes e Prettier.
- [ ] Conferir que o snapshot foi atualizado.
- [ ] Reler o corpo do PR (Regra 6 do `AGENTS.md`).

---

## 6. 📱 Espaço de tela

1. **Botão e ação:** 1 a 3 palavras. `Arquivar`, `Excluir`, `Tentar novamente`.
2. **Tabela:** coluna curta; o detalhe vai em tooltip.
3. **Configuração:** rótulo + descrição; o usuário avançado aceita termo técnico.
4. **Erro:** uma ou duas linhas; diga o que falhou e o que fazer.
5. **Player:** sobrepõe o vídeo; prefira `Legendas`, não `Configurações de legenda`.

---

## 7. ✅ Checklist antes de abrir/atualizar a PR

**Etapas 1 e 2 — origem**
- [ ] Li a chave e sei em que tela o texto aparece?
- [ ] Traduzi a partir do `en.json`, não de `es`/`de`/`fr`?

**Etapas 3 e 4 — texto**
- [ ] A frase cabe no componente (botão, tabela, configuração, player)?
- [ ] Sentence Case aplicado; marca e termo técnico preservados?
- [ ] Português do Brasil, sem termo de Portugal e sem construção literal?

**Etapa 5 — regras**
- [ ] Só o delta mudou? Nenhuma chave idêntica ao EN foi copiada?
- [ ] ICU (`plural`/`select`) preservado, com argumento e `#`?
- [ ] Placeholders com a mesma quantidade e os mesmos nomes?
- [ ] `Admin.*` e `CustomViews.presets.*` ficaram fora?
- [ ] `bun scripts/i18n.js verify` passou?
- [ ] 14 testes de i18n passaram?
- [ ] Prettier limpo?
- [ ] Snapshot do hub atualizado?

---

## 8. ⚠️ Lacunas conhecidas

1. **Validação falhando.** `All`/`all` quebra o `ConvertFrom-Json` do hub; o `verify` do projeto roda
   com bun temporário, mas falha porque as chaves dos 7 locales não estão ordenadas (teste 13/14).
2. **126 chaves herdadas.** Não estão no delta por regra; não são pendência.
3. **Nada foi rodado no app.** O hub não instala web/desktop; nenhuma regra de espaço de tela foi
   conferida.
4. **PR conflitante.** O [#125](https://github.com/jittarao/torbox-app/pull/125) precisa de rebase; a release `v0.1.2` é anterior ao PR.
5. **Snapshot e clone podem divergir.** Se o upstream avançar, o snapshot fica velho.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 1.592 chaves EN | `en.json` em 02/11/2026 |
| 1.466 chaves no delta pt-BR | `pt-BR.json` em 02/11/2026 |
| 126 chaves ausentes do delta | diferença `en.json` × `pt-BR.json` em 02/11/2026 |
| `verify`, 14 testes, Prettier, 0 pendentes | execução registrada em 30/10/2026 |
| PR [#125](https://github.com/jittarao/torbox-app/pull/125): aberto, `CONFLICTING`, base `main` | `gh pr view 125` em 03/11/2026 |
| Release `v0.1.2` (02/11/2026) | `gh release view --repo jittarao/torbox-app` |
