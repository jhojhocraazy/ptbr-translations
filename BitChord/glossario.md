# 📗 Glossário de termos — BitChord

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la em XML**. Status do projeto em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** clone em `BitChord/repo`, branch `i18n/pt-br-182`, commit `706ccb0`
> (30/10/2026 18:20). Toda citação `arquivo:linha` foi conferida no catálogo pt-BR em **02/11/2026**.
>
> **Como usar:** procure o termo, confira a linha citada e escreva igual. Se o termo não estiver
> aqui, decida com a regra da seção 1 e acrescente a linha **no mesmo commit** da string nova.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É nome próprio, marca, produto, protocolo, codec, unidade ou sigla?**
   Fica em inglês. `BitChord`, `YouTube Music`, `Dolby Atmos`, `WebDAV`, `FLAC`, `LUFS`.
2. **É termo que o brasileiro já usa em inglês no dia a dia?**
   Fica. `playlist`, `replay`, `scrobbling`, `addon`, `token`.
3. **É palavra comum com equivalente natural em pt-BR?**
   Traduz. `lossless` ➔ **sem perdas**; `equalizer` ➔ **equalizador**; `liked songs` ➔
   **músicas curtidas**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale em todas as telas. O catálogo já segue
isso: `addon` aparece **18** vezes no `app/` (contagem própria em 02/11/2026), nunca "extensão" nem
"complemento"; `Músicas curtidas` (`values-pt/strings.xml:1075`), nunca "canções curtidas".

**Termo técnico que o leitor pode não conhecer** ganha explicação curta na própria tela, não no
glossário — o glossário é para quem traduz, a explicação é para quem usa. Exemplo:
`Painel nativo do seu dispositivo` (`values-pt/strings.xml:1154`) em vez de "painel HAL".

---

## 2. 🚫 Fica em inglês

### 2.1. Marcas e produtos

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| BitChord | `BitChord` | `app_name` (`values-pt/strings.xml:3`) |
| YouTube / YouTube Music | `YouTube` / `YouTube Music` | `sign_in_youtube_music` (`:121`) |
| Spotify | `Spotify` | `spotify_sign_in` (`:1345`) |
| Discord | `Discord` | `sign_in_discord` (`:122`) |
| Dolby Atmos | `Dolby Atmos` | `dolby_atmos` (`:859`) |
| Chromecast / Google Cast | `Chromecast` / `Google Cast` | `cast_dialog_subtitle` (`:1208`) |
| Android Auto / Wear OS | `Android Auto` / `Wear OS` | `wear_os_page_title` (`:1380`) |
| Wi-Fi | `Wi-Fi` (com hífen, maiúsculas) | `wifi` (`:329`) |

### 2.2. Áudio e processamento

| Termo | Como escrever | Onde aparece | Por quê |
| :--- | :--- | :--- | :--- |
| Automix | `Automix` | `automix` (`:204`) | Nome do recurso, não descrição. |
| Crossfade | `Crossfade` | `crossfade` (`:202`) | Mesmo termo em Spotify e Apple Music. |
| DSP | `DSP` | `pipeline_dsp` (`:1224`) | Sigla de *Digital Signal Processing*. |
| EQ | `EQ` | `pipeline_eq_preset` (`:1252`) | Só como sigla; o painel se chama `Equalizador` (`:208`). |
| LUFS | `LUFS` | `loudness_lufs` (`:938`) | Unidade de intensidade sonora. |
| dB | `dB` | `loudness_gain_db` (`:937`) | Unidade. |
| PCM / FLAC / ALAC / AAC / Opus / LDAC / LHDC | nome exato | `lossless_source_subtitle` (`:86`), `lossless_output_permission_detail` (`:1303`) | Codecs e formatos. |
| Hi-Res | `Hi-Res` | `discord_show_audio_quality_subtitle` (`:304`) | Selo de qualidade, não "alta resolução". |
| DAC | `DAC` | `prefer_usb_dac` (`:898`) | Conversor digital-analógico. |
| Bit-exact | `Bit-exact` | `pipeline_bit_exact` (`:935`) | Indicador do painel de áudio. |
| bit-perfect | `bit-perfect` (minúsculo no meio da frase) | `bit_perfect_output` (`:909`) | Nome do modo de saída. |
| Buffers | `Buffers` | `pipeline_buffers` (`:1256`) | Termo do diagnóstico de áudio. |
| Mono | `Mono` | `mono` (`:325`) | Opção de saída. |
| Loudness | `Loudness` | `eq_preset_loudness` (`:1172`) | **Só como nome da predefinição** — ver seção 4.1. |
| float | `float` | `skip_silence_float_subtitle` (`:207`) | `saída float de 32 bits`, minúsculo. |

### 2.3. Rede e transmissão

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| WebDAV | `WebDAV` | `webdav` (`:556`) |
| SMB | `SMB` | `smb` (`:573`) |
| NAS | `NAS` | `smb_description` (`:577`) |

### 2.4. Biblioteca e recursos do app

| Termo | Como escrever | Onde aparece | Por quê |
| :--- | :--- | :--- | :--- |
| playlist / playlists | `playlist` / `playlists` (minúsculo no texto) | `new_playlist` (`:37`), `your_playlists` (`:354`) | Palavra corrente em pt-BR. |
| Playlist / Playlists | `Playlist` / `Playlists` (maiúsculo só como rótulo isolado) | `playlist_action` e `playlists` (`sharedUi/.../values-pt/strings.xml:153-154`) | É o título do botão, não frase. |
| Replay | `Replay` | `replay` (`:152`), `close_replay` (`:475`) | Nome do recurso (retrospectiva de audição). |
| Scrobbling | `Scrobbling` | `scrobbling` (`:96`) | Nome do recurso. |
| scrobble (verbo) | `fazer scrobble` | `scrobbling_footer` (`:417`) | Verbo aportuguesado, sem tradução. |
| addon / addons | `addon` / `addons` | `add_addon` (`:801`), `search_source_addons` (`:1354`) | Nunca "extensão" nem "complemento". |
| Single / EP / Shorts | `Single` / `EP` / `Shorts` | `shelf_single` (`:1012`), `recent_ep` (`:1323`), `shelf_shorts` (`:1008`) | Nomes de prateleira do YouTube Music. |

### 2.5. Interface

| Termo | Como escrever | Onde aparece | Por quê |
| :--- | :--- | :--- | :--- |
| Status | `Status` | `status` (`:455`) | Rótulo do seletor de presença do Discord. |
| Online | `Online` | `status_online` (`:461`), `listen_together_server_online` (`:689`) | Valor de status e latência de servidor. |
| Token | `Token` | `token` (`:467`), `api_token` (`:283`) | Credencial de API. |

---

## 3. ✅ Traduz-se

### 3.1. Áudio

| Termo em inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Lossless | `Sem perdas` / `Áudio sem perdas` | `lossless` (`:250`), `lossless_audio` (`:84`) |
| Spatial audio | `Áudio espacial` | `spatial_audio` (`:148`) |
| Loudness normalization | `Normalização de volume` | `loudness_normalization` (`:926`) |
| Loudness (medidor do pipeline) | `Intensidade` | `pipeline_loudness` (`:932`) |
| Loudness target | `Intensidade alvo` | `loudness_target` (`:929`) |
| Bitstream | `bitstream` (mantido, minúsculo) | `equalizer_bitstream_footer` (`:1150`) |
| Resampler | `Reamostrador` | `pipeline_resampler` (`:1222`) |
| Bit depth | `Profundidade de bits` | `pipeline_bit_depth` (`:1232`) |
| Sample rate | `Taxa de amostragem` | `pipeline_sample_rate` (`:1234`) |
| Output device | `Dispositivo de saída` | `pipeline_output_device` (`:1226`) |
| Lyrics offset | `Deslocamento da letra` | `lyrics_offset` (`:1065`) |

### 3.2. Equalizador

| Termo em inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Equalizer | `Equalizador` | `equalizer` (`:208`) |
| System equalizer | `Equalizador do sistema` | `system_equalizer` (`:1152`) |
| Broad (modo) | `Amplo` | `equalizer_broad` (`:1125`) |
| Focused (modo) | `Focado` | `equalizer_focused` (`:1127`) |
| Contour | `Contorno` | `equalizer_contour` (`:1123`) |
| Tilt | `Inclinação` | `equalizer_tilt` (`:1121`) |
| Bass boost / Bass cut | `Reforço de graves` / `Atenuação de graves` | `eq_preset_bass_boost` (`:1162`), `eq_preset_bass_cut` (`:1164`) |
| Treble boost / Treble cut | `Reforço de agudos` / `Atenuação de agudos` | `eq_preset_treble_boost` (`:1168`), `eq_preset_treble_cut` (`:1170`) |
| Spoken word | `Voz falada` | `eq_preset_spoken_word` (`:1174`) |
| Late night | `Modo noturno` | `eq_preset_late_night` (`:1188`) |
| Small speakers | `Alto-falantes pequenos` | `eq_preset_small_speakers` (`:1186`) |
| Reset all bands | `Redefinir todas as bandas` | `equalizer_reset` (`:1139`) |
| Preset | `Predefinição` | `equalizer_preset` (`:1133`) |
| Bands | `Bandas` | `equalizer_bands` (`:1135`) |

Os gêneros musicais seguem a grafia da indústria: `Rock`, `Jazz`, `Hip-hop` e `Vocal` ficam iguais
ao inglês; `Clássica` (`:1184`) é o único traduzido.

### 3.3. Biblioteca e interface

| Termo em inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Liked songs | `Músicas curtidas` | `auto_liked` (`:1075`), `remove_from_liked` (`:400`) |
| Likes | `Curtidas` | `song_info_likes` (`:1417`) |
| Listen together | `Ouvir junto` | `listen_together` (`:684`) |
| Party | `festa` | `listen_together_in_party` (`:686`) |
| Quick picks | `Escolhas rápidas` | `auto_quick_picks` (`:1071`) |
| Up Next | `A seguir` | `up_next` (`wearos/.../values-pt/strings.xml:10`) |
| Now Playing | `Tocando agora` | `playing_now` (`wearos/.../values-pt/strings.xml:13`) |

---

## 4. ⚠️ Decisões que não são óbvias

Estas são as que geram dúvida de verdade. Todas já estão aplicadas no catálogo — a seção existe para
que ninguém "corrija" o que foi decidido.

### 4.1. `Loudness` sobrevive só como nome de predefinição

A palavra inglesa aparece **uma vez**, como preset de equalizador (`eq_preset_loudness`, `:1172`).
A função se chama `Normalização de volume` (`:926`) e o medidor do pipeline, `Intensidade` (`:932`).
São três nomes para coisas diferentes: o **preset** é uma curva de EQ; a **normalização** é o
recurso; a **intensidade** é o número medido. Não unifique.

### 4.2. `Bit-exact` e `bit-perfect` não são a mesma coisa

- `Bit-exact` (`:935`) é o **indicador** do painel de áudio: o sinal chegou sem alteração.
- `Saída bit-perfect` (`:909`) é o **modo** que envia a faixa ao DAC sem passar por EQ, crossfade ou
  volume.

Os dois ficam em inglês, e o hífen é parte do termo. `bit-perfect` aparece minúsculo no meio da
frase (`:906`), `Bit-exact` capitalizado porque é rótulo de linha do painel.

### 4.3. `playlist` muda de caixa conforme a posição

- No meio da frase, minúsculo: `Nova playlist` (`:37`), `Suas playlists` (`:354`).
- Como rótulo isolado de botão ou título, maiúsculo: `Playlist` (`sharedUi/.../values-pt/strings.xml:153`),
  `Playlists` (`:154`).

Não é inconsistência: é a mesma regra de Sentence Case do resto do app — nome de tela começa com
maiúscula.

### 4.4. `Ouvir junto` tem três nomes no catálogo

| Onde | Texto | Chave |
| :--- | :--- | :--- |
| Nome do recurso | `Ouvir junto` | `listen_together` (`:684`) |
| Unidade da sessão | `festa` | `listen_together_in_party` (`:686`) |
| Etiqueta no `sharedUi` | `Jam de %1$s` | `listen_together_jam` (`sharedUi/.../values-pt/strings.xml:44`) |

`festa` é o nome interno da sessão e aparece em texto de usuário, então fica. `Jam` é o único ponto
divergente — está registrado como pendência na seção 7.

### 4.5. `Status` fica, mas os valores são traduzidos

O rótulo do seletor é `Status` (`:455`); os valores são `Não perturbe` (`:457`), `Ausente` (`:459`) e
`Online` (`:461`). Traduzir o rótulo para "Situação" quebraria o paralelo com o Discord, que é onde
o usuário vê esse seletor.

### 4.6. `Downloads` não é inglês mantido — é a mesma palavra

`download_channel_name` (`:4`) e `downloads` (`:29`) são idênticos ao EN, mas em pt-BR "downloads" é
palavra corrente. Não troque por "baixados" só porque a string é igual à fonte.

---

## 5. 🚗 Android Auto

Mensagem lida de relance, em movimento. Frase curta, sem parágrafo, sem instrução longa.
As linhas abaixo são de `app/src/main/res/values-pt/strings.xml`.

| Termo em inglês | pt-BR | Chave e linha |
| :--- | :--- | :--- |
| Quick picks | `Escolhas rápidas` | `auto_quick_picks` (`:1071`) |
| Recents | `Recentes` | `auto_recents` (`:1073`) |
| Liked songs | `Músicas curtidas` | `auto_liked` (`:1075`) |
| Sign in to YouTube on your phone | `Faça login no YouTube no seu celular` | `auto_login_title` (`:1077`) |
| No recent songs | `Nenhuma música recente` | `auto_empty_recents_title` (`:1081`) |
| No liked songs | `Nenhuma música curtida` | `auto_empty_liked_title` (`:1093`) |
| No offline songs | `Nenhuma música offline` | `auto_empty_offline_title` (`:1097`) |
| Content unavailable | `Conteúdo indisponível` | `auto_unavailable_title` (`:1101`) |

`offline` fica: é como o usuário chama o modo sem conexão, e "sem conexão" mudaria o sentido (a tela
lista músicas baixadas, não um estado de rede).

---

## 6. ⌚ Wear OS

Tela circular, espaço mínimo. Rótulo de 1 ou 2 palavras.
As linhas abaixo são de `wearos/src/main/res/values-pt/strings.xml`.

| Termo em inglês | pt-BR | Chave e linha |
| :--- | :--- | :--- |
| Now Playing | `Tocando agora` | `playing_now` (`:13`) |
| Up Next | `A seguir` | `up_next` (`:10`) |
| Queue empty | `Nada na sequência` | `queue_empty` (`:11`) |
| Watch speaker or headphones | `Alto-falante do relógio ou fones` | `watch_speaker` (`:32`) |
| This watch / On phone | `Este relógio` / `No celular` | `this_watch` (`:31`), `on_phone` (`:25`) |
| Phone not connected | `Celular não conectado` | `no_phone_title` (`:4`) |
| Retry | `Tentar novamente` | `retry` (`:6`) |

`watch_speaker` cobre **duas** saídas (alto-falante do relógio e fones), por isso a tradução tem o
"ou fones". Encurtar para "Alto-falante do relógio" perde informação que o usuário precisa.

---

## 7. ❓ Ainda não decidido

1. **`Jam` contra `Ouvir junto`.** O `sharedUi` mostra `Jam de %1$s`
   (`sharedUi/.../values-pt/strings.xml:44`) enquanto o resto do app diz `Ouvir junto` (`:684`).
   Decidir: padronizar em `Ouvir junto` ou assumir `Jam` como nome curto. Falta: a escolha.
2. **`Ouvindo junto` contra `Ouvir junto`.** `listen_together_jam_unnamed` está no gerúndio
   (`sharedUi/.../values-pt/strings.xml:45`), o nome do recurso está no infinitivo. Mesma decisão do
   item 1.
3. **Termos sem string ainda.** `Watch Party` **não existe** neste app — a única chave `party_` é
   `party_queue_full` (`:1279`), e o texto fala em "festa". Não invente nome de recurso que o
   catálogo não tem.
4. **Termos fora deste glossário.** O catálogo mantém em inglês `Beta` (`:264`), `Manual` (`:1117`)
   e `L` / `R` (`:1143`, `:1145`). Nenhum deles gera dúvida hoje, mas nenhum tem linha própria aqui.
   Falta: acrescentar se algum virar dúvida.
5. **`Status` em outros contextos.** A decisão da seção 4.5 vale para o seletor do Discord.
   `barra de status` (`:241`) é a barra do sistema Android e já está traduzida como `barra de status`.
   Se aparecer um terceiro contexto, ele precisa de decisão própria.

---

## 8. 📌 Como este glossário se mantém honesto

- Toda linha aponta `chave:linha` do catálogo pt-BR. Sem linha, é opinião.
- Termo novo entra **no mesmo commit** da string que o usa.
- Termo que saiu do catálogo sai daqui — o glossário não guarda vocabulário de recurso removido.
- A lista de termos idênticos ao EN é a pista de onde procurar linha faltando: **57** chaves do
  `app/` têm texto igual à fonte (contagem própria em 02/11/2026), e o validador reporta **38**
  porque só acusa quando a fonte tem 4+ letras minúsculas seguidas
  (`scripts/validate-ptbr.ps1:176`). As duas contagens medem a mesma coisa com réguas diferentes.
