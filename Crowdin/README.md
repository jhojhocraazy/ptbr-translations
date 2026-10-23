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
| **Volume Total do Projeto** | **17.335 strings visíveis** (118.956 palavras; 18.258 no total, 923 ocultas) |
| **Entregas Submetidas (pt-BR)** | **17.335 strings** — 0 pendentes em 214 arquivos |
| **Cobertura** | 🟢 **100%** (auditoria de placeholders e ICU com 0 divergências) |
| **Foco Estratégico Atual** | Projeto completo: `en.json`, `editor.csv`, `dynamic.csv`, `backend.csv`, `frontend.csv`, escopos/permissões, MFA, log de segurança e e-mails — **100% Concluído** |
| **Integração Técnica** | Crowdin REST API v2 (`https://api.crowdin.com/api/v2/`) |

> **Última atualização (22/10/2026):** 286 novas strings traduzidas e 8 divergências antigas de placeholders corrigidas. Auditoria completa em 17.335 strings com **0 divergências**.

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
├── crowdin_translations_pt_BR.json  # Backup da Web UI + metadados de cobertura
├── diretrizes-tecnicas.md     # Padrões de interpolação, sintaxe ICU e regras de qualidade
├── glossario.md               # Terminologia especializada em TMS, i18n e l10n
└── README.md                  # Este documento
```
