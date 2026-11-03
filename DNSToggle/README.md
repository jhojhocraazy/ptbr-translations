# 🛡️ DNSToggle — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) do aplicativo
> [DNSToggle](https://github.com/ELowry/DNSToggle).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | [Weblate — projeto `elowry`](https://hosted.weblate.org/projects/elowry/) |
| **Componentes** | `dnstoggle-strings` + `dnstoggle-metadata` |
| **Cobertura** | 🟢 **176/176 strings** e **39/39 metadados** (100%) |
| **Pendências** | 🟢 **0 strings pendentes** nos dois componentes |
| **Checks nativos** | 🟢 **0** desde 03/11/2026 — eram 2 (`off_label`, `mode_disabled`) |
| **Entrega** | 🟢 **Weblate** — a entrega termina na plataforma; não há PR de tradução |
| **Snapshot** | 174 `<string>` + 1 `<plurals>` (3 formas) = **177 unidades** (02/11/2026) |
| **Última release** | `v3.0.8` (01/11/2026) — cita oficialmente a tradução pt-BR |
| **Clone no hub** | **não existe** — projeto de plataforma |

A tradução está completa nos dois componentes. Os 2 checks nativos zeraram em 03/11/2026 — não há
decisão pendente.

---

## 🌐 O que é o DNSToggle

Utilitário Android para alternar servidores de **DNS Privado** (AdGuard, Cloudflare, NextDNS, Quad9,
Google DNS) e protocolos **DNS-over-TLS (DoT)** direto dos **Blocos das Configurações Rápidas**, sem
root.

O app altera o ajuste de sistema **DNS Privado** do Android 9+. Por isso o vocabulário precisa bater
com o menu nativo: o usuário compara os dois.

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 🗂️ Componentes no Weblate

| Componente | Conteúdo | Cobertura |
| :--- | :--- | :---: |
| **`dnstoggle-strings`** | interface, Blocos, notificações, diálogos e permissões | 🟢 176/176 |
| **`dnstoggle-metadata`** | título, descrição curta, descrição completa e changelog | 🟢 39/39 |

Os cinco domínios funcionais (app, tiles, notifications, dialogs e metadata) são cobertos por esses
dois componentes.

O snapshot de strings tem **177 unidades** (174 strings + 1 plural de 3 formas). O Weblate reporta
176/176 porque o `app_name` é tratado à parte pelo exportador.

---

## 🧪 Como conferir

Precisa de `WEBLATE_TOKEN` no ambiente (ou `scripts/tokens.ps1`, ignorado pelo Git):

```powershell
./scripts/weblate-sync.ps1 -Action Status -Project elowry -Component dnstoggle-strings
./scripts/weblate-sync.ps1 -Action Check  -Project elowry -Component dnstoggle-strings
./scripts/weblate-sync.ps1 -Action Checks -Project elowry -Component dnstoggle-strings
```

Resultado de 02/11/2026:

```text
dnstoggle-strings   176/176   pendentes=0   checks=2
dnstoggle-metadata   39/39    pendentes=0   checks=0
```

Os 2 checks são `off_label` e `mode_disabled`, ambos com alvo "Desativado". A decisão está em aberto:
falso positivo a dispensar ou colisão real de termo.

> **Sem fonte EN no hub.** O validador não roda contra uma fonte fixa; falta criar
> `DNSToggle/fonte/` (ver [`../organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md)).
> Enquanto isso, a conferência é feita na plataforma.

---

## 🔄 Como a entrega funciona

1. As strings são traduzidas e revisadas no Weblate, projeto `elowry`, idioma `pt_BR`.
2. O critério de conclusão é **100% traduzido e 0 pendências** nos dois componentes.
3. A entrega termina na plataforma; a publicação no repositório é responsabilidade do Weblate e do
   mantenedor.

O commit no hub é documentação, não entrega.

---

## ⚠️ Lacunas

1. **2 checks — zerados em 03/11/2026.** `off_label` e `mode_disabled` deixaram de aparecer em
   `-Action Checks`; a causa não foi investigada.
2. **Sem fonte EN versionada.** O validador não roda offline contra o EN.
3. **Nada foi rodado em Android.** Nenhum limite de Tile foi conferido em aparelho real.
4. **Snapshot de metadados em ZIP.** Não é XML legível; a conferência é manual.
5. **Snapshot pode divergir.** O XML é cópia do Weblate; se a plataforma avançar, o snapshot fica
   velho.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método aplicado a XML Android, limites de
  Tile, vocabulário do Android, ADB/Shizuku e validação no Weblate.
- 📗 [**Glossário de termos**](./glossario.md) — DNS, DoT, Tiles, estados e permissões.
- 🗂️ [**Snapshots**](./snapshots/) — XML de strings e ZIP de metadados.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 176/176 strings, 0 pendentes, 2 checks | `weblate-sync.ps1 -Action Status` em 02/11/2026 |
| 39/39 metadados | mesma execução |
| 174 strings + 1 plural (3 formas) = 177 | contagem no snapshot em 02/11/2026 |
| `off_label` e `mode_disabled` | `weblate-sync.ps1 -Action Checks` em 02/11/2026 |
| Release `v3.0.8` (01/11/2026) | `gh release view --repo ELowry/DNSToggle` |
