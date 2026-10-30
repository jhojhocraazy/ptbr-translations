# 🎵 BitChord — Central de Localização pt-BR

> **Módulo de Localização & Engenharia de Internacionalização (i18n & l10n) para o aplicativo [BitChord](https://github.com/kushagrasinghx/BitChord).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma Tecnológica** | Kotlin Multiplatform (KMP) + Jetpack Compose / Compose Multiplatform |
| **Sistemas Alvo** | Android e Wear OS (o módulo Desktop foi removido do upstream em 26/10/2026) |
| **Cobertura Geral** | 🟢 **100% Traduzido** (+1.471 strings nos 3 módulos ativos: Android, Shared UI e Wear OS) |
| **Repositório Upstream** | [`kushagrasinghx/BitChord`](https://github.com/kushagrasinghx/BitChord) (+3.700 stars) |
| **Branch de Trabalho** | `i18n/pt-br-182` (PR #1204, base `v1.8.2`) |
| **Última Versão** | `v1.9` (30/10/2026) — saiu antes do merge desta PR |

---

## 🎧 Sobre o BitChord

O **BitChord** é um dos clientes de código aberto mais elegantes e avançados para o **YouTube Music**. Desenvolvido com foco em estética minimalista inspirada no **Apple Music**, o aplicativo conta com:
* Equalizador paramétrico avançado com suporte a saídas PCM e Float de 32 bits.
* Integração completa com **Android Auto** para navegação no painel de veículos.
* Aplicativo complementar dedicado para **Wear OS** (smartwatches).
* Suporte multiplataforma nativo para desktop e mobile com **Compose Multiplatform**.

---

## 🗂️ Arquitetura dos Módulos de Tradução

A localização do BitChord cobre os 3 módulos da branch `v1.8.2`:

| Módulo | Arquivo de Tradução | Strings | Status pt-BR |
| :--- | :--- | :---: | :---: |
| **Android Core (`app/`)** | [`app/src/main/res/values-pt/strings.xml`](./repo/app/src/main/res/values-pt/strings.xml) | 1.112 strings + 23 plurais | 🟢 100% Concluído |
| **UI Multiplataforma (`sharedUi/`)** | [`sharedUi/.../values-pt/strings.xml`](./repo/sharedUi/src/commonMain/composeResources/values-pt/strings.xml) | 249 | 🟢 100% Concluído |
| **Wear OS Smartwatches (`wearos/`)** | [`wearos/src/main/res/values-pt/strings.xml`](./repo/wearos/src/main/res/values-pt/strings.xml) | 40 | 🟢 100% Concluído (Criado) |

---

## 🚀 O que foi Feito Nesta Localização

1. **Eliminação de Termos em Inglês:** 115 entradas que ainda estavam em inglês no `app` (saída de áudio, Cast, atraso de letras, equalizador, SMB, WebDAV e outras) foram traduzidas, além das 79 que faltavam no `sharedUi`.
2. **Base Correta do Ciclo de Release (28/10/2026):** a entrega foi refeita sobre a branch `v1.8.2`, conforme o `CONTRIBUTING.md`, em vez de `main`. A PR #952 foi fechada e substituída pela #1204.
3. **Criação do Módulo Wear OS:** arquivo `values-pt/strings.xml` criado do zero para relógios Wear OS (40 strings), já que o upstream ainda não tem tradução nesse módulo.
4. **Novas Strings:** traduzidas as 145 chaves que o upstream adicionou (bit-perfect/DAC, modos de renderização, Top Picks, catálogo de climas, períodos do Replay, cache parcial e painel de informações da música), com paridade total de chaves traduzíveis.
5. **Rebase de 30/10/2026:** a branch foi refeita sobre o head atual da `v1.8.2` (14 commits) e recebeu as 15 strings novas do upstream — seleção de fonte (SF Pro/Clássica), sincronização de playlists baixadas, conversão para DACs limitados e a tolerância padrão atualizada de 3 para 5 segundos.

---

## 🛠️ Como Trabalhar no Repositório Local (`repo/`)

A pasta [`repo/`](./repo/) é um clone oficial do seu fork (`jhojhocraazy/BitChord`).

### Remotos Configurados:
* **`origin`**: `https://github.com/jhojhocraazy/BitChord.git` (Seu fork pessoal)
* **`upstream`**: `https://github.com/kushagrasinghx/BitChord.git` (Repositório oficial)

---

## 📖 Documentos Complementares

* 📘 [**Diretrizes Técnicas de Tradução (diretrizes-tecnicas.md)**](./diretrizes-tecnicas.md): Manual técnico detalhando a normalização do `LocaleTags.kt`, escapes XML e validação de testes.
* 📗 [**Glossário de Áudio & Streaming (glossario.md)**](./glossario.md): Dicionário de padronização para termos de equalização, YouTube Music, áudio espacial e Automix.
