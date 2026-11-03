# 🤖 AGENTS.md — Diretrizes e Constituição para Agentes de IA

> Este arquivo define os padrões de arquitetura, qualidade de tradução, regras visuais e comportamento
> operacional para qualquer Agente de IA (Antigravity, Claude, Cursor, Copilot, etc.) que atue no
> repositório **`ptbr-translations`**.

---

## 📌 1. Visão Geral do Projeto

* **Repositório:** [`jhojhocraazy/ptbr-translations`](https://github.com/jhojhocraazy/ptbr-translations)
* **Mantenedor Oficial:** **Joseph Alves** ([@jhojhocraazy](https://github.com/jhojhocraazy) | `jhojhocraazy@gmail.com`)
* **Objetivo:** Hub central de localização e internacionalização (**i18n & l10n**) de projetos de código aberto de alto impacto para o **Português do Brasil (`pt-BR`)**.
* **Escopo atual (02/11/2026):** Nuvio Mobile, BitChord, TizenTube & Cobalt, TorBox, Better Lyrics, Crowdin Platform, YTDLnis e DNSToggle.

---

## 🛡️ 2. Regras Fundamentais (Invioláveis)

### 🚨 Regra 1: Integridade Visual do `README.md`
O design do [README.md](./README.md) principal foi padronizado com elementos visuais dinâmicos e **NUNCA DEVE SER SIMPLIFICADO OU DESFEITO**, a menos que o usuário solicite explicitamente.
* **Componentes Obrigatórios a Preservar:**
  * Banner SVG em ondas (*Capsule Render*).
  * Texto dinâmico de máquina de escrever (*Typing SVG*).
  * Badges no formato `for-the-badge` com logos oficiais e cores vibrantes.
  * Tabela de projetos (Dashboard) com barras de progresso visuais (`geps.dev`).
  * Sanfonas interativas retráteis (`<details><summary>`).
* **Ao Adicionar ou Atualizar Projetos:**
  * Incrementar os números de métricas (+strings, +palavras) e **corrigir os que envelheceram**.
  * Manter a formatação de tabela e links markdown clicáveis.

---

### 🚨 Regra 2: Isolamento da Arquitetura de Pastas e Git
* **Repositório Raiz (`ptbr-translations`):**
  * Controla documentação, snapshots de strings, notas de tradução e glossários.
* **Repositórios Aninhados (`*/repo/`):**
  * `NuvioMobile/repo`, `BitChord/repo`, `TizenTube/repo` e `TorBox/repo` são clones independentes, com `origin` (fork) e `upstream` (projeto original).
  * **DEVEM permanecer no `.gitignore` raiz.** Nunca adicione o submódulo ou arquivos internos de um `repo/` diretamente aos commits da raiz.
  * Nunca commite em uma ref `upstream/*`. O trabalho acontece em uma branch de `origin` e chega ao projeto por PR.
* **Projetos de Plataforma Externa (sem clone):**
  * `BetterLyrics/`: Crowdin (projeto 863186).
  * `Crowdin/`: Crowdin (projeto 31).
  * `DNSToggle/`: Weblate (`elowry`).
  * `YTDLnis/`: Weblate (`ytdlnis`).

---

### 🚨 Regra 3: Rigor Técnico e Qualidade em `pt-BR`
Em qualquer tarefa de tradução ou revisão:
1. **Preservação Absoluta de Placeholders:**
   * Nunca altere, traduza ou remova placeholders como `%s`, `%1$s`, `%2$d`, `{username}`, `{count}`, `{{name}}`, `$NAME$`.
2. **Escape depende do destino:**
   * **XML Android final** (`values*/strings.xml`): apóstrofo `\'`, aspas `\"`, `&amp;`.
   * **Plataforma (Weblate/Crowdin):** envie **texto cru** (`d'água`), sem escape manual. O exportador adiciona o escape ao gerar o XML; `\\'`/`\\\"` é over-escaping e defeito.
   * **Compose Resources (Nuvio):** apóstrofo e aspas são literais; **não** use escape Android.
   * **JSON/i18n:** aspas duplas dentro do texto viram `\"`; apóstrofo não precisa de escape.
3. **Tags HTML internas** (`<b>`, `<i>`, `<br/>`) devem ser preservadas integralmente.
4. **Porcentagem literal** em string formatada: `%%`. Sem formatação, `%` solto é válido.
5. **Plurais:** preserve as categorias do formato (Android `one`/`many`/`other`; Weblate arrays; ICU `plural`/`select`).
6. **Fluidez Cultural (Português do Brasil):**
   * Evitar construções literais do inglês.
   * Não utilizar termos do Português de Portugal (ex: usar "tela" e não "ecrã"; "arquivo" e não "ficheiro"; "salvar" e não "guardar").
7. **Glossário & Consistência:**
   * Manter termos técnicos consagrados da comunidade sem tradução forçada (ex: *Stremio*, *Scraper*, *Debrid*, *Canvas*, *Tile*, *Addon*).
   * O glossário do projeto decide a **palavra**; as diretrizes técnicas decidem **como escrevê-la**.

---

### 🚨 Regra 4: Identidade de Commits & Git
Sempre que realizar commits em qualquer repositório do usuário:
* **Nome do Autor:** `Joseph Alves`
* **Email do Autor:** `jhojhocraazy@gmail.com`
* **Padrão de Mensagens (Conventional Commits):**
  * `feat:` Para novas traduções ou recursos.
  * `fix:` Para correções de ortografia, tags ou placeholders.
  * `docs:` Para atualizações de documentação e READMEs.
  * `chore:` Para organização de arquivos e manutenção de dependências.
* **Push somente com confirmação.** Commits locais não são entrega; PR e plataforma são.

---

### 🚨 Regra 5: Imutabilidade dos Arquivos de Governança, Regras e Diretrizes
* **Proteção Absoluta:**
  * Todos os arquivos de governança, constituição, regras de tradução, diretrizes técnicas e glossários (incluindo `AGENTS.md`, `README.md` raiz, `NuvioMobile/README.md`, `NuvioMobile/diretrizes-tecnicas.md`, `NuvioMobile/glossario.md` e equivalentes em qualquer pasta) são considerados **definitivos e protegidos**.
  * **Nenhum Agente de IA tem permissão para alterar, sobrescrever, reformatar, resumir ou deletar** qualquer um desses arquivos sem a **SOLICITAÇÃO EXPLÍCITA ou AUTORIZAÇÃO EXPLÍCITA** de Joseph Alves.

---

### 🚨 Regra 6: Mensagens, PRs, Issues e Commits via CLI (Markdown Seguro)
* **Corpo de texto sempre em arquivo:**
  * Todo texto com Markdown (corpo de PR, comentário, issue, descrição de release ou commit multi-linha) deve ser gravado em um arquivo `.md` e passado por `--body-file` ou `gh api -F body=@arquivo`.
  * **Nunca** montar Markdown inline em string de shell, especialmente no PowerShell.
* **Crase e `\n` são proibidos em string PowerShell:**
  * A crase (`` ` ``) é caractere de escape no PowerShell: `` `a `` vira BEL (0x07), `` `n `` vira quebra de linha e crases de Markdown desaparecem.
  * `\n` não é interpretado pelo PowerShell e é publicado como texto literal.
* **Aspas simples ou here-string quando inevitável:**
  * Se o texto for realmente curto e de uma linha, usar aspas simples (`'...'`) ou here-string (`@' ... '@`), nunca aspas duplas com crases.
* **Verificação obrigatória após publicar:**
  * Reler o texto publicado (`gh pr view`, `gh api ... --jq '.body'`) e corrigir imediatamente qualquer escape, caractere de controle ou Markdown quebrado.

---

### 🚨 Regra 7: Fonte Canônica — Traduzir Sempre do Idioma Original
* **A fonte é o arquivo EN do projeto:**
  * Android/Compose: `values/strings.xml` ou `values-pt/strings.xml` derivado dele.
  * JSON/i18n: `en.json`, `messages/en.json` ou o catálogo EN da plataforma.
  * Plataformas: o texto de origem exibido no Crowdin/Weblate (sempre o EN), nunca outro locale.
  * Quando existir `<Projeto>/fonte/`, essa é a fonte fixa e o SHA está no README do projeto.
* **Nunca use outro idioma como origem:**
  * `es`, `de`, `fr`, `ja`, `pl`, `pt-PT` ou qualquer tradução de terceiro servem apenas como **referência terminológica**, jamais como texto de origem.
  * Uma string já traduzida no upstream só pode ser reaproveitada depois de conferida contra a fonte EN; se não bater, retraduza.
* **Validação obrigatória antes de subir:**
  * Paridade de chaves com a fonte EN: **0 faltando, 0 sobrando**.
  * Placeholders, ICU (`plural`/`select`), tags HTML e escapes idênticos aos da fonte.
  * Strings idênticas ao EN apenas para marca, unidade ou termo técnico consagrado — nunca para frase.
* **Vale para todos os projetos do hub:** Nuvio, BitChord, TorBox, TizenTube, Better Lyrics, YTDLnis, DNSToggle e Crowdin Platform.

---

### 🚨 Regra 8: Contexto do Projeto — Ler o README Antes de Traduzir
* **Referência obrigatória:** o vocabulário do serviço equivalente (lista abaixo) é a referência de naturalidade. Aplique sem pedir autorização; só mude mediante instrução explícita do mantenedor.
* **Leia o projeto antes da string:**
  * README do projeto, `docs/`, `glossario.md` e `diretrizes-tecnicas.md`.
  * Entenda o que o produto faz, para quem, e qual é o vocabulário do domínio.
* **A tradução deve soar como o produto:**
  * Player de música, gerenciador de downloads, TMS, extensão de letras e cliente de TV têm vocabulários diferentes.
  * Botões: curtos e imperativos. Erros: diretos e acionáveis. Configurações: consistentes com o glossário.
* **Termos de domínio e nomes de recursos ficam como são:**
  * Exemplos: `Airlock`, `Canvas`, `Automix`, `Replay`, `SponsorBlock`, `DeArrow`, `Unison`, `Addon`, `Debrid`, `Scraper`.
  * Nunca “traduza” um nome de recurso proprietário por impulso.
* **Sem glossário, crie um:**
  * Se o projeto ainda não tiver `glossario.md` no hub, registre os termos de domínio antes de fechar o lote.
* **Vocabulário de referência por projeto:**
  * **Nuvio** → Netflix, Prime Video, Disney+, Max.
  * **BitChord** → YouTube Music, Spotify, Apple Music, Tidal.
  * **TorBox** → qBittorrent.
  * **TizenTube** → YouTube.
  * **Better Lyrics** → Letras.mus.br, Genius, Musixmatch.
  * **YTDLnis** → YouTube, Internet Download Manager.
  * **DNSToggle** → AdGuard, Cloudflare, OpenDNS.
  * **Crowdin Platform** → Crowdin, Transifex, Lokalise, Phrase.
* **Vale para todos os projetos do hub:** Nuvio, BitChord, TorBox, TizenTube, Better Lyrics, YTDLnis, DNSToggle e Crowdin Platform.

---

### 🚨 Regra 9: Evidência, Registro e Lacunas
* **Cite `arquivo:linha` para toda afirmação sobre código.** Sem linha, é impressão, não fato.
* **Não responda de memória nem de um resumo anterior.** Releia o arquivo, o log ou a saída da API.
* **Todo número carrega sua fonte e sua data.** Contagem, horário, versão e commit fazem parte do número.
* **Diga o que não foi verificado.** "Não reproduzido" e "não medido" são respostas válidas; preencher a lacuna com uma explicação plausível é a única coisa que não pode acontecer.
* **Registros em pt-BR:** achados em `ledger.md`, corpo de PR em `pr-body.md` e mensagens de commit no mesmo idioma da documentação. Esses arquivos vivem na pasta de trabalho `research/`, não no repositório.
* **Silêncio em log é evidência sobre a instrumentação primeiro, sobre o produto depois.**

---

### 🚨 Regra 10: Sondas, Tokens e Efeitos Colaterais
* **Leitura é livre; escrita exige autorização.**
  * `Status`, `Export`, `Check` e `Checks` apenas leem.
  * `Backup` grava um arquivo local e sobrescreve o snapshot versionado; é inofensivo, mas é escrita.
  * `crowdin-sync.ps1 -Action Push` e `weblate-sync.ps1 -Action Push` / `-Action PushJson` escrevem em conta de terceiro e precisam de **autorização explícita** antes.
* **Tokens nunca entram no repositório, no chat, no log, no PR ou no commit.**
  * `scripts/tokens.ps1` é ignorado pelo Git (`.gitignore:6`) e guarda `CROWDIN_TOKEN` e `WEBLATE_TOKEN`.
  * Os scripts leem os tokens do ambiente; nunca embutem token na linha de comando.
  * Apague scripts e temporários que contenham token ao final da sessão.
* **Saída de build fica fora do git.** Um build de teste recebe bump local de versão revertido antes do commit.

---

## 📂 3. Mapa do Repositório

```text
ptbr-translations/
├── .gitignore                  # Ignora */repo/, tokens e estado local
├── AGENTS.md                   # Este arquivo de diretrizes
├── README.md                   # Vitrine oficial e portfólio dinâmico
├── metodologia.md              # Ciclo de trabalho, qualidade e definição de pronto
├── organizacao-dos-repositorios.md  # Clone × fonte EN fixada; execução e pendências
├── 📁 BetterLyrics/            # Crowdin 863186; snapshots EN/PT; sem clone
├── 📁 BitChord/                # XML, snapshots e clone do fork
│   ├── 📁 snapshots/
│   └── 📁 repo/
├── 📁 Crowdin/                 # Crowdin 31; snapshot do en.json; sem clone
├── 📁 DNSToggle/               # Weblate elowry; XML + ZIP; sem clone
├── 📁 NuvioMobile/             # Compose Resources, snapshots e clone do fork
│   ├── 📁 snapshots/
│   └── 📁 repo/
├── 📁 TizenTube/               # JSON, snapshot e clone do fork
│   ├── 📁 snapshots/
│   └── 📁 repo/
├── 📁 TorBox/                  # JSON, snapshots e clone do fork
│   ├── 📁 snapshots/
│   └── 📁 repo/
├── 📁 YTDLnis/                 # Weblate ytdlnis; XML; sem clone
└── 📁 scripts/                 # Ferramentas de tradução e validação
    ├── crowdin-sync.ps1
    ├── weblate-sync.ps1
    ├── validate-ptbr.ps1
    ├── check-updates.ps1
    └── README.md
```

---

## 📚 4. Ordem de Autoridade da Documentação

Em caso de conflito, vale a ordem abaixo:

1. `AGENTS.md` (este arquivo) — constituição.
2. [`metodologia.md`](./metodologia.md) — ciclo de trabalho e definição de pronto.
3. [`organizacao-dos-repositorios.md`](./organizacao-dos-repositorios.md) — onde a fonte e o clone vivem.
4. `README.md` e `diretrizes-tecnicas.md` do projeto — regras específicas.
5. `glossario.md` do projeto — vocabulário.

O `README.md` raiz é portfólio e dashboard: ele **resume** o estado, não é fonte de verdade. Quando o
número do dashboard divergir da plataforma ou do clone, o dashboard está errado.
