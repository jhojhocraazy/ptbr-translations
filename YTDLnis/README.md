# 📥 YTDLnis — Central de Localização pt-BR

> **Módulo de Localização & Gestão de Tradução via Weblate para o aplicativo [YTDLnis](https://github.com/deniscerri/ytdlnis).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Repositório Oficial** | [`deniscerri/ytdlnis`](https://github.com/deniscerri/ytdlnis) (+10.600 stars) |
| **Plataforma de Tradução** | [Hosted Weblate — YTDLnis pt-BR](https://hosted.weblate.org/projects/ytdlnis/-/pt_BR/) |
| **Cobertura Geral** | 🟢 **100% Traduzido** (672 strings + 9 plurais) |
| **Status Upstream** | Sincronização direta via Pull Requests automáticos do Weblate |

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
├── ytdlnis_strings_pt_BR.xml # Backup local 100% completo com todas as strings traduzidas
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
