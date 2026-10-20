# 🛡️ DNSToggle — Central de Localização pt-BR

> **Módulo de Localização & Gestão de Tradução via Weblate para o aplicativo [DNSToggle](https://github.com/ELowry/DNSToggle).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Repositório Oficial** | [`ELowry/DNSToggle`](https://github.com/ELowry/DNSToggle) |
| **Plataforma de Tradução** | [Weblate — projeto `elowry`](https://hosted.weblate.org/projects/elowry/) |
| **Componentes** | `dnstoggle-strings` + `dnstoggle-metadata` |
| **Cobertura pt-BR** | 🟢 **176/176 strings · 36/36 metadados (100%)** |
| **Pendências** | 🟢 **0 strings pendentes** |
| **Última revisão** | 20/10/2026 — naturalidade (14 ajustes) |

---

## 🌐 Sobre o DNSToggle

O **DNSToggle** é um utilitário open source essencial para Android desenvolvido por [ELowry](https://github.com/ELowry). Ele permite alternar instantaneamente servidores de **DNS Privado** (como AdGuard, Cloudflare 1.1.1.1, NextDNS, Quad9 e Google DNS) e protocolos de **DNS-over-TLS (DoT)** diretamente a partir dos **Blocos das Configurações Rápidas (Quick Settings Tiles)** da barra de notificações do Android, sem a necessidade de acesso root.

---

## 🗂️ Componentes no Weblate

A tradução do DNSToggle está organizada em dois componentes oficiais:

| Componente | Conteúdo | Cobertura pt-BR |
| :--- | :--- | :---: |
| **`dnstoggle-strings`** | Interface principal, Blocos das Configurações Rápidas, notificações, diálogos e permissões | 🟢 176/176 (100%) |
| **`dnstoggle-metadata`** | Título, descrição curta, descrição completa e changelogs das lojas | 🟢 36/36 (100%) |

> Os cinco domínios funcionais (app, tiles, notifications, dialogs e metadata) são cobertos por esses dois componentes.

> **Qualidade:** revisão de naturalidade aplicada em 20/10/2026 (14 ajustes). Restam 2 avisos automáticos de consistência — gênero em “Desativado/Desativada” e termo repetido — ambos intencionais.

---

## 🚀 Fluxo de Entrega

O DNSToggle é um projeto de plataforma: a entrega termina no Weblate.

1. As strings são traduzidas e revisadas no projeto `elowry`, idioma `pt_BR`.
2. O critério de conclusão é **100% traduzido e 0 pendências** nos dois componentes.
3. A entrega termina na plataforma; a publicação no repositório upstream é responsabilidade do Weblate e do mantenedor.

---

## 📁 Arquitetura dos Arquivos Locais

```text
DNSToggle/
├── README.md               # Este documento (Visão geral e status dos componentes)
├── diretrizes-tecnicas.md  # Regras de limite de caracteres para Tiles e alinhamento com Android OS
├── glossario.md            # Dicionário de redes, DNS, segurança Android e permissões
└── dnstoggle_strings_pt_BR.xml  # Snapshot do componente de strings (Weblate)
```

---

## 📖 Documentos Complementares

* 📘 [**Diretrizes Técnicas de Tradução (diretrizes-tecnicas.md)**](./diretrizes-tecnicas.md): Manual de engenharia para adaptação aos limites de caracteres dos Quick Settings Tiles, alinhamento terminológico estrito com as configurações do Android da Google e instruções de comandos ADB.
* 📗 [**Glossário de Redes & DNS (glossario.md)**](./glossario.md): Tabela de referência técnica para desambiguação de termos de DNS Privado, DoT, DoH, Shizuku, Tiles e estados de rede.
