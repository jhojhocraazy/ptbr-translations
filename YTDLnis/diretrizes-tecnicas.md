# 📘 Diretrizes Técnicas de Localização — YTDLnis

> **O que é este documento:** o método de tradução do YTDLnis aplicado às regras que só valem nele.
> Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem [`README.md`](./README.md)
> (o status).
>
> **Contra o que foi escrito:** componente `strings` no Weblate (projeto `ytdlnis`) e o snapshot
> `YTDLnis/snapshots/ytdlnis_strings_pt_BR.xml` (670 strings + 9 plurais, 697 formas). Contagens de
> plataforma medidas em **02/11/2026**.
>
> **O que ele não cobre:** baixar vídeos de verdade, testar permissões no Android e validar os checks
> nativos — ver seção 7.

---

## 1. 🔁 O método: cinco etapas, sempre na mesma ordem

1. **Ler a chave interna**
2. **Ler a string em inglês**
3. **Entender o que o usuário vê**
4. **Escrever em pt-BR**
5. **Conferir contra as regras do projeto**

### 1.1. Etapa 1 — Ler a chave interna

O componente é um XML Android. O prefixo diz a tela:

| Prefixo | Onde vive |
| :--- | :--- |
| `welcome_` | onboarding e permissões |
| `download_` / `downloading_` | fila, progresso e conclusão |
| `lyrics_` | letras e LRCLIB |
| `settings_` | configurações gerais e avançadas |
| `format_` / `video_` / `audio_` | seleção de formato e qualidade |
| `playlist_` / `channel_` | playlists e canais |
| `error_` | mensagens de erro |

### 1.2. Etapa 2 — Ler a string em inglês

A fonte é o texto EN exibido no Weblate (`ytdlnis/strings`). **Não há fonte EN versionada no hub** —
essa é a lacuna registrada em [`../organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md).
Enquanto o `fonte/` não existir, a conferência é feita na plataforma.

Nunca use outro locale como origem; `pt-PT`, `es` e `de` servem de referência, não de fonte.

### 1.3. Etapa 3 — Entender o que o usuário vê

- **Onboarding:** explica permissões críticas (bateria, armazenamento, alarmes); texto didático.
- **Fila de downloads:** linha por item; o progresso e o estado precisam caber.
- **Notificação:** aparece fora do app, truncada.
- **Configurações avançadas:** termos do yt-dlp/FFmpeg; o usuário avançado reconhece.
- **Letras:** `.lrc`, sincronizadas, texto simples e offset.

### 1.4. Etapa 4 — Escrever em pt-BR

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| definições | **configurações** |

Sentence Case; nomes de ferramenta e codec mantêm a grafia. O vocabulário vem do
[`glossario.md`](./glossario.md). O que **não** se traduz:
`YTDLnis` · `yt-dlp` · `FFmpeg` · `aria2c` · `SponsorBlock` · `LRCLIB` · `DASH` / `HLS` ·
`JSON` / `Info-JSON` · `PO Token` · codecs e contêineres.

### 1.5. Etapa 5 — Conferir contra as regras do projeto

1. **O XML** — chaves, placeholders, plurais e escapes (seção 3).
2. **O Weblate** — texto cru no envio; o exportador adiciona os escapes (seção 3.3).
3. **Os checks nativos** — `weblate-sync.ps1 -Action Checks` (seção 4).

### 1.6. O método aplicado a uma string real

`welcome_perm_battery`:

1. **Chave:** `welcome_perm_battery` → onboarding, permissão de bateria.
2. **EN:** `Unrestricted battery use`.
3. **O que o usuário vê:** um item de permissão com título e explicação; o texto precisa convencer sem
   assustar.
4. **pt-BR:** `Uso irrestrito da bateria` — e a explicação: `Evita que downloads longos sejam
   interrompidos em segundo plano.`
5. **Regras:** sem placeholder, chave presente, sem escape; `validate-ptbr.ps1` retorna `OK`.

---

## 2. 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Plataforma (fonte de verdade)** | Weblate, projeto `ytdlnis`, componente `strings`, idioma `pt_BR` |
| **Arquivo no Android** | `app/src/main/res/values-pt-rBR/strings.xml` |
| **Snapshot do hub** | [`snapshots/ytdlnis_strings_pt_BR.xml`](./snapshots/ytdlnis_strings_pt_BR.xml) |
| **Entrega** | Weblate; o bot abre PR automático no GitHub |
| **Clone no hub** | **não existe** — projeto de plataforma |

O snapshot tem **670 `<string>` + 9 `<plurals>` (27 formas) = 697 unidades**. O Weblate conta
**686 unidades** e **671 traduzidas** em 02/11/2026 — os dois números medem coisas diferentes e não
devem ser somados.

---

## 3. 🧩 O formato: XML Android + Weblate

### 3.1. Escape: texto cru no Weblate, escape no XML final

- **No Weblate, envie texto cru:** `d'água`, não `d\'água`.
- **O exportador Android do Weblate** adiciona `\'`/`\"` ao gerar o XML.
- O XML final deve ter **escape simples**; `\\'`/`\\\"` é over-escaping e defeito.
- `\n`/`\t` podem ser literais no target; se a fonte usa quebra real, envie quebra real.

### 3.2. Placeholders

Preserve `%1$s`, `%2$s`, `%d` e a ordem dos índices. Exemplo:

- `Checked %1$s` ➔ `Verificado %1$s`
- `%1$s → %2$s` ➔ `%1$s → %2$s`

### 3.3. Plurais

Plural é array (`one`/`many`/`other`). Use `PushJson`; não concatene formas com `/`, `|` ou vírgula.
Se o Weblate exigir três formas, preencha `many` com o mesmo conteúdo de `other`.

### 3.4. Strings read-only

Três unidades não são editáveis no Weblate e não entram no XML exportado:

- `trendingPlaylist`
- `unfound_file`
- `ytdlp`

O Android usa o fallback da fonte. Não trate como pendência nem como erro.

### 3.5. Checks nativos

`Status` mostra **15 checks** em 03/11/2026. `Checks` lista as unidades com `has_failing_check`.
Todas as 15 são **falsos positivos de classificação**: no upstream são `<string>` e já estão
traduzidas no `values-pt-rBR`; o Weblate as trata como plural, com formas vazias.

Não preencha `many`/`other` nem converta essas chaves em `<plurals>`. O critério de integridade é o
`Check` (placeholders/ICU/chaves), não o check nativo.

Além disso, 5 strings traduzidas no Weblate ainda não chegaram ao upstream:
`no_cookies_found`, `all_artists_in_album_artist`, `all_artists_in_album_artist_summary`,
`press_cancel`, `fetching_data`. Elas dependem do sync do bot.

---

## 4. 🧪 Validação no hub

```powershell
./scripts/weblate-sync.ps1 -Action Status -Project ytdlnis
./scripts/weblate-sync.ps1 -Action Check  -Project ytdlnis -Component strings
./scripts/weblate-sync.ps1 -Action Checks -Project ytdlnis -Component strings
```

Resultado de 02/11/2026:

```text
Projeto ytdlnis | idioma pt_BR
  strings   671/686   pendentes=15   checks=15
```

Não há fonte EN no hub, então `validate-ptbr.ps1` não roda contra uma régua fixa. Essa é a lacuna
principal.

### 4.1. Backup

```powershell
./scripts/weblate-sync.ps1 -Action Backup -Project ytdlnis -Component strings `
  -OutFile YTDLnis/snapshots/ytdlnis_strings_pt_BR.xml
```

Depois de baixar, confira:

- XML válido e UTF-8 sem BOM.
- Nenhum `\\'`/`\\\"` (escape duplicado).
- Placeholders e tags contra a fonte.
- Nenhuma string vazia.
- Contagem de contextos e ausência esperada das 3 read-only.

---

## 5. 🚀 Entrega e revisão

1. As traduções são submetidas no Weblate.
2. O bot abre um PR com o título *"Translations update from Hosted Weblate"*, atribuindo os commits ao
   tradutor.
3. O mantenedor mescla quase diariamente.

A entrega termina na plataforma; o hub não abre PR.

---

## 6. 📱 Espaço de tela

1. **Onboarding:** título curto + explicação em uma ou duas linhas.
2. **Fila:** o estado cabe ao lado do nome; `Baixando`, `Concluído`, `Falhou`.
3. **Notificação:** uma linha; `Download concluído`, não `O download foi concluído com sucesso`.
4. **Configurações avançadas:** o usuário aceita termo técnico; não simplifique demais.
5. **Letras:** `Sincronizadas`, `Texto simples`, `Ajuste de atraso (offset)`.

---

## 7. ✅ Checklist antes de enviar ao Weblate

**Etapas 1 e 2 — origem**
- [ ] Li a chave e sei em que tela o texto aparece?
- [ ] Traduzi a partir do EN do Weblate, não de `pt-PT`/`es`/`de`?

**Etapas 3 e 4 — texto**
- [ ] A frase cabe no componente (onboarding, fila, notificação)?
- [ ] Sentence Case aplicado; ferramentas, codecs e siglas preservados?
- [ ] Português do Brasil, sem termo de Portugal e sem construção literal?

**Etapa 5 — regras**
- [ ] O texto enviado está cru (sem `\'`/`\"`)?
- [ ] O XML final tem escape simples, sem `\\'`/`\\\"`?
- [ ] Placeholders `%1$s`, `%2$s`, `%d` preservados?
- [ ] Plurais enviados como array (`PushJson`)?
- [ ] As 3 read-only foram deixadas de fora?
- [ ] `Status` sem pendências no componente?
- [ ] `Check` com 0 divergências e `Checks` revisado?
- [ ] Snapshot do hub atualizado?

---

## 8. ⚠️ Lacunas conhecidas

1. **15 checks de plural.** São falsos positivos: as chaves são `<string>` no upstream e já estão traduzidas.
2. **5 traduzidas aguardando sync.** `no_cookies_found`, `all_artists_in_album_artist`, `all_artists_in_album_artist_summary`, `press_cancel`, `fetching_data`.
3. **Sem fonte EN no hub.** Falta criar `YTDLnis/fonte/` para validar offline.
4. **Snapshot desatualizado.** O XML tem 670 strings + 9 plurais; o Weblate já tem 686 unidades.
5. **Nada foi rodado em Android.** Nenhuma permissão ou notificação foi testada em aparelho real.
6. **3 read-only.** Não são editáveis; o Android usa o fallback da fonte.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 671/686, 15 checks (falsos positivos de plural) | `weblate-sync.ps1 -Action Status` em 03/11/2026 |
| 5 traduzidas fora do upstream | comparação `values-pt-rBR` × export do Weblate em 03/11/2026 |
| 670 strings + 9 plurais (27 formas) = 697 | contagem no snapshot em 02/11/2026 |
| 3 read-only | `trendingPlaylist`, `unfound_file`, `ytdlp` |
| Release `v1.9.1.1` (19/10/2026) | `gh release view --repo deniscerri/ytdlnis` |
