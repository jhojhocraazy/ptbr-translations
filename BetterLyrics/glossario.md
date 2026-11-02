# 📗 Glossário de termos — Better Lyrics

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la em JSON**. Status do projeto em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** snapshot
> [`snapshots/better_lyrics_messages_pt_BR.json`](./snapshots/better_lyrics_messages_pt_BR.json)
> (638 chaves), conferido chave a chave contra o EN em **02/11/2026**. Toda citação `:linha` é desse
> arquivo.
>
> **Como usar:** procure o termo, confira a linha citada e escreva igual. Se o termo não estiver aqui,
> decida com a regra da seção 1 e acrescente a linha **no mesmo commit** da string nova.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É nome próprio, marca, produto, formato ou sigla?**
   Fica em inglês. `Better Lyrics`, `Unison`, `LRC`, `TTML`, `ISRC`.
2. **É termo que o brasileiro já usa em inglês no dia a dia?**
   Fica. `Feed`, `Playground`, `Crossfade`, `Shaders`, `Marketplace`.
3. **É palavra comum com equivalente natural em pt-BR?**
   Traduz. `theme` ➔ **tema**; `install` ➔ **instalar**; `rating` ➔ **avaliação**;
   `revision` ➔ **revisão**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale em todas as telas. O catálogo já segue
isso, e as contagens abaixo são a prova de que a decisão foi aplicada em massa, não em uma string:

| Termo | Em quantas chaves do pt-BR aparece |
| :--- | ---: |
| `letra` / `letras` | **70** |
| `tema` / `temas` | **62** |
| `sincroniz…` (sincronização, sincronizada) | **30** |
| `Unison` | **11** |
| `fonte` / `fontes` | **11** |
| `Marketplace` | **10** |

Se você encontrar "canção" onde o resto diz "música", ou "ficheiro" onde o resto diz "arquivo", o erro
é seu, não uma variação aceitável.

**Termo técnico que o leitor pode não conhecer** ganha explicação curta na própria tela, não no
glossário — o glossário é para quem traduz, a explicação é para quem usa. Exemplo:
`reprodução contínua (gapless)` (`:3034`) em vez de só "gapless".

---

## 2. 🚫 Fica em inglês

### 2.1. Produto e plataformas

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| Better Lyrics | `Better Lyrics` | `options_provider_betterLyrics` (`:796`) |
| Unison | `Unison` | `unison_title` (`:1936`) |
| Portato / Legato | `Portato` / `Legato` | `options_provider_betterLyricsPortato` (`:804`), `:800` |
| YouTube / YouTube Music | `YouTube` / `YouTube Music` | `options_provider_youtube` (`:820`) |
| Musixmatch / LRClib / BiniLyrics | grafia original | `:812`, `:816`, `:828` |
| GitHub / Discord | grafia original | `marketplace_githubBadge` (`:1012`), `options_about_discordLink` (`:1644`) |

`Portato`, `Legato` e `Unison` também são nomes de provedor (`options_provider_betterLyricsUnison`,
`:808`): aparecem como sufixo do produto, nunca traduzidos.

### 2.2. Formatos, siglas e nomes de recurso

| Termo | Como escrever | Onde aparece | Por quê |
| :--- | :--- | :--- | :--- |
| LRC / TTML | `LRC` / `TTML` | `unison_format_lrc` (`:2104`), `unison_format_ttml` (`:2108`) | Nomes de formato de letra |
| ISRC | `ISRC` | `unison_isrc` (`:2188`) | Código internacional de gravação |
| RICS | `RICS` | `marketplace_ricsBadge` (`:1342`) | Selo no detalhe do tema; o texto é "Este tema usa RICS" |
| XP | `XP` | `unison_xpToNext` (`:2402`) | Unidade de experiência do Unison |
| JSON | `JSON` | `options_identityImport_pastePlaceholder` (`:482`) | Formato de arquivo |
| GPL / PRs | `GPL` / `PRs` | `options_about_openSourceBody` (`:1606`) | Licença e termo de contribuição |
| Shaders | `Shaders` | `marketplace_shadersBadge` (`:1008`) | Nome do pacote de efeitos — ver 4.2 |
| Playground | `Playground` | `editor_playground` (`:1506`) | Área de testes do editor |
| Crossfade | `Crossfade` | `options_pipTransition_crossfade` (`:222`) | Mesmo termo em Spotify e Apple Music |
| Marketplace | `Marketplace` | `marketplace_title` (`:892`) | Ver 4.3 |
| Feed | `Feed` | `unison_tabFeed` (`:2270`) | Nome da aba; ver 4.6 |
| Status / Original | `Status` / `Original` | `unison_rev_colStatus` (`:2804`), `unison_rev_original` (`:2584`) | Rótulos de coluna e de revisão |
| Commit | `Commit` | `marketplace_commit` (`:1468`) | `Commit $hash$` — termo do git |
| Picture-in-Picture | `Picture-in-Picture` | `options_display_pipWindow` (`:230`) | Nome do recurso de janela flutuante |
| Layout | `Layout` | `options_display_pipWindowLayout` (`:194`) | "Layout da janela" |
| Cache | `cache` (minúsculo no meio da frase) | `options_general_clearCache` (`:50`) | Palavra corrente; "Limpar cache" |

---

## 3. ✅ Traduz-se

### 3.1. Letras e sincronização

| Inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Lyrics | `Letras` | `unison_lyrics` (`:2160`) |
| Time-synced lyrics | `Letras sincronizadas` | `options_about_tagline` (`:1562`) |
| Community lyrics | `Letras da comunidade` | `unison_subtitle` (`:1940`) |
| Raw lyrics | `Letras sem formatação` | `unison_rawLyrics` (`:2184`) |
| Synced version | `Versão sincronizada` | `lyrics_requestSyncedLanded` (`:1928`) |
| Syllable / Word / Line / Unsynced | `Sílaba` / `Palavra` / `Linha` / `Não sincronizado` | `options_syncType_*` (`:832`, `:840`, `:848`, `:856`) |
| Sync offset | `Ajuste de sincronização` | `options_unisonModal_controlOffset` (`:318`) — ver 4.7 |
| Per-song offsets | `Ajustes por música` | `options_offsetModal_perSong` (`:350`) |
| Saved offsets | `Ajustes salvos` | `options_offsetModal_perSongCount` (`:358`) |
| Shift lyrics earlier / later | `Adiantar` / `Atrasar sincronização das letras` | `lyricsDock_offsetEarlier` (`:338`), `lyricsDock_offsetLater` (`:342`) |
| Bad sync | `Sincronização incorreta` | `unison_report_bad_sync` (`:2036`) |
| Source | `Fonte` | `lyrics_source` (`:1514`) |
| Translation / Romanization | `Tradução` / `Romanização` | `options_translation_tab` (`:1704`), `options_language_romanization` (`:374`) |
| Karaoke subtitles | `Legendas de karaokê` | `options_display_karaoke` (`:3026`) — **com acento** |

### 3.2. Marketplace e temas

| Inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Theme | `Tema` | `options_themes_theme` (`:402`) |
| Theme Marketplace | `Marketplace de temas` | `options_themes_marketplace` (`:430`) — ver 4.3 |
| Install / Installed | `Instalar` / `Instalados` | `marketplace_install` (`:992`), `marketplace_showInstalled` (`:948`) |
| Rating / ratings | `Avaliação` / `avaliações` | `marketplace_tooltipRating` (`:1286`) |
| Shader config | `configuração de shader` | `options_detail_shaderInfo` (`:876`) — "shader" minúsculo no meio da frase |
| Custom styles | `Estilos personalizados` | `options_themes_customStyles` (`:418`) |
| Styles editor | `Editor de estilos` | `editor_pageTitle` (`:1478`) |

### 3.3. Unison

| Inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Upvote / Downvote | `Voto positivo` / `Voto negativo` | `unison_upvote` (`:1996`), `unison_downvote` (`:2000`) |
| vote / votes | `voto` / `votos` | `unison_vote_singular` (`:2450`), `unison_vote_plural` (`:2454`) |
| Revision / Revisions | `Revisão` / `Revisões` | `unison_rev_revision` (`:2820`), `unison_rev_revisions` (`:2618`) |
| Council | `conselho` | `unison_rev_councilNote` (`:2730`) — "Nota do conselho" |
| Council review | `revisão do conselho` | `unison_rev_pendingTitle` (`:2700`) |
| Submission / submissions | `envio` / `envios` | `unison_deleteForbidden` (`:2024`), `unison_tabMySubmissions` (`:2274`) — ver 4.6 |
| Level / Max level | `Nível` / `Nível máximo` | `unison_level` (`:2392`), `unison_maxLevel` (`:2416`) |
| Rank | `Classificação nº $rank$` | `unison_rank` (`:2420`) |
| Top-Rated | `Mais bem avaliado` / `Mais bem avaliados` | `unison_confidence_high` (`:2060`), `unison_sortTopRated` (`:2064`) — ver 4.4 |
| Requested & fulfilled | `Solicitado e atendido` | `unison_fulfilledBadge` (`:2310`) |

### 3.4. Interface, janela e identidade

| Inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Fullscreen | `Tela cheia` | `options_display_fullscreenTab` (`:88`) |
| Floating lyrics window | `Janela de letras flutuante` | `options_display_pipWindow` (`:230`) |
| Fit window | `Ajustar à janela` | `picture_in_picture_fitWindow` (`:3054`) |
| Lyrics controls dock | `Painel de controles de letras` | `options_display_unisonActions` (`:254`) — ver 4.1 |
| Identity | `Identidade` | `options_identity_yourIdentity` (`:446`) |
| Storage | `Armazenamento` | `options_general_storageUsed` (`:58`) |
| Cache | `cache` | `options_general_clearCache` (`:50`) |

---

## 4. ⚠️ Decisões que não são óbvias

Estas são as que geram dúvida de verdade. Todas já estão aplicadas no catálogo — a seção existe para
que ninguém "corrija" o que foi decidido.

### 4.1. `dock` virou `painel`

O inglês usa "dock" em **4** chaves (`:254`, `:258`, `:262`, `:266`). O pt-BR não tem nenhuma
ocorrência de "dock": todas viraram **painel**.

- `Lyrics controls dock` ➔ `Painel de controles de letras` (`:254`, `:258`)
- `Show controls dock` ➔ `Mostrar painel de controles` (`:262`)
- `A floating dock` ➔ `Painel flutuante` (`:266`)

O `description` de `picture_in_picture_open` ainda chama de "dock action" — é o nome interno. O
usuário nunca vê "dock".

### 4.2. `badge` tem dois destinos

A palavra inglesa aparece no texto **uma** vez: `options_about_badgesBody` (`:1686`), sobre os
emblemas do Unison — e ali virou **`emblema`**.

Nos outros lugares, "badge" existe só no **nome da chave**, não no texto:

| Chave | Texto | Por quê |
| :--- | :--- | :--- |
| `marketplace_shadersBadge` (`:1008`) | `Shaders` | o badge mostra o nome do recurso |
| `marketplace_githubBadge` (`:1012`) | `GitHub` | o badge mostra a marca |
| `theme_top_badge` (`:1812`) | `Nº $RANK$ no Marketplace` | o selo mostra a posição |
| `unison_fulfilledBadge` (`:2310`) | `Solicitado e atendido` | o badge mostra o estado |

Não traduza "badge" por reflexo: traduza o que ele **exibe**.

### 4.3. `Marketplace` fica, `Theme` traduz

`Theme Marketplace` ➔ **`Marketplace de temas`** (`:430`, `:892`). A ordem inverte — em pt-BR o
núcleo vem primeiro — e só a segunda palavra é traduzida.

O mesmo vale para `Temas do Marketplace` (`:1060`) e `Nº $RANK$ no Marketplace` (`:1812`). "Marketplace"
sozinho, capitalizado, é o nome da loja. Não vire "mercado" nem "loja de temas".

### 4.4. `Top-Rated` muda de número conforme o contexto

| Contexto | Texto | Chave |
| :--- | :--- | :--- |
| Etiqueta de uma letra | `Mais bem avaliado` (singular) | `unison_confidence_high` (`:2060`) |
| Opção de ordenação | `Mais bem avaliados` (plural) | `unison_sortTopRated` (`:2064`) |

A etiqueta classifica **uma** entrada; a ordenação classifica **a lista**. Plural ali não é descuido.

### 4.5. `gapless` fica entre parênteses

`Audio-only gapless playback is preserved` ➔ `A reprodução contínua (gapless) de áudio é mantida`
(`:3034`).

"Reprodução contínua" é a tradução; `gapless` fica como âncora para quem já conhece o termo. Traduzir
só para "sem intervalos" perderia a palavra que o usuário procura, e manter só `gapless` perderia
quem não conhece.

### 4.6. `Feed` fica; `submission` vira `envio`

- `Feed` (`:2270`) é o nome da aba. Fica.
- `submission` **não** fica: `Meus envios` (`:2274`), `Não é o seu envio` (`:2024`),
  `Falha no envio` (`:2332`).

São coisas diferentes: `Feed` é uma tela; "submission" é o ato de enviar uma letra.

### 4.7. `offset` não é `deslocamento`

`Sync offset` ➔ **`Ajuste de sincronização`** (`:318`), não "deslocamento" nem "offset". O botão que
move a letra no tempo diz `Adiantar` / `Atrasar sincronização das letras` (`:338`, `:342`).

"Offset" continua correto em conversa técnica, mas não é o que o usuário lê.

### 4.8. O nome do produto é traduzido no parêntese

`extensionName` (`:2`): `Better Lyrics (Lyrics for YouTube Music)` ➔
**`Better Lyrics (Letras para YouTube Music)`**.

A marca fica; a explicação entre parênteses traduz. É a linha em que o nome do produto e uma tradução
dividem a mesma string — o parêntese existe justamente para quem ainda não conhece o produto.

### 4.9. `Rank` tem duas renderizações

| Chave | Texto | Forma |
| :--- | :--- | :--- |
| `unison_rank` (`:2420`) | `Classificação nº $rank$` | nome + número |
| `theme_top_badge` (`:1812`) | `Nº $RANK$ no Marketplace` | só o número, com contexto |

As duas usam o indicador de número `nº`, minúsculo. A diferença é o que vem antes: na primeira, o
rótulo; na segunda, o contexto já está na frase.

---

## 5. 📱 Onde o termo aparece muda o tamanho

O mesmo vocabulário, espaços diferentes:

1. **Popup do navegador:** 1 a 2 palavras. `Instalar`, `Atualizar`, `Entrar`.
2. **Badge e chip em card:** o texto é etiqueta, não frase. `Shaders`, `GitHub`, `Solicitado e
   atendido`.
3. **Tooltip e rótulo acessível:** lido em voz alta, precisa funcionar sozinho.
   `Ajustar à janela` (`:3054`) funciona; `Ajustar` não.
4. **Página de opções:** cabe explicação nos campos `*Hint`, `*Body` e `*Footer`.
5. **Unison:** rótulos de coluna e de aba são curtos por natureza. `Revisão`, `Status`, `Feed`.

---

## 6. ❓ Ainda não decidido

1. **`Richsync` / `Linesync` / `Plain`.** Hoje: `Sincronização rica` (`:2080`),
   `Sincronização por linhas` (`:2084`), `Sem sincronização` (`:2088`). O `description` avisa que o
   mesmo texto vira **badge em card** e **chip de filtro** — espaço mínimo — e os formatos vizinhos
   (`LRC`, `TTML`) ficaram em inglês. Falta: decidir se tipo de sincronização é termo de domínio
   (mantém) ou descrição (traduz, e encurta).
2. **`Furigana`, `Romaji`, `Now Playing`, `Queue`, `Lead-in`, `Pitch`, `Tempo`, `Vocal Stem`.** Nenhum
   aparece no catálogo atual (0 ocorrências). Estão listados por precaução, não porque existam hoje.
   Falta: decidir cada um quando a string aparecer — e aí registrar aqui.
3. **21 chaves com EN de uma palavra e pt-BR de duas ou mais**, contra `CONTRIBUTING.md:156`. As mais
   visíveis: `Retry` ➔ `Tentar novamente` (`marketplace_retry`), `Unsynced` ➔ `Não sincronizado`
   (`:856`), `Fullscreen` ➔ `Tela cheia` (`:88`). Falta: decidir quais encurtar e quais aceitar como
   inevitáveis.
4. **`Classificação nº` contra `Nº`.** As duas formas convivem (4.9). Falta: dizer se a diferença é
   intencional ou se uma delas deve padronizar.
5. **Nenhum termo foi conferido em tela.** As decisões vêm do texto e do `description` de cada chave,
   não de ver a extensão rodando. Falta: carregar a extensão em modo desenvolvedor.

---

## 7. 📌 Como este glossário se mantém honesto

- Toda linha aponta `chave:linha` do snapshot pt-BR. Sem linha, é opinião.
- Termo novo entra **no mesmo commit** da string que o usa.
- Termo que saiu do catálogo sai daqui — o glossário não guarda vocabulário de recurso removido.
- As **29** chaves com texto idêntico ao EN são a pista de onde procurar decisão faltando: elas são
  marca, sigla, nome de formato ou string composta só de placeholders. O validador reporta **28**
  porque só acusa quando a fonte tem 4+ letras seguidas (`scripts/validate-ptbr.ps1:176`) — a que
  escapa é `options_general_segment`, `$LABEL$: $VALUE$`.
- Contagem de ocorrências é do snapshot de **02/11/2026**, não do Crowdin. O catálogo da plataforma
  pode estar diferente; confira a chave antes de confiar na linha.
