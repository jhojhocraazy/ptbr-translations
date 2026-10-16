# 🇧🇷 ptbr-translations

> **Central de Localização & Internacionalização (i18n / l10n) para Projetos Open Source em Português do Brasil.**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Visão Geral & Métricas

| Métrica | Valor |
| :--- | :--- |
| **Projetos Ativos** | 3 (Nuvio Mobile, Better Lyrics, DNSToggle) |
| **Total de Strings Traduzidas** | **+3.200 strings** |
| **Palavras Traduzidas** | **+15.000 palavras** |
| **Taxa de Cobertura** | 100% de precisão semântica e suporte a placeholders |
| **Formatos Suportados** | Android XML (Compose Multiplatform), JSON (Crowdin), Gettext PO (Weblate) |

---

## 🚀 Projetos Mantidos

### 1. [Nuvio Mobile](https://github.com/NuvioMedia/NuvioMobile)
Aplicativo moderno de streaming de mídia e entretenimento desenvolvido em **Kotlin Multiplatform (Compose Multiplatform)** para Android e iOS.

* **Método de Tradução:** Git / Fork / Pull Requests diretos.
* **Status:** 🟢 **100% Traduzido** (+2.610 strings).
* **Entregas & Histórico:**
  * **PR #2234:** [Traduz todas as strings do app para pt-BR](https://github.com/NuvioMedia/NuvioMobile/pull/2234) — **Merged** (Lançado nas versões oficiais `0.6.0-beta` e `0.6.1-beta`).
  * **PR #2288:** [Adiciona tradução dos 5 novos módulos](https://github.com/NuvioMedia/NuvioMobile/pull/2288) (Party, Servers, MDBList, AutoSync).
* **Pasta Local:** [`NuvioMobile/`](./NuvioMobile/)

---

### 2. [Better Lyrics](https://github.com/khanhas/better-lyrics)
Utilitário de letras sincronizadas em tempo real para Spotify, Apple Music e tocadores de desktop.

* **Método de Tradução:** Crowdin ([Projeto 863186](https://crowdin.com/project/better-lyrics/pt-BR)).
* **Status:** 🟢 **100% Traduzido** (637 frases / 2.498 palavras).
* **Entregas & Histórico:**
  * **Release v3.0.0:** Tradução integral oficializada e incorporada na versão estável via PR #1001.
  * Sincronização contínua via API oficial do Crowdin.
* **Pasta Local:** [`BetterLyrics/`](./BetterLyrics/)

---

### 3. [DNSToggle](https://github.com/ELowry/DNSToggle)
Aplicativo Android open source para alternar rapidamente servidores DNS privados e perfis de rede via Quick Settings Tiles.

* **Método de Tradução:** Weblate / GitHub.
* **Status:** 🟢 **100% Traduzido** em todos os 5 componentes oficiais.
* **Entregas & Histórico:**
  * Commits oficiais de tradução aceitos e mesclados na branch `translation`.
* **Pasta Local:** [`DNSToggle/`](./DNSToggle/)

---

## 📁 Estrutura do Workspace

```text
ptbr-translations/
├── BetterLyrics/         # Backups de mensagens e scripts da API Crowdin
├── DNSToggle/            # Recursos de localização e notas Weblate
├── NuvioMobile/          # Backups XML e clone do repositório (repo/)
│   └── repo/             # Repositório Git conectado ao fork e upstream
├── .gitignore            # Regras de isolamento de builds e repositórios aninhados
└── README.md             # Documentação e portfólio oficial
```

---

## 🎯 Padrões de Localização (Diretrizes de Qualidade)

1. **Naturalidade e Clareza:** Adaptação fluida para o português falado no Brasil, evitando traduções mecânicas ou literais.
2. **Preservação Técnica:** 100% de compatibilidade com placeholders (`%1$s`, `%2$d`, `{username}`, etc.), tags XML/HTML e caracteres de escape.
3. **Consistência Terminológica:** Termos técnicos do ecossistema (como *Stremio*, *Scraper*, *Debrid*, *Canvas*) são preservados conforme o padrão adotado pela comunidade.

---

<p align="center">
  Feito com dedicação por <b>Joseph Alves</b> 🇧🇷
</p>
