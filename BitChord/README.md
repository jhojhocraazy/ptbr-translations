# 🎵 BitChord — Central de Localização pt-BR

> **Módulo de Localização & Engenharia de Internacionalização (i18n & l10n) para o aplicativo [BitChord](https://github.com/kushagrasinghx/BitChord).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma Tecnológica** | Kotlin Multiplatform (KMP) + Jetpack Compose / Compose Multiplatform |
| **Sistemas Alvo** | Android, Desktop (Windows, macOS, Linux) e Wear OS (Relógios) |
| **Cobertura Geral** | 🟢 **100% Traduzido** (+1.250 strings em todos os 5 módulos) |
| **Repositório Upstream** | [`kushagrasinghx/BitChord`](https://github.com/kushagrasinghx/BitChord) (+3.700 stars) |
| **Branch de Trabalho** | `i18n/portuguese-complete-pt-br` |

---

## 🎧 Sobre o BitChord

O **BitChord** é um dos clientes de código aberto mais elegantes e avançados para o **YouTube Music**. Desenvolvido com foco em estética minimalista inspirada no **Apple Music**, o aplicativo conta com:
* Equalizador paramétrico avançado com suporte a saídas PCM e Float de 32 bits.
* Integração completa com **Android Auto** para navegação no painel de veículos.
* Aplicativo complementar dedicado para **Wear OS** (smartwatches).
* Suporte multiplataforma nativo para desktop e mobile com **Compose Multiplatform**.

---

## 🗂️ Arquitetura dos Módulos de Tradução

A localização do BitChord está dividida em 5 arquivos modulares:

| Módulo | Arquivo de Tradução | Strings | Status pt-BR |
| :--- | :--- | :---: | :---: |
| **Android Core (`app/`)** | [`app/src/main/res/values-pt/strings.xml`](./repo/app/src/main/res/values-pt/strings.xml) | 1.044 + 23 plurais | 🟢 100% Concluído |
| **Desktop App (`desktopApp/`)** | [`desktopApp/src/main/resources/strings/pt.xml`](./repo/desktopApp/src/main/resources/strings/pt.xml) | 765 | 🟢 100% Concluído |
| **Desktop Específico** | [`desktopApp/src/main/resources/strings/desktop-pt.xml`](./repo/desktopApp/src/main/resources/strings/desktop-pt.xml) | 89 | 🟢 100% Concluído |
| **UI Multiplataforma (`sharedUi/`)** | [`sharedUi/.../values-pt/strings.xml`](./repo/sharedUi/src/commonMain/composeResources/values-pt/strings.xml) | 179 | 🟢 100% Concluído |
| **Desktop Compose UI (`desktopUi/`)** | [`desktopUi/.../values-pt/strings.xml`](./repo/desktopUi/src/commonMain/composeResources/values-pt/strings.xml) | 179 | 🟢 100% Concluído |
| **Wear OS Smartwatches (`wearos/`)** | [`wearos/src/main/res/values-pt/strings.xml`](./repo/wearos/src/main/res/values-pt/strings.xml) | 40 | 🟢 100% Concluído (Criado) |

---

## 🚀 O que foi Feito Nesta Localização

1. **Eliminação de Termos em Inglês:** Mais de 41 frases que estavam em inglês no meio das telas (como avisos do Android Auto, predefinições do equalizador e diálogos de login) foram 100% traduzidas para o Português do Brasil.
2. **Preenchimento de Lacunas no Desktop:** Adicionadas as **180 strings ausentes** no catálogo de desktop (`desktopApp/resources/strings/pt.xml`), atingindo paridade total com o inglês.
3. **Criação do Módulo Wear OS:** Criado do zero o arquivo `values-pt/strings.xml` para suportar relógios Wear OS em português.
4. **Conformidade com os Testes do App:** 100% de aprovação nos testes unitários nativos `LocaleStringsTest.kt` e `DesktopStringsTest.kt`.

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
