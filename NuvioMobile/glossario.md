# 📗 Glossário de termos — Nuvio Mobile

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la em XML**. Status do projeto em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** snapshot
> [`snapshots/NuvioMobile_strings_pt_BR.xml`](./snapshots/NuvioMobile_strings_pt_BR.xml) e os seis
> catálogos menores, conferidos contra o EN do clone em **02/11/2026**. As citações são de **chave**,
> não de linha, porque o snapshot muda a cada lote.
>
> **Como usar:** procure o termo, confira a chave citada e escreva igual. Se o termo não estiver aqui,
> decida com a regra da seção 1 e acrescente a linha **no mesmo commit** da string nova.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É nome próprio, marca, produto, protocolo ou sigla?**
   Fica em inglês. `Nuvio`, `Stremio`, `Debrid`, `HLS`, `MPV`.
2. **É termo que o brasileiro já usa em inglês no dia a dia?**
   Fica. `Addon`, `Buffer`, `Player`, `Trailer`, `Spoiler`.
3. **É palavra comum com equivalente natural em pt-BR?**
   Traduz. `playback` ➔ **reprodução**; `watchlist` ➔ **Minha lista**; `cast` ➔ **transmitir**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale em todas as telas. O catálogo já segue
isso: `Minha lista` aparece no menu e nos botões, nunca alternado com "Lista de interesses".

**Termo técnico que o leitor pode não conhecer** ganha explicação curta na própria tela, não no
glossário — o glossário é para quem traduz, a explicação é para quem usa.

---

## 2. 🚫 Fica em inglês

### 2.1. Produto, protocolos e provedores

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| Nuvio | `Nuvio` | nome do app |
| Stremio | `Stremio` | integração de addons e catálogo |
| Addon / Addons | `Addon` / `Addons` | `addons_*`; nunca "complemento" |
| Debrid | `Debrid` | categoria de serviço |
| Real-Debrid / AllDebrid / Premiumize / TorBox | nome exato | provedores |
| Trakt / Simkl / MDBList / TMDB / IMDb | nome exato | metadados e scrobble |
| HLS / DASH | `HLS` / `DASH` | protocolos de streaming |
| MPV | `MPV` | motor de reprodução |
| Picture-in-Picture (PiP) | `Picture-in-Picture (PiP)` | recurso do sistema |
| Android Auto | `Android Auto` | projeção no carro |

### 2.2. Rede e torrent

| Termo | Como escrever | Por quê |
| :--- | :--- | :--- |
| Scraper / Scrapers | `Scraper` / `Scrapers` | mecanismo que descobre links |
| Seeds / Peers | `Seeds` / `Peers` | conceitos do BitTorrent |
| Torrent / Magnet | `Torrent` / `Magnet` | protocolo e URI |
| Buffer | `Buffer` | estado de pré-carregamento |

---

## 3. ✅ Traduz-se

### 3.1. Reprodução e player

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Playback | `Reprodução` | `compose_settings_page_playback` |
| Audio track | `Faixa de áudio` | `compose_player_audio_tracks` |
| Subtitle track | `Faixa de legenda` | `compose_player_subtitles` |
| Embedded subtitles | `Legendas embutidas` | `stream_info_subtitle_source_embedded` |
| Subtitle delay | `Atraso da legenda` | `compose_player_subtitle_delay` |
| Queue | `Fila` | `downloads_enqueue_*` |
| Resume | `Continuar assistindo` | `action_resume` |
| Playback speed | `Velocidade de reprodução` | `compose_player_speed` |

### 3.2. Catálogo e metadados

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Watchlist | `Minha lista` | `trakt_watchlist` |
| Rating / Score | `Avaliação` / `Nota` | `settings_mdb_enable_ratings` |
| Genres | `Gêneros` | `collections_editor_all_genres` |
| Overview / Synopsis | `Sinopse` | `settings_meta_overview` |
| Cast (actors) | `Elenco` | `settings_meta_cast` |
| Crew | `Equipe técnica` | `meta_section_cast_description` |

### 3.3. Watch Party

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Host | `Anfitrião` | `party_host` |
| Join party | `Entrar na sessão` | `party_join_action` |
| Leave party | `Sair da sessão` | `party_leave` |
| End party | `Encerrar sessão` | `party_end` |
| Syncing / In sync | `Sincronizando` / `Em sincronia` | `party_status_ready`, `party_reconnecting` |
| Lobby | `Sala de espera` | `party_waiting` |
| Room code | `Código da sala` | `party_code_label` |

### 3.4. Servidores e AutoSync de legendas

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Server address | `Endereço do servidor` | `servers_address` |
| Username / Password | `Usuário` / `Senha` | `servers_username`, `servers_password` |
| Unreachable | `Inalcançável` | `servers_status_unreachable` |
| Credentials | `Credenciais` | `servers_sign_in_title` |
| Subtitle auto-sync | `Sincronização automática de legendas` | `settings_playback_subtitle_auto_sync` |
| Auto-sync tolerance | `Tolerância da sincronização automática` | `settings_playback_auto_sync_tolerance` |
| Synced automatically | `Sincronizado automaticamente` | `autosync_label_synced` |
| Auto-sync failed | `Falha na sincronização` | `autosync_toast_failed` |

---

## 4. ⚠️ Decisões que não são óbvias

### 4.1. `Player` fica; `playback` traduz

O app usa `player` como nome do componente (*"Configurações do player"*), mas `playback` vira
**reprodução** (*"Velocidade de reprodução"*). São coisas diferentes: o player é a tela; a reprodução é
o ato.

### 4.2. `Minha lista` é o nome do recurso

`Watchlist` não vira "Lista de interesses" nem "Assistir depois". O padrão de Netflix e Prime Video é
**Minha lista**, e é o termo que o usuário reconhece. O mesmo vale para `Continuar assistindo`.

### 4.3. `Buffer` fica; `Armazenando em buffer` descreve o estado

O substantivo é `Buffer` (*"Tamanho do buffer"*). O estado é **Armazenando em buffer** — não
"Carregando", que perderia a informação técnica.

### 4.4. `Host` tem dois sentidos

- Em Watch Party, `Host` é **Anfitrião** (pessoa).
- Em servidor, `Host` é **Endereço do servidor** (rede).

Nunca use "Host" para a pessoa; nunca use "Anfitrião" para o endereço.

### 4.5. `Lobby` vira `Sala de espera`

`Lobby` é entendido por parte do público, mas **Sala de espera** é mais claro para quem nunca usou o
recurso. O código e a chave continuam `lobby`.

### 4.6. `Cast` tem dois sentidos

- Verbo (`Cast to TV`) ➔ **Transmitir**.
- Substantivo (`Cast`) ➔ **Elenco**.

O contexto é a chave: `cast_*` é transmissão; `details_cast` é elenco.

---

## 5. 📱 Onde o termo aparece muda o tamanho

1. **Botão e aba:** 1 a 3 palavras. `Minha lista`, `Favoritos`, `Baixar`.
2. **Configuração:** rótulo curto; a explicação vai em `*_description`.
3. **PiP e Android Auto:** espaço mínimo; prefira `Reproduzir`, não `Iniciar a reprodução`.
4. **Toast e notificação:** fora do app, truncado. `Download concluído`, `Falha na conexão`.
5. **Watch Party:** o estado precisa ser inequívoco para todos os participantes.

---

## 6. ❓ Ainda não decidido

1. **`many` nos plurais.** Os 4 blocos usam só `one` e `other`; falta decidir se vale completar
   `many` para milhões exatos.
2. **`Debrid` como categoria.** Hoje fica em inglês; não há termo em pt-BR que o público reconheça.
3. **`Scraper` em texto de usuário.** Aparece em configurações avançadas; falta decidir se ganha
   explicação entre parênteses.
4. **`Spoiler`.** Não há chave no catálogo atual; se aparecer, a tendência é manter.

---

## 7. 📌 Como este glossário se mantém honesto

- Toda linha aponta uma **chave** do catálogo. Sem chave, é opinião.
- Termo novo entra **no mesmo commit** da string que o usa.
- Termo que saiu do catálogo sai daqui — o glossário não guarda vocabulário de recurso removido.
- As **111** strings idênticas ao EN são a pista de onde procurar decisão faltando; o validador as
  lista como aviso, não como erro.
- Contagem e vocabulário são do snapshot de **02/11/2026**, não do app em produção. Confira a chave
  antes de confiar na linha.
