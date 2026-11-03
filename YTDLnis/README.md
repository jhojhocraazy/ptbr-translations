# 📥 YTDLnis — Localização pt-BR

> **Central de localização para Português do Brasil (`pt-BR`) do aplicativo
> [YTDLnis](https://github.com/deniscerri/ytdlnis).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status

| Item | Estado |
| :--- | :--- |
| **Plataforma** | [Hosted Weblate — YTDLnis pt-BR](https://hosted.weblate.org/projects/ytdlnis/-/pt_BR/) |
| **Componente** | `strings` |
| **Cobertura** | 🟢 **671/686** — 15 checks são falsos positivos de plural; 5 traduzidas aguardam sync |
| **Checks nativos** | 🟡 **15** — todos são `<string>` no upstream; o Weblate as classifica como plural |
| **Entrega** | 🟢 **Weblate** — o bot abre PR automático no GitHub; não há PR manual |
| **Snapshot** | 670 `<string>` + 9 `<plurals>` (27 formas) = **697 unidades**; 5 traduzidas atrás do Weblate |
| **Read-only** | 3 — `trendingPlaylist`, `unfound_file`, `ytdlp` |
| **Última release** | `v1.9.1.1` (19/10/2026) |
| **Clone no hub** | **não existe** — projeto de plataforma |

As 15 unidades que o Weblate mostra como pendentes são **falsos positivos**: no upstream elas são
`<string>` e já estão traduzidas no `values-pt-rBR`. O Weblate as trata como plural com formas vazias.
O gap real são **5 traduções** que já existem na plataforma e ainda não chegaram ao upstream
(`no_cookies_found`, `all_artists_in_album_artist`, `all_artists_in_album_artist_summary`,
`press_cancel`, `fetching_data`).

---

## 🚀 O que é o YTDLnis

Aplicativo Android de download de vídeo e áudio baseado em **`yt-dlp`** e **FFmpeg**:

- download de múltiplos formatos, com extração automática;
- playlists, canais, capítulos e segmentos do SponsorBlock;
- letras sincronizadas via **LRCLIB**;
- corte de vídeo, embutimento de legendas e download acelerado com **`aria2c`**;
- tela de créditos para tradutores.

O vocabulário está em [`glossario.md`](./glossario.md); as regras de escrita em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Plataforma (fonte de verdade)** | Weblate, projeto `ytdlnis`, componente `strings`, idioma `pt_BR` |
| **Arquivo no Android** | `app/src/main/res/values-pt-rBR/strings.xml` |
| **Snapshot do hub** | [`snapshots/ytdlnis_strings_pt_BR.xml`](./snapshots/ytdlnis_strings_pt_BR.xml) |
| **Entrega** | Weblate; o bot abre PR automático |
| **Clone no hub** | **não existe** |

O snapshot é de 24/10/2026: tem 670 strings + 9 plurais (27 formas). O Weblate já está em 686
unidades. Os dois números medem coisas diferentes e não devem ser somados.

---

## 🧪 Como conferir

Precisa de `WEBLATE_TOKEN` no ambiente (ou `scripts/tokens.ps1`, ignorado pelo Git):

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

**Sem fonte EN no hub.** O `validate-ptbr.ps1` não roda contra uma régua fixa; falta criar
`YTDLnis/fonte/` (ver [`../organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md)).

Os checks nativos incluem falsos positivos conhecidos (`multiple_capital` em `JSON`/`Info-JSONs`,
`same` em `Nightly`), mas os 15 atuais não foram todos revisados nesta rodada.

---

## 🔄 Como a entrega funciona

1. As traduções são submetidas no Weblate.
2. O bot abre um PR com o título *"Translations update from Hosted Weblate"*, atribuindo os commits
   ao tradutor.
3. O mantenedor mescla quase diariamente.

A entrega termina na plataforma; o hub não abre PR.

---

## ⚠️ Lacunas

1. **15 checks de plural.** São falsos positivos: no upstream as chaves são `<string>` e já estão traduzidas; o Weblate as classifica como plural.
2. **5 traduzidas aguardando sync.** `no_cookies_found`, `all_artists_in_album_artist`, `all_artists_in_album_artist_summary`, `press_cancel` e `fetching_data` já estão no Weblate, mas não no upstream/snapshot.
3. **Sem fonte EN versionada.** O validador não roda offline contra o EN.
4. **Snapshot atrás.** O XML tem 670 strings + 9 plurais; faltam as 5 traduzidas que aguardam sync.
5. **Nada foi rodado em Android.** Nenhuma permissão, notificação ou download foi testado em aparelho
   real.
6. **3 read-only.** Não são editáveis; o Android usa o fallback da fonte.

---

## 📖 Documentos complementares

- 📘 [**Diretrizes técnicas**](./diretrizes-tecnicas.md) — o método aplicado a XML Android, texto cru
  × escape de exportação, plurais, read-only e checks.
- 📗 [**Glossário de termos**](./glossario.md) — yt-dlp, FFmpeg, codecs, letras e permissões.
- 🗂️ [**Snapshot**](./snapshots/) — cópia do Weblate em 24/10/2026.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 671/686, 15 checks (falsos positivos de plural) | `weblate-sync.ps1 -Action Status` em 02/11/2026 |
| 5 traduzidas fora do upstream | comparação `values-pt-rBR` × export do Weblate em 03/11/2026 |
| 670 strings + 9 plurais (27 formas) = 697 | contagem no snapshot em 02/11/2026 |
| 3 read-only | `trendingPlaylist`, `unfound_file`, `ytdlp` |
| Release `v1.9.1.1` (19/10/2026) | `gh release view --repo deniscerri/ytdlnis` |
| 682/682 em 24/10/2026 | medição anterior registrada no README antigo |
