# 📗 Glossário Terminológico Musical — Better Lyrics

> **Dicionário Técnico de Padronização para Português do Brasil (`pt-BR`).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📌 Introdução

O Better Lyrics é a extensão de navegador para **YouTube Music** (organização [better-lyrics](https://github.com/better-lyrics)) que exibe letras sincronizadas, romanização, tradução e temas personalizados.  
Este glossário estabelece o que deve ser mantido no termo internacional consagrado e como traduzir os termos específicos de áudio, sincronização e interface. Cobre as **637 strings** do catálogo atual (projeto Crowdin 863186).

---

## 1. 🚫 Termos que NUNCA Devem Ser Traduzidos

Estes termos são nomes de produto, marcas do ecossistema de letras ou conceitos fonéticos universais:

| Termo em Inglês | Tradução no Better Lyrics | Justificativa / Contexto |
| :--- | :--- | :--- |
| **Better Lyrics** | `Better Lyrics` | Nome do produto. Verificado por `tooling/check-i18n-brand.ts` — nunca traduzir nem transliterar. |
| **Unison** | `Unison` | Acervo colaborativo de letras da extensão (votação, dock de ações). Também protegido pelo checador de marca. |
| **Furigana** | `Furigana` | Sistema japonês de escrita fonética em kana sobre kanjis para indicar pronúncia. Termo linguístico padrão. |
| **Romanization / Romaji** | `Romanização` / `Romaji` | Transliteração de escrita japonesa/coreana/chinesa para o alfabeto latino (chave `options_language_romanization`). |
| **Karaoke** | `Karaokê` (com acento) | Modo de exibição de letras sincronizadas sílaba por sílaba com efeito de preenchimento. |
| **YouTube Music** | *Manter nome exato* | Plataforma hospedeira da extensão. |
| **Picture-in-Picture (PiP)** | `Picture-in-Picture (PiP)` | Janela flutuante de letras do sistema operacional (inclui `picture_in_picture_fitWindow`). |
| **Playground** | `Playground` | Área de testes de estilos do editor. Mantido em inglês por ser termo consagrado entre desenvolvedores. |

---

## 2. 🎵 Letras & Modos de Sincronização

| Termo em Inglês | Tradução Oficial pt-BR | Contexto / Exemplo |
| :--- | :--- | :--- |
| **Time-synced lyrics** | `Letras sincronizadas` | Letras que rolam automaticamente no tempo exato da música. |
| **Plain lyrics / Unsynced** | `Letras não sincronizadas` / `Letras estáticas` | Texto simples da letra sem marcação de tempo por linha. |
| **Line-by-line** | `Linha por linha` | Modo de sincronização onde a linha inteira acende de uma vez. |
| **Word-by-word / Syllable-by-syllable** | `Palavra por palavra` / `Sílaba por sílaba` | Modo dinâmico onde cada palavra ou sílaba acende conforme é cantada. |
| **Lyrics Provider** | `Provedor de letras` | Fonte de onde as letras são baixadas (Musixmatch, NetEase, LRCLIB, Genius). |
| **Offset / Delay** | `Ajuste de atraso` / `Offset (atraso)` | Ajuste fino em milissegundos (+/- ms) para sincronizar letra adiantada/atrasada. |
| **Lead-in** | `Contagem regressiva` / `Aviso de entrada` | Indicador visual de contagem antes da voz começar. |
| **Instrumental break** | `Intervalo instrumental` | Momento da música onde não há vocal e a interface indica solo/pausa. |

---

## 3. 🎛️ Controles de Áudio, Reprodução & Janela

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Fit window** | `Ajustar à janela` | Redimensionar o conteúdo ou a arte para preencher a janela ativa. |
| **Always on top / Pin** | `Sempre no topo` / `Fixar no topo` | Manter a janela do aplicativo sobreposta sobre todas as outras. |
| **Compact mode** | `Modo compacto` | Visualização minimalista ocupando pouco espaço na tela. |
| **Track / Song** | `Faixa` / `Música` | A gravação em reprodução. |
| **Artist / Album** | `Artista` / `Álbum` | Metadados principais da música. |
| **Now Playing** | `Reproduzindo agora` | Cabeçalho indicando a faixa ativa no momento. |
| **Queue** | `Fila de reprodução` | Lista das próximas músicas programadas para tocar. |
| **Crossfade** | `Crossfade` | Transição suave entre faixas ou capas. Mesmo termo de Spotify e Apple Music. |
| **Seek / Scrubbing** | `Avançar/Retroceder` ou `Buscar` | Ação de arrastar a barra de progresso temporal da música. |
| **Pitch / Tempo** | `Tom` / `Andamento (velocidade)` | Parâmetros de afinação e velocidade rítmica do áudio. |
| **Vocal Stem / Instrumental** | `Faixa vocal` / `Faixa instrumental` | Separação de canais de áudio para isolar a voz ou a melodia. |

---

## 4. 🎨 Efeitos Visuais & Tipografia

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Blur / Background Blur** | `Desfoque de fundo` | Efeito translúcido (Glassmorphism/Aero) da arte do álbum desfocada. |
| **Font Size / Line Height** | `Tamanho da fonte` / `Altura da linha` | Ajustes tipográficos para legibilidade das letras. |
| **Opacity** | `Opacidade` / `Transparência` | Nível de transparência do fundo ou das linhas inativas. |
| **Highlight color** | `Cor de destaque` | Cor da linha ativa que está sendo cantada no momento. |
| **Alignment** | `Alinhamento` | Alinhamento do texto (À esquerda, Centralizado, À direita). |
