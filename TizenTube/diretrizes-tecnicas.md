# 📘 Diretrizes Técnicas de Localização — TizenTube & TizenTube Cobalt

> **O que é este documento:** o método de tradução do TizenTube aplicado às regras que só valem nele.
> Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem [`README.md`](./README.md)
> (o status).
>
> **Contra o que foi escrito:** clone em `TizenTube/repo`, branch `i18n/portuguese-complete-pt-br`,
> commit `008f40d` (30/10/2026), e o snapshot `TizenTube/snapshots/tizentube_pt_BR.json`. Contagens
> medidas em **02/11/2026**.
>
> **O que ele não cobre:** instalar na TV, testar com controle remoto e julgar fluência — ver seção 7.

---

## 1. 🔁 O método: cinco etapas, sempre na mesma ordem

1. **Ler a chave interna**
2. **Ler a string em inglês**
3. **Entender o que o usuário vê**
4. **Escrever em pt-BR**
5. **Conferir contra as regras do projeto**

### 1.1. Etapa 1 — Ler a chave interna

O catálogo é um JSON aninhado (`mods/translations/resources/pt-BR.json`). O caminho da chave diz a
área da interface:

| Prefixo / seção | Onde vive |
| :--- | :--- |
| `common` | rótulos reaproveitados (voltar, cancelar, confirmar) |
| `settings.options` | página de configurações do app |
| `settings.options.socialMedia` | QR Code, grupo, site e patrocínio |
| `settings.options.adBlock` | bloqueador de anúncios |
| `settings.options.sponsorblock` | SponsorBlock |
| `player` | controles do player e relógio em tela |
| `videoMenu` | menu de vídeo, capítulos e velocidade |
| `toasts` | avisos voláteis |
| `welcomeMsg` | mensagem de boas-vindas |
| `__contributors` | lista de créditos — **não é string de interface** |

O prefixo não substitui o contexto: a mesma palavra pode aparecer na TV Samsung (Tizen) e no Cobalt
(Android TV), e o espaço é diferente.

### 1.2. Etapa 2 — Ler a string em inglês

A fonte é `mods/translations/resources/en.json` **do mesmo commit**. O repositório tem 31 pastas de
locale (`de`, `es`, `fr`, `ja`, `pt-PT`…), e **nenhuma serve de origem**. A armadilha específica é o
**`pt-PT`**: existe, é português e parece resposta pronta, mas é português de Portugal.

Uma string já traduzida no `pt-BR` só pode ser reaproveitada depois de conferida contra o EN; se não
bater, retraduza.

### 1.3. Etapa 3 — Entender o que o usuário vê

A interface é de **10 pés** (*10-foot UI*), operada por D-Pad:

- **Botão e item de menu:** 1 a 3 palavras; o foco é navegado com as setas.
- **Aviso e toast:** aparece no canto, por poucos segundos, muitas vezes truncado.
- **QR Code:** o texto instrui a apontar a câmera do celular; precisa ser curto e direto.
- **Menu de vídeo:** sobrepõe o vídeo; o texto não pode cobrir os controles.
- **Relógio em tela:** 12h/24h; o formato precisa caber.

Use **"selecione"** e **"pressione"**, não "clique": não há mouse.

### 1.4. Etapa 4 — Escrever em pt-BR

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| definições | **configurações** |

Sentence Case; nome próprio e sigla mantêm a grafia. O vocabulário vem do
[`glossario.md`](./glossario.md). O que **não** se traduz:
`TizenTube` · `TizenTube Cobalt` · `YouTube` · `SponsorBlock` · `DeArrow` · `Shorts` · `AFR` ·
`Picture-in-Picture (PiP)` · `Codec`.

### 1.5. Etapa 5 — Conferir contra as regras do projeto

1. **O JSON** — chaves, `{{placeholders}}`, emojis e encoding (seção 3).
2. **O validador** — `scripts/validate-ptbr.ps1 -Format nested` (seção 4).
3. **O PR** — o CI do upstream e a revisão do mantenedor (seção 5).

### 1.6. O método aplicado a uma string real

`settings.options.socialMedia.qrCodeScanMessage`:

1. **Chave:** `settings.options.socialMedia.qrCodeScanMessage` → QR Code na página de redes sociais.
2. **EN:** `You can access the {{name}} page by scanning the QR code below.`
3. **O que o usuário vê:** uma linha de instrução abaixo do QR Code, na TV; o `{{name}}` vira o nome
   da página.
4. **pt-BR:** `Você pode acessar a página {{name}} escaneando o código QR abaixo.`
5. **Regras:** `{{name}}` preservado, chave presente nos dois lados, `validate-ptbr.ps1` retorna `OK`.

---

## 2. 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Fonte EN** | `TizenTube/repo/mods/translations/resources/en.json` |
| **Tradução pt-BR** | `.../pt-BR.json` |
| **Snapshot do hub** | [`snapshots/tizentube_pt_BR.json`](./snapshots/tizentube_pt_BR.json) |
| **Entrega** | PR no repositório `reisxd/TizenTube` |
| **Branch** | `i18n/portuguese-complete-pt-br` |

O catálogo tem **198 chaves de interface** e **1 entrada de créditos** (`__contributors`), total
**199**. O snapshot é cópia do catálogo; quem entrega é a branch, via PR.

O bundle `@foxreis/tizentube` é consumido por Tizen (Samsung) e Cobalt (Android TV / Google TV /
Fire TV). Uma tradução atende os dois.

---

## 3. 🧩 O formato: JSON aninhado + i18next

### 3.1. Estrutura

- **Codificação:** UTF-8 sem BOM.
- **Indentação:** 2 espaços; não reindente o arquivo inteiro.
- **Aspas:** chaves e valores com aspas duplas; aspas simples internas não precisam de escape.
- **Emojis:** preservar os oficiais (`❤️`, `ℹ️`).

### 3.2. Placeholders `{{nome}}`

O motor é o **i18next**, com chaves duplas. Copie a variável **na mesma grafia** e não acrescente
espaços:

| Placeholder | Exemplo |
| :--- | :--- |
| `{{count}}` | `"{{count}} segundo"` / `"{{count}} minutos"` |
| `{{name}}` | `"Você pode acessar a página {{name}}…"` |
| `{{version}}` | `"Versão atual: {{version}}"` |
| `{{latestVersion}}` / `{{currentVersion}}` | aviso de atualização do Cobalt |
| `{{date}}` | `"Data de lançamento: {{date}}"` |
| `{{segment}}` | `"Pulando {{segment}}"` |

Não há ICU neste projeto. Plural é resolvido por **chaves separadas** (`second`/`seconds`,
`minute`/`minutes`), e cada lado precisa concordar sozinho.

### 3.3. Escapes

O valor é texto cru dentro do JSON:

- Aspas duplas dentro do texto: `\"`.
- Barra invertida literal: `\\`.
- `\n` só se a string precisar de quebra de linha.
- `%` literal não é duplicado — não há printf aqui.

### 3.4. O que não é string de interface

`__contributors` é uma lista de nomes. Não traduza, não reordene e não remova entradas; a inclusão de
Joseph Alves é o crédito oficial da tradução.

---

## 4. 🧪 Validação no hub

```powershell
./scripts/validate-ptbr.ps1 `
  -Path   TizenTube/snapshots/tizentube_pt_BR.json `
  -Source TizenTube/repo/mods/translations/resources/en.json `
  -Format nested
```

Resultado de 02/11/2026:

```text
OK   tizentube_pt_BR.json  (199 strings, perfil=nested, escape=none)
     avisos: 4 string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)
```

As 4 idênticas são `GitHub Sponsors`, `Podcasts`, `Shorts` e uma linha de URL de patrocínio. Nenhuma
é frase esquecida em inglês.

---

## 5. 🚀 Entrega e revisão

O PR [#718](https://github.com/reisxd/TizenTube/pull/718) está aberto contra `main`, com 7 commits e
`mergeState=CLEAN` (02/11/2026). O mantenedor revisa manualmente; não há CI de tradução no upstream.

Antes de atualizar o PR:

- [ ] `git fetch upstream main` e rebase se a base avançou.
- [ ] Rodar o validador da seção 4.
- [ ] Conferir que o snapshot foi atualizado.
- [ ] Reler o corpo do PR (Regra 6 do `AGENTS.md`).

---

## 6. 📱 Espaço de tela

1. **Menu lateral e configurações:** 1 a 3 palavras. `Início`, `Inscrições`, `Filmes e TV`.
2. **Aviso e toast:** uma linha; o texto longo é cortado.
3. **QR Code:** instrução curta, com o nome da página entre `{{ }}`.
4. **Menu de vídeo:** não cobrir os controles; prefira `Velocidade`, não `Configurações de velocidade`.
5. **Relógio em tela:** 12h/24h; o rótulo do formato precisa caber.

---

## 7. ✅ Checklist antes de abrir/atualizar a PR

**Etapas 1 e 2 — origem**
- [ ] Li a chave e sei em que seção/tela o texto aparece?
- [ ] Traduzi a partir do `en.json`, não de `pt-PT`/`es`/`de`?

**Etapas 3 e 4 — texto**
- [ ] A frase cabe no componente (menu, toast, QR, relógio)?
- [ ] Usei "selecione"/"pressione", não "clique"?
- [ ] Sentence Case aplicado; nomes próprios e siglas preservados?

**Etapa 5 — regras**
- [ ] Todas as variáveis `{{nome}}` do EN aparecem no pt-BR, na mesma grafia?
- [ ] Nenhuma chave sobrando ou faltando (198 de interface + `__contributors`)?
- [ ] Emojis e encoding UTF-8 sem BOM preservados?
- [ ] `validate-ptbr.ps1 -Format nested` retornando `OK`?
- [ ] Snapshot do hub atualizado?

---

## 8. ⚠️ Lacunas conhecidas

1. **Sem teste em TV.** O hub não instala o app; nenhuma regra da seção 6 foi verificada em Tizen,
   Android TV ou Fire TV reais.
2. **Sem CI de tradução no upstream.** A validação é local + revisão do mantenedor.
3. **`pt-PT` existe no repositório.** É a armadilha de origem; nunca use como fonte.
4. **Créditos.** `__contributors` é a única entrada que não é interface; trate à parte.
5. **Snapshot e clone podem divergir.** Se o upstream avançar, o validador continua verde contra o EN
   velho.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 198 chaves de interface + 1 crédito = 199 | contagem em `en.json` e `pt-BR.json` em 02/11/2026 |
| `OK`, 4 avisos | `validate-ptbr.ps1 -Format nested` em 02/11/2026 |
| PR #718: aberto, `CLEAN`, 7 commits, base `main` | `gh pr view 718` em 02/11/2026 |
| Branch e commit | `git -C TizenTube/repo branch --show-current` e `git log -1` |
| Release `v2.1.1` (13/09/2026) | `gh release view --repo reisxd/TizenTube` |
