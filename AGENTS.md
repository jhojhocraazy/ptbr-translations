# 🤖 AGENTS.md — Diretrizes e Constituição para Agentes de IA

> Este arquivo define os padrões de arquitetura, qualidade de tradução, regras visuais e comportamento operacional para qualquer Agente de IA (Antigravity, Claude, Cursor, Copilot, etc.) que atue no repositório **`ptbr-translations`**.

---

## 📌 1. Visão Geral do Projeto

* **Repositório:** [`jhojhocraazy/ptbr-translations`](https://github.com/jhojhocraazy/ptbr-translations)
* **Mantenedor Oficial:** **Joseph Alves** ([@jhojhocraazy](https://github.com/jhojhocraazy) | `jhojhocraazy@gmail.com`)
* **Objetivo:** Hub central de localização e internacionalização (**i18n & l10n**) de projetos de código aberto de alto impacto para o **Português do Brasil (`pt-BR`)**.

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
  * Incrementar os números de métricas (+strings, +palavras).
  * Manter a formatação de tabela e links markdown clicáveis.

---

### 🚨 Regra 2: Isolamento da Arquitetura de Pastas e Git
* **Repositório Raiz (`ptbr-translations`):**
  * Controla documentação, backups de strings, notas de tradução e glossários.
* **Repositório Aninhado (`NuvioMobile/repo`):**
  * É um repositório Git independente conectado ao fork `jhojhocraazy/NuvioMobile` e ao upstream `NuvioMedia/NuvioMobile`.
  * **DEVE permanecer no `.gitignore` raiz.** Nunca adicione o submódulo ou arquivos internos de `NuvioMobile/repo` diretamente aos commits da raiz.
* **Projetos de Plataforma Externa:**
  * `BetterLyrics/`: Sincronizado via Crowdin (Projeto 863186).
  * `DNSToggle/`: Sincronizado via Weblate / GitHub.

---

### 🚨 Regra 3: Rigor Técnico e Qualidade em `pt-BR`
Em qualquer tarefa de tradução ou revisão:
1. **Preservação Absoluta de Placeholders:**
   * Nunca altere, traduza ou remova placeholders como `%s`, `%1$s`, `%2$d`, `{username}`, `{count}`, etc.
2. **Escapes e Sintaxe XML/JSON:**
   * No Android XML: apóstrofos simples devem ser escapados como `\'`, aspas duplas como `\"`, e caracteres reservados como `&amp;`.
   * Tags HTML internas (`<b>`, `<i>`, `<br/>`) devem ser preservadas integralmente.
3. **Fluidez Cultural (Português do Brasil):**
   * Evitar construções literais do inglês.
   * Não utilizar termos do Português de Portugal (ex: usar "tela" e não "ecrã"; "arquivo" e não "ficheiro"; "salvar" e não "guardar").
4. **Glossário & Consistência:**
   * Manter termos técnicos consagrados da comunidade sem tradução forçada (ex: *Stremio*, *Scraper*, *Debrid*, *Canvas*, *Tile*, *Addon*).

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
* **Nunca use outro idioma como origem:**
  * `es`, `de`, `fr`, `ja`, `pl` ou qualquer tradução de terceiro servem apenas como **referência terminológica**, jamais como texto de origem.
  * Uma string já traduzida no upstream só pode ser reaproveitada depois de conferida contra a fonte EN; se não bater, retraduza.
* **Validação obrigatória antes de subir:**
  * Paridade de chaves com a fonte EN: **0 faltando, 0 sobrando**.
  * Placeholders, ICU (`plural`/`select`), tags HTML e escapes idênticos aos da fonte.
  * Strings idênticas ao EN apenas para marca, unidade ou termo técnico consagrado — nunca para frase.
* **Vale para todos os projetos do hub:** Nuvio, BitChord, TorBox, TizenTube, Better Lyrics, YTDLnis, DNSToggle e Crowdin Platform.

---

## 📂 3. Mapa do Repositório

```text
ptbr-translations/
├── .gitignore             # Ignora NuvioMobile/repo/, caches e arquivos de SO
├── AGENTS.md              # Este arquivo de diretrizes
├── README.md              # Vitrine oficial e portfólio dinâmico
├── 📁 BetterLyrics/       # Recursos do Crowdin e backup JSON
├── 📁 DNSToggle/          # Recursos do Weblate e documentação
└── 📁 NuvioMobile/        # Backups XML e repositório Git local
    └── 📁 repo/           # Clone oficial do fork
```
