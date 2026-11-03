# 📘 Diretrizes Técnicas de Localização — Crowdin Platform

> **O que é este documento:** o método de tradução da plataforma Crowdin aplicado às regras que só
> valem nela. Não substitui [`glossario.md`](./glossario.md) (o vocabulário) nem
> [`README.md`](./README.md) (o status).
>
> **Contra o que foi escrito:** projeto Crowdin **31**, idioma `pt-BR`, e o snapshot
> `Crowdin/snapshots/crowdin_translations_pt_BR.json` (`en.json`, arquivo 32447, 3.637 strings,
> gerado em 30/10/2026). Contagens de plataforma medidas em **03/11/2026**.
>
> **O que ele não cobre:** navegar a interface do Crowdin, julgar fluência e validar em todos os 214
> arquivos — ver seção 7.

---

## 1. 🔁 O método: cinco etapas, sempre na mesma ordem

1. **Ler a chave interna**
2. **Ler a string em inglês**
3. **Entender o que o usuário vê**
4. **Escrever em pt-BR**
5. **Conferir contra as regras do projeto**

### 1.1. Etapa 1 — Ler a chave interna

A chave diz o módulo e o componente. No `en.json` da interface moderna, o prefixo costuma entregar a
tela:

| Área | Onde vive |
| :--- | :--- |
| Projetos | lista e configuração de projetos |
| Editor | editor de tradução |
| Relatórios | relatórios e estatísticas |
| Configurações | conta e workspace |
| Cobrança | planos e faturas |
| Equipe | membros, papéis e permissões |
| Integrações | apps e conectores |
| Autenticação | login, 2FA e SSO |

Nos arquivos PHP/Blade e CSV, a chave é o próprio texto de origem ou um identificador curto; leia o
contexto do arquivo antes de traduzir. No `en.json`, o snapshot numera as strings por ID, não por nome
de chave — por isso a tabela fala de **área**, não de prefixo.

### 1.2. Etapa 2 — Ler a string em inglês

A fonte é o texto EN exibido no Crowdin (projeto 31). O snapshot local cobre **apenas** o `en.json`;
os outros 213 arquivos vivem na plataforma. Nunca use outro locale como origem — `es`, `de`, `fr` e
`pt-PT` servem, no máximo, como referência terminológica.

### 1.3. Etapa 3 — Entender o que o usuário vê

O Crowdin é uma ferramenta profissional usada por gerentes de projeto, engenheiros e tradutores:

- **Botão e menu:** ação curta no infinitivo/imperativo (*"Remover arquivo"*, *"Calcular estimativa"*).
- **Tabela e coluna:** rótulo curto; o texto explicativo vai em tooltip ou ajuda.
- **E-mail transacional:** frase completa, tom profissional; o `{name}` é o destinatário.
- **Mensagem de erro:** o que falhou e o que fazer; muitas vezes inclui código e link.
- **Interface in-context:** o texto aparece sobre a tela real; espaço apertado.

### 1.4. Etapa 4 — Escrever em pt-BR

| ❌ Portugal | ✅ Brasil |
| :--- | :--- |
| ecrã | **tela** |
| ficheiro | **arquivo** |
| guardar | **salvar** |
| equipa | **equipe** |
| definições | **configurações** |

Tom profissional, direto e sem anglicismo forçado. Sentence Case em rótulos; nomes de produto e siglas
mantêm a grafia. O vocabulário vem do [`glossario.md`](./glossario.md).

### 1.5. Etapa 5 — Conferir contra as regras do projeto

1. **O formato** — placeholders, ICU, HTML e escapes (seção 3).
2. **O validador** — `crowdin-sync.ps1 -Action Check` (seção 4).
3. **A plataforma** — 0 pendentes e 0 divergências no arquivo/projeto (seção 5).

### 1.6. O método aplicado a uma string real

`7046707` (arquivo `en.json`):

1. **Chave:** `7046707` → mensagem de erro de upload, no `en.json`.
2. **EN:** `File "{name}" exceeds the maximum size of 8 MB`.
3. **O que o usuário vê:** um alerta de erro com o nome do arquivo; `{name}` é o arquivo enviado.
4. **pt-BR:** `O arquivo "{name}" excede o tamanho máximo de 8 MB`.
5. **Regras:** `{name}` preservado, aspas mantidas, `Check` sem divergência.

---

## 2. 🗂️ Onde a tradução vive

| Item | Caminho |
| :--- | :--- |
| **Plataforma (fonte de verdade)** | Crowdin, projeto **31**, idioma `pt-BR` |
| **Arquivos** | 214 — `en.json`, `editor.csv`, `dynamic.csv`, `backend.csv`, `frontend.csv`, `auth.php`, `workspace.php`, `scopes.php`, `mfa.php`, e-mails |
| **Snapshot do hub** | [`snapshots/crowdin_translations_pt_BR.json`](./snapshots/crowdin_translations_pt_BR.json) — só `en.json` (arquivo 32447) |
| **Entrega** | submissão direta na plataforma; não há PR de tradução |
| **Clone no hub** | **não existe** — projeto de plataforma |

O snapshot é um recorte: ele guarda 3.637 strings do `en.json`, não os 18.819 do projeto. Cobertura e
pendências dos outros arquivos só são visíveis via API (`-Action Status`).

---

## 3. 🧩 O formato: ICU, chaves e HTML

### 3.1. Placeholders

O Crowdin usa interpolação em chaves simples (`{name}`, `{count}`) na interface moderna, e chaves
duplas ou sintaxe Blade/Jinja em e-mails e páginas de servidor.

| Variável | Exemplo |
| :--- | :--- |
| `{name}` | `O arquivo "{name}" excede o tamanho máximo de 8 MB` |
| `{count}` | `Você pode enviar até {count} arquivos.` |
| `{vendor}` | `Acompanhe gastos por idioma e {vendor}…` |
| `{percent}%` | `Progresso atual: {percent}%` |

Nunca renomeie, remova, duplique ou traduza o identificador. Mantenha a **mesma quantidade** de cada
placeholder.

### 3.2. ICU MessageFormat

Quando a string usa `plural`, `select` ou `selectordinal`:

- Mantenha o argumento e as categorias.
- Não renomeie `{count}` para `{contagem}`.
- `#` dentro de `plural` é o número; preserve.
- Chaves balanceadas.

### 3.3. HTML e escapes

- Preserve tags e atributos (`<b>`, `<a href="…">`, `<br>`).
- Não converta tag em entidade (`&lt;a&gt;`) nem em índice (`<0>`) sem exigência do formato.
- No CSV, aspas duplas dentro do campo são escapadas pelo exportador; não escape à mão.
- No JSON, aspas duplas dentro do texto viram `\"`.

### 3.4. Porcentagem

`{percent}%` é porcentagem literal depois de um placeholder; não duplique. `%%` só existe em strings
de formatação printf, que não é o caso da interface moderna.

---

## 4. 🧪 Validação no hub

```powershell
./scripts/crowdin-sync.ps1 -Action Status -ProjectId 31
./scripts/crowdin-sync.ps1 -Action Check  -ProjectId 31 -Tsv divergencias.tsv
```

- `Status` mostra total, pendentes e uma linha por arquivo.
- `Check` audita placeholders, ICU, chaves e balanceamento; critério: **0 divergências**.

Resultado de 03/11/2026:

```text
Projeto 31 | 18819 strings | 354 pendentes
  31090  backend.en_US.csv  344/4325
  32187  auth.php             6/69
  32219  workspace.php        2/41
  32447  en.json              2/3643
```

O snapshot de `en.json` tem 3.637 strings; o arquivo na plataforma tem 3.643, com 2 pendentes. O
snapshot está **6 strings atrás** e precisa ser refeito depois do próximo lote.

---

## 5. 🚀 Entrega e revisão

O Crowdin é a fonte de verdade: a tradução é submetida na plataforma e o mantenedor publica. Não há
PR, branch ou merge neste hub.

Antes de fechar um lote:

- [ ] `Status` sem pendências no arquivo trabalhado.
- [ ] `Check` com 0 divergências.
- [ ] Backup do arquivo atualizado em `snapshots/` (quando o arquivo for o `en.json`).
- [ ] `README.md` e dashboard do hub atualizados.

---

## 6. 📱 Espaço de tela

1. **Botão e menu:** 1 a 3 palavras. `Remover`, `Salvar`, `Calcular estimativa`.
2. **Tabela e coluna:** rótulo curto; o detalhe vai em tooltip.
3. **E-mail:** cabe frase completa, mas o assunto é curto.
4. **Erro e toast:** uma linha; diga o que falhou e o que fazer.
5. **Interface in-context:** o texto divide espaço com a tela real; prefira o termo mais curto.

---

## 7. ✅ Checklist antes de enviar ao Crowdin

**Etapas 1 e 2 — origem**
- [ ] Li a chave e sei em que tela/arquivo o texto aparece?
- [ ] Traduzi a partir do EN do projeto 31, não de `es`/`de`/`fr`/`pt-PT`?

**Etapas 3 e 4 — texto**
- [ ] A frase cabe no componente (botão, tabela, e-mail, tooltip)?
- [ ] Sentence Case aplicado; nomes de produto e siglas preservados?
- [ ] Português do Brasil, sem termo de Portugal e sem anglicismo forçado?

**Etapa 5 — regras**
- [ ] Todos os placeholders `{nome}` do EN aparecem no pt-BR, na mesma grafia?
- [ ] ICU (`plural`/`select`) preservado, com categorias e `#`?
- [ ] Tags HTML e escapes intactos?
- [ ] `Check` retornando 0 divergências?
- [ ] `Status` sem pendências no arquivo trabalhado?
- [ ] Snapshot atualizado (se for o `en.json`)?

---

## 8. ⚠️ Lacunas conhecidas

1. **354 pendentes.** Em 03/11/2026 o projeto tem 354 strings pendentes em 4 arquivos; a tradução
   **não** está 100%.
2. **Snapshot parcial.** Só o `en.json` está versionado; os outros 213 arquivos não têm cópia local.
3. **Snapshot 6 strings atrás.** `en.json` na plataforma tem 3.643; o snapshot tem 3.637.
4. **Sem validação de todos os arquivos.** `Check` cobre placeholders/ICU, não fluência nem espaço de
   tela.
5. **Sem interface aberta.** Nenhuma regra da seção 6 foi conferida na UI real.
6. **`en.json` cresce toda semana.** O número de 03/11/2026 envelhece rápido; meça antes de citar.

---

## 📚 Fontes dos números

| Valor | De onde veio |
| :--- | :--- |
| 18.819 strings, 354 pendentes | `crowdin-sync.ps1 -Action Status -ProjectId 31` em 03/11/2026 |
| 344/4.325, 6/69, 2/41, 2/3.643 | mesma execução, por arquivo |
| 3.637 strings no snapshot | `total_submitted` do JSON, gerado em 30/10/2026 |
| 214 arquivos | `research/README.md` e dashboard do hub |
| 0 divergências | última auditoria completa registrada em 30/10/2026 |
