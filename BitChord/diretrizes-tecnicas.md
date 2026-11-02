# 📘 Diretrizes Técnicas de Localização — BitChord

> **O que é este documento:** as regras que só valem no BitChord para traduzir a interface para
> Português do Brasil (`pt-BR`). Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem
> [`README.md`](./README.md) (o status).
>
> **Contra o que foi escrito:** clone em `BitChord/repo`, branch `i18n/pt-br-182`, commit `706ccb0`
> (30/10/2026 18:20). Todas as contagens e citações de linha foram medidas em **02/11/2026**.
>
> **O que ele não cobre:** compilar o app, testar em aparelho e julgar fluência. Isso está na
> seção 8.

---

## 1. 🗂️ Onde a tradução vive

O BitChord é um app Kotlin Multiplatform (**KMP** — um mesmo código-fonte gera apps para Android,
Wear OS e outras plataformas). A interface textual fica em três catálogos:

| Módulo | Fonte EN (a referência) | Tradução pt-BR | `<string>` | `<plurals>` | `<string-array>` |
| :--- | :--- | :--- | :---: | :---: | :---: |
| **Android** (`app/`) | `app/src/main/res/values/strings.xml` | `app/src/main/res/values-pt/strings.xml` | 1.112 (de 1.138) | 23 | — |
| **UI multiplataforma** (`sharedUi/`) | `sharedUi/src/commonMain/composeResources/values/strings.xml` | `.../values-pt/strings.xml` | 249 | — | 2 |
| **Wear OS** (`wearos/`) | `wearos/src/main/res/values/strings.xml` | `wearos/src/main/res/values-pt/strings.xml` | 40 | — | — |

O que cada elemento é:

- `<string>` — uma frase ou rótulo simples.
- `<plurals>` — a mesma frase em formas de quantidade (`one`, `many`, `other`).
- `<string-array>` — uma lista de frases; cada `<item>` é uma unidade traduzível.

### 1.1. Por que o Android tem 1.138 na fonte e 1.112 na tradução

Das 1.138 strings da fonte, **26** carregam `translatable="false"` — marca que diz "não traduza"
(nome próprio, marca, termo técnico). Exemplo: `search_source_youtube`
(`values/strings.xml:32`). O teste nativo ignora essas chaves dos dois lados
(`LocaleStringsTest.kt:44`), então 1.138 − 26 = **1.112** é o total correto a traduzir.

### 1.2. Não existe módulo Desktop

`git ls-files` não devolve nenhum caminho começando com `desktop/`, e não há
`DesktopStringsTest`. O clone é raso (`--depth 1`), então **não é possível datar a remoção** a partir
dele — só afirmar que, no commit `706ccb0`, o módulo não existe.

### 1.3. O snapshot do hub

O que fica versionado neste repositório é uma cópia em [`snapshots/`](./snapshots/):

- `bitchord_strings_pt_BR.xml` — cópia exata do catálogo `app/`;
- `sharedUi_strings_pt_BR.xml` e `wearos_strings_pt_BR.xml` — cópias dos outros dois módulos.

Quem entrega é a branch, via PR; o snapshot sobrevive se a branch for fechada ou rebaseada.

---

## 2. 🎯 A fonte é sempre o inglês

Traduza do catálogo EN **do mesmo módulo**. O repositório tem 19 pastas de locale no `app/`
(`values-es`, `values-de`, `values-fr`, `values-pl`…), e nenhuma delas serve de origem.

**Por quê:** uma tradução de terceiro pode ter erro, termo regional ou omissão — e o erro se propaga
sem aparecer. O inglês é o único texto que o mantenedor revisa. Uma string já traduzida no upstream
só pode ser reaproveitada depois de conferida contra o EN; se não bater, retraduza.

### 2.1. Português do Brasil, não de Portugal

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| definições | **configurações** |

Evite construção literal do inglês. *"Tocar agora"* soa natural; *"Reproduzindo neste momento"* não.

### 2.2. O que não se traduz

Nome de app, recurso proprietário, protocolo, codec e unidade ficam como estão. A lista completa
está em [`glossario.md`](./glossario.md); os que mais aparecem:

`BitChord` · `YouTube` / `YouTube Music` · `Dolby Atmos` · `Automix` · `WebDAV` · `SMB` ·
`PCM` / `FLAC` / `AAC` / `Opus` · `DSP` · `LUFS` / `dB` · `Android Auto` · `Wear OS` ·
`Chromecast` / `Google Cast` · `Crossfade` · `addon` / `addons`

O glossário decide a **palavra**; este documento decide **como escrevê-la em XML** (escapes,
placeholders, plurais).

### 2.3. Como conferir a paridade

```powershell
./scripts/validate-ptbr.ps1 -Path BitChord/snapshots/bitchord_strings_pt_BR.xml `
  -Source BitChord/repo/app/src/main/res/values/strings.xml -Format xml -Escape android
```

`-Escape android` liga a checagem de apóstrofo e aspas do XML Android. O resultado de 02/11/2026:

```text
OK   bitchord_strings_pt_BR.xml  (1159 strings, perfil=xml, escape=android)
     avisos: 38 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

As 1.159 "strings" do relatório são **1.112 `<string>` + 47 `<item>` de plural** — o validador conta
cada forma de plural como uma unidade.

> **Cuidado:** o validador compara o snapshot com o EN **do clone**. Se o clone estiver velho, o
> resultado também está. Rode `git -C BitChord/repo fetch upstream` antes de confiar no número.

---

## 3. 🏗️ Por que a pasta é `values-pt` e não `values-pt-rBR`

Arquivo: `shared/src/jvmSharedMain/kotlin/com/music/bitchord/data/LocaleTags.kt`.

- `normalizeAppTag()` (`:23`) reduz qualquer tag **BCP-47** (o padrão de códigos de idioma, como
  `pt-BR` ou `en-US`) ao idioma base: `pt-BR` ➔ `pt`. Também corrige códigos antigos
  (`iw` ➔ `he`, `in` ➔ `id`, `ji` ➔ `yi` — `:39-41`).
- Só o Chinês preserva a escrita (`zh-Hant` / `zh-Hans`, `:13-14`); a região (`zh-TW` / `zh-CN`) é
  usada apenas ao falar com as APIs (`:103-104`).
- **Consequência:** o catálogo tem de ficar em `values-pt`. Um `values-pt-rBR` nunca seria lido,
  porque o app procura pela tag base.
- **Efeito desejado:** qualquer falante de português recebe a interface em português, em vez de cair
  no inglês.

### 3.1. O idioma precisa estar registrado em dois lugares

1. `SUPPORTED_LANGUAGES` em `app/src/main/java/com/music/bitchord/ui/components/AppLanguageDialog.kt:56`
   — é a lista do seletor de idioma; `pt` está na linha 62.
2. `app/src/main/res/xml/locales_config.xml:8` — é o que o Android usa para oferecer o idioma nas
   configurações do sistema.

Registrar em um só dos dois quebra o `LocalizationTest` (seção 5.2).

---

## 4. ⚡ Codificação XML: escapes, placeholders e plurais

### 4.1. Apóstrofo (`'`)

No XML Android, apóstrofo simples precisa ser escapado como `\'`. Em pt-BR preferimos **reescrever a
frase** para não precisar de escape — o catálogo atual tem **0** ocorrências de `\'`.

- ❌ `Your device's own panel`
- ✅ `Painel nativo do seu dispositivo`

### 4.2. Porcentagem literal em string formatada (`%%`)

Quando a string tem argumento de formatação **e** exibe um `%` literal, o `%` precisa ser duplicado:

```xml
<string name="downloads_progress">Downloads • %1$d%%</string>   <!-- values-pt/strings.xml:336 -->
```

A fonte já usa `%%` nesse caso (`values/strings.xml:527`), então a tradução copia a forma. Sem
argumento de formatação, `%` solto é válido: `100% em repetição` (`shelf_100_on_repeat`,
`values-pt/strings.xml:956`).

### 4.3. Placeholders posicionais

**Placeholder** é o buraco que o app preenche em tempo de execução (`%1$s` = primeiro argumento de
texto, `%2$d` = segundo argumento inteiro). Use sempre a forma com índice, porque a ordem das
palavras muda na tradução:

- Inglês: `Playing from %1$s`
- Português: `Reproduzindo de %1$s`

O catálogo usa **180** placeholders posicionais. **Exceção:** `party_queue_full` mantém `%d` porque
a fonte também usa `%d` (`values/strings.xml:606` / `values-pt/strings.xml:1279`); com um único
argumento não há risco de troca de posição.

Copie o placeholder da fonte e confira **quantidade** e **índice**. Traduzir não autoriza mudar
`%1$s` para `%s` nem trocar a ordem dos índices.

### 4.4. Plurais (`one` / `many` / `other`)

**Plural** é a mesma frase em formas de quantidade. No **CLDR** (a base de regras de idioma que o
Android usa), o português tem três categorias: `one`, `many` e `other`. `many` cobre quantidades que
o inglês não distingue — na prática, milhões exatos.

A regra é preencher as três formas; `many` recebe o mesmo texto de `other` quando a frase não muda.
O único bloco que hoje segue a regra por inteiro é o exemplo abaixo:

```xml
<plurals name="uploading_song_count">   <!-- values-pt/strings.xml:14 -->
    <item quantity="one">Enviando %1$d música</item>
    <item quantity="many">Enviando %1$d músicas</item>
    <item quantity="other">Enviando %1$d músicas</item>
</plurals>
```

**Estado medido (02/11/2026):** dos 23 blocos `<plurals>`, **1** tem as três formas; os outros **22**
têm só `one` e `other`. Isso passa no CI porque o `LocaleStringsTest` compara **nomes de chave**, não
formas de quantidade (`LocaleStringsTest.kt:38-48`). O efeito em execução (qual forma o Android
escolhe para 1.000.000) não foi verificado nesta sessão.

### 4.5. Arrays (`<string-array>`)

O `sharedUi` tem dois: `lyrics_intro_lines` (`values-pt/strings.xml:55`) e `lyrics_loading_lines`
(`:69`) — frases curtas exibidas enquanto a letra carrega. Cada `<item>` é uma unidade de tradução,
e a tradução precisa ter **a mesma quantidade de itens** da fonte.

### 4.6. Tags HTML e CDATA

Hoje o catálogo pt-BR tem **0** tags HTML (`<b>`, `<i>`, `<u>`, `<br/>`) e **0** blocos CDATA. Se
uma string nova do EN trouxer marcação, copie a marcação inteira e traduza só o texto entre as tags
— nunca remova, nunca acrescente.

---

## 5. 🧪 Testes nativos e CI

Dois testes rodam em todo PR: o workflow `Check` dispara em `pull_request`
(`.github/workflows/check.yml:6`) e executa `./gradlew testDevDebugUnitTest` (`:46`).

### 5.1. `LocaleStringsTest.kt` — paridade de chaves

`app/src/test/java/com/music/bitchord/LocaleStringsTest.kt`

- Parametrizado por `SUPPORTED_LANGUAGES`, ignorando `en` (`:23`).
- Lê `values/strings.xml`, descarta `translatable="false"` (`:44`) e exige que
  `values-<qualifier>/strings.xml` tenha todas as chaves de `<string>`, `<plurals>` e
  `<string-array>` (`:40`, `:53`, `:72-78`).
- Se faltar chave, falha e lista quais. O motivo está no próprio teste: chave ausente não quebra o
  app, ela cai silenciosamente no inglês no meio da tela.
- **Cobertura:** só o módulo `app` (`resDir = app/src/main/res`, `:25-31`).

### 5.2. `LocalizationTest.kt` — idioma registrado nos dois lugares

`app/src/test/java/com/music/bitchord/LocalizationTest.kt`

- `supportedLanguages_containsVietnamese()` (`:15`) garante que `vi` está na lista.
- `localesConfig_matchesSupportedLanguages()` (`:23`) exige que todo idioma de
  `SUPPORTED_LANGUAGES` exista em `xml/locales_config.xml` (`:50`).

### 5.3. O que os testes não pegam

- `sharedUi/` e `wearos/` não têm teste de paridade — só o validador da seção 2.3.
- Os testes comparam **chaves**, não texto, placeholders nem plurais. Trocar `%1$s` por `%2$s`
  passa no CI.
- Nada verifica se a frase está em português, nem se é fluente.
- O aviso "idêntica à fonte" do validador também é heurística: ele só dispara quando o texto é igual
  ao EN **e** a fonte tem uma sequência de 4+ letras minúsculas (`scripts/validate-ptbr.ps1:176`).
  Uma frase inglesa curta ou capitalizada pode passar sem aviso.

### 5.4. Estado medido em 02/11/2026

| Módulo | Resultado do `validate-ptbr.ps1` |
| :--- | :--- |
| Android | `OK` — 1.159 unidades (1.112 `<string>` + 47 itens de plural); 38 avisos de texto idêntico ao EN |
| Shared UI | `OK` — 249 strings + 2 arrays; 10 avisos |
| Wear OS | `OK` — 40 strings; 2 avisos |

Conferi as 57 chaves com texto idêntico ao EN no `app/` (contagem própria, mais ampla que o aviso do
validador). Todas são nome próprio, marca, termo técnico, unidade, sigla ou string composta só de
placeholders — nenhuma é frase esquecida em inglês.

**O que não foi verificado:** o `LocaleStringsTest` e o `LocalizationTest` não foram executados nesta
sessão (o hub não tem Gradle/JDK configurado para o projeto). A paridade acima é contagem de
arquivo, não resultado de teste.

---

## 6. 📱 Padrões de interface (app, Android Auto e Wear OS)

1. **Android Auto:** mensagens curtas e legíveis em movimento — *"Faça login no YouTube no seu
   celular"* em vez de um parágrafo. O suporte existe em
   `app/src/main/res/xml/automotive_app_desc.xml`.
2. **Wear OS:** tela circular tem espaço mínimo. Rótulo de botão com 1 ou 2 palavras (*"Tocar"*,
   *"Pausar"*, *"A seguir"*, *"No celular"*).
3. **Sentence Case:** só a primeira letra maiúscula (*"Ajuste de atraso da letra"*). Nome próprio e
   sigla mantêm a grafia.

---

## 7. ✅ Checklist antes de abrir/atualizar a PR

- [ ] Traduzi a partir do EN do **mesmo módulo**, não de `es`/`de`/`fr`/`pl`?
- [ ] Paridade nos **3** módulos (`app`, `sharedUi`, `wearos`), sem chave sobrando nem faltando?
- [ ] Placeholders com a mesma quantidade e os mesmos índices da fonte (`%1$s`, `%2$d`, `%d`)?
- [ ] `%%` em toda string formatada que exibe `%` literal?
- [ ] Plurais novos com `one` / `many` / `other` preenchidos?
- [ ] Arrays com a mesma quantidade de `<item>` da fonte?
- [ ] Sentence Case aplicado; nomes próprios e siglas preservados conforme o glossário?
- [ ] `validate-ptbr.ps1` retornando `OK` nos três arquivos, contra um clone atualizado?
- [ ] Snapshot do hub atualizado em [`snapshots/`](./snapshots/)
      (`bitchord_strings_pt_BR.xml`, `sharedUi_strings_pt_BR.xml` e `wearos_strings_pt_BR.xml`)?

---

## 8. ⚠️ Lacunas conhecidas

Coisas que este documento **não** resolve, com o que falta para resolver:

1. **Base da PR.** O `CONTRIBUTING.md:12` pede que o trabalho novo saia da branch da versão ativa,
   não de `main`. A PR #1204 está aberta contra **`main`** (verificado com `gh pr view 1204` em
   02/11/2026: `base=main`, `state=OPEN`, `mergeable=MERGEABLE`). Falta: a decisão do mantenedor
   sobre qual das duas vale — até lá, o documento registra as duas.
2. **Termos técnicos fora do glossário.** O catálogo mantém em inglês `Loudness`, `Replay`,
   `Scrobbling`, `Buffers`, `Bit-exact`, `Playlist`, `Mono`, `Status`, `Online` e `Token`, e o
   [`glossario.md`](./glossario.md) não os cobre. Falta: registrá-los lá para que a decisão não seja
   refeita a cada string.
3. **Módulos sem teste.** `sharedUi/` e `wearos/` dependem do validador local; não há teste de CI
   para eles. Falta: um teste equivalente ao `LocaleStringsTest` nesses módulos (decisão do
   upstream, não do hub).
4. **Reprodução em aparelho.** O hub não compila nem instala o app. Nenhuma regra da seção 6 foi
   verificada em Android Auto ou Wear OS reais. Falta: rodar o build do projeto.
5. **Histórico.** O clone é raso; não dá para datar quando o módulo Desktop foi removido nem
   consultar commits anteriores a `706ccb0` sem baixar mais histórico.
6. **Plurais incompletos.** 22 dos 23 blocos `<plurals>` não têm a forma `many` (seção 4.4). Falta:
   decidir se vale completar as 22 — o CI não acusa, e o efeito em execução não foi medido.
