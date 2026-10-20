# 🎵 Better Lyrics — Central de Localização pt-BR

> **Módulo de Localização & Gestão de Tradução via Crowdin para a extensão [Better Lyrics](https://github.com/better-lyrics/better-lyrics) (YouTube Music).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma de Tradução** | [Crowdin — Projeto 863186 (`better-lyrics`)](https://crowdin.com/project/better-lyrics/pt-BR) |
| **Status no Crowdin** | 🟢 **100% Traduzido** (637 frases / 2.498 palavras) |
| **Status de Aprovação** | 🟡 **0% Aprovado** (nenhuma revisão formal registrada — a conta não tem permissão de *proofreader*) |
| **Entrega Upstream** | Sincronizado em `_locales/pt_BR/messages.json` pelos PRs automáticos #1001 (mesclado em 15/10/2026) e #1010 (mesclado em 20/10/2026) |

---

## 🎧 Sobre o Better Lyrics

O **Better Lyrics** é uma extensão de navegador para o **YouTube Music**, mantida pela organização [better-lyrics](https://github.com/better-lyrics), que exibe **letras sincronizadas em tempo real**, com tradução, **romanização** fonética, modo **Picture-in-Picture**, **Theme Marketplace** (temas personalizados e editor de estilos) e integração com o acervo colaborativo **Unison**.

> ⚠️ **Nota de escopo:** este módulo cobre exclusivamente a extensão do YouTube Music (projeto Crowdin **863186**). O aplicativo desktop homônimo para Spotify/Apple Music é um projeto distinto e não faz parte deste hub.

---

## 🚀 Histórico de Entregas & Marcos

### 1. Tradução Integral Inicial
* **Volume:** 637 frases e 2.498 palavras traduzidas do zero para o Português do Brasil.
* **Pull Request Upstream #1001:** O arquivo completo de localização (`_locales/pt_BR/messages.json`) foi incorporado ao repositório upstream em 15/10/2026, tornando o português brasileiro parte das línguas distribuídas com a extensão.

### 2. Manutenção Contínua & Atualizações
* **Sincronização mais recente:** PR #1010, aberto pelo bot do Crowdin em 16/10/2026 e mesclado em 20/10/2026, cobrindo as 637 strings vigentes naquele momento.
* **Strings Recentes:** `picture_in_picture_fitWindow` ("Fit window" ➔ "Ajustar à janela") traduzida conforme o glossário (linha 51). Uma submissão de 20/10 havia regredido a string para "Ajustar janela"; a versão correta foi restaurada no Crowdin em 20/10/2026.
* **Revisão:** o catálogo está 100% traduzido, mas **0% aprovado** — a conta usada no projeto não possui permissão de *proofreader*, portanto a aprovação formal depende do mantenedor.

---

## 📁 Arquitetura dos Arquivos Locais

```text
BetterLyrics/
├── better_lyrics_messages_pt_BR.json  # Backup local das mensagens em pt-BR (JSON i18n)
├── better_lyrics_messages_en.json     # Snapshot exato da fonte EN (upstream), para auditoria offline
├── README.md                          # Este documento (Visão geral e status do projeto)
├── diretrizes-tecnicas.md             # Regras de sintaxe JSON, ICU MessageFormat e API Crowdin
└── glossario.md                       # Dicionário de termos musicais, streaming e CJK
```

---

## 🌐 Como Funciona a Gestão no Crowdin

Diferente do Nuvio (que utiliza commits diretos em XML no GitHub), o Better Lyrics utiliza a plataforma **Crowdin** como fonte oficial da verdade (*Single Source of Truth*):

1. O mantenedor da organização [better-lyrics](https://github.com/better-lyrics) adiciona ou edita strings no código-fonte.
2. O bot oficial do Crowdin sincroniza as novas strings na nuvem.
3. Joseph Alves (`@jhojhocraazy`) realiza a tradução e revisão das novas frases via painel web ou via automação por API REST v2.
4. O bot do Crowdin gera um Pull Request automático no repositório oficial do Better Lyrics contendo os arquivos `messages.json` atualizados para todas as línguas.

---

## 📖 Documentos Complementares

* 📘 [**Diretrizes Técnicas de Tradução (diretrizes-tecnicas.md)**](./diretrizes-tecnicas.md): Manual de engenharia para ICU MessageFormat, interpolação de variáveis, escapes JSON e documentação de integração com a API v2 do Crowdin.
* 📗 [**Glossário Terminológico Musical (glossario.md)**](./glossario.md): Dicionário especializado com regras para *Unison*, *Time-synced*, *Furigana*, *Romanization*, *Picture-in-Picture* e ajustes de sincronização.
