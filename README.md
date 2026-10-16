<div align="center">

<!-- Banner Dinâmico -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=008542,002776,1e3a8a&height=180&section=header&text=ptbr-translations&fontSize=52&fontAlignY=36&desc=Central%20de%20Localiza%C3%A7%C3%A3o%20Open%20Source%20em%20Portugu%C3%AAs%20do%20Brasil%20%F0%9F%87%A7%F0%9F%87%B7&descAlignY=62&descSize=18" width="100%" alt="Header Banner" />

<!-- Efeito de Digitação Animado -->
<a href="https://github.com/jhojhocraazy/ptbr-translations">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=19&duration=3000&pause=1000&color=22C55E&center=true&vCenter=true&width=620&lines=Central+de+Localiza%C3%A7%C3%A3o+Open+Source+%F0%9F%87%A7%F0%9F%87%B7;Mais+de+3.200+strings+traduzidas+para+pt-BR;Nuvio+Mobile+%E2%80%A2+Better+Lyrics+%E2%80%A2+DNSToggle;100%25+Compat%C3%ADvel+com+Placeholders+%26+Tags;Qualidade%2C+Fluidez+e+Consist%C3%AAncia+Terminol%C3%B3gica" alt="Typing SVG" />
</a>

<br/><br/>

<!-- Badges Principais Estilizadas -->
[![pt-BR](https://img.shields.io/badge/Portugu%C3%AAs%20(Brasil)-pt--BR-009739?style=for-the-badge&logo=brazil&logoColor=white)](https://github.com/jhojhocraazy/ptbr-translations)
[![Strings](https://img.shields.io/badge/Strings-+3.200-007ACC?style=for-the-badge&logo=google-translate&logoColor=white)](https://github.com/jhojhocraazy/ptbr-translations)
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
| [**Better Lyrics**](#2-better-lyrics) | Desktop / Spotify / Apple Music | Crowdin (863186) | **637** | 🟢 **Lançado** (`v3.0.0`) | ![100%](https://geps.dev/progress/100?color=00c853) |
| [**DNSToggle**](#3-dnstoggle) | Android Quick Settings | Weblate / GitHub | **100%** | 🟢 **Integrado** (`main`) | ![100%](https://geps.dev/progress/100?color=00c853) |

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

### 2. Better Lyrics
> Utilitário de letras sincronizadas em tempo real para Spotify, Apple Music e tocadores de desktop.

* **Repositório Oficial:** [`khanhas/better-lyrics`](https://github.com/khanhas/better-lyrics)
* **Plataforma de Tradução:** [Crowdin — Projeto 863186](https://crowdin.com/project/better-lyrics/pt-BR)
* **Status:** 🟢 **100% Concluído** (637 frases / 2.498 palavras traduzidas e aprovadas).
* **Diretório Local:** [`BetterLyrics/`](./BetterLyrics/)

<details>
<summary><b>🔍 Ver Detalhes do Projeto Better Lyrics</b></summary>
<br/>

* **Release Oficial:** Incorporado integralmente no lançamento oficial **v3.0.0** via Pull Request upstream #1001.
* **Sincronização:** Atualização em tempo real via API oficial do Crowdin.
* **Terminologia Musical:** Preservação cuidadosa de termos como *Canvas*, *Time-synced*, *Romanization* e *Furigana*.
</details>

---

### 3. DNSToggle
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
│   └── better_lyrics_messages_pt_BR.json
├── 📁 DNSToggle/             # Documentação e recursos do Weblate
│   └── README.md
├── 📁 NuvioMobile/           # Backups XML e clone do repositório
│   ├── NuvioMobile_strings_pt_BR.xml
│   └── 📁 repo/              # Repositório Git conectado ao fork e upstream
├── .gitignore                # Isolamento de compilações e repositórios aninhados
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
