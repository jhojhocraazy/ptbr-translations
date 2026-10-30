# 📗 Glossário Terminológico de Download & Mídia — YTDLnis

> **Dicionário Técnico de Padronização para Português do Brasil (`pt-BR`).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📌 Introdução

O YTDLnis é uma ponte entre o usuário Android e utilitários de mídia avançados como **yt-dlp**, **FFmpeg** e **aria2c**. Este glossário estabelece regras estritas sobre o que deve ser traduzido e quais termos técnicos devem ser preservados para garantir a máxima clareza e autoridade técnica.

---

## 1. 🚫 Termos que NUNCA Devem Ser Traduzidos

| Termo em Inglês | Tradução no YTDLnis | Justificativa / Contexto |
| :--- | :--- | :--- |
| **yt-dlp / YTDLnis** | *Manter nome exato* | Nome da biblioteca base e do aplicativo. |
| **FFmpeg** | `FFmpeg` | Framework de processamento e transcodificação de áudio e vídeo. |
| **aria2 / aria2c** | `aria2c` | Utilitário de download paralelo de alta velocidade. |
| **SponsorBlock** | `SponsorBlock` | Banco de dados comunitário para pular anúncios embutidos em vídeos. |
| **LRCLIB / lrclib.net** | *Manter nome exato* | Provedor de letras sincronizadas de código aberto. |
| **DASH / HLS** | `DASH` / `HLS` | Protocolos de streaming dinâmico adaptativo. |
| **Weblate** | `Weblate` | Plataforma oficial de tradução comunitária. |
| **JSON / Info-JSON** | `JSON` / `Info-JSON` | Formato de armazenamento de metadados extraídos dos vídeos. |
| **PO Token** | `PO Token` | Token de prova de origem exigido pelo YouTube; sigla técnica mantida. |
| **Cookie** | `cookie` / `cookies` | Credenciais de sessão do navegador importadas para o yt-dlp. |
| **APK** | `APK` | Formato de pacote de aplicativo do Android. |
| **Codecs (Opus, AAC, VP9, AV1, H.264, H.265)** | *Manter nomes exatos* | Padrões industriais de compressão de mídia. |
| **Contêineres (MP4, MKV, WebM, MP3, M4A)** | *Manter extensões* | Extensões e formatos de arquivo. |

---

## 2. 🎬 Operações de Download, Fila & Processamento

| Termo em Inglês | Tradução Oficial pt-BR | Contexto / Exemplo |
| :--- | :--- | :--- |
| **Download queue** | `Fila de downloads` | Lista de itens aguardando para serem baixados. |
| **Reorder queue** | `Reordenar fila` | Ação de mover itens para cima ou para baixo na fila. |
| **Concurrent fragments** | `Fragmentos simultâneos` | Quantidade de partes baixadas ao mesmo tempo em transmissões HLS/DASH. |
| **Embed subtitles** | `Embutir legendas` | Inserir a faixa de legenda diretamente dentro do arquivo de vídeo. |
| **Embed thumbnail** | `Embutir miniatura como capa` | Usar a capa do vídeo como thumbnail do arquivo de mídia. |
| **Crop** | `Cortar` / `Recorte` | Recurso de edição para baixar apenas um trecho do vídeo. |
| **Merge cuts into one file** | `Mesclar cortes em um único arquivo` | Unir vários trechos cortados em um único arquivo de saída. |
| **Limit rate** | `Limitar velocidade` | Definir teto máximo de transferência de dados (ex: 50K ou 4.2M). |
| **Command template** | `Modelo de comando` | Instrução pré-configurada de parâmetros do yt-dlp. |
| **Update channel** | `Canal de atualização` | `Stable` → `Estável`; `Nightly` e `Master` permanecem como nomes de canal; `Beta` → `Beta`. |

---

## 3. 🎵 Letras Sincronizadas (`.lrc`) & lrclib.net

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Embed lyrics** | `Embutir letras` | Inserir a letra diretamente nas tags do arquivo de áudio. |
| **Save .lrc file** | `Salvar arquivo .lrc` | Gerar um arquivo de texto com timestamps ao lado da música baixada. |
| **Synced lyrics** | `Letras sincronizadas` | Letras com sincronia temporal linha por linha. |
| **Plain text lyrics** | `Letras em texto simples` | Letras estáticas sem marcação de tempo. |
| **Lyrics offset** | `Ajuste de atraso (offset)` | Correção em milissegundos para letras adiantadas ou atrasadas. |

---

## 4. ⚙️ Permissões & Telas de Boas-Vindas (`welcome_*`)

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Welcome to YTDLnis** | `Boas-vindas ao YTDLnis` | Título da tela inicial de onboarding. |
| **Get started** | `Começar` | Botão principal de início da configuração. |
| **Storage access** | `Acesso ao armazenamento` | Permissão para gravar arquivos de mídia no dispositivo. |
| **Unrestricted battery use** | `Uso irrestrito da bateria` | Ajuste para evitar que downloads longos parem em segundo plano. |
| **Alarms and reminders** | `Alarmes e lembretes` | Permissão para disparar downloads agendados com precisão. |
| **Restored folders** | `Pastas restauradas` | Pastas recuperadas de um backup de configuração. |
