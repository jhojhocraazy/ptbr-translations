# 📘 Diretrizes Técnicas de Localização — Better Lyrics

> **O que é este documento:** o método de tradução do Better Lyrics aplicado às regras que só valem
> nele. Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem [`README.md`](./README.md)
> (o status).
>
> **Contra o que foi escrito:** snapshots em `BetterLyrics/snapshots/`
> (`better_lyrics_messages_en.json` e `better_lyrics_messages_pt_BR.json`, 638 chaves cada) e o
> upstream `better-lyrics/better-lyrics` no commit `f77dcc2` (02/11/2026), lido pela API do GitHub.
> Contagens e citações de linha medidas em **02/11/2026**.
>
> **O que ele não cobre:** abrir a extensão no navegador, julgar fluência e verificar o que está no
> Crowdin — ver seção 9.

---

## 1. 🔁 O método: cinco etapas, sempre na mesma ordem

Toda string segue esta ordem, sem pular etapa:

1. **Ler a chave interna**
2. **Ler a string em inglês**
3. **Entender o que o usuário vê**
4. **Escrever em pt-BR**
5. **Conferir contra as regras do projeto**

A ordem não é cerimônia. Pular a etapa 1 produz tradução genérica para um contexto que não é aquele.
Pular a 3 produz frase correta que não cabe na tela. Pular a 5 produz texto bonito que quebra a
extensão.

### 1.1. Etapa 1 — Ler a chave interna

A chave é o identificador da string no JSON (`"unison_vote_plural"`). O prefixo diz em que área da
extensão o texto aparece, e a distribuição real do catálogo confirma isso:

| Prefixo | Chaves | Onde vive |
| :--- | ---: | :--- |
| `options_` | 221 | página de opções da extensão (a maior parte da interface) |
| `unison_` | 208 | painel do **Unison**, o acervo colaborativo de letras |
| `marketplace_` | 104 | **Theme Marketplace** — loja e modal de detalhe de tema |
| `editor_` | 28 | editor de temas |
| `lyrics_` | 20 | exibição de letras e pedidos de letra |
| `report_` | 14 | formulário de denúncia |
| `auth_` | 9 | consentimento de login |
| `picture_` | 8 | janela **Picture-in-Picture** |
| `lyricsDock_` | 7 | dock de ações sobre a letra |
| `theme_` | 7 | tema em uso |
| `blUpdate_` | 4 | aviso de atualização da própria extensão |
| `ui_` | 3 | componentes genéricos |

A tabela cobre 633 das 638 chaves. As outras 5 são `extensionName`, `extensionDescription`,
`symlink_` (2) e `builtin_` (1) — chaves soltas, sem área própria.

O `CONTRIBUTING.md:169-174` documenta o padrão como `<área>_<componente>_<elemento>` e dá três
exemplos. O que ele **não** diz: depois do prefixo de área, o resto costuma ser **camelCase**
(`options_display_letterWaveBadge`, `unison_rev_colStatus`). Isso é normal e não se mexe — a chave
nunca é traduzida, reformatada ou renomeada.

### 1.2. Etapa 2 — Ler a string em inglês

Aqui este projeto é diferente dos que entregam por pull request: **não existe clone do repositório
no hub** (seção 2.1). Então a fonte tem três camadas, e cada uma serve a uma pergunta diferente:

| Camada | Onde | Responde |
| :--- | :--- | :--- |
| **Fonte de tradução** | o texto que o Crowdin mostra como fonte | "o que eu traduzo agora?" |
| **Espelho fixo** | `snapshots/better_lyrics_messages_en.json` (638 chaves) | "contra o que eu valido?" |
| **Antecipação** | `master` do upstream, via `gh api` | "o que vem por aí?" |

Na dúvida, a fonte é a **primeira**. O snapshot não é a fonte: ele é a fotografia do EN usada na
última tradução, congelada para que o validador não mude de régua no meio do trabalho. E o `master`
não é a fonte: ele anda na frente da plataforma (hoje, 643 contra 638) e traduzir por ele produz
string que ainda não existe no Crowdin.

**Nunca use outro locale como origem.** O repositório upstream tem 24 pastas de locale (`de`, `es`,
`fr`, `ja`, `pl`, `pt_PT`…), e nenhuma delas serve. A armadilha específica deste projeto é o
**`pt_PT`**: existe, é português e parece uma resposta pronta — mas é português de Portugal, com
vocabulário e concordância diferentes. Uma tradução de terceiro pode ter erro, e o erro se propaga
sem aparecer.

Uma string já traduzida no `pt_BR` só pode ser reaproveitada depois de conferida contra o EN; se não
bater, retraduza.

### 1.3. Etapa 3 — Entender o que o usuário vê

Aqui a pergunta deixa de ser "o que a frase diz" e passa a ser "onde ela aparece e o que a pessoa está
fazendo quando lê". A extensão tem contextos bem diferentes:

- **Popup da barra do navegador:** pouco espaço, rótulos de 1 ou 2 palavras.
- **Página de opções:** a maior parte das 221 chaves `options_`; cabe texto, mas o item de menu
  continua curto.
- **Sobreposição de letras e Picture-in-Picture:** o texto divide espaço com a arte do álbum e os
  controles do player.
- **Badge e chip** (etiqueta pequena dentro de um card): `unison_syncRichsync` é descrito como
  "Sync type: word/syllable-level timing. **Reused by the sync badge on cards and the sync filter
  chip**" — ou seja, o mesmo texto aparece num badge minúsculo.
- **Tooltip e rótulo acessível:** o mesmo texto é lido por leitor de tela, então precisa fazer sentido
  fora de contexto visual.
- **Aviso e erro** (`alert`, `toast`): aparece fora da página de opções e muitas vezes truncado.

**O atalho para esta etapa é o campo `description`.** Ele é a nota do tradutor: descreve a tela, o
estado e o que o clique faz. O `CONTRIBUTING.md:155` manda lê-lo em cada string, e as 638 chaves do
snapshot têm `description` preenchida (0 sem nota, medido em 02/11/2026).

O `CONTRIBUTING.md:156` acrescenta uma regra dura de espaço: **"Match word count — If the original is
one word, use one word in translation."** O catálogo atual tem **21** chaves em que o EN é uma palavra
e o pt-BR tem duas ou mais (seção 9, lacuna 3).

### 1.4. Etapa 4 — Escrever em pt-BR

Português do Brasil, natural e não literal:

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| definições | **configurações** |

Use **Sentence Case** — só a primeira letra maiúscula (*"Ajustar à janela"*, não *"Ajustar À Janela"*).
Nome próprio e sigla mantêm a grafia.

O vocabulário vem do [`glossario.md`](./glossario.md). O que **não** se traduz, e por quê:

| Termo | Por quê |
| :--- | :--- |
| `Better Lyrics`, `Unison`, `Portato`, `Legato`, `boidu.dev` | nomes do produto. Verificados por `tooling/check-i18n-brand.ts:14` no CI do upstream — reprova quem altera |
| `YouTube Music`, `Musixmatch`, `LRClib`, `BiniLyrics`, `Spicy Lyrics` | plataformas e provedores de letra. O mesmo arquivo, `:12-13`, diz que marcas de terceiro **podem** ser transliteradas — o glossário decide manter |
| `LRC`, `TTML`, `ISRC` | nomes de formato e de código. `unison_format_lrc` e `unison_format_ttml` já estão idênticos ao EN |
| `Playground`, `Crossfade`, `Shaders`, `Picture-in-Picture` | termo consagrado do domínio |

O glossário decide a **palavra**; este documento decide **como escrevê-la em JSON** (seção 3).

### 1.5. Etapa 5 — Conferir contra as regras do projeto

Quatro barreiras, nesta ordem:

1. **O formato JSON** — `message`, `description`, `placeholders` (seção 3).
2. **O validador do hub** — `scripts/validate-ptbr.ps1 -Format chrome` (seção 6).
3. **As checagens do projeto** — `check-i18n-brand`, `check-i18n-format` e `check-i18n-stale`, que
   rodam no CI do upstream quando o bot abre o PR de sync (seção 5).
4. **O olho no `description`** — a string continua fazendo sentido no contexto descrito?

### 1.6. O método aplicado a uma string real

`picture_in_picture_fitWindow`:

1. **Chave:** `picture_in_picture_fitWindow` → janela Picture-in-Picture, ação sobre a janela.
2. **EN:** `Fit window` (`better_lyrics_messages_en.json:167`), com a nota "Tooltip **and accessible
   label** for the selected song/video button in the Picture-in-Picture lyrics window when the window
   size no longer matches its content; clicking it resizes the window to fit".
3. **O que o usuário vê:** o texto aparece ao passar o mouse sobre um botão **e** é lido por leitor de
   tela; o clique redimensiona a janela. É uma ação, não um estado.
4. **pt-BR:** `Ajustar à janela` (`better_lyrics_messages_pt_BR.json:3054`) — verbo no infinitivo,
   porque é ação de botão.
5. **Regras:** sem placeholder, chave presente nos dois lados, `description` copiada intacta,
   `validate-ptbr.ps1` retorna `OK`.

O contraexemplo está em `unison_syncRichsync`: o EN é uma palavra (`Richsync`) e a nota avisa que o
texto vira **badge** em card. O pt-BR atual é `Sincronização rica` — duas palavras num badge. É uma
decisão de termo em aberto (seção 9, lacuna 4), não um erro de digitação.

---

## 2. 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Plataforma (fonte de verdade)** | Crowdin, projeto **863186**, idioma `pt-BR` |
| **Arquivo no upstream** | `_locales/en/messages.json` → `_locales/pt_BR/messages.json` |
| **Snapshot no hub (EN fixo)** | `BetterLyrics/snapshots/better_lyrics_messages_en.json` |
| **Snapshot no hub (pt-BR)** | `BetterLyrics/snapshots/better_lyrics_messages_pt_BR.json` |
| **Branch do upstream** | `master` |
| **Clone no hub** | **não existe** — removido em 02/11/2026 |

**A pasta é `pt_BR`, com underscore — e o idioma no Crowdin é `pt-BR`, com hífen.** Não é engano: o
`crowdin.yml:14` faz o mapeamento `pt-BR: pt_BR` porque o Chrome exige o nome da pasta no formato
dele. Criar uma pasta `pt-BR` produziria uma tradução que a extensão nunca carrega.

**Não há PR de tradução.** A entrega é feita pelo Crowdin, que abre um PR automático
(`CONTRIBUTING.md:142-149`). Este hub não commita em `_locales/` — o snapshot é o registro local.

### 2.1. Por que não há clone

A regra do hub é: **clone só onde o clone é o veículo de entrega**
([`organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md) §2). Better Lyrics entrega por Crowdin, então o clone não
entregava nada — era uma cópia de leitura, parada em 20/10/2026 e **6 chaves** atrás do `master`
(637 contra 643).

O que o clone dava e como ficou:

| O clone servia para | Substituto |
| :--- | :--- |
| Ler o EN mais recente | `gh api` no `master` (seção 1.2) |
| Ler `CONTRIBUTING.md` e `crowdin.yml` | `gh api`, ou o link direto no GitHub |
| Ler `tooling/check-i18n-*.ts` | `gh api` — leitura sim, execução não |
| Rodar as checagens do projeto | **não roda mais aqui** — roda no CI do upstream (seção 5) |
| Dar contexto de tela | o `description` de cada chave, que já descreve a tela |

O custo da remoção: **7,9 MB** e uma dependência a menos. O preço: as checagens do projeto deixaram
de ser executáveis localmente; quem valida no hub é o `validate-ptbr.ps1` (seção 6).

---

## 3. 🧩 O formato: Chrome i18n, não ICU

Este é o ponto em que a documentação antiga deste hub errava, e o erro contaminava o resto.

### 3.1. A anatomia de uma entrada

Cada chave mapeia para um **objeto**, não para uma string:

```json
"unison_vote_plural": {
  "message": "votes",
  "description": "Plural noun used after numbers other than 1 in the Unison vote count (e.g. '5 votes')"
}
```

- **`message`** — o texto que o usuário vê. É o único campo que se traduz.
- **`description`** — a nota do tradutor. **Nunca se traduz** (seção 3.4).
- **`placeholders`** — o dicionário de variáveis, quando a string tem alguma (seção 3.2).

O motor é o `chrome.i18n` do navegador, chamado por `src/core/i18n.ts:93`
(`chrome.i18n.getMessage(key, substitutions)`). É por isso que o formato é este e não o do Android.

### 3.2. Placeholders: `$NOME$`, não `{nome}`

Uma variável na mensagem é escrita **entre cifrões, em maiúsculas ou não**:

```json
"marketplace_tooltipInstalls": {
  "message": "$COUNT$ installs",
  "description": "Tooltip on a theme's install count",
  "placeholders": { "count": { "content": "$1", "example": "1204" } }
}
```

Lendo de dentro para fora: o app chama `t("marketplace_tooltipInstalls", [String(n)])`; o `$1` do
`content` recebe o primeiro argumento; o motor troca `$COUNT$` por esse valor
(`src/core/i18n.ts:77-82`).

Números medidos em 02/11/2026:

| O que | Quantas |
| :--- | ---: |
| Chaves com bloco `placeholders` | **74** de 638 |
| Nomes de variável distintos | **42** (`$NAME$`, `$count$`, `$N$`, `$LABEL$`, `$hash$`…) |
| Chaves cujo bloco `placeholders` diverge do EN | **0** |
| Chaves cujo conjunto de variáveis diverge do EN | **0** |

**A regra:** copie o `message` com as variáveis **na mesma grafia da fonte** e copie o bloco
`placeholders` inteiro. O código compara sem diferenciar maiúsculas de minúsculas
(`src/core/i18n.ts:80`, flag `gi`), e o `check-i18n-format.ts:13` também normaliza os nomes antes de
comparar — mas grafia divergente é ruído que ninguém precisa criar.

**Cuidado com o `CONTRIBUTING.md:154`.** Ele diz "Preserve placeholders like `$1`, `$2` in strings".
Isso descreve o campo **`content`** do bloco `placeholders`, não o `message`. No `message` o que
aparece é `$NOME$`. Confundir os dois produz uma string que nunca recebe valor.

**O que este catálogo não tem:** nenhum `{nome}` (0 ocorrências) e nenhum `%s` / `%1$s` (0
ocorrências). Se uma string nova do EN trouxer `{nome}`, o próprio `check-i18n-format.ts:22-24` reprova
com a mensagem "`{name}` must be written as `$NAME$`".

### 3.3. Plurais são chaves separadas, não ICU

O projeto **não usa ICU MessageFormat**. Não existe `{count, plural, one {...} other {...}}` em
nenhuma das 638 chaves. Plural é resolvido por **duas chaves**, e o código escolhe qual chamar:

| Singular | Plural | O que o usuário vê |
| :--- | :--- | :--- |
| `unison_vote_singular` = `voto` (`:2450`) | `unison_vote_plural` = `votos` (`:2454`) | contagem de votos do Unison |
| `marketplace_tooltipInstallsSingular` = `1 instalação` | `marketplace_tooltipInstalls` = `$COUNT$ instalações` (`:1276`) | tooltip de instalações de um tema |
| `unison_searchResultsOne` = `“$query$” · 1 resultado` | `unison_searchResults` = `“$query$” · $count$ resultados` | contagem de busca no Unison |
| `lyrics_requestedOneOther` = `Solicitado · mais 1 pessoa também quer` | `lyrics_requestedNOthers` = `Solicitado · $N$ outras pessoas também querem` (`:1902`) | rótulo de botão após pedir uma letra |

**Consequência prática:** não existe forma `many` para preencher. A concordância é resolvida pelo par
de chaves, e cada lado precisa concordar sozinho — `1 instalação` no singular, `N instalações` no
plural. O `description` de cada chave diz exatamente quando ela é usada.

> As linhas entre parênteses na tabela acima são do snapshot **pt-BR**
> (`better_lyrics_messages_pt_BR.json`), medido em 02/11/2026.

### 3.4. `description` nunca é traduzida

As 638 `description` do `pt_BR` são **idênticas** às do EN — 0 divergências, medido em 02/11/2026. Isso
não é descuido: o campo é a nota do tradutor, exibida no editor do Crowdin e lida por
`CONTRIBUTING.md:155`. Traduzi-la apaga o contexto para quem revisar depois.

Ao editar um `message`, copie o `description` do EN sem tocar.

### 3.5. Escapes e encoding

O arquivo é JSON puro, escrito pelo bot do Crowdin — **não reformate**.

| Situação | Estado no catálogo | O que fazer |
| :--- | :--- | :--- |
| Aspas duplas dentro do texto | **1** chave | escapar como `\"` — ver abaixo |
| `\n` (quebra de linha) | **0** chaves | se aparecer, usar o escape literal `\n` |
| Barra invertida literal | **0** chaves | escapar como `\\` |
| `%` literal (não é printf) | **2** chaves | manter o `%` como está — **não** duplicar |
| Tag HTML (`<b>`, `<br>`) | **0** chaves | copiar a marcação inteira e traduzir só o texto entre as tags |
| Emoji | **0** chaves | — |
| Encoding | UTF-8 **sem BOM** | nunca salvar com BOM |
| Indentação | 2 espaços | não reindentar |

As duas chaves com `%` são `unison_rev_driftValues` (`Texto $text$% · Tempo $timing$%`) e
`unison_rev_ofLimit` (`do limite de $limit$%`). O `%` ali é sinal de porcentagem literal, não
marcador de formatação: no Chrome i18n não existe `%%`, e duplicar quebraria o texto.

A única string com aspas é `unison_linkConfirmBody` (`better_lyrics_messages_en.json:2438` /
`better_lyrics_messages_pt_BR.json:2490`), e a tradução preserva os dois pares:

```json
"message": "\"$video$\" não tem exatamente o mesmo título que \"$song$\". Verifique se é a mesma gravação antes de vincular, pois remixes, versões ao vivo ou aceleradas geralmente precisam de suas próprias letras."
```

---

## 4. 🔄 Como a entrega chega ao repositório

1. A string é traduzida **no editor do Crowdin** (projeto 863186, idioma `pt-BR`) —
   `CONTRIBUTING.md:146-148`.
2. O bot do Crowdin abre um PR automático com o título definido em `crowdin.yml:2`:
   `chore(i18n): sync translations`, com as labels `i18n` e `crowdin` (`:3-5`).
3. O PR roda as checagens da seção 5 e é mergeado no `master`.

**Histórico recente** (`gh pr list` em 02/11/2026): [#975](https://github.com/better-lyrics/better-lyrics/pull/975), [#994](https://github.com/better-lyrics/better-lyrics/pull/994), [#1001](https://github.com/better-lyrics/better-lyrics/pull/1001) e [#1010](https://github.com/better-lyrics/better-lyrics/pull/1010) mergeados; **[#1019](https://github.com/better-lyrics/better-lyrics/pull/1019)
aberto** em 20/10/2026, com última atualização em 21/10/2026.

**Estado das chaves em 02/11/2026:**

| Arquivo | Chaves |
| :--- | ---: |
| `master` — `_locales/en/messages.json` | **643** |
| `master` — `_locales/pt_BR/messages.json` | **637** |
| PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) — `_locales/pt_BR/messages.json` | **638** |
| Snapshot do hub (EN e PT) | **638** |

Ou seja: mergear o [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) leva o `pt_BR` a 638 e ainda faltam **5** chaves novas, todas ausentes do
[#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) e, portanto, ainda fora do `pt_BR`:

- `options_provider_spicylyrics` = `Spicy Lyrics`
- `lyrics_syncedBy` = `Synced by`
- `lyrics_syncedAndUploadedBy` = `Synced and uploaded by`
- `unison_detectedFromLyrics` = `Lyrics have`
- `unison_detectedUse` = `Use`

Essas 5 **não podem ser entregues por PR manual**: o texto tem de nascer no Crowdin, senão o próximo
sync do bot sobrescreve. O caminho é esperar a fonte chegar à plataforma e traduzir lá.

Além dessas 5, o `master` não tem `options_display_fullscreenControlsTooltipStates`; o PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) a
carrega em inglês. Por isso o `master` tem 637 chaves e não 638: **faltam 6**, não 5.

> **Números antigos deste hub, corrigidos aqui:** o `research/README.md` registra "Crowdin 638 ×
> upstream 640", medição de 26/10/2026. Em 02/11/2026 o upstream está em 643 e o `master` em 637 —
> o número mudou porque o upstream continua trabalhando. O README deste projeto já foi atualizado
> para 643/637 e 6 chaves ausentes no `master`.

---

## 5. 🧪 As checagens do projeto

O upstream tem três verificadores próprios em `tooling/`, rodados pelo CI dele. **Eles não rodam
neste hub** — sem clone, não há checkout. Conhecê-los serve para saber o que o PR do bot vai reprovar.

### 5.1. `check-i18n-format.ts` — placeholders e mensagens vazias

- Extrai as variáveis de cada `message` com a regex `\$([A-Za-z0-9_]+)\$` (`:13`).
- Reprova **tradução vazia** quando a fonte não é vazia (`:16`).
- Reprova **placeholder desconhecido** — variável no pt-BR que não existe no EN (`:20`).
- Reprova `{nome}` escrito no lugar de `$NOME$` (`:22-24`).
- Percorre **todos** os locales, não só o `pt_BR` (`:28-39`).

### 5.2. `check-i18n-brand.ts` — nomes que não se traduzem

A lista é curta e explícita (`:14`): `Better Lyrics`, `Unison`, `Portato`, `Legato`, `boidu.dev`. Se a
fonte contém o termo e a tradução não, o CI falha. Marcas de terceiro ficam **fora** da lista de
propósito (`:11-13`) — o projeto aceita que sejam transliteradas; o glossário do hub é que decide
mantê-las.

### 5.3. `check-i18n-stale.ts` — inglês velho esquecido

Compara cada tradução com o **histórico do EN** (`:12-25`): se o texto do pt-BR é igual a uma versão
**antiga** do inglês, a chave ficou para trás e o CI falha (`:107-125`). A correção recomendada pelo
próprio script é rodar o workflow de limpeza do Crowdin, não editar o arquivo à mão.

### 5.4. Onde cada uma roda

`.github/workflows/i18n-brand-check.yml`:

| Passo | Linha | Quando |
| :--- | :--- | :--- |
| `check-i18n-brand.ts` | `:38` | todo PR que toca `_locales/` |
| `check-i18n-format.ts` | `:42` | todo PR que toca `_locales/` |
| `check-i18n-stale.ts` | `:67` | só em PR da branch `chore/i18n` ou em execução manual (`:45`) |

---

## 6. 🛠️ O que o hub roda

O hub não compila a extensão. O passo equivalente é o validador, que entende o formato Chrome:

```powershell
./scripts/validate-ptbr.ps1 `
  -Path   BetterLyrics/snapshots/better_lyrics_messages_pt_BR.json `
  -Source BetterLyrics/snapshots/better_lyrics_messages_en.json `
  -Format chrome
```

Resultado de 02/11/2026:

```text
OK   better_lyrics_messages_pt_BR.json  (638 strings, perfil=chrome, escape=none)
     avisos: 28 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

`-Format chrome` é o perfil que lê `{ "message": ... }` e extrai `$VAR$`
(`scripts/validate-ptbr.ps1:114`).

**Sobre os 28 avisos:** são strings idênticas ao EN. Contei **29** — a diferença de 1 é
`options_general_segment`, cujo texto é `$LABEL$: $VALUE$`, sem nenhuma palavra; o aviso do validador
só dispara quando a fonte tem uma sequência de 4+ letras (`scripts/validate-ptbr.ps1:176`). As 29 são
marca, sigla, nome de formato ou string composta só de placeholders — nenhuma é frase esquecida em
inglês.

> **Cuidado:** o validador compara o snapshot com o EN **do snapshot**. Snapshot velho, resultado
> velho. A atualização é a seção 6.2.

### 6.1. O que o `crowdin-sync.ps1 -Action Check` **não** vê neste projeto

O `crowdin-sync.ps1 -Action Check` audita placeholders e blocos ICU, mas a função que extrai tokens
(`scripts/crowdin-sync.ps1:129-138`) reconhece `{{var}}`, `%s`, `{var}`, `${...}` e tags HTML —
**`$NOME$` não está na lista**. Testei a função com `Instalado $NAME$ de $SOURCE$` e ela devolve
conjunto vazio: para este projeto o `Check` reporta 0 divergências mesmo que um `$NAME$` tenha sido
apagado.

Para Better Lyrics, a conferência de placeholder é o validador da seção 6 ou o
`check-i18n-format.ts` do CI do upstream. O `Check` continua útil para cobertura e strings pendentes.

### 6.2. Como atualizar os snapshots (sem clone)

**EN — o espelho fixo.** Só muda quando a tradução é refeita contra uma fonte nova, não a cada sync.
Baixa o arquivo cru, sem reformatar:

```powershell
curl.exe -sL "https://raw.githubusercontent.com/better-lyrics/better-lyrics/master/_locales/en/messages.json" `
  -o BetterLyrics/snapshots/better_lyrics_messages_en.json
```

**pt-BR — o que a extensão entrega.** O conteúdo é o que o bot do Crowdin escreveu. Antes do merge do
PR, baixe da cabeça do PR; depois do merge, do `master`:

```powershell
# antes do merge (troque 1019 pelo PR de sync aberto)
curl.exe -sL "https://raw.githubusercontent.com/better-lyrics/better-lyrics/refs/pull/1019/head/_locales/pt_BR/messages.json" `
  -o BetterLyrics/snapshots/better_lyrics_messages_pt_BR.json

# depois do merge
curl.exe -sL "https://raw.githubusercontent.com/better-lyrics/better-lyrics/master/_locales/pt_BR/messages.json" `
  -o BetterLyrics/snapshots/better_lyrics_messages_pt_BR.json
```

O `curl.exe` grava os bytes como vêm. `Set-Content` e `>` não servem: eles trocam o fim de linha para
CRLF e o arquivo deixa de bater com o do upstream.

**Cobertura no Crowdin.** Precisa de token:

```powershell
./scripts/crowdin-sync.ps1 -Action Status -ProjectId 863186
```

---

## 7. 📱 Espaço de tela (etapa 3 em detalhe)

1. **Popup do navegador:** cabe pouco. Rótulo de 1 a 2 palavras.
2. **Página de opções:** o grosso do catálogo. Item de menu curto; o texto explicativo vai no
   `*Hint`/`*Body`/`*Footer`, que é onde há espaço.
3. **Sobreposição de letras e Picture-in-Picture:** o texto disputa espaço com a arte do álbum e os
   controles do player. Prefira o termo mais curto que ainda seja claro.
4. **Badge e chip:** etiqueta pequena. `unison_syncRichsync`, `unison_syncLinesync` e
   `unison_syncPlain` são o mesmo texto do badge e do filtro — uma frase longa quebra o card.
5. **Tooltip e rótulo acessível:** o mesmo texto é lido em voz alta. "Ajustar à janela" funciona
   sozinho; "Ajustar" não.

---

## 8. ✅ Checklist antes de enviar ao Crowdin

Cada item pertence a uma etapa do método.

**Etapas 1 e 2 — origem**
- [ ] Li a chave e sei em que tela/área o texto aparece (prefixo da seção 1.1)?
- [ ] Traduzi a partir da fonte EN do Crowdin, não de `pt_PT`/`es`/`de`/`fr`?
- [ ] Li o `description` da chave antes de escrever?

**Etapas 3 e 4 — texto**
- [ ] A frase cabe no componente (popup, badge, tooltip, PiP)?
- [ ] Se o EN é uma palavra, o pt-BR também é — ou a exceção está justificada?
- [ ] Sentence Case aplicado; nomes próprios e siglas preservados conforme o glossário?
- [ ] Português do Brasil, sem termo de Portugal e sem construção literal do inglês?

**Etapa 5 — regras**
- [ ] Só o `message` mudou? `description` e `placeholders` estão idênticos ao EN?
- [ ] Toda variável `$NOME$` do EN aparece no pt-BR, na mesma grafia, e nenhuma sobrando?
- [ ] Par singular/plural conferido nas duas chaves (seção 3.3)?
- [ ] Aspas duplas escapadas como `\"`?
- [ ] `validate-ptbr.ps1 -Format chrome` retornando `OK`?
- [ ] Snapshot do hub atualizado (seção 6.2) depois da mudança?

---

## 9. ⚠️ Lacunas conhecidas

Coisas que este documento **não** resolve, com o que falta para resolver:

1. **6 chaves ausentes no `master`.** São 5 novas + `options_display_fullscreenControlsTooltipStates`;
   o [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) leva o `pt_BR` a 638, mas mantém essa chave em inglês (seção 4). Falta: o sync e a tradução
   da chave no Crowdin.
2. **Estado do Crowdin não reverificado.** `crowdin-sync.ps1 -Action Status` exige `CROWDIN_TOKEN`
   (`scripts/crowdin-sync.ps1:67`) e não há token nesta sessão — a última medição local é de
   30/10/2026 (638/638). Falta: rodar `Status` com token para confirmar cobertura e pendências.
3. **21 chaves contrariam a regra "uma palavra por uma palavra"** (`CONTRIBUTING.md:156`). Algumas são
   inevitáveis (*Retry* → *Tentar novamente*); outras são rótulo de ordenação que poderia ser mais
   curto (*Most-Voted* → *Mais votados*). Falta: decidir quais encurtar.
4. **Nomes de tipo de sincronização em aberto.** `Richsync` virou `Sincronização rica`, `Linesync`
   virou `Sincronização por linhas` e `Plain` virou `Sem sincronização` — mas o mesmo texto é badge
   (seção 7). Os formatos vizinhos (`LRC`, `TTML`) ficaram em inglês. Falta: registrar no
   [`glossario.md`](./glossario.md) se tipo de sincronização é termo de domínio (mantém) ou
   descrição (traduz).
5. **As checagens do projeto não rodam aqui.** Sem clone, `check-i18n-format`, `check-i18n-brand` e
   `check-i18n-stale` só executam no CI do upstream. Falta: um jeito de rodá-las sem checkout (ou
   aceitar que o CI cobre).
6. **Nada foi aberto no navegador.** O hub não instala a extensão. Nenhuma regra da seção 7 foi
   verificada em popup, página de opções ou PiP reais. Falta: carregar a extensão em modo desenvolvedor
   e olhar as telas.
7. **O snapshot está 5 chaves atrás do EN.** O snapshot tem 638, o `master` tem 643 — de propósito,
   porque o espelho é fixo (seção 1.2). Falta: reexportar depois do próximo sync.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 638 chaves em EN e PT; 0 faltando, 0 sobrando | contagem em `BetterLyrics/snapshots/*.json` em 02/11/2026 |
| 74 chaves com `placeholders`, 42 nomes distintos | regex `\$([A-Za-z0-9_]+)\$` sobre `better_lyrics_messages_en.json` |
| 0 divergências de placeholder e de bloco `placeholders` | comparação chave a chave EN × PT |
| 29 strings idênticas ao EN (28 avisos) | comparação EN × PT; aviso em `validate-ptbr.ps1:176` |
| 0 `description` traduzida | comparação do campo nas 638 chaves |
| 1 chave com aspas duplas; 2 com `%`; 0 com `\n`, HTML ou emoji | varredura de `better_lyrics_messages_en.json` |
| Distribuição por prefixo (221/208/104/28/20/14/9/8/7/7/4/3) | `Object.keys` sobre o snapshot EN |
| 4 pares singular/plural | chaves `*Singular`/`*Plural`/`*One`/`*Others` no catálogo |
| 21 chaves com EN de 1 palavra e PT com 2+ | contagem de palavras depois de remover `$NOME$` |
| 24 pastas de locale no upstream | API do GitHub: `contents/_locales` |
| `pt-BR` → `pt_BR` | `crowdin.yml:14` (lido no `master` em 02/11/2026) |
| 643 EN / 637 PT no `master`; 638 no PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) | API do GitHub em 02/11/2026 (`contents?ref=master`, `?ref=refs/pull/1019/head`) |
| 5 chaves novas sem tradução | diferença de chaves `master` EN × PR [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) PT |
| HEAD do `master` = `f77dcc2` (02/11/2026) | `gh api repos/better-lyrics/better-lyrics/commits/master` |
| Clone removido: 7,9 MB, `99c9ea6`, 0 commits locais | `Measure-Object` e `git log` antes da remoção, em 02/11/2026 |
| PRs [#975](https://github.com/better-lyrics/better-lyrics/pull/975)/[#994](https://github.com/better-lyrics/better-lyrics/pull/994)/[#1001](https://github.com/better-lyrics/better-lyrics/pull/1001)/[#1010](https://github.com/better-lyrics/better-lyrics/pull/1010) mergeados, [#1019](https://github.com/better-lyrics/better-lyrics/pull/1019) aberto | `gh pr list --search "i18n in:title" --state all` |
| Checagens e linhas de CI | `.github/workflows/i18n-brand-check.yml:38`, `:42`, `:45`, `:67` |
| Termos protegidos | `tooling/check-i18n-brand.ts:14` |
| Regex de placeholder | `tooling/check-i18n-format.ts:13` |
| Substituição em tempo de execução | `src/core/i18n.ts:77-82`, `:93` |
| `$NOME$` invisível ao `Check` do hub | `scripts/crowdin-sync.ps1:129-138`; teste com `Instalado $NAME$ de $SOURCE$` devolveu conjunto vazio |
| Saída do validador do hub | `./scripts/validate-ptbr.ps1 -Format chrome` em 02/11/2026 |
| Clone só onde há entrega por PR | [`organizacao-dos-repositorios.md`](../organizacao-dos-repositorios.md) §2 |
