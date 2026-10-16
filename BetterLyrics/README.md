# 🎵 Better Lyrics — Central de Localização pt-BR

> **Módulo de Localização & Gestão de Tradução via Crowdin para o aplicativo [Better Lyrics](https://github.com/khanhas/better-lyrics).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma de Tradução** | [Crowdin — Projeto 863186 (`better-lyrics`)](https://crowdin.com/project/better-lyrics/pt-BR) |
| **Status no Crowdin** | 🟢 **100% Traduzido** (637 frases / 2.498 palavras) |
| **Status de Aprovação** | 🟢 **100% Aprovado** |
| **Versão Oficial em Produção** | `v3.0.0` (Lançamento oficial com tradução integral incluída) |
| **Integração Upstream** | Incorporado via Pull Request upstream #1001 pelo mantenedor `khanhas` |

---

## 🎧 Sobre o Better Lyrics

O **Better Lyrics** é um aplicativo de desktop de alta performance desenvolvido por [khanhas](https://github.com/khanhas) para exibir **letras sincronizadas em tempo real**, vídeos em looping (**Canvas**), traduções dinâmicas e suporte a romanização fonética (**Furigana** e **Romaji**) integrado diretamente com **Spotify**, **Apple Music**, **YouTube Music** e tocadores locais.

---

## 🚀 Histórico de Entregas & Marcos

### 1. Tradução Integral Inicial (v3.0.0)
* **Volume:** 636 frases originais e 2.495 palavras traduzidas do zero para o Português do Brasil.
* **Pull Request Upstream #1001:** O arquivo completo de localização foi incorporado oficialmente ao repositório upstream, fazendo o português brasileiro estar disponível nativamente no lançamento global estável da versão `v3.0.0`.

### 2. Manutenção Contínua & Atualizações (v3.1+)
* **Strings Recentes:** Nova chave `picture_in_picture_fitWindow` ("Fit window" ➔ "Ajustar à janela") traduzida e aprovada instantaneamente via API do Crowdin.
* **Taxa de Resposta:** Sincronização em tempo real conforme novas atualizações são publicadas pelo desenvolvedor.

---

## 📁 Arquitetura dos Arquivos Locais

```text
BetterLyrics/
├── better_lyrics_messages_pt_BR.json  # Backup local completo das mensagens (JSON i18n)
├── README.md                          # Este documento (Visão geral e status do projeto)
├── diretrizes-tecnicas.md             # Regras de sintaxe JSON, ICU MessageFormat e API Crowdin
└── glossario.md                       # Dicionário de termos musicais, streaming e CJK
```

---

## 🌐 Como Funciona a Gestão no Crowdin

Diferente do Nuvio (que utiliza commits diretos em XML no GitHub), o Better Lyrics utiliza a plataforma **Crowdin** como fonte oficial da verdade (*Single Source of Truth*):

1. O mantenedor (`khanhas`) adiciona ou edita strings no código-fonte.
2. O bot oficial do Crowdin sincroniza as novas strings na nuvem.
3. Joseph Alves (`@jhojhocraazy`) realiza a tradução e revisão das novas frases via painel web ou via automação por API REST v2.
4. O bot do Crowdin gera um Pull Request automático no repositório oficial do Better Lyrics contendo os arquivos `messages.json` atualizados para todas as línguas.

---

## 📖 Documentos Complementares

* 📘 [**Diretrizes Técnicas de Tradução (diretrizes-tecnicas.md)**](./diretrizes-tecnicas.md): Manual de engenharia para ICU MessageFormat, interpolação de variáveis, escapes JSON e documentação de integração com a API v2 do Crowdin.
* 📗 [**Glossário Terminológico Musical (glossario.md)**](./glossario.md): Dicionário especializado com regras para *Canvas*, *Time-synced*, *Furigana*, *Romanization*, *Scrobble* e ajustes de latência.
