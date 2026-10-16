# 📗 Glossário Terminológico Oficial — Nuvio Mobile

> **Dicionário Técnico de Padronização para Português do Brasil (`pt-BR`).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📌 Introdução

O Nuvio Mobile opera na interseção entre streaming de mídia, serviços de Debrid, integração com o protocolo Stremio e redes P2P.  
A tradução de termos deve equilibrar **clareza para usuários leigos** com o **respeito à terminologia consolidada** utilizada pela comunidade de tecnologia e entretenimento.

---

## 1. 🚫 Termos que NUNCA Devem Ser Traduzidos

Estes termos são marcas registradas, nomes de protocolos ou jargões universais da comunidade. Traduzi-los gera confusão ou estraga a compatibilidade semântica.

| Termo em Inglês | Tradução no Nuvio | Justificativa / Contexto |
| :--- | :--- | :--- |
| **Stremio** | `Stremio` | Nome do protocolo e ecossistema de streaming. |
| **Addon / Add-ons** | `Addon` / `Addons` | Padrão absoluto na comunidade Stremio (evitar "Complemento"). |
| **Real-Debrid / AllDebrid / Premiumize / TorBox** | *Manter nome exato* | Nomes próprios de provedores de serviço Debrid. |
| **Debrid** | `Debrid` | Categoria de serviço de download e streaming em nuvem. |
| **Scraper / Scrapers** | `Scraper` / `Scrapers` | Mecanismo técnico que rastreia e descobre links de mídia. |
| **Seeds / Peers** | `Seeds` / `Peers` | Conceitos técnicos fundamentais da rede BitTorrent. |
| **Torrent / Magnet** | `Torrent` / `Magnet` | Protocolo e formato de URI de distribuição. |
| **Trakt / Simkl / MDBList / TMDB / IMDb** | *Manter nome exato* | Plataformas e serviços externos de metadados e scrobbling. |
| **HLS / DASH** | `HLS` / `DASH` | Protocolos de streaming adaptativo. |
| **MPV** | `MPV` | Motor de reprodução de vídeo utilizado no aplicativo. |
| **Picture-in-Picture (PiP)** | `Picture-in-Picture (PiP)` | Recurso nativo do sistema operacional. |

---

## 2. 🎬 Reprodução de Mídia & Player de Vídeo

| Termo em Inglês | Tradução Oficial pt-BR | Exemplos de Aplicação no App |
| :--- | :--- | :--- |
| **Playback** | `Reprodução` | *Velocidade de reprodução*, *Falha na reprodução*. |
| **Cast / Casting** | `Transmitir` | *Transmitir para a TV*, *Transmitir via Chromecast*. |
| **Audio Track** | `Faixa de áudio` | *Selecionar faixa de áudio*. |
| **Subtitle Track** | `Faixa de legenda` | *Faixas de legenda embutidas*. |
| **Embedded Subtitles** | `Legendas embutidas` | Legendas encapsuladas no arquivo de vídeo (MKV/MP4). |
| **Hardware Acceleration** | `Aceleração de hardware` | Decodificação por GPU nos ajustes do player. |
| **Aspect Ratio** | `Proporção de tela` | *Ajustar proporção de tela (16:9, preencher, original)*. |
| **Buffer / Buffering** | `Buffer` / `Armazenando em buffer` | Estado de pré-carregamento do fluxo de vídeo. |
| **Queue** | `Fila` | *Adicionar à fila de reprodução*, *Próximo da fila*. |
| **Resume** | `Continuar assistindo` | Ação de retomar vídeo a partir do timestamp gravado. |
| **Rewind / Fast Forward** | `Retroceder` / `Avançar` | Pular 10 segundos para trás ou para frente. |

---

## 3. 👥 Watch Party & Sessões em Grupo (`strings_party.xml`)

| Termo em Inglês | Tradução Oficial pt-BR | Justificativa / Contexto de Aplicação |
| :--- | :--- | :--- |
| **Host** | `Anfitrião` | Usuário que criou a sessão e controla a reprodução de todos. |
| **Join Party** | `Entrar na sessão` | Ação de um usuário se conectar à sala do anfitrião. |
| **Leave Party** | `Sair da sessão` | Desconectar da sala atual. |
| **End Party** | `Encerrar sessão` | Ação exclusiva do anfitrião que encerra a sala para todos. |
| **Syncing / In Sync** | `Sincronizando` / `Em sincronia` | Estado de alinhamento temporal entre os participantes. |
| **Lobby** | `Sala de espera` ou `Lobby` | Tela de pré-início onde os participantes aguardam. |
| **Room Code** | `Código da sala` | Hash ou código numérico compartilhado para conexão. |

---

## 4. 🖥️ Servidores Remotos & Redes (`strings_servers.xml`)

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Host (Networking)** | `Endereço do servidor` ou `Host` | Endereço IP ou domínio do servidor remoto. |
| **Port** | `Porta` | Porta de conexão TCP/UDP (ex: 8080). |
| **Latency / Ping** | `Latência` / `Ping` | Tempo de resposta de ida e volta do servidor. |
| **Reachability** | `Acessibilidade` / `Conectividade` | Teste de verificação se o servidor responde à rota. |
| **Timeout** | `Tempo limite esgotado` | Falha após tempo de espera sem resposta. |
| **Credentials** | `Credenciais` | Nome de usuário e senha de autenticação. |

---

## 5. 📑 Catálogos, Metadados & MDBList (`strings_mdblist.xml`)

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Cast (Actors)** | `Elenco` | Lista de atores e atrizes do filme ou série. |
| **Crew** | `Equipe técnica` | Direção, roteiro, produção. |
| **Watchlist** | `Lista de interesses` | Títulos salvos pelo usuário para assistir depois. |
| **Favorites** | `Favoritos` | Itens marcados com estrela/coração. |
| **Rating / Score** | `Avaliação` / `Nota` | Notas do IMDb, Metacritic, Trakt ou MDBList. |
| **Genres** | `Gêneros` | Categorias (Ação, Comédia, Drama, Ficção científica). |
| **Overview / Synopsis** | `Sinopse` | Resumo da trama da obra. |
| **Air Date** | `Data de exibição` | Data de lançamento original do episódio na TV. |
| **Release Date** | `Data de lançamento` | Data de estreia do filme nos cinemas ou digital. |

---

## 6. 🔄 Sincronização Automática (`autosync_strings.xml`)

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **AutoSync** | `Sincronização automática` | Recurso de background sync de histórico e listas. |
| **Sync Interval** | `Intervalo de sincronização` | Frequência de atualização (ex: a cada 1 hora). |
| **Last Synced** | `Última sincronização` | Timestamp da última execução bem-sucedida. |
| **Sync on Startup** | `Sincronizar ao iniciar` | Gatilho de sincronização ao abrir o aplicativo. |
