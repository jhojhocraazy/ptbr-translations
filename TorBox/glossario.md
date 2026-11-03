# 📗 Glossário de termos — TorBox

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la** no JSON. Status em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** snapshots
> [`snapshots/torbox_messages_en.json`](./snapshots/torbox_messages_en.json) (1.592 chaves) e
> [`torbox_messages_pt_BR.json`](./snapshots/torbox_messages_pt_BR.json) (1.466 chaves), conferidos em
> **02/11/2026**. As citações são de **chave**, não de linha.
>
> **Como usar:** procure o termo, confira a chave citada e escreva igual. Se o termo não estiver aqui,
> decida com a regra da seção 1 e acrescente a linha **no mesmo commit** da string nova.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É marca, nome de recurso ou protocolo?**
   Fica em inglês. `TorBox`, `Airlock`, `WebDL`, `Usenet`, `Torrent`.
2. **É termo que o usuário avançado já usa em inglês?**
   Fica. `download`, `upload`, `cache`, `webhook`, `hash`.
3. **É palavra comum com equivalente natural?**
   Traduz. `seed` ➔ **semente**; `peer` ➔ **par**; `tag` ➔ **etiqueta**; `ratio` ➔ **proporção**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale em toda a interface. O delta já segue isso:
`Etiqueta` em todas as telas, nunca alternado com "tag".

**A regra que manda neste projeto:** a terminologia de torrents segue o **qBittorrent pt-BR** quando
ele traduz. É o vocabulário que o usuário avançado já conhece.

---

## 2. 🚫 Fica em inglês

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| TorBox / TBM | `TorBox` / `TBM` | marca e abreviação |
| Airlock / Airlocked | `Airlock` / `Airlocked` | recurso exclusivo |
| Torrent / Torrents | `Torrent` / `Torrents` | tipo de download |
| Usenet | `Usenet` | rede/protocolo |
| WebDL / Webdl | `WebDL` / `Webdl` | tipo de download |
| Magnet | `Magnet` | `Link magnet` |
| Hash / ID | `Hash` / `ID` | identificadores |
| API key | `Chave de API` | **traduz** — ver 3.3 |
| Webhook | `Webhook` | termo técnico |
| Cache | `Cache` | termo corrente |
| Download / Upload | `Download` / `Upload` | termos correntes |
| Status | `Status` | termo corrente |
| Pro | `Pro` | nome do plano |

---

## 3. ✅ Traduz-se

### 3.1. Terminologia de torrents

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Seed / Seeds | `Semente` / `Sementes` | `ActionButtons.stopSeeding` |
| Peer / Peers | `Par` / `Pares` | `Columns.peers` |
| Tag / Tags | `Etiqueta` / `Etiquetas` | `ActionButtons.assignTags` |
| Ratio | `Proporção` | `Columns.ratio` |
| Tracker | `Rastreador` | `DownloadsFilters.activeTracker` |
| Stalled | `Parado` | `Statuses.stalled` |
| Meta DL | `Meta DL` | estado de metadados |
| Rate limit | `Limite de taxa` | `UploadProgress.rateLimit` |

### 3.2. Planos e conta

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Free | `Grátis` | `User.plans.free` |
| Essential | `Essencial` | `User.plans.essential` |
| Standard | `Padrão` | `User.plans.standard` |
| Pro | `Pro` | `User.plans.pro` |
| API key | `Chave de API` | `ApiKeyInput.label` |

### 3.3. Interface e ações

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Download | `Baixar` (ação) / `Download` (substantivo) | `ActionButtons.*` |
| Upload | `Enviar` (ação) / `Upload` (substantivo) | `UploadManager.*` |
| Archive | `Arquivar` | `ActionButtons.archive` |
| Delete | `Excluir` | `ActionButtons.delete` |
| Retry | `Tentar novamente` | `ActionButtons.retry.label` |
| Search | `Pesquisar` | `SearchBar.*` |
| Filter | `Filtrar` | `DownloadsFilters.*` |
| Settings | `Configurações` | `Navigation.*` |

---

## 4. ⚠️ Decisões que não são óbvias

### 4.1. `Seed` é `Semente`, `Peer` é `Par`

Segue o qBittorrent pt-BR. "Seed" e "peer" são jargão; a interface traduzida usa **Semente** e
**Par**. Em texto técnico (log, diagnóstico), o termo em inglês pode aparecer.

### 4.2. `Tag` é `Etiqueta`

O qBittorrent usa **Etiqueta**. Não use "tag" no texto de usuário, mesmo que o usuário avançado
entenda.

### 4.3. `Stalled` é `Parado`

É o estado de download sem atividade. "Parado" é o termo do qBittorrent; "travado" sugere erro.

### 4.4. `Airlock` fica

É um recurso exclusivo do TorBox. Traduzir para "compartimento estanque" não comunica nada. Mantenha
`Airlock` e `Airlocked`.

### 4.5. `Download` tem dois papéis

- **Ação** (`Download` botão) ➔ **Baixar**.
- **Substantivo** (`Downloads` seção) ➔ **Download**.

O mesmo vale para `Upload` ➔ **Enviar** / **Upload**.

### 4.6. `Pro` fica, `Free` traduz

`Free`, `Essential` e `Standard` viram **Grátis**, **Essencial** e **Padrão**. `Pro` é nome de plano e
fica.

---

## 5. 📱 Onde o termo aparece muda o tamanho

1. **Botão e ação:** 1 a 3 palavras. `Arquivar`, `Excluir`, `Tentar novamente`.
2. **Tabela e lista:** coluna curta; o detalhe vai em tooltip.
3. **Configuração:** rótulo + descrição; o usuário avançado aceita termo técnico.
4. **Erro:** uma ou duas linhas; diga o que falhou e o que fazer.
5. **Player:** sobrepõe o vídeo; prefira `Legendas`, não `Configurações de legenda`.

---

## 6. ❓ Ainda não decidido

1. **`WebDL` x `Webdl`.** O catálogo usa as duas grafias; falta padronizar uma.
2. **`Meta DL`.** Ficou em inglês; "Download de metadados" é mais claro, mas mais longo.
3. **`Cache`.** Ficou em inglês; "memória cache" é mais longo e não é o termo do produto.
4. **`Webhook`.** Ficou em inglês; não há equivalente curto em pt-BR.
5. **`Admin.*` e `CustomViews.presets.*`.** Ficam em inglês por regra; não entram neste glossário.

---

## 7. 📌 Como este glossário se mantém honesto

- Toda linha aponta uma **chave** do catálogo. Sem chave, é opinião.
- Termo novo entra **no mesmo commit** da string que o usa.
- Termo que saiu do catálogo sai daqui.
- O delta tem 1.466 chaves; as 126 ausentes são herdadas do EN por regra, não por esquecimento.
- Contagem e vocabulário são do snapshot de **02/11/2026**; o clone pode estar diferente.
