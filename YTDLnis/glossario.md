# 📗 Glossário de termos — YTDLnis

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la** no XML e no Weblate. Status em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** snapshot
> [`snapshots/ytdlnis_strings_pt_BR.xml`](./snapshots/ytdlnis_strings_pt_BR.xml) (670 strings + 9
> plurais) e o componente `strings` no Weblate, conferidos em **02/11/2026**. As citações são de
> **chave**, não de linha.
>
> **Como usar:** procure o termo, confira a chave citada e escreva igual. Se o termo não estiver aqui,
> decida com a regra da seção 1 e acrescente a linha **no mesmo lote**.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É nome de ferramenta, codec, contêiner ou sigla?**
   Fica em inglês. `yt-dlp`, `FFmpeg`, `aria2c`, `Opus`, `MP4`, `PO Token`.
2. **É termo que o usuário avançado já usa em inglês?**
   Fica. `cookie`, `JSON`, `DASH`, `HLS`.
3. **É palavra comum com equivalente natural?**
   Traduz. `queue` ➔ **fila**; `embed` ➔ **embutir**; `crop` ➔ **cortar**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale em toda a interface e nos metadados.

**A regra que manda neste projeto:** o YTDLnis é uma ponte para `yt-dlp` e `FFmpeg`. O usuário avançado
espera o nome exato da ferramenta; traduzir "FFmpeg" para "conversor" quebra a confiança.

---

## 2. 🚫 Fica em inglês

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| YTDLnis / yt-dlp | nome exato | app e comando |
| FFmpeg | `FFmpeg` | transcodificação |
| aria2 / aria2c | `aria2c` | download paralelo |
| SponsorBlock | `SponsorBlock` | segmentos patrocinados |
| LRCLIB / lrclib.net | nome exato | letras |
| DASH / HLS | `DASH` / `HLS` | streaming adaptativo |
| JSON / Info-JSON | `JSON` / `Info-JSON` | metadados |
| PO Token | `PO Token` | token do YouTube |
| Cookie | `cookie` / `cookies` | sessão importada |
| APK | `APK` | pacote Android |
| Codecs | `Opus`, `AAC`, `VP9`, `AV1`, `H.264`, `H.265` | formatos |
| Contêineres | `MP4`, `MKV`, `WebM`, `MP3`, `M4A` | extensões |

---

## 3. ✅ Traduz-se

### 3.1. Downloads e fila

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Download queue | `Fila de downloads` | `download_queue` |
| Reorder queue | `Reordenar fila` | `download_queue` |
| Concurrent fragments | `Fragmentos simultâneos` | `concurrent_fragments` |
| Limit rate | `Limitar velocidade` | `limit_rate` |
| Command template | `Modelo de comando` | `preferred_command_template` |
| Update channel | `Canal de atualização` | `update_channel` |
| Embed subtitles | `Embutir legendas` | `embed_subtitles` |
| Embed thumbnail | `Embutir miniatura como capa` | `embed_thumb` |
| Crop | `Cortar` / `Recorte` | `crop` |
| Merge cuts into one file | `Mesclar cortes em um único arquivo` | `merge_cuts` |

### 3.2. Letras e LRCLIB

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Embed lyrics | `Embutir letras` | `embed_lyrics` |
| Save .lrc file | `Salvar arquivo .lrc` | `save_lrc_file` |
| Synced lyrics | `Letras sincronizadas` | `lyrics_synced` |
| Plain text lyrics | `Letras em texto simples` | `lyrics_plain` |
| Lyrics offset | `Ajuste de atraso (offset)` | `lyrics_offset` |

### 3.3. Permissões e onboarding

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Welcome to YTDLnis | `Boas-vindas ao YTDLnis` | `welcome_title` |
| Get started | `Começar` | `welcome_get_started` |
| Storage access | `Acesso ao armazenamento` | `welcome_perm_storage` |
| Unrestricted battery use | `Uso irrestrito da bateria` | `welcome_perm_battery` |
| Alarms and reminders | `Alarmes e lembretes` | `welcome_perm_alarms` |
| Restored folders | `Pastas restauradas` | `welcome_perm_folders_summary` |

### 3.4. Estados e erros

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Downloading | `Fazendo o download` | `downloading` |
| Completed | `Baixado` | `downloaded` |
| Failed | `Falha no download` | `failed_download` |
| Cancelled | `Cancelado` | `cancelled` |
| Retry | `Tentar novamente` | `retry` |
| Unavailable | `Indisponível` | `translators_unavailable` |

---

## 4. ⚠️ Decisões que não são óbvias

### 4.1. `offset` fica entre parênteses

`Lyrics offset` ➔ **Ajuste de atraso (offset)**. "Offset" é o termo que o usuário avançado procura;
"atraso" sozinho não distingue adiantado de atrasado.

### 4.2. `embed` é `embutir`

`Embed subtitles` ➔ **Embutir legendas**; `Embed lyrics` ➔ **Embutir letras**. Não use "incorporar"
nem "inserir": o resultado é a faixa dentro do arquivo.

### 4.3. `crop` é `cortar`; o substantivo é `recorte`

A ação é **Cortar**; a seleção é **Recorte**. `Merge cuts` ➔ **Mesclar cortes**.

### 4.4. `channel` tem dois sentidos

- `Update channel` ➔ **Canal de atualização** (`Stable` ➔ `Estável`, `Nightly` e `Master` ficam).
- `YouTube channel` ➔ **Canal** (do YouTube).

O contexto é a chave; não unifique.

### 4.5. `Nightly` e `Master` ficam

São nomes de canal de atualização, não adjetivos. `Stable` vira **Estável**; `Beta` fica **Beta**.

### 4.6. `cookie` fica minúsculo

É a credencial de sessão importada para o yt-dlp. `Cookies` no plural; não vire "biscoito".

---

## 5. 📱 Onde o termo aparece muda o tamanho

1. **Onboarding:** título curto + explicação em uma ou duas linhas.
2. **Fila:** estado ao lado do nome; `Baixando`, `Concluído`, `Falhou`.
3. **Notificação:** uma linha. `Download concluído`.
4. **Configurações avançadas:** o usuário aceita termo técnico.
5. **Letras:** `Sincronizadas`, `Texto simples`, `Ajuste de atraso (offset)`.

---

## 6. ❓ Ainda não decidido

1. **`PO Token (GVS)`.** A sigla é mantida; o check nativo pode apontar duplicidade. Falta decidir se
   o parêntese ajuda ou só ocupa espaço.
2. **`length` x `duration`.** Os dois viram **Duração** e geram check de duplicidade. São o mesmo dado
   em contextos diferentes; a decisão é manter.
3. **`Nightly` x `Master`.** Ficam em inglês; falta confirmar se o usuário de canal instável entende.
4. **`offset`.** Fica entre parênteses; se o espaço apertar, a decisão precisa ser revista.

---

## 7. 📌 Como este glossário se mantém honesto

- Toda linha aponta uma **chave** do catálogo. Sem chave, é opinião.
- Termo novo entra **no mesmo lote** da string que o usa.
- Termo que saiu do catálogo sai daqui.
- Os checks nativos em aberto estão registrados na seção 6, não escondidos.
- Contagem e vocabulário são do snapshot de **02/11/2026**; o Weblate pode estar diferente.
