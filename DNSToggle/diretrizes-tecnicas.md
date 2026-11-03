# 📘 Diretrizes Técnicas de Localização — DNSToggle

> **O que é este documento:** o método de tradução do DNSToggle aplicado às regras que só valem nele.
> Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem [`README.md`](./README.md)
> (o status).
>
> **Contra o que foi escrito:** componente `dnstoggle-strings` no Weblate (projeto `elowry`) e o
> snapshot `DNSToggle/snapshots/dnstoggle_strings_pt_BR.xml`. Contagens medidas em **02/11/2026**.
>
> **O que ele não cobre:** testar no Android, abrir os Quick Settings Tiles e validar o ZIP de
> metadados — ver seção 7.

---

## 1. 🔁 O método: cinco etapas, sempre na mesma ordem

1. **Ler a chave interna**
2. **Ler a string em inglês**
3. **Entender o que o usuário vê**
4. **Escrever em pt-BR**
5. **Conferir contra as regras do projeto**

### 1.1. Etapa 1 — Ler a chave interna

O componente é um XML Android. O prefixo da chave diz o componente:

| Prefixo | Onde vive |
| :--- | :--- |
| `mode_` | estados do DNS (`mode_automatic`, `mode_disabled`) |
| `on_` / `off_` | rótulos de estado (`on_label`, `off_label`) |
| `notif_` / `notification_` | notificações e canais |
| `service_notif_` | notificação persistente do serviço |
| `permission_` / `grant_` | diálogos de permissão e concessão |
| `vpn_` | override de VPN e DNS |
| `wifi_` / `ssid_` | perfis de Wi-Fi |
| `qs_` | contexto do painel rápido (Quick Settings) |
| `connectivity_` | watchdog de conectividade |
| `import_` / `export_` | backup de configuração |
| `status_` | estados medidos (ativo, testando, alcance) |

A chave não substitui o contexto: um rótulo `on_`/`off_` aparece no Bloco de 1×1; um `permission_`
aparece em diálogo de tela cheia.

### 1.2. Etapa 2 — Ler a string em inglês

A fonte é o texto EN exibido no Weblate (`dnstoggle-strings`). **Não há fonte EN versionada no hub** —
essa é a lacuna registrada em [`../organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md).
Enquanto o `fonte/` não existir, a conferência é feita na plataforma.

Nunca use outro locale como origem. O componente tem traduções de terceiro; elas servem de referência,
não de fonte.

### 1.3. Etapa 3 — Entender o que o usuário vê

- **Quick Settings Tile:** 1×1, rótulo de **10 a 14 caracteres**; o subtítulo, 12 a 16.
- **Notificação persistente:** aparece na gaveta, muitas vezes truncada.
- **Diálogo de permissão:** explica o ADB/Shizuku; precisa ser didático e tranquilizador.
- **Configurações do Android:** o usuário compara com o menu nativo; o termo tem de bater.

### 1.4. Etapa 4 — Escrever em pt-BR

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| definições | **configurações** |

Sentence Case; nome de provedor mantém a grafia. O vocabulário vem do
[`glossario.md`](./glossario.md). O que **não** se traduz:
`DNS` · `DoT` · `DoH` · `Cloudflare` · `AdGuard` · `NextDNS` · `Quad9` · `Shizuku` · `ADB`.

### 1.5. Etapa 5 — Conferir contra as regras do projeto

1. **O XML** — chaves, placeholders, plurais e escapes (seção 3).
2. **O Weblate** — texto cru no envio; o exportador adiciona os escapes (seção 3.3).
3. **Os checks nativos** — `weblate-sync.ps1 -Action Checks` (seção 4).

### 1.6. O método aplicado a uma string real

`off_label`:

1. **Chave:** `off_label` → rótulo de estado desligado, usado no Bloco e nos diálogos.
2. **EN:** `Off`.
3. **O que o usuário vê:** o subtítulo do Bloco das Configurações Rápidas; espaço de 12–16 caracteres.
4. **pt-BR:** `Desativado` — é o termo do Android, não "Desligado".
5. **Regras:** sem placeholder, chave presente, sem escape; `validate-ptbr.ps1` retorna `OK`.

---

## 2. 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Plataforma (fonte de verdade)** | Weblate, projeto `elowry`, componente `dnstoggle-strings`, idioma `pt_BR` |
| **Metadados** | componente `dnstoggle-metadata` |
| **Snapshot de strings** | [`snapshots/dnstoggle_strings_pt_BR.xml`](./snapshots/dnstoggle_strings_pt_BR.xml) |
| **Snapshot de metadados** | [`snapshots/dnstoggle_metadata_pt_BR.zip`](./snapshots/dnstoggle_metadata_pt_BR.zip) |
| **Entrega** | Weblate; não há PR de tradução |
| **Clone no hub** | **não existe** — projeto de plataforma |

O snapshot de strings tem **174 `<string>` + 1 `<plurals>` (3 formas) = 177 unidades**, medido em
02/11/2026. O Weblate reporta **176/176** no componente; a diferença é o `app_name`, que o exportador
trata à parte.

---

## 3. 🧩 O formato: XML Android + Weblate

### 3.1. Limite de caracteres

| Elemento | Limite recomendado | Exemplo |
| :--- | :--- | :--- |
| Rótulo do Tile | 10–14 caracteres | `DNS Privado` (11) |
| Subtítulo do Tile | 12–16 caracteres | `Ativo`, `Alternando...` |
| Botão de diálogo | 1–3 palavras | `Conceder`, `Cancelar` |
| Notificação | uma linha | `DNS Privado ativo` |

Passar do limite faz o Android cortar com reticências.

### 3.2. Vocabulário do Android

O DNSToggle altera o ajuste **DNS Privado** do sistema. O texto tem de bater com o Android em pt-BR:

| Android (EN) | Android (pt-BR) | Regra |
| :--- | :--- | :--- |
| Private DNS | `DNS Privado` | nome do recurso, iniciais maiúsculas |
| Off | `Desativado` | não use "Desligado" |
| Automatic | `Automático` | resolução pelo provedor/DHCP |
| Private DNS provider hostname | `Nome do host do provedor de DNS privado` | diálogo manual |

### 3.3. Escape: texto cru no Weblate, escape no XML final

- **No Weblate, envie texto cru:** `d'água`, não `d\'água`.
- **O exportador Android do Weblate** adiciona `\'`/`\"` ao gerar o XML.
- O XML final deve ter **escape simples**; `\\'`/`\\\"` é over-escaping e defeito.
- `\n`/`\t` podem ser literais no target; se a fonte usa quebra real, envie quebra real.

### 3.4. Placeholders e plurais

- Preserve `%s`, `%d` e variáveis nomeadas (`{server_name}`).
- Plural é array (`one`/`many`/`other`). Use `PushJson`; não concatene formas.
- Se o Weblate exigir três formas, preencha `many` com o mesmo conteúdo de `other`.

### 3.5. Comandos ADB

Blocos de comando nunca são traduzidos:

```bash
adb shell pm grant com.draco.dnstoggle android.permission.WRITE_SECURE_SETTINGS
```

O texto ao redor explica que **não é necessário root**, que o **Shizuku** é alternativa e que a
permissão é concedida **uma única vez**.

---

## 4. 🧪 Validação no hub

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
falso positivo a dispensar ou colisão real de termo (ver [`glossario.md`](./glossario.md), seção 6).

### 4.1. Backup

```powershell
./scripts/weblate-sync.ps1 -Action Backup -Project elowry -Component dnstoggle-strings `
  -OutFile DNSToggle/snapshots/dnstoggle_strings_pt_BR.xml
```

Depois de baixar, confira:

- XML válido e UTF-8 sem BOM.
- Nenhum `\\'`/`\\\"` (escape duplicado).
- Placeholders e tags contra a fonte.
- Nenhuma string vazia.
- Contagem de contextos e ausência esperada das unidades read-only.

---

## 5. 🚀 Entrega e publicação

O DNSToggle entrega pelo Weblate. O mantenedor publica a release; o hub não abre PR.

- Release atual: `v3.0.8` (01/11/2026), que cita a tradução pt-BR.
- O componente de metadados tem 39/39 (título, descrição curta, descrição completa e changelog).
- A publicação no repositório é responsabilidade do Weblate e do mantenedor.

---

## 6. 📱 Espaço de tela

1. **Tile:** 10–14 caracteres no rótulo; 12–16 no subtítulo.
2. **Notificação:** uma linha; `DNS Privado ativo`, não `O DNS Privado está ativo no momento`.
3. **Diálogo:** pode explicar, mas em parágrafos curtos.
4. **Metadados da loja:** título curto; descrição completa pode ser longa.

---

## 7. ✅ Checklist antes de enviar ao Weblate

**Etapas 1 e 2 — origem**
- [ ] Li a chave e sei em que componente o texto aparece?
- [ ] Traduzi a partir do EN do Weblate, não de outro locale?

**Etapas 3 e 4 — texto**
- [ ] O rótulo do Tile cabe em 10–14 caracteres?
- [ ] O termo bate com o Android em pt-BR (`DNS Privado`, `Desativado`, `Automático`)?
- [ ] Sentence Case aplicado; provedores e siglas preservados?

**Etapa 5 — regras**
- [ ] O texto enviado está cru (sem `\'`/`\"`)?
- [ ] O XML final tem escape simples, sem `\\'`/`\\\"`?
- [ ] Placeholders `%s`/`%d`/`{server_name}` preservados?
- [ ] Plurais enviados como array (`PushJson`)?
- [ ] `Status` com 0 pendentes e `Check` com 0 divergências?
- [ ] Checks nativos revisados e falsos positivos documentados?
- [ ] Snapshot do hub atualizado?

---

## 8. ⚠️ Lacunas conhecidas

1. **Sem fonte EN no hub.** O validador não roda contra uma fonte fixa; falta criar
   `DNSToggle/fonte/` (ver [`../organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md)).
2. **2 checks em aberto.** `off_label` e `mode_disabled` continuam sem decisão.
3. **Nada foi rodado em Android.** Nenhum limite de Tile foi conferido em aparelho real.
4. **Snapshot pode divergir.** O XML é cópia do Weblate; se a plataforma avançar, o snapshot fica
   velho.
5. **Metadados em ZIP.** O snapshot de metadados não é legível como XML; a conferência é manual.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 176/176 strings, 0 pendentes, 2 checks | `weblate-sync.ps1 -Action Status` em 02/11/2026 |
| 39/39 metadados | mesma execução |
| 174 strings + 1 plural (3 formas) = 177 unidades | contagem no snapshot em 02/11/2026 |
| `off_label` e `mode_disabled` | `weblate-sync.ps1 -Action Checks` em 02/11/2026 |
| Release `v3.0.8` (01/11/2026) | `gh release view --repo ELowry/DNSToggle` |
