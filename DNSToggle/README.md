# 🛡️ DNSToggle — Central de Localização pt-BR

> **Módulo de Localização & Gestão de Tradução via Weblate para o aplicativo [DNSToggle](https://github.com/ELowry/DNSToggle).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Repositório Oficial** | [`ELowry/DNSToggle`](https://github.com/ELowry/DNSToggle) |
| **Plataforma de Tradução** | Weblate / GitHub |
| **Branch de Tradução Upstream** | `translation` |
| **Componentes Mapeados** | 🟢 **5/5 Componentes 100% Traduzidos** |
| **Status de Integração** | 🟢 **Commits Oficiais Atribuídos e Mesclados** |

---

## 🌐 Sobre o DNSToggle

O **DNSToggle** é um utilitário open source essencial para Android desenvolvido por [ELowry](https://github.com/ELowry). Ele permite alternar instantaneamente servidores de **DNS Privado** (como AdGuard, Cloudflare 1.1.1.1, NextDNS, Quad9 e Google DNS) e protocolos de **DNS-over-TLS (DoT)** diretamente a partir dos **Blocos das Configurações Rápidas (Quick Settings Tiles)** da barra de notificações do Android, sem a necessidade de acesso root.

---

## 🗂️ Os 5 Componentes de Localização

A tradução do DNSToggle é estruturada em 5 domínios fundamentais:

| Componente | Domínio / Função | Status pt-BR |
| :--- | :--- | :---: |
| **1. `app`** | Interface Principal: Telas de seleção de provedor, alternância manual e ajustes | 🟢 100% Traduzido |
| **2. `tiles`** | Blocos das Configurações Rápidas: Títulos curtos, subtítulos e estados (*Ativo*, *Inativo*, *Alternando*) | 🟢 100% Traduzido |
| **3. `notifications`** | Serviços em Segundo Plano: Alertas de serviço ativo e avisos de falha de conexão | 🟢 100% Traduzido |
| **4. `dialogs`** | Permissões & Segurança: Instruções de permissão `WRITE_SECURE_SETTINGS` via ADB e Shizuku | 🟢 100% Traduzido |
| **5. `metadata`** | Metadados de Lojas: Título, descrição curta, descrição completa e changelogs para F-Droid e Play Store | 🟢 100% Traduzido |

---

## 🚀 Histórico de Contribuições & Git Workflow

Diferente do Nuvio (PRs de código) e do Better Lyrics (Crowdin API), o DNSToggle opera com uma esteira híbrida entre **Weblate e Git**:

1. As strings são traduzidas e revisadas por Joseph Alves na instância oficial do Weblate.
2. O Weblate sincroniza automaticamente as alterações gerando commits assinados diretamente na branch `translation` do repositório upstream.
3. O mantenedor `ELowry` mescla periodicamente a branch `translation` no tronco principal para gerar as novas compilações oficiais.

---

## 📁 Arquitetura dos Arquivos Locais

```text
DNSToggle/
├── README.md               # Este documento (Visão geral e status dos componentes)
├── diretrizes-tecnicas.md  # Regras de limite de caracteres para Tiles e alinhamento com Android OS
└── glossario.md            # Dicionário de redes, DNS, segurança Android e permissões
```

---

## 📖 Documentos Complementares

* 📘 [**Diretrizes Técnicas de Tradução (diretrizes-tecnicas.md)**](./diretrizes-tecnicas.md): Manual de engenharia para adaptação aos limites de caracteres dos Quick Settings Tiles, alinhamento terminológico estrito com as configurações do Android da Google e instruções de comandos ADB.
* 📗 [**Glossário de Redes & DNS (glossario.md)**](./glossario.md): Tabela de referência técnica para desambiguação de termos de DNS Privado, DoT, DoH, Shizuku, Tiles e estados de rede.
