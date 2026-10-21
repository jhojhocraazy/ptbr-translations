# 🧭 Metodologia de Trabalho — ptbr-translations

> Documento operacional do hub. Complementa o [`AGENTS.md`](./AGENTS.md) (constituição) e o
> [`scripts/README.md`](./scripts/README.md) (ferramentas). Em caso de conflito, o `AGENTS.md` prevalece.

---

## 1. Princípio central: a entrega termina onde a tradução vive

Cada projeto tem **um único destino de entrega**. Misturar as etapas gera retrabalho e ruído de comunicação.

| Onde o projeto está | Nossa entrega | GitHub é nosso escopo? |
| :--- | :--- | :---: |
| **Crowdin** | 100% traduzido no projeto, no idioma alvo | ❌ Não |
| **Weblate** | 100% traduzido no componente, no idioma alvo | ❌ Não |
| **Sem plataforma de tradução** | Tradução no repositório + Pull Request | ✅ Sim |

**Regra de ouro:** se o projeto está em Crowdin ou Weblate, o trabalho termina na plataforma.
Não abrimos PR, não acompanhamos merge e não tratamos sincronização como pendência nossa —
o envio ao produto é responsabilidade da plataforma/mantenedor.

---

## 2. Classificação atual dos projetos

| Projeto | Tipo | Onde entregamos |
| :--- | :--- | :--- |
| Nuvio Mobile | Sem plataforma | PR no GitHub |
| BitChord | Sem plataforma | PR no GitHub |
| TizenTube & Cobalt | Sem plataforma | PR no GitHub |
| Better Lyrics | Plataforma | Crowdin (863186) |
| Crowdin Platform | Plataforma | Crowdin (31) |
| YTDLnis | Plataforma | Weblate |
| DNSToggle | Plataforma | Weblate |

> Ao entrar um projeto novo, **classifique antes de começar**. A classificação define o critério de conclusão.

---

## 3. Ciclo de trabalho — projeto em plataforma

### 3.1 Preparação
1. Confirmar **ID do projeto** e **idioma alvo** (`pt-BR`).
2. Carregar o token para a sessão (nunca versionar):
   ```powershell
   $env:CROWDIN_TOKEN = 'seu-token'
   ```
   Para carregar Crowdin e Weblate de uma vez, use o arquivo local `scripts/tokens.ps1`
   (ignorado pelo Git; modelo em `scripts/tokens.example.ps1`):
   ```powershell
   . .\scripts\tokens.ps1
   ```
3. Consultar pendências:
   ```powershell
   ./scripts/crowdin-sync.ps1 -Action Status -ProjectId 31
   ```

### 3.2 Tradução
1. Exportar um arquivo por vez:
   ```powershell
   ./scripts/crowdin-sync.ps1 -Action Export -ProjectId 31 -FileId 31090 -Tsv backend.tsv
   ```
2. Traduzir em lotes de ~120 strings, usando o glossário do projeto.
3. Preservar integralmente placeholders, ICU, tags e escapes (ver §5).
4. Enviar o lote:
   ```powershell
   ./scripts/crowdin-sync.ps1 -Action Push -ProjectId 31 -Tsv lote.tsv
   ```
   Saída esperada: `OK=120 FALHAS=0`.

### 3.3 Auditoria
1. Conferir pendências do arquivo/projeto:
   ```powershell
   ./scripts/crowdin-sync.ps1 -Action Status -ProjectId 31
   ```
2. Auditar integridade de todas as strings traduzidas:
   ```powershell
   ./scripts/crowdin-sync.ps1 -Action Check -ProjectId 31 -Tsv divergencias.tsv
   ```
   Critério de aceite: **0 pendentes** e **0 divergências**.

### 3.4 Registro no hub
1. Atualizar o backup/snapshot do projeto (`-Action Backup` quando aplicável).
2. Atualizar `README.md` do projeto e a linha do dashboard no `README.md` raiz.
3. Commitar no hub com identidade e padrão definidos no `AGENTS.md`.

> O commit no hub é **documentação**, não entrega do projeto. Ele não substitui nem antecede a plataforma.

### 3.5 Projeto em Weblate

O ciclo é o mesmo, com a ferramenta `weblate-sync.ps1`:

1. Consultar a cobertura: `-Action Status -Project <projeto>` (traduzidas/total, pendentes e checks falhando).
2. Exportar as pendentes em TSV: `-Action Export -Project <projeto> -Component <componente> -Tsv ...`.
   Se houver plurais (ou for preciso revisar tudo), exportar em JSON:
   `-Action Export -Project <projeto> -Component <componente> -All -Format json -OutFile unidades.json`
   — o JSON preserva `source` e `target` como arrays.
3. Traduzir em lotes, preservando placeholders, ICU e tags.
4. Enviar strings de forma única com
   `-Action Push -Project <projeto> -Component <componente> -Tsv lote.tsv`.
   Plurais (arrays) vão por
   `-Action PushJson -Project <projeto> -Component <componente> -Json lote.json`.
5. Auditar: `-Action Check -Project <projeto> -Component <componente>` (placeholders/ICU/chaves;
   critério: **0 divergências**) e `-Action Checks -Project <projeto> -Component <componente>`
   (checks nativos do Weblate; revisar `has_failing_check`).
6. Confirmar `-Action Status -Project <projeto>` (**0 pendentes**), baixar o backup com
   `-Action Backup -Project <projeto> -Component <componente> -OutFile ...` e validá-lo antes de
   commitar (ver §3.5.1).

Token via `$env:WEBLATE_TOKEN` (ou `-Token`). O Weblate pode estar atrás do Anubis; o script já envia
um User-Agent de navegador, mas a API ainda pode exigir ajuste de acesso na instância.

### 3.5.1 Armadilhas específicas do Weblate

**Escape é responsabilidade do exportador, não do envio.**
- O `target` da API é **texto cru**: envie `d'água`, não `d\'água`. Nunca escape `'`/`"` manualmente no payload.
- O exportador Android do Weblate adiciona `\'`/`\"` ao gerar o XML. O XML final deve ter escapes
  simples; `\\'`/`\\\"` é **over-escaping** e defeito.
- `\n`/`\t` podem ser literais no target. Se a fonte usa uma quebra de linha real, envie newline
  real para satisfazer o check `Mismatched \n`.

**Plurais são arrays, não texto concatenado.**
- O `target` de uma unidade plural é um array (`one`/`many`/`other`). Não juntar formas com `/`, `|` ou vírgula.
- Exportar com `-Format json`, editar o array e enviar com `-Action PushJson -Json lote.json`.
- Se o Weblate exigir três formas, preencher `many` com o mesmo conteúdo de `other`.
- `-Action Push -Tsv` só aceita forma única e **recusa** unidades plurais — nesse caso, usar `PushJson`.

**Read-only não é falha.**
- `state=100`, target vazio e `PATCH` retornando `403` indicam unidade somente leitura. Elas são
  omitidas do backup; não tratar como pendência nem como erro.
- No Android, o app usa o fallback da fonte. Exemplos no YTDLnis: `trendingPlaylist`, `unfound_file`, `ytdlp`.

**Checks nativos ≠ auditoria de integridade.**
- `Status` mostra a contagem de checks falhando.
- `Check` valida placeholders, ICU e chaves (0 divergências é o critério).
- `Checks` lista as unidades com `has_failing_check`, incluindo os checks nativos do Weblate.
- Falsos positivos conhecidos: `multiple_capital` para `JSON`/`Info-JSONs` e `same` para `Nightly`.
  Editar/ignorar flags exige permissão na instância e pode não estar disponível; nesse caso,
  documentar a justificativa no `README.md` do projeto.

**Backup só termina depois da validação.**
1. Baixar o arquivo nativo com `-Action Backup -OutFile ...`.
2. Validar o XML/JSON e escanear `\\'`/`\\\"` (escape duplicado).
3. Conferir placeholders e tags contra a fonte.
4. Procurar strings vazias.
5. Conferir a contagem de contextos e a ausência esperada das unidades read-only.

**Token.**
- Usar `$env:WEBLATE_TOKEN` ou `-Token`; nunca versionar.
- Apagar scripts/temporários que contenham token ao final da sessão.

---

## 4. Ciclo de trabalho — projeto sem plataforma (GitHub)

1. Clonar o repositório oficial e criar fork/branch de tradução.
2. Traduzir os arquivos de locale (`values-pt-rBR/`, `pt-BR.json`, etc.).
3. Validar localmente:
   ```powershell
   ./scripts/validate-ptbr.ps1 -Path <arquivo> -Source <fonte> -Format xml -Escape android
   ```
4. Commitar com a identidade do `AGENTS.md` e abrir **PR** para o repositório oficial.
5. Registrar o PR (link, status, volume) no `README.md` do projeto e no dashboard.
6. Acompanhar revisão e ajustes solicitados pelo mantenedor.

Critério de aceite: **PR aberto e válido**, com validação local sem erros.

---

## 5. Regras de qualidade (todas as plataformas)

### Placeholders e variáveis
- Preservar exatamente: `%s`, `%1$s`, `%2$d`, `{nome}`, `{{nome}}`, `${valor}`, `$VAR$`, `:nome`, `@string/nome`.
- Não traduzir nomes de variáveis, nunca remover nem duplicar.
- Manter a **mesma quantidade** de cada placeholder.

### ICU MessageFormat
- Manter o argumento (`plural`, `select`, `selectordinal`) e suas categorias.
- Não renomear o argumento (`{count}` ≠ `{contagem}`).
- `#` dentro de `plural` é o número: preservar.
- Chaves devem permanecer balanceadas.

### Tags e escapes
- Preservar tags HTML/XML e seus atributos (`<b>`, `<a href="...">`, `<br>`).
- Android XML: apóstrofo `\'`, aspas `\"`, `&amp;`.
- Não converter tags em entidades (`&lt;a&gt;`) nem em índices (`<0>`) sem necessidade do formato.
- Preservar quebras de linha e espaços significativos quando a string exigir.

### Terminologia e naturalidade
- Seguir o glossário do projeto (`glossario.md`) e as diretrizes técnicas locais.
- Português do Brasil: "tela" (não "ecrã"), "arquivo" (não "ficheiro"), "salvar" (não "guardar").
- Evitar tradução literal; adaptar para o uso real da interface.
- Manter termos consagrados da comunidade sem tradução forçada.

---

## 6. Definição de pronto (DoD)

Um projeto só é considerado concluído quando **todos** os itens do seu tipo forem verdadeiros.

**Plataforma (Crowdin/Weblate):**
- [ ] 0 strings pendentes no idioma alvo
- [ ] Auditoria de placeholders/ICU/chaves com 0 divergências
- [ ] Checks nativos revisados (`Checks`) e falsos positivos documentados
- [ ] Backup baixado e validado (over-escape `\\'`/`\\\"`, placeholders, tags, strings vazias, read-only)
- [ ] Lote de refinamentos conferido
- [ ] Backup/snapshot atualizado no hub
- [ ] `README.md` do projeto atualizado
- [ ] Dashboard do `README.md` raiz atualizado
- [ ] Commit no hub (documentação)

**Sem plataforma (GitHub):**
- [ ] Todos os arquivos de locale traduzidos
- [ ] `validate-ptbr.ps1` sem erros
- [ ] PR aberto no repositório oficial
- [ ] `README.md` do projeto + dashboard atualizados
- [ ] Commit no hub (documentação)

---

## 7. Manutenção do hub

- **Backups:** cada projeto de plataforma mantém snapshot local em sua pasta.
- **Fonte da verdade:** a plataforma (Crowdin/Weblate) ou o repositório oficial — o hub é espelho documental.
- **Prontidão para atualizações:** ao chegar nova rodada de strings, repetir o ciclo da §3/§4 e atualizar os números.
- **Segurança:** tokens e credenciais **nunca** entram no repositório; usar `CROWDIN_TOKEN` e
  `WEBLATE_TOKEN` no ambiente (ou `-Token`), sem versionamento. O arquivo local `scripts/tokens.ps1`
  é ignorado pelo Git; use `scripts/tokens.example.ps1` como modelo. Apagar scripts e temporários
  que contenham token ao final da sessão.
- **Commits:** autor `Joseph Alves <jhojhocraazy@gmail.com>`, Conventional Commits, push somente com confirmação.

### 7.1 Consulta de atualizações (somente leitura)

Antes de iniciar uma nova rodada, execute:

```powershell
./scripts/check-updates.ps1
```

A rotina consulta Crowdin (`31` e `863186`), Weblate (YTDLnis e componentes do DNSToggle)
e os projetos mantidos apenas no GitHub (Nuvio Mobile, BitChord e TizenTube & Cobalt).
Ela compara com a execução anterior e mostra no console o texto das strings novas,
removidas, alteradas, ainda sem tradução e órfãs.

- A primeira execução cria a linha de base em `scripts/.state/check-updates.json`,
  ignorado pelo Git; as seguintes mostram as diferenças e a lista de pendências.
- Use `-Project <texto>` para consultar um projeto específico, `-AllDetails` para ver todas
  as strings e `-NoFetch` para não atualizar as referências dos clones locais.
- A rotina não envia alterações, não exporta arquivos e não faz commits. Tokens continuam
  vindo de `scripts/tokens.ps1` ou das variáveis de ambiente.
- Códigos de saída: `0` sem novidades, `2` novidades encontradas, `1` erro.
