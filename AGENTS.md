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
