# 📗 Glossário de termos — DNSToggle

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la** no XML e no Weblate. Status em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** snapshot
> [`snapshots/dnstoggle_strings_pt_BR.xml`](./snapshots/dnstoggle_strings_pt_BR.xml) (174 strings + 1
> plural) e o componente `dnstoggle-strings` no Weblate, conferidos em **02/11/2026**. As citações
> são de **chave**, não de linha.
>
> **Como usar:** procure o termo, confira a chave citada e escreva igual. Se o termo não estiver aqui,
> decida com a regra da seção 1 e acrescente a linha **no mesmo lote**.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É sigla, marca ou provedor?**
   Fica em inglês. `DNS`, `DoT`, `Cloudflare`, `AdGuard`, `Shizuku`.
2. **É termo que o Android em pt-BR já traduziu?**
   Use a tradução oficial. `Private DNS` ➔ **DNS Privado**; `Off` ➔ **Desativado**.
3. **É palavra comum com equivalente natural?**
   Traduz. `toggle` ➔ **alternar**; `fallback` ➔ **contingência**; `hostname` ➔ **nome do host**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale nos Tiles, notificações, diálogos e
metadados.

**A regra que manda neste projeto:** o usuário compara o DNSToggle com o menu de **DNS Privado** do
Android. Se o termo divergir do sistema, ele pensa que é outro recurso.

---

## 2. 🚫 Fica em inglês

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| DNS | `DNS` | nome do app e Tiles |
| DoT / DoH | `DoT` / `DoH` | protocolos |
| Cloudflare / 1.1.1.1 | nome exato | provedor |
| AdGuard DNS | nome exato | provedor |
| NextDNS / Quad9 | nome exato | provedores |
| Shizuku | `Shizuku` | alternativa ao ADB |
| ADB | `ADB` | comando de permissão |
| Root | `root` | termo técnico |
| Tile | `Bloco` | **traduz** — ver 3.2 |
| Fallback | `Contingência` | **traduz** — ver 4.3 |

---

## 3. ✅ Traduz-se

### 3.1. Configurações do Android

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Private DNS | `DNS Privado` | `private_dns` |
| Off | `Desativado` | `off_label` / `mode_disabled` |
| Automatic | `Automático` | `mode_automatic` |
| Custom DNS | `DNS personalizado` | `custom_dns_provider` |
| Hostname | `Nome do host` | `dns_hostname_hint` |
| Toggle | `Alternar` | `shortcut_toggle_short` |
| Active / Enabled | `Ativo` / `Ativado` | `on_label` / `status_active_reachable` |
| Inactive / Disabled | `Inativo` / `Desativado` | `off_label` |
| Switching… | `Alternando...` | `status_testing_dns` |

### 3.2. Tiles e notificações

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Quick Settings | `Configurações Rápidas` | metadados |
| Tile | `Bloco` | `show_usb_debugging_tile` (nome do recurso) |
| Notification shade | `Barra de notificações` | metadados |
| Persistent notification | `Notificação fixa` | `service_notif_title` |
| One-tap toggle | `Alternância com um toque` | metadados |

### 3.3. Permissões e segurança

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Secure settings | `Configurações seguras` | `main_permission_message` |
| Grant permission | `Conceder permissão` | `grant_permission_button` |
| No root needed | `Não é necessário root` | `permission_message` |
| Reboot / Restart | `Reiniciar` | sem chave no snapshot |
| Fallback provider | `Provedor de contingência` | `grant_auto_fallback` |

### 3.4. Metadados da loja

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Open source | `Código aberto` | `github` |
| Changelog | `Notas da versão` / `Novidades` | `whats_new` |
| DNS provider | `Provedor de DNS` | `custom_dns_provider` |

---

## 4. ⚠️ Decisões que não são óbvias

### 4.1. `Off` é `Desativado`, não `Desligado`

O Android usa **Desativado** no menu de DNS Privado. "Desligado" descreve um aparelho, não um modo.
Vale para o Tile, o diálogo e os metadados.

### 4.2. `Tile` é `Bloco`

O Android em pt-BR chama os Quick Settings Tiles de **Blocos** (ou "Blocos das Configurações
Rápidas"). "Tile" é aceito por usuários avançados, mas o texto de usuário usa **Bloco**.

### 4.3. `Fallback` é `Contingência`

`Fallback provider` ➔ **Provedor de contingência**. "Fallback" é jargão de desenvolvedor; o usuário
comum não sabe o que é.

### 4.4. `DNS Privado` com iniciais maiúsculas

É o nome do recurso no Android, não uma frase. Mantenha `DNS Privado` mesmo no meio da frase.

### 4.5. `root` fica minúsculo

`root` é o conceito técnico, não uma marca. `Não é necessário root`, não "Root".

### 4.6. `Shizuku` é alternativa, não sinônimo de ADB

O texto deve dizer que o Shizuku concede a permissão sem computador; o ADB é o caminho com PC. Não
troque um pelo outro.

---

## 5. 📱 Onde o termo aparece muda o tamanho

1. **Tile:** 10–14 caracteres no rótulo; 12–16 no subtítulo.
2. **Notificação:** uma linha. `DNS Privado ativo`.
3. **Diálogo:** pode explicar, mas em parágrafos curtos.
4. **Metadados:** título curto; descrição completa pode ser longa.

---

## 6. ❓ Ainda não decidido

1. **`off_label` e `mode_disabled`.** Os dois checks nativos apontam para "Desativado". É falso
   positivo (o termo é o mesmo em contextos diferentes) ou colisão real que pede outro texto? Falta: o
   motivo do check, que o relatório não expõe.
2. **`Desativado` x `Desativada`.** O check de gênero aparece porque o alvo pode concordar com
   "configuração" (feminino) ou "DNS" (masculino). Hoje "Desativado" segue o Android.
3. **`Tile` x `Bloco`.** O glossário decide **Bloco**, mas o nome do componente e a documentação
   técnica ainda dizem "Tile". Não é texto de usuário; não precisa mudar.
4. **Metadados em ZIP.** O snapshot não é XML legível; a conferência de termos é manual.

---

## 7. 📌 Como este glossário se mantém honesto

- Toda linha aponta uma **chave** do catálogo. Sem chave, é opinião.
- Termo novo entra **no mesmo lote** da string que o usa.
- Termo que saiu do catálogo sai daqui.
- Os 2 checks em aberto estão registrados na seção 6, não escondidos.
- Contagem e vocabulário são do snapshot de **02/11/2026**; o Weblate pode estar diferente.
