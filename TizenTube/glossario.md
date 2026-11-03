# 📗 Glossário de termos — TizenTube & TizenTube Cobalt

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la em JSON**. Status do projeto em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** snapshot
> [`snapshots/tizentube_pt_BR.json`](./snapshots/tizentube_pt_BR.json) e o `en.json` do clone,
> conferidos em **02/11/2026**. As citações são de **chave**, não de linha.
>
> **Como usar:** procure o termo, confira a chave citada e escreva igual. Se o termo não estiver aqui,
> decida com a regra da seção 1 e acrescente a linha **no mesmo commit** da string nova.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É nome próprio, marca, produto, protocolo ou sigla?**
   Fica em inglês. `TizenTube`, `SponsorBlock`, `DeArrow`, `AFR`.
2. **É termo que o brasileiro já usa em inglês no dia a dia?**
   Fica. `Shorts`, `Player`, `Codec`.
3. **É palavra comum com equivalente natural em pt-BR?**
   Traduz. `queue` ➔ **fila**; `screen off` ➔ **desligar tela**; `watch later` ➔ **assistir mais
   tarde**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale nas duas plataformas (Tizen e Cobalt) e em
todas as telas.

---

## 2. 🚫 Fica em inglês

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| TizenTube / TizenTube Cobalt | nome exato | nome do app |
| YouTube / YouTube Music | `YouTube` / `YouTube Music` | menus e login |
| SponsorBlock | `SponsorBlock` | `settings.options.sponsorblock` |
| DeArrow | `DeArrow` | títulos e miniaturas |
| Shorts | `Shorts` | menu lateral |
| AFR | `AFR` | taxa de quadros automática |
| Picture-in-Picture (PiP) | `Picture-in-Picture (PiP)` | janela sobreposta |
| Codec | `Codec` | menu de vídeo |
| Mini Player | `Mini Player` | player minimizado |
| GitHub Sponsors | `GitHub Sponsors` | redes sociais |

---

## 3. ✅ Traduz-se

### 3.1. Navegação

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Back | `Voltar` | `common.back` |
| Home | `Início` | menu lateral |
| Subscriptions | `Inscrições` | menu lateral |
| Library | `Biblioteca` | menu lateral |
| Watch Later | `Assistir mais tarde` | menu lateral |
| Queue / Queued videos | `Fila` / `Vídeos na fila` | player |
| Screen off | `Desligar tela` | menu do player |

### 3.2. SponsorBlock e DeArrow

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Sponsored segment | `Segmento patrocinado` | `settings.options.sponsorblock` |
| Intro / Outro | `Introdução` / `Encerramento` | categorias |
| Interaction reminder | `Lembrete de interação` | categorias |
| Self-promotion | `Autopromoção` | categorias |
| Recap or preview | `Resumo ou prévia` | categorias |
| Tangents / Jokes | `Assuntos paralelos` / `Piadas` | categorias |
| Highlight | `Destaque` | categorias |

### 3.3. Vídeo e performance

| Inglês | pt-BR | Chave de exemplo |
| :--- | :--- | :--- |
| Auto frame rate (AFR) | `Taxa de quadros automática (AFR)` | configurações |
| Fix stuttering | `Corrigir engasgos` | configurações |
| Playback speed | `Velocidade de reprodução` | `videoMenu` |
| Chapters | `Capítulos` | `videoMenu` |
| Update available | `Atualização disponível` | avisos do Cobalt |

---

## 4. ⚠️ Decisões que não são óbvias

### 4.1. `selecione`, não `clique`

A interface é operada por controle remoto. "Clique" descreve mouse; "selecione" descreve o D-Pad. Vale
para botões, menus e itens de lista.

### 4.2. `Inscrições`, não `Assinaturas`

É o termo que o YouTube usa em pt-BR. `Assinaturas` sugere plano pago e confunde.

### 4.3. `Shorts` fica

É o nome oficial do formato. Traduzir para "Curtos" quebra o paralelo com o YouTube e com o resto do
ecossistema.

### 4.4. `AFR` fica, com expansão na primeira aparição

`Taxa de quadros automática (AFR)` explica a sigla uma vez; depois, só `AFR`. O usuário de TV
reconhece a sigla pelo menu do YouTube.

### 4.5. `Screen off` é `Desligar tela`, não `Tela desligada`

É uma **ação** (o vídeo continua tocando com a tela apagada), não um estado. O verbo no infinitivo
deixa isso claro.

### 4.6. `Watch Later` é `Assistir mais tarde`

Padrão do YouTube em pt-BR. Não use "Ver depois" nem "Salvar para depois".

---

## 5. 📱 Onde o termo aparece muda o tamanho

1. **Menu lateral:** 1 a 2 palavras. `Início`, `Inscrições`, `Shorts`.
2. **Configurações:** rótulo curto; a explicação vai na descrição.
3. **Toast:** uma linha, truncada. `Atualização disponível`.
4. **QR Code:** instrução curta, com `{{name}}` no meio.
5. **Menu de vídeo:** sobrepõe o vídeo; prefira `Velocidade`, não `Configurações de velocidade`.

---

## 6. ❓ Ainda não decidido

1. **`Podcasts`.** Ficou em inglês (idêntico ao EN). O YouTube usa "Podcasts" em pt-BR; falta decidir
   se é termo de domínio ou se vira "Podcasts" mesmo — hoje já é.
2. **`Mini Player`.** Ficou em inglês; "Player minimizado" é mais longo. Falta decidir se o espaço do
   canto justifica manter.
3. **`Cobalt`.** É o nome do container; não se traduz. Mas o app é chamado de "TizenTube Cobalt" e
   "Cobalt" no mesmo texto — padronizar quando aparecer um terceiro contexto.

---

## 7. 📌 Como este glossário se mantém honesto

- Toda linha aponta uma **chave** do catálogo. Sem chave, é opinião.
- Termo novo entra **no mesmo commit** da string que o usa.
- Termo que saiu do catálogo sai daqui — o glossário não guarda vocabulário de recurso removido.
- As **4** strings idênticas ao EN são `GitHub Sponsors`, `Podcasts`, `Shorts` e uma URL de
  patrocínio; nenhuma é frase esquecida.
- Contagem e vocabulário são do snapshot de **02/11/2026**.
