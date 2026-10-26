# 📥 YTDLnis — Central de Localização pt-BR

> **Módulo de Localização & Gestão de Tradução via Weblate para o aplicativo [YTDLnis](https://github.com/deniscerri/ytdlnis).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Repositório Oficial** | [`deniscerri/ytdlnis`](https://github.com/deniscerri/ytdlnis) (+10.600 stars) |
| **Plataforma de Tradução** | [Hosted Weblate — YTDLnis pt-BR](https://hosted.weblate.org/projects/ytdlnis/-/pt_BR/) |
| **Cobertura Geral** | 🟢 **100% Traduzido** (682 unidades, 0 pendentes e 0 avisos de qualidade) |
| **Pendências** | 🟢 **0 pendentes** no Weblate (24/10/2026) |
| **Checks Ativos** | 🟢 **0 avisos** — os 5 falsos positivos anteriores foram resolvidos/suprimidos na plataforma |
| **Refinamentos** | 107 strings revisadas e aplicadas nesta rodada |
| **Status Upstream** | Sincronização direta via Pull Requests automáticos do Weblate |

> **Nota:** as 3 strings read-only (`trendingPlaylist`, `unfound_file`, `ytdlp`) não são editáveis no Weblate e não entram no XML exportado; o Android usa o fallback da fonte. Os 5 checks restantes são falsos positivos: `JSON`/`Info-JSONs` são termos protegidos pelo glossário e `Nightly` é o nome próprio do canal.

---

## 🚀 Sobre o YTDLnis

O **YTDLnis** é o mais popular e completo aplicativo de download de vídeo e áudio para Android baseado na poderosa ferramenta de linha de comando **`yt-dlp`** e no motor multimídia **`FFmpeg`**.

O aplicativo oferece:
* Download de múltiplos formatos de vídeo e áudio com extração automática.
* Suporte a playlists, canais, capítulos e segmentos do SponsorBlock.
* Integração com letras sincronizadas em tempo real via **LRCLIB**.
* Ferramentas avançadas de corte de vídeo, embutimento de legendas e download acelerado com **`aria2c`**.
* Reconhecimento oficial de contribuidores em uma tela dedicada de **Tradutores**.

---

## 📁 Arquitetura dos Arquivos Locais

```text
YTDLnis/
├── ytdlnis_strings_pt_BR.xml # Backup oficial do Weblate (669 strings + 9 plurais; 3 read-only não exportadas)
├── README.md                 # Este documento (Visão geral e status do projeto)
├── diretrizes-tecnicas.md    # Regras técnicas de XML, permissões Android e integração com Weblate
└── glossario.md              # Dicionário especializado de yt-dlp, FFmpeg, codecs e formatos de mídia
```

---

## 🌐 Como Funciona o Ciclo de Tradução no Weblate

1. As traduções são submetidas na plataforma oficial do Weblate ([`hosted.weblate.org/projects/ytdlnis/-/pt_BR/`](https://hosted.weblate.org/projects/ytdlnis/-/pt_BR/)).
2. O bot oficial do Weblate gera Pull Requests com o título *"Translations update from Hosted Weblate"* atribuindo os commits ao tradutor (**Joseph Alves**).
3. O desenvolvedor `Denis Çerri` mescla os Pull Requests quase diariamente no repositório oficial do GitHub.

---

## 📖 Documentos Complementares

* 📘 [**Diretrizes Técnicas de Tradução (diretrizes-tecnicas.md)**](./diretrizes-tecnicas.md): Manual técnico detalhando variáveis, permissões do Android, regras de tags XML e boas práticas do Weblate.
* 📗 [**Glossário de Download & Mídia (glossario.md)**](./glossario.md): Tabela de referência técnica para desambiguação de termos de yt-dlp, FFmpeg, codecs, aria2c e letras musicais.
