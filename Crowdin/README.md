# 🌐 Crowdin Platform — Central de Localização pt-BR

> **Módulo de Localização & Engenharia de Internacionalização (i18n & l10n) para a plataforma oficial do [Crowdin](https://crowdin.com).**  
> Mantido ativamente por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Plataforma Tecnológica** | Crowdin Enterprise / Modern Web UI (React, TypeScript, JSON, PHP/Blade) |
| **Projeto Oficial** | [Crowdin Translations (ID: 31)](https://crowdin.com/project/crowdin) |
| **Idioma Alvo** | Português do Brasil (`pt-BR`) |
| **Volume Total do Projeto** | **17.154 frases** (116.959 palavras) |
| **Foco Estratégico Atual** | Interface Moderna Web (`src/i18n/locales/en.json` — ID: 32447) |
| **Integração Técnica** | Crowdin REST API v2 (`https://api.crowdin.com/api/v2/`) |

---

## 🚀 Sobre o Projeto Oficial do Crowdin

O **Crowdin** é a principal plataforma global de gerenciamento contínuo de localização e internacionalização (**TMS / CAT Tool**) utilizada por milhares de empresas de tecnologia (como GitLab, Discord, GitHub, Khan Academy e milhares de projetos de código aberto).

A localização oficial do Crowdin visa proporcionar uma experiência completamente fluida, profissional e natural em **Português do Brasil** para gerentes de projeto, engenheiros de software, tradutores voluntários e equipes de produto.

---

## 🗂️ Módulos Principais do Sistema

1. **Interface Moderna (`src/i18n/locales/en.json`):**
   * Novo painel de controle, gerenciamento de projetos, estimativas de custo (*Cost estimates*), resumos de economia (*Savings summary*), pré-tradução via TM/IA e relatórios em tempo real.
2. **Backend & Autenticação (`resources/lang/en/`):**
   * Telas de login, autenticação de dois fatores (2FA), SSO corporativo e configurações de equipe.
3. **Modelos de Notificação & E-mails (`email_templates/`):**
   * Comunicações transacionais enviadas a gerentes, colaboradores e tradutores.

---

## 📁 Estrutura de Arquivos Locais

```text
Crowdin/
├── diretrizes-tecnicas.md     # Padrões de interpolação, sintaxe ICU e regras de qualidade
├── glossario.md               # Terminologia especializada em TMS, i18n e l10n
└── README.md                  # Este documento
```
