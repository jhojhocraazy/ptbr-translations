<div align="center">

<!-- Banner Dinâmico -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=008542,002776,1e3a8a&height=180&section=header&text=ptbr-translations&fontSize=52&fontAlignY=36&desc=Central%20de%20Localiza%C3%A7%C3%A3o%20Open%20Source%20em%20Portugu%C3%AAs%20do%20Brasil%20%F0%9F%87%A7%F0%9F%87%B7&descAlignY=62&descSize=18" width="100%" alt="Header Banner" />

<!-- Efeito de Digitação Animado -->
<a href="https://github.com/jhojhocraazy/ptbr-translations">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=19&duration=3000&pause=1000&color=22C55E&center=true&vCenter=true&width=620&lines=Central+de+Localiza%C3%A7%C3%A3o+Open+Source+%F0%9F%87%A7%F0%9F%87%B7;Mais+de+22.500+strings+traduzidas+para+pt-BR;Nuvio+%E2%80%A2+BitChord+%E2%80%A2+Crowdin+%E2%80%A2+TizenTube+%E2%80%A2+YTDLnis;100%25+Compat%C3%ADvel+com+Placeholders+%26+Tags;Qualidade%2C+Fluidez+e+Consist%C3%AAncia+Terminol%C3%B3gica" alt="Typing SVG" />
</a>

<br/><br/>

<!-- Badges Principais Estilizadas -->
[![pt-BR](https://img.shields.io/badge/Portugu%C3%AAs%20(Brasil)-pt--BR-009739?style=for-the-badge&logo=brazil&logoColor=white)](https://github.com/jhojhocraazy/ptbr-translations)
[![Strings](https://img.shields.io/badge/Strings-+22.544-007ACC?style=for-the-badge&logo=google-translate&logoColor=white)](https://github.com/jhojhocraazy/ptbr-translations)
[![Cobertura](https://img.shields.io/badge/Cobertura-100%25-brightgreen?style=for-the-badge&logo=checkmarx)](https://github.com/jhojhocraazy/ptbr-translations)
[![Autor](https://img.shields.io/badge/Mantido%20por-Joseph%20Alves-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/jhojhocraazy)

</div>

---

## 📌 Sobre o Projeto

O **`ptbr-translations`** é o hub central de localização e internacionalização (**i18n & l10n**) dedicado a traduzir, manter e aprimorar projetos de código aberto de alto impacto para o **Português do Brasil (`pt-BR`)**.

Mantido ativamente por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy), o projeto garante traduções naturais, consistentes com a cultura do usuário brasileiro e com **100% de rigor técnico** na preservação de variáveis, placeholders e tags de sistema.

---

## 📊 Painel Geral de Projetos (Dashboard)

| Projeto | Ecossistema | Plataforma | Strings | Status Oficial | Progresso |
| :--- | :---: | :---: | :---: | :---: | :---: |
| [**Nuvio Mobile**](#1-nuvio-mobile) | Kotlin / Compose Multiplatform | GitHub PRs / XML | **+2.610** | 🟢 **Lançado** (`v0.6.1-beta`) | ![100%](https://geps.dev/progress/100?color=00c853) |
| [**BitChord**](#2-bitchord) | Android / Desktop / Wear OS | GitHub PRs / XML | **+1.250** | 🚀 **Em Análise** ([PR #952](https://github.com/kushagrasinghx/BitChord/pull/952)) | ![100%](https://geps.dev/progress/100?color=00c853) |
| [**YTDLnis**](#3-ytdlnis) | Android (yt-dlp Downloader) | Hosted Weblate / XML | **681** | 🟢 **100% Traduzido** (Sugestões Ativas) | ![100%](https://geps.dev/progress/100?color=00c853) |
| [**Better Lyrics**](#4-better-lyrics) | Extensão / YouTube Music | Crowdin (863186) | **637** | 🟢 **Sincronizado** (PR #1010) | ![100%](https://geps.dev/progress/100?color=00c853) |
| [**Crowdin Platform**](#5-crowdin-platform) | TMS / Web App + Backend | Crowdin API (31) | **17.169** (214 arquivos) | 🟢 **100% Traduzido** (0 pendentes) | ![100%](https://geps.dev/progress/100?color=00c853) |
| [**TizenTube & Cobalt**](#6-tizentube--tizentube-cobalt) | Smart TV (Tizen OS / Android TV) | GitHub PRs / JSON | **197** | 🚀 **Em Análise** ([PR #718](https://github.com/reisxd/TizenTube/pull/718)) | ![100%](https://geps.dev/progress/100?color=00c853) |
| [**DNSToggle**](#7-dnstoggle) | Android Quick Settings | Weblate / GitHub | **100%** | 🟢 **Integrado** (`main`) | ![100%](https://geps.dev/progress/100?color=00c853) |

---

## 🚀 Projetos Mantidos em Detalhes

### 1. Nuvio Mobile
> Aplicativo moderno de streaming de mídia e entretenimento desenvolvido em **Kotlin Multiplatform (Compose Multiplatform)** para Android e iOS.

* **Repositório Oficial:** [`NuvioMedia/NuvioMobile`](https://github.com/NuvioMedia/NuvioMobile)
* **Status:** 🟢 **100% Traduzido** (+2.610 strings em 7 arquivos modulares).
* **Diretório Local:** [`NuvioMobile/`](./NuvioMobile/)

<details>
<summary><b>🔍 Ver Histórico de Entregas & Pull Requests do Nuvio Mobile</b></summary>
<br/>

* **PR #2234:** [Traduz todas as strings do app para pt-BR](https://github.com/NuvioMedia/NuvioMobile/pull/2234)
  * **Status:** 🚀 **MERGED**
  * **Publicação:** Lançado oficialmente nas versões estáveis `v0.6.0-beta` e `v0.6.1-beta`.
  * **Volume:** 2.410 strings + 4 plurais.
* **PR #2288:** [Adiciona tradução dos 5 novos módulos](https://github.com/NuvioMedia/NuvioMobile/pull/2288)
  * **Status:** 🧪 **CI PASSED** (`Build fullDebug APK: SUCCESS`).
  * **Módulos:** `strings_party.xml` (74 strings), `strings_servers.xml` (60 strings), `strings_mdblist.xml` (52 strings), `autosync_strings.xml` (10 strings), `autosync_toast_strings.xml` (4 strings).
</details>

---

### 2. BitChord
> Cliente moderno de YouTube Music com estética inspirada no Apple Music desenvolvido em **Kotlin Multiplatform (KMP)** para Android, Desktop e Wear OS.

* **Repositório Oficial:** [`kushagrasinghx/BitChord`](https://github.com/kushagrasinghx/BitChord) (+3.700 stars)
* **Status:** 🟢 **100% Traduzido** (+1.250 strings em todos os 5 módulos).
* **Diretório Local:** [`BitChord/`](./BitChord/)

<details>
<summary><b>🔍 Ver Histórico de Entregas & Detalhes do BitChord</b></summary>
<br/>

* **PR #952:** [loc(pt): complete Portuguese (pt-BR) localization and fix untranslated strings across all modules](https://github.com/kushagrasinghx/BitChord/pull/952)
  * **Status:** 🚀 **OPEN / IN REVIEW**
  * **Módulos Abrangidos:** Android Core (1.044 strings), Desktop App (765 strings), Shared UI (179 strings), Desktop UI (179 strings) e Wear OS (40 strings).
  * **Destaques:** Tradução completa das telas do Android Auto, predefinições do equalizador paramétrico, pipeline de áudio DSP e módulo para smartwatches Wear OS.
</details>

---

### 3. YTDLnis
> Poderoso gerenciador e baixador de áudio e vídeo para Android com suporte a mais de 1.000 sites via yt-dlp.

* **Repositório Oficial:** [`deniscerri/ytdlnis`](https://github.com/deniscerri/ytdlnis) (+10.600 stars)
* **Plataforma de Tradução:** [Hosted Weblate — YTDLnis pt_BR](https://hosted.weblate.org/projects/ytdlnis/-/pt_BR/)
* **Status:** 🟢 **100% Traduzido** (681 strings e plurais revisados).
* **Diretório Local:** [`YTDLnis/`](./YTDLnis/)

<details>
<summary><b>🔍 Ver Detalhes do Projeto YTDLnis</b></summary>
<br/>

* **Cobertura Completa:** 672 strings + 9 plurais traduzidos e validados.
* **Escopo da Tradução:** Telas de boas-vindas (*welcome onboarding*), integração com lrclib.net para letras sincronizadas, corte e recorte de mídia, agendamento de downloads e configurações avançadas do yt-dlp.
* **Rigor e Qualidade:** 100% de integridade em tags de escape (`\'`, `\"`, `&amp;`) e placeholders de sistema (`%1$s`, `%2$d`).
</details>

---

### 4. Better Lyrics
> Extensão para YouTube Music com letras sincronizadas em tempo real, romanização, tradução e temas personalizados.

* **Repositório Oficial:** [`better-lyrics/better-lyrics`](https://github.com/better-lyrics/better-lyrics)
* **Plataforma de Tradução:** [Crowdin — Projeto 863186](https://crowdin.com/project/better-lyrics/pt-BR)
* **Status:** 🟢 **100% Traduzido** (637 frases / 2.498 palavras) — revisão formal pendente no Crowdin.
* **Diretório Local:** [`BetterLyrics/`](./BetterLyrics/)

<details>
<summary><b>🔍 Ver Detalhes do Projeto Better Lyrics</b></summary>
<br/>

* **Sincronização Upstream:** `_locales/pt_BR/messages.json` entregue pelos PRs automáticos do Crowdin #1001 e #1010, mesclados em 15/10 e 20/10/2026.
* **Sincronização Contínua:** Atualização via API oficial do Crowdin, com validação de placeholders (`$VAR$`), tags e termos protegidos antes de cada envio.
* **Terminologia Musical:** Preservação de termos como *Unison*, *Time-synced*, *Romanization*, *Furigana* e *Picture-in-Picture*.
</details>

---

### 5. Crowdin Platform
> A principal plataforma global de gerenciamento contínuo de localização e tradução baseada em nuvem para equipes de engenharia e produto.

* **Projeto Oficial:** [Crowdin Translations (ID: 31)](https://crowdin.com/project/crowdin)
* **Plataforma de Tradução:** Crowdin API v2
* **Status:** 🟢 **100% Traduzido** (**17.169 strings** / 117.078 palavras em 214 arquivos — 0 pendentes).
* **Diretório Local:** [`Crowdin/`](./Crowdin/)

<details>
<summary><b>🔍 Ver Detalhes do Projeto Crowdin Platform</b></summary>
<br/>

* **Cobertura Total (100%):** 17.169 strings visíveis traduzidas, 923 strings ocultas e **0 pendentes** em 214 arquivos, cobrindo web app, backend, e-mails e templates.
* **Interface Moderna Web:** 1.642 strings de `src/i18n/locales/en.json` (ID: 32447) concluídas.
* **Escopo Completo:** Editor (`editor.csv`), Aplicação Web (`dynamic.csv`), Backend/Relatórios (`backend.csv`), Frontend (`frontend.csv`), permissões e escopos, MFA, log de segurança, autenticação e modelos de e-mail.
* **Qualidade:** 100% de integridade em placeholders (`{project}`, `%s`, `{{mustache}}`), argumentos ICU (`plural`/`select`), tags HTML e escapes — auditoria final com **0 divergências**. 21 traduções anteriores corrigidas (placeholders perdidos, HTML escapado e textos truncados).
* **Integração:** Submissão direta e atribuída oficialmente a Joseph Alves (`@jhojhocraazy`) via API v2.
</details>

---

### 6. TizenTube & TizenTube Cobalt
> Cliente avançado de streaming sem anúncios com suporte nativo a SponsorBlock, DeArrow e controle de taxa de quadros (AFR) para Smart TVs Samsung (Tizen OS) e Android TV / Google TV / Fire TV (Cobalt).

* **Repositórios Oficiais:** [`reisxd/TizenTube`](https://github.com/reisxd/TizenTube) (+2.800 stars) e [`reisxd/TizenTubeCobalt`](https://github.com/reisxd/TizenTubeCobalt)
* **Status:** 🟢 **100% Traduzido** (197 strings revisadas e traduzidas).
* **Diretório Local:** [`TizenTube/`](./TizenTube/)

<details>
<summary><b>🔍 Ver Histórico de Entregas & Detalhes do TizenTube</b></summary>
<br/>

* **PR #718:** [feat(i18n): complete Portuguese (pt-BR) localization and translate missing strings](https://github.com/reisxd/TizenTube/pull/718)
  * **Status:** 🚀 **OPEN / IN REVIEW**
  * **Destaques:** Tradução completa de 92 strings que estavam em inglês (barra lateral, relógio em tela, menus de vídeo, atualizador do Cobalt e controle de velocidade).
  * **Multiplataforma:** A tradução atende simultaneamente Smart TVs Samsung (TizenBrew/Tizen OS) e dispositivos Android TV/Fire TV via TizenTube Cobalt.
  * **Créditos Oficiais:** Inclusão de Joseph Alves no arquivo oficial `pt-BR.json` (`__contributors`).
</details>

---

### 7. DNSToggle
> Aplicativo Android open source para alternar rapidamente servidores DNS privados e perfis de rede via Quick Settings Tiles.

* **Repositório Oficial:** [`ELowry/DNSToggle`](https://github.com/ELowry/DNSToggle)
* **Plataforma de Tradução:** Weblate / GitHub
* **Status:** 🟢 **100% Traduzido** em todos os 5 componentes oficiais.
* **Diretório Local:** [`DNSToggle/`](./DNSToggle/)

<details>
<summary><b>🔍 Ver Detalhes do DNSToggle</b></summary>
<br/>

* **Componentes Traduzidos:** Interface do Usuário, Quick Settings Tiles, Descrições de Notificação, Diálogos de Permissão e Metadados do App.
* **Integração:** Commits diretos atribuídos e mesclados na branch oficial `translation`.
</details>

---

## 📁 Arquitetura do Repositório

```text
ptbr-translations/
├── 📁 BetterLyrics/          # Backups JSON e recursos do Crowdin
│   ├── better_lyrics_messages_en.json   # Snapshot da fonte EN (upstream)
│   └── better_lyrics_messages_pt_BR.json
├── 📁 BitChord/              # Recursos XML e clone do repositório
│   └── 📁 repo/              # Repositório Git conectado ao fork e upstream
├── 📁 Crowdin/               # Recursos da plataforma Crowdin e backup JSON
│   ├── crowdin_translations_pt_BR.json
│   ├── diretrizes-tecnicas.md
│   ├── glossario.md
│   └── README.md
├── 📁 DNSToggle/             # Documentação e recursos do Weblate
│   └── README.md
├── 📁 NuvioMobile/           # Backups XML e clone do repositório
│   ├── NuvioMobile_strings_pt_BR.xml
│   └── 📁 repo/              # Repositório Git conectado ao fork e upstream
├── 📁 TizenTube/             # Backup JSON completo e clone do repositório
│   ├── diretrizes-tecnicas.md
│   ├── glossario.md
│   ├── README.md
│   ├── tizentube_pt_BR.json
│   └── 📁 repo/              # Repositório Git conectado ao fork e upstream
├── 📁 YTDLnis/               # Backup XML completo e documentação
│   ├── diretrizes-tecnicas.md
│   ├── glossario.md
│   ├── README.md
│   └── ytdlnis_strings_pt_BR.xml
├── .gitignore                # Isolamento de compilações e repositórios aninhados
├── AGENTS.md                 # Diretrizes e governança do repositório
└── README.md                 # Documentação e portfólio oficial
```

---

## 🎯 Padrões de Qualidade & Engenharia de Localização

Todas as traduções seguem um protocolo rigoroso de controle de qualidade:

1. **🇧🇷 Naturalidade Fluida:** Adaptação contextual para o português falado no Brasil, eliminando traduções literais robóticas.
2. **🛡️ Integridade de Código:** 100% de compatibilidade e preservação de placeholders (`%1$s`, `%2$d`, `{username}`), tags de formatação XML/HTML e sequências de escape (`\n`, `\'`).
3. **📖 Consistência Terminológica:** Termos técnicos do ecossistema de streaming, áudio e redes são harmonizados entre versões.

---

<div align="center">

Desenvolvido com dedicação por **[Joseph Alves](https://github.com/jhojhocraazy)** 🇧🇷

[![GitHub Profile](https://img.shields.io/badge/GitHub-jhojhocraazy-181717?style=flat-square&logo=github)](https://github.com/jhojhocraazy)

</div>
