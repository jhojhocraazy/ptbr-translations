# 📱 Nuvio Mobile — Central de Localização pt-BR

> **Módulo de Localização & Engenharia de Internacionalização (i18n & l10n) para o aplicativo [Nuvio Mobile](https://github.com/NuvioMedia/NuvioMobile).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma Tecnológica** | Kotlin Multiplatform (KMP) + Compose Multiplatform (CMP) |
| **Sistemas Alvo** | Android e iOS |
| **Cobertura Geral** | 🟢 **100% Traduzido** (2.638 entradas em 7 arquivos; 208 novas no PR #2288 + 6 novas no PR #2338) |
| **Refinamento de Qualidade** | 🟢 **92 entradas revisadas** (terminologia, Sentence Case e naturalidade) |
| **Última Versão Estável** | `v0.6.3-beta` (traduções principais ativas; novas strings no PR #2338) |
| **Último Pull Request** | [**PR #2338**](https://github.com/NuvioMedia/NuvioMobile/pull/2338) (6 novas strings do player e watch party — CI validado) |

---

## 🗂️ Arquitetura dos Módulos XML

No Compose Multiplatform, as strings residem em `composeApp/src/commonMain/composeResources/values-pt-rBR/`.  
O projeto divide as strings em **7 arquivos modulares**:

| Arquivo XML | Descrição do Domínio | Entradas | Status |
| :--- | :--- | :---: | :---: |
| [`strings.xml`](./repo/composeApp/src/commonMain/composeResources/values-pt-rBR/strings.xml) | Módulo Principal: Catálogos, Player, Configurações, Debrid e Stremio | 2.427 | 🟢 Merged + 4 novas no #2338 (em análise) |
| [`strings_pip.xml`](./repo/composeApp/src/commonMain/composeResources/values-pt-rBR/strings_pip.xml) | Picture-in-Picture: Controles flutuantes e mini-player | 1 | 🟢 Merged + refinado no #2288 |
| [`strings_party.xml`](./repo/composeApp/src/commonMain/composeResources/values-pt-rBR/strings_party.xml) | Watch Party: Sessões em grupo, sincronia, salas e chat | 84 | 🟢 Merged (PR #2288) + 2 novas no #2338 (em análise) |
| [`strings_servers.xml`](./repo/composeApp/src/commonMain/composeResources/values-pt-rBR/strings_servers.xml) | Servidores Remotos: Endereços, conexão, portas e latência | 60 | 🟢 Merged (PR #2288) |
| [`strings_mdblist.xml`](./repo/composeApp/src/commonMain/composeResources/values-pt-rBR/strings_mdblist.xml) | Integração MDBList: Filtros avançados, listas e notas de avaliação | 52 | 🟢 Merged (PR #2288) |
| [`autosync_strings.xml`](./repo/composeApp/src/commonMain/composeResources/values-pt-rBR/autosync_strings.xml) | AutoSync: Sincronização em segundo plano e agendamento | 10 | 🟢 Merged (PR #2288) |
| [`autosync_toast_strings.xml`](./repo/composeApp/src/commonMain/composeResources/values-pt-rBR/autosync_toast_strings.xml) | Notificações Rápidas: Mensagens voláteis de sucesso/erro | 4 | 🟢 Merged (PR #2288) |

---

## 🚀 Histórico de Contribuições & Pull Requests

### 1. [Pull Request #2234](https://github.com/NuvioMedia/NuvioMobile/pull/2234) — Tradução Principal Completa
* **Branch:** `i18n/pt-br`
* **Volume:** 2.410 strings e 4 blocos de plurais (`<plurals>`).
* **Resultado:** Incorporado oficialmente no código-fonte principal pelo mantenedor `Nayif` e disponibilizado para os usuários finais nas versões oficiais `0.6.0-beta` e `0.6.1-beta`.

### 2. [Pull Request #2288](https://github.com/NuvioMedia/NuvioMobile/pull/2288) — Módulos Adicionais (Watch Party, Servers, MDBList e AutoSync)
* **Branch:** `i18n/pt-br-modules`
* **Volume:** 208 novas entradas nos 5 novos módulos arquiteturais, além do refinamento de 92 entradas no módulo principal e no PiP.
* **Refinamento:** terminologia do glossário (`Continuar assistindo`, `Lista de interesses`, `Picture-in-Picture (PiP)`), Sentence Case, miniaturas, provedores de streaming e mensagens de download.
* **Cobertura validada:** 2.632/2.632 entradas, 0 faltando e 0 divergências de placeholders.
* **Status:** ✅ **MERGED** — incorporado na versão `0.6.3-beta`.
* **Status da Pipeline CI/CD:**
  * ✅ `PR Template Check` (`validate_pr_body`): **SUCCESS**
  * ✅ `PR Full Debug Build` (`Build fullDebug APK`): **SUCCESS** (6m49s)

### 3. [Pull Request #2338](https://github.com/NuvioMedia/NuvioMobile/pull/2338) — Strings do Player e Watch Party
* **Branch:** `i18n/pt-br-player-badges`
* **Volume:** 6 novas entradas — 4 em `strings.xml` (emblemas no player e troca de motor) e 2 em `strings_party.xml` (chat companion e saída de dispositivo).
* **Cobertura validada:** 2.638/2.638 entradas, 0 faltando e 0 divergências de placeholders.
* **Status:** 🚀 **OPEN / MERGEABLE**.
* **Status da Pipeline CI/CD:**
  * ✅ `PR Template Check` (`validate_pr_body`): **SUCCESS**
  * ✅ `PR Full Debug Build` (`Build fullDebug APK`): **SUCCESS** (4m42s)

---

## 🛠️ Como Trabalhar no Repositório Local (`repo/`)

A pasta [`repo/`](./repo/) é um clone oficial do seu fork (`jhojhocraazy/NuvioMobile`).

### Remotos Configurados:
* **`origin`**: `https://github.com/jhojhocraazy/NuvioMobile.git` (Seu fork pessoal)
* **`upstream`**: `https://github.com/NuvioMedia/NuvioMobile.git` (Repositório oficial dos criadores)

### Fluxo para Atualizar e Criar Novas Traduções:
```bash
# 1. Entrar na pasta do repositório
cd repo

# 2. Atualizar o tronco principal com as novidades do app oficial
git checkout cmp-rewrite
git fetch upstream cmp-rewrite
git merge upstream/cmp-rewrite
git push origin cmp-rewrite

# 3. Criar uma branch temática nova para o trabalho
git checkout -b i18n/nome-da-melhoria

# 4. Fazer as alterações e commitar
git add .
git commit -m "feat(i18n): atualiza traduções de pt-BR"
git push origin i18n/nome-da-melhoria
```

---

## 📖 Documentos Complementares

* 📘 [**Diretrizes Técnicas de Tradução (diretrizes-tecnicas.md)**](./diretrizes-tecnicas.md): Manual aprofundado com regras de XML, escapes, placeholders posicionais, tags HTML e conformidade com a pipeline de CI/CD.
* 📗 [**Glossário Terminológico Oficial (glossario.md)**](./glossario.md): Tabela de referência técnica para desambiguação de termos de streaming, redes e mídia.
