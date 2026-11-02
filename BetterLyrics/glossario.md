# 📗 Glossário Terminológico — Better Lyrics

> **O vocabulário da localização em Português do Brasil (`pt-BR`) da extensão
> [Better Lyrics](https://github.com/better-lyrics/better-lyrics).**
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📌 Como usar

O Better Lyrics é a extensão de navegador para **YouTube Music** que exibe letras sincronizadas,
romanização, tradução e temas personalizados.

Cada linha abaixo traz a **chave do catálogo** onde o termo aparece, para que a decisão seja
verificável. As linhas entre parênteses são do snapshot
[`snapshots/better_lyrics_messages_pt_BR.json`](./snapshots/better_lyrics_messages_pt_BR.json),
medido em 02/11/2026.

O glossário decide a **palavra**. O formato, os placeholders e os plurais estão em
[`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md).

---

## 1. 🚫 Termos que nunca se traduzem

Nomes de produto e de marca. O `tooling/check-i18n-brand.ts:14` do upstream reprova o PR que alterar
os cinco primeiros.

| Termo | Como fica | Onde / por quê |
| :--- | :--- | :--- |
| **Better Lyrics** | `Better Lyrics` | nome do produto (`options_provider_betterLyrics`, `:796`) |
| **Unison** | `Unison` | acervo colaborativo de letras — votação, revisões, dock de ações (`unison_title`) |
| **Portato** | `Portato` | provedor do produto (`options_provider_betterLyricsPortato`) |
| **Legato** | `Legato` | provedor do produto (`options_provider_betterLyricsLegato`) |
| **boidu.dev** | `boidu.dev` | endereço do projeto. Não aparece no catálogo atual — a proteção vale se aparecer |
| **YouTube Music** | `YouTube Music` | plataforma hospedeira |
| **Musixmatch**, **LRClib**, **BiniLyrics**, **Spicy Lyrics** | grafia original | provedores de letra. O mesmo `check-i18n-brand.ts:11-13` diz que marcas de terceiro **podem** ser transliteradas — a decisão daqui é manter. `Spicy Lyrics` ainda não está no snapshot: é uma das 5 chaves pendentes |
| **LRC**, **TTML** | `LRC`, `TTML` | nomes de formato de letra (`unison_format_lrc`, `unison_format_ttml`) |
| **ISRC** | `ISRC` | código internacional de gravação (`unison_isrc`, `:2188`) |
| **Picture-in-Picture** | `Picture-in-Picture` | nome do recurso de janela flutuante (`picture_in_picture_open`) |
| **Playground** | `Playground` | área de testes de estilo (`editor_playground`, `:1506`) |
| **Crossfade** | `Crossfade` | nome da transição, igual em Spotify e Apple Music (`options_pipTransition_crossfade`) |
| **Shaders** | `Shaders` | nome do pacote de efeitos (`marketplace_shadersBadge`, `:1008`) |
| **GitHub**, **Discord** | grafia original | `marketplace_githubBadge`, `options_about_discordLink` |
| **Feed**, **Status**, **Original** | grafia original | rótulos de aba e coluna no Unison (`unison_tabFeed` `:2270`, `unison_rev_colStatus`, `unison_rev_original`) |

---

## 2. 🎵 Letras & modos de sincronização

O catálogo tem **dois** vocabulários de sincronização, em telas diferentes. Não misture.

### 2.1. Configuração do app (traduz)

| Inglês | pt-BR | Chave |
| :--- | :--- | :--- |
| Syllable | `Sílaba` | `options_syncType_syllable` (`:832`) |
| Word | `Palavra` | `options_syncType_word` (`:840`) |
| Line | `Linha` | `options_syncType_line` (`:848`) |
| Unsynced | `Não sincronizado` | `options_syncType_unsynced` (`:856`) |
| Sync | `Sincronização` | `unison_sync` |

### 2.2. Etiqueta do Unison (decisão em aberto)

| Inglês | pt-BR atual | Chave |
| :--- | :--- | :--- |
| Richsync | `Sincronização rica` | `unison_syncRichsync` (`:2080`) |
| Linesync | `Sincronização por linhas` | `unison_syncLinesync` (`:2084`) |
| Plain | `Sem sincronização` | `unison_syncPlain` (`:2088`) |

**Por que está em aberto:** o `description` dessas três chaves diz que o texto é reaproveitado no
**badge do card** e no **chip de filtro** — um espaço minúsculo. O EN usa uma palavra; o pt-BR usa
duas ou três. E os formatos vizinhos (`LRC`, `TTML`) ficaram em inglês, o que deixa o conjunto
inconsistente. A decisão é do mantenedor: tratar tipo de sincronização como termo de domínio (mantém
`Richsync`/`Linesync`) ou como descrição (traduz, e aí vale encurtar).

### 2.3. Demais termos de letra

| Inglês | pt-BR | Chave / observação |
| :--- | :--- | :--- |
| Time-synced lyrics | `Letras sincronizadas` | `options_about_tagline` (`:1562`) — "Letras sincronizadas para o YouTube Music" |
| Synced version | `Solicitar versão sincronizada` | `lyrics_requestSyncedVersion` (`:1890`) — botão, no infinitivo |
| Bad sync / Bad synchronization | `Sincronização incorreta` | `unison_report_bad_sync` (`:2036`), `report_lyrics_bad_sync` |
| Sync offset | `Ajuste de sincronização` | `options_unisonModal_controlOffset` |
| Per-song offsets | `Ajustes por música` | `options_offsetModal_perSong` |
| Karaoke subtitles | `Legendas de karaokê` | `options_display_karaoke` (`:3026`) — **com acento** |
| Romanization | `Romanização` | `options_language_romanization` (`:374`) |

**Furigana** e **Romaji** não aparecem no catálogo atual (0 ocorrências). Se aparecerem, mantêm a
grafia: são termos linguísticos, não marca.

---

## 3. 🎛️ Reprodução & janela

| Inglês | pt-BR | Chave / observação |
| :--- | :--- | :--- |
| Fit window | `Ajustar à janela` | `picture_in_picture_fitWindow` — ação de botão, no infinitivo |
| Open Picture-in-Picture lyrics | `Abrir letras Picture-in-Picture` | `picture_in_picture_open` (`:148`) |
| Crossfade | `Crossfade` | `options_pipTransition_crossfade` |
| Shaders | `Shaders` | `marketplace_shadersBadge` |

Termos de player que **não** estão no catálogo atual (0 ocorrências): *Now Playing*, *Queue*,
*Lead-in*, *Pitch*, *Tempo*, *Vocal Stem*. Não invente tradução para eles — se aparecerem, decidir
aqui primeiro.

---

## 4. 🔤 Regras de escrita

1. **Sentence Case.** Só a primeira letra maiúscula: `Ajustar à janela`, não `Ajustar À Janela`. Nome
   próprio e sigla mantêm a grafia.
2. **Português do Brasil, não de Portugal.** `tela` (não *ecrã*), `arquivo` (não *ficheiro*),
   `salvar` (não *guardar*), `configurações` (não *definições*).
3. **Botão começa com verbo**, no infinitivo: `Ajustar`, `Abrir`, `Solicitar`, `Tentar novamente`.
4. **Uma palavra por uma palavra** (`CONTRIBUTING.md:156`). Se o EN é `Retry`, o ideal é uma palavra;
   `Tentar novamente` é a exceção aceita porque `Repetir` não é o que o botão faz.
5. **Sigla e unidade não se traduzem.** `ISRC`, `LRC`, `TTML`, `PiP`.

---

## 5. ⚠️ Lacunas

1. **Tipo de sincronização em aberto** (seção 2.2) — falta a decisão do mantenedor.
2. **Termos sem ocorrência no catálogo** (Furigana, Romaji, Now Playing, Queue, Lead-in, Pitch, Tempo,
   Vocal Stem) — o glossário os lista por precaução, não porque existam hoje.
3. **Nenhum termo foi conferido em tela.** As decisões vêm do texto e do `description` das chaves, não
   de ver a extensão rodando.
