# 📘 Diretrizes Técnicas de Localização — Nuvio Mobile

> **O que é este documento:** o método de tradução do Nuvio Mobile aplicado às regras que só valem
> nele. Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem [`README.md`](./README.md)
> (o status).
>
> **Contra o que foi escrito:** clone em `NuvioMobile/repo`, branch `cmp-rewrite`, commit `46febb5`
> (01/11/2026), e os snapshots em `NuvioMobile/snapshots/`. Contagens e validação medidas em
> **02/11/2026**.
>
> **O que ele não cobre:** compilar o app, testar em aparelho e julgar fluência — ver seção 7.

---

## 1. 🔁 O método: cinco etapas, sempre na mesma ordem

Toda string segue esta ordem, sem pular etapa:

1. **Ler a chave interna**
2. **Ler a string em inglês**
3. **Entender o que o usuário vê**
4. **Escrever em pt-BR**
5. **Conferir contra as regras do projeto**

Pular a etapa 1 produz tradução genérica para outro contexto. Pular a 3 produz frase correta que não
cabe na tela. Pular a 5 produz texto bonito que quebra o build.

### 1.1. Etapa 1 — Ler a chave interna

A chave é o identificador no XML (`<string name="settings_playback_render_scale">`). O prefixo costuma
entregar a tela:

| Prefixo | Onde vive |
| :--- | :--- |
| `settings_` | telas de configurações (player, legendas, aparência, MDBList) |
| `party_` | Watch Party — sessão em grupo, sincronia e chat |
| `server_` / `servers_` | servidores remotos e teste de latência |
| `mdb_` / `mdblist_` | integração MDBList, filtros e avaliações |
| `autosync_` | sincronização automática de legendas |
| `pip_` | Picture-in-Picture e mini-player |
| `details_` / `entity_` | ficha de filme/série e catálogo |

O prefixo não substitui o arquivo: `strings_party.xml` e `strings_servers.xml` são catálogos separados
do `strings.xml`, e uma chave com o mesmo `name` em dois arquivos **quebra a compilação** (seção 3.1).

### 1.2. Etapa 2 — Ler a string em inglês

A fonte é o catálogo EN **do mesmo módulo**:

- `composeApp/src/commonMain/composeResources/values/strings.xml`
- `.../values/strings_party.xml`, `strings_servers.xml`, `strings_mdblist.xml`, `strings_pip.xml`,
  `autosync_strings.xml`, `autosync_toast_strings.xml`

O projeto tem 20 pastas de locale no módulo principal, e **nenhuma delas serve de origem** — nem `es`,
nem `pt` (que pode ser português europeu). Uma tradução de terceiro pode ter erro, e o erro se propaga
sem aparecer.

### 1.3. Etapa 3 — Entender o que o usuário vê

- **Botão ou ação:** verbo no imperativo, curto (*"Reproduzir"*, *"Tentar novamente"*).
- **Configuração:** rótulo curto + descrição em chave separada (`*_description`).
- **Aviso e erro:** o que aconteceu e o que fazer; muitas vezes vira `Toast` ou notificação.
- **Android Auto / PiP:** espaço mínimo; o texto aparece sobre o vídeo ou no painel do carro.
- **Watch Party:** o mesmo texto é lido por vários participantes; nomes de estado precisam ser
  inequívocos (*"Em sincronia"*, *"Sincronizando"*).

### 1.4. Etapa 4 — Escrever em pt-BR

Português do Brasil, natural e não literal:

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| definições | **configurações** |

Use **Sentence Case** — só a primeira letra maiúscula (*"Adicionar à minha lista"*, não *"Adicionar À
Minha Lista"*). Nome próprio e sigla mantêm a grafia.

O vocabulário vem do [`glossario.md`](./glossario.md). O que **não** se traduz:
`Nuvio` · `Stremio` · `Addon` · `Debrid` · `Real-Debrid` / `AllDebrid` / `Premiumize` / `TorBox` ·
`Trakt` / `Simkl` / `MDBList` / `TMDB` / `IMDb` · `HLS` / `DASH` · `MPV` · `Picture-in-Picture (PiP)`.

### 1.5. Etapa 5 — Conferir contra as regras do projeto

Três barreiras, nesta ordem:

1. **O XML** — chaves, placeholders, plurais e tags (seção 3).
2. **O validador** — `scripts/validate-ptbr.ps1` contra o EN do clone (seção 4).
3. **O build do upstream** — o job `Build fullDebug APK` roda em todo PR (seção 5).

### 1.6. O método aplicado a uma string real

`settings_playback_render_scale`:

1. **Chave:** `settings_playback_render_scale` → configurações de reprodução, resolução das legendas.
2. **EN:** `Subtitle Render Resolution` (`values/strings.xml:1156`), com a descrição em
   `settings_playback_render_scale_description:1157`.
3. **O que o usuário vê:** um rótulo de configuração e uma linha de ajuda logo abaixo; não é botão.
4. **pt-BR:** `Resolução de renderização das legendas` (`values-pt-rBR/strings.xml:1163`).
5. **Regras:** sem placeholder, chave presente nos dois lados, `validate-ptbr.ps1` retorna `OK`.

---

## 2. 🗂️ Onde a tradução vive

| Arquivo | Fonte EN | Tradução pt-BR | Entradas |
| :--- | :--- | :--- | ---: |
| Principal | `values/strings.xml` | `values-pt-rBR/strings.xml` | 2.496 |
| Watch Party | `values/strings_party.xml` | `values-pt-rBR/strings_party.xml` | 84 |
| Servidores | `values/strings_servers.xml` | `values-pt-rBR/strings_servers.xml` | 60 |
| MDBList | `values/strings_mdblist.xml` | `values-pt-rBR/strings_mdblist.xml` | 52 |
| PiP | `values/strings_pip.xml` | `values-pt-rBR/strings_pip.xml` | 1 |
| AutoSync | `values/autosync_strings.xml` | `values-pt-rBR/autosync_strings.xml` | 10 |
| AutoSync toast | `values/autosync_toast_strings.xml` | `values-pt-rBR/autosync_toast_strings.xml` | 4 |
| **Total** | | | **2.707** |

A contagem de 2.496 no principal inclui 2.488 `<string>` e 4 blocos `<plurals>` (8 formas). O
validador conta cada forma de plural como uma unidade.

O snapshot versionado em [`snapshots/`](./snapshots/) é cópia dos sete catálogos. Quem entrega é a
branch, via PR; o snapshot sobrevive se a branch for fechada ou rebaseada.

---

## 3. 🧩 O formato: Compose Multiplatform, não Android nativo

### 3.1. Escopo global de símbolos

O compilador Kotlin gera uma classe estática única para todos os arquivos XML. Duas strings com o
mesmo `name` em arquivos diferentes causam **símbolo duplicado** e falham a compilação. O atributo
`name` nunca é traduzido, renomeado ou reformatado.

A tag raiz é `<resources>`, sem `xmlns:android` — o formato é multiplataforma (Android e iOS).

### 3.2. Escapes: o Nuvio **não** usa escape Android

Esta é a diferença que mais gera falso positivo. Em Compose Resources, apóstrofo e aspas dentro do
texto são literais; o catálogo EN tem 31 apóstrofos e apenas 2 aspas escapadas.

- ✅ `Excluir "%1$s"? Isso não pode ser desfeito.`
- ✅ `Séries colocadas nas listas 'Em espera'…`
- ❌ `Excluir \"%1$s\"?` — escape desnecessário, aparece com barra na tela.

Por isso a validação correta é `-Escape none`. Rodar `-Escape android` neste projeto reporta 11
"erros" que são falsos positivos (medido em 02/11/2026).

`&` continua sendo entidade XML: `&amp;`. `<` e `>` só viram tag quando formam marcação permitida.

### 3.3. Porcentagem literal

Quando a string tem argumento de formatação **e** exibe `%` literal, duplique: `100%%`. Sem argumento,
`%` solto é válido.

### 3.4. Placeholders posicionais

**Placeholder** é o buraco preenchido em tempo de execução (`%1$s` = primeiro argumento de texto,
`%2$d` = segundo argumento inteiro). Use sempre a forma com índice:

```xml
<string name="server_log">Falha no servidor %1$s às %2$s</string>
```

Copie o placeholder da fonte e confira **quantidade** e **índice**. Traduzir não autoriza trocar
`%1$s` por `%s` nem mudar a ordem dos índices.

### 3.5. Plurais

No CLDR, o português tem `one`, `many` e `other`. Os 4 blocos atuais usam só `one` e `other`; `many`
cobre milhões exatos e cai em `other` quando ausente. Se um bloco novo for criado, prefira as três
formas.

```xml
<plurals name="details_season_count">
    <item quantity="one">%1$d Temporada</item>
    <item quantity="other">%1$d Temporadas</item>
</plurals>
```

### 3.6. Tags HTML inline

Tags permitidas: `<b>`, `<i>`, `<u>`, `<br/>`. Toda tag aberta precisa fechar, e o espaço fora da tag
é significativo:

- ❌ `<b>%1$s</b>episódios`
- ✅ `<b>%1$s</b> episódios`

---

## 4. 🧪 Validação no hub

O hub não compila o app. O passo equivalente é o validador, rodado contra o EN do clone:

```powershell
./scripts/validate-ptbr.ps1 `
  -Path   NuvioMobile/snapshots/NuvioMobile_strings_pt_BR.xml `
  -Source NuvioMobile/repo/composeApp/src/commonMain/composeResources/values/strings.xml `
  -Format xml
```

Resultado de 02/11/2026:

```text
OK   NuvioMobile_strings_pt_BR.xml  (2496 strings, perfil=xml, escape=none)
     avisos: 111 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

Os 111 avisos são marca, sigla, nome de formato ou string composta só de placeholders. Nenhum é frase
esquecida em inglês.

> **Cuidado:** o validador compara o snapshot com o EN **do clone**. Clone velho, resultado velho.
> Rode `git -C NuvioMobile/repo fetch upstream` antes de confiar no número.

---

## 5. 🤖 CI/CD do upstream

Todo PR passa por dois jobs:

1. **`PR Template Check`** — o corpo precisa conter `### Type of change` e `- [x] Localization`.
2. **`Build fullDebug APK`** — roda `./gradlew assembleFullDebug`; erro de XML, chave duplicada ou
   encoding quebra o job.

O job de build pode falhar por erro **pré-existente na base**. Antes de atribuir a falha à tradução,
leia o log e confira se o erro está numa linha que a PR não tocou (foi o caso de
`Unresolved reference 'updateAssMargins'` em `PlayerEngine.android.kt` no #2435).

---

## 6. 📱 Espaço de tela

1. **Botões e abas:** 1 a 3 palavras. O português é 20–30% mais longo que o inglês.
2. **Configurações:** o rótulo é curto; a explicação vai na chave `*_description`.
3. **PiP e Android Auto:** o texto divide espaço com vídeo e controles. Prefira o termo mais curto que
   ainda seja claro.
4. **Notificação e toast:** aparece fora do app, muitas vezes truncado. Frase direta.

---

## 7. ✅ Checklist antes de abrir/atualizar a PR

**Etapas 1 e 2 — origem**
- [ ] Li a chave e sei em que tela/arquivo o texto aparece?
- [ ] Traduzi a partir do EN do **mesmo módulo**, não de `es`/`pt`/`fr`?

**Etapas 3 e 4 — texto**
- [ ] A frase cabe no componente (botão, configuração, PiP, Android Auto)?
- [ ] Sentence Case aplicado; nomes próprios e siglas preservados?
- [ ] Português do Brasil, sem termo de Portugal e sem construção literal?

**Etapa 5 — regras**
- [ ] Paridade de chaves nos 7 arquivos, sem chave sobrando nem faltando?
- [ ] Placeholders com a mesma quantidade e os mesmos índices da fonte?
- [ ] `%%` em toda string formatada que exibe `%` literal?
- [ ] Nenhum escape Android (`\'`, `\"`) introduzido no XML do CMP?
- [ ] `validate-ptbr.ps1 -Escape none` retornando `OK`, contra um clone atualizado?
- [ ] Snapshot do hub atualizado em [`snapshots/`](./snapshots/)?

---

## 8. ⚠️ Lacunas conhecidas

1. **Sem teste em aparelho.** O hub não compila nem instala o app; nenhuma regra da seção 6 foi
   verificada em Android Auto, PiP ou tela pequena.
2. **Plurais sem `many`.** Os 4 blocos usam só `one` e `other`; o efeito para milhões exatos não foi
   medido.
3. **Build da base instável.** O job `Build fullDebug APK` já falhou por erro que não era da tradução.
   Falta: registrar o erro da base e decidir entre esperar a correção ou rebasear.
4. **Validação com `-Escape android` é ruído.** O projeto usa Compose Resources; a documentação antiga
   pedia escape Android e produzia 11 falsos positivos. Corrigido aqui.
5. **Snapshot e clone podem divergir.** O snapshot é cópia do commit traduzido; se o upstream avançar,
   o validador continua verde contra o EN velho.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 2.496 entradas no principal | `validate-ptbr.ps1` em 02/11/2026 (2.488 strings + 8 formas de plural) |
| 2.707 entradas no total | soma dos 7 arquivos: 2.496 + 84 + 60 + 52 + 1 + 10 + 4 |
| `OK`, 111 avisos | `validate-ptbr.ps1 -Escape none` em 02/11/2026 |
| 11 falsos positivos com `-Escape android` | mesma execução, com a flag Android |
| 31 apóstrofos e 2 aspas escapadas no EN | varredura de `values/strings.xml` em 02/11/2026 |
| Branch e commit | `git -C NuvioMobile/repo branch --show-current` e `git log -1` em 02/11/2026 |
| PRs e release | `gh pr view` e `gh release view` em 02/11/2026 |
