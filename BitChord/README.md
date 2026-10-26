# 🎵 BitChord — Central de Localização pt-BR

> **Módulo de Localização & Engenharia de Internacionalização (i18n & l10n) para o aplicativo [BitChord](https://github.com/kushagrasinghx/BitChord).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma Tecnológica** | Kotlin Multiplatform (KMP) + Jetpack Compose / Compose Multiplatform |
| **Sistemas Alvo** | Android e Wear OS (o módulo Desktop foi removido do upstream em 26/10/2026) |
| **Cobertura Geral** | 🟢 **100% Traduzido** (+1.336 strings nos 3 módulos ativos: Android, Shared UI e Wear OS) |
| **Repositório Upstream** | [`kushagrasinghx/BitChord`](https://github.com/kushagrasinghx/BitChord) (+3.700 stars) |
| **Branch de Trabalho** | `i18n/portuguese-complete-pt-br` (PR #952) |
| **Última Versão** | `v1.8.1` (19/10/2026) — anterior ao lote atual |

---

## 🎧 Sobre o BitChord

O **BitChord** é um dos clientes de código aberto mais elegantes e avançados para o **YouTube Music**. Desenvolvido com foco em estética minimalista inspirada no **Apple Music**, o aplicativo conta com:
* Equalizador paramétrico avançado com suporte a saídas PCM e Float de 32 bits.
* Integração completa com **Android Auto** para navegação no painel de veículos.
* Aplicativo complementar dedicado para **Wear OS** (smartwatches).
* Suporte multiplataforma nativo para desktop e mobile com **Compose Multiplatform**.

---

## 🗂️ Arquitetura dos Módulos de Tradução

A localização do BitChord está dividida em 3 arquivos modulares após a reestruturação do upstream (os módulos `desktopApp/` e `desktopUi/` foram removidos):

| Módulo | Arquivo de Tradução | Strings | Status pt-BR |
| :--- | :--- | :---: | :---: |
| **Android Core (`app/`)** | [`app/src/main/res/values-pt/strings.xml`](./repo/app/src/main/res/values-pt/strings.xml) | 1.070 traduzíveis + 24 plurais | 🟢 100% Concluído |
| **UI Multiplataforma (`sharedUi/`)** | [`sharedUi/.../values-pt/strings.xml`](./repo/sharedUi/src/commonMain/composeResources/values-pt/strings.xml) | 179 | 🟢 100% Concluído |
| **Wear OS Smartwatches (`wearos/`)** | [`wearos/src/main/res/values-pt/strings.xml`](./repo/wearos/src/main/res/values-pt/strings.xml) | 40 | 🟢 100% Concluído (Criado) |

---

## 🚀 O que foi Feito Nesta Localização

1. **Eliminação de Termos em Inglês:** Mais de 140 frases que estavam em inglês no meio das telas (avisos do Android Auto, predefinições do equalizador, saída de áudio, Cast e diálogos de login) foram 100% traduzidas para o Português do Brasil.
2. **Reestruturação do Upstream (26/10/2026):** os módulos `desktopApp/` e `desktopUi/` foram removidos do repositório oficial e a UI passou para `sharedUi/`. A PR #952 foi refeita sobre a nova base e voltou a ficar **MERGEABLE**.
3. **Criação do Módulo Wear OS:** mantido o arquivo `values-pt/strings.xml` criado do zero para relógios Wear OS (40 strings), já que o upstream ainda não tem tradução nesse módulo.
4. **Novas Strings (26/10/2026):** traduzidas as 17 entradas adicionadas pelo upstream (períodos do Replay, cache parcial e painel de informações da música), com paridade total de chaves traduzíveis.

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
