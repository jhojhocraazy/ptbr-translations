# 🗂️ Organização dos Repositórios e das Fontes EN

> **Proposta de reorganização das pastas do hub.**
> Status: **validada e executada em 01–02/11/2026**; falta apenas a criação de `fonte/` (§7).
> Medições de 01–02/11/2026.

---

## 1. Pergunta que este documento responde

Precisamos manter o clone completo de cada projeto dentro do hub, ou basta guardar o arquivo de
strings em inglês (a fonte)?

**Resposta:** depende de como o projeto é entregue. O clone só se paga onde ele **é** o veículo de
entrega.

---

## 2. Regra de decisão

| Entrega | Projetos | Clone local? | O que basta |
| :--- | :--- | :---: | :--- |
| Pull Request no GitHub | Nuvio Mobile, BitChord, TizenTube, TorBox | **Sim** | clone raso + fonte EN |
| Plataforma (Weblate/Crowdin) | DNSToggle, YTDLnis, Better Lyrics, Crowdin Platform | **Não** | fonte EN fixada |

Fonte da classificação: [`metodologia.md`](./metodologia.md) §2 e `research/README.md` (seção
"Fontes").

**Base do clone:** sempre a **branch padrão do upstream**. Na prática é `main` em BitChord, TizenTube
e TorBox. O Nuvio Mobile é a exceção: o upstream não tem `main` — a branch padrão é `cmp-rewrite`.

O clone serve a quatro funções: entregar por PR, fornecer a fonte EN para o validador, detectar deriva
no upstream (`scripts/check-updates.ps1`) e dar contexto de tela. Só a primeira e a última exigem o
clone; as outras duas exigem apenas **um arquivo EN de versão fixa**.

---

## 3. Estado medido antes da execução (01/11/2026)

| Pasta | Total | Composição |
| :--- | ---: | :--- |
| TorBox | 1.736,2 MB | `node_modules` 876,2 MB + `.next` 780,0 MB + `.git` 11,0 MB |
| NuvioMobile | 552,7 MB | `.git` 478,2 MB (histórico) |
| BitChord | 188,5 MB | `.git` 75,8 MB |
| TizenTube | 34,4 MB | `.git` 32,5 MB |
| BetterLyrics | 8,2 MB | `.git` 2,3 MB — clone **removido em 02/11/2026** |
| **Soma dos clones** | **≈ 2.520 MB** | para 8 projetos |

Medição: `Get-ChildItem -Recurse -File | Measure-Object Length -Sum`, por pasta, em 01/11/2026.

Fatos que sustentam a proposta:

- `git -C TorBox/repo ls-files node_modules .next` devolve **0** arquivos, e `git check-ignore`
  confirma que ambos são ignorados: apagar não perde nada versionado.
- DNSToggle, YTDLnis e Crowdin **não têm fonte EN nenhuma** no hub — são justamente os que mais
  precisam dela para validar.
- Better Lyrics era entregue por Crowdin e mantinha clone de 8,2 MB **e** o EN local. O clone era
  redundante para **validar** e foi removido em 02/11/2026.

---

## 4. O problema que a fonte fixada resolve

Sem EN fixada, a validação depende de baixar a fonte do GitHub na hora. Duas consequências medidas em
01/11/2026 com `scripts/validate-ptbr.ps1`:

| Projeto | Resultado | Leitura |
| :--- | :--- | :--- |
| Nuvio Mobile | OK — 2.496 unidades (`-Escape none`) | paridade com a fonte; `-Escape android` gera 11 falsos positivos |
| BitChord | OK — 1.159 + 249 + 40 unidades | paridade nos 3 módulos |
| Better Lyrics | OK — 638 unidades | paridade com a fonte |
| DNSToggle | não executa | **não há fonte EN no hub** |
| YTDLnis | não executa | **não há fonte EN no hub** |
| TorBox | não executa | JSON com chaves `All`/`all` quebra o validador |

O caso YTDLnis é o argumento central: sem EN fixada, "ausente" mistura duas coisas diferentes — erro
do tradutor e novidade do upstream. Com o EN fixado no commit traduzido, "ausente" passa a significar
apenas a primeira. Deriva vira um passo separado e explícito (`check-updates.ps1`), não ruído na
validação.

---

## 5. Recomendação

1. **Fonte EN fixada por projeto**, em `fonte/`, com o **SHA do commit** anotado no README do projeto.
   Custo: ~30 KB por projeto.
2. **Clone apenas nos quatro projetos entregues por PR.** Não criar clone para DNSToggle, YTDLnis,
   Better Lyrics e Crowdin.
3. **Remover o clone do Better Lyrics — executado em 02/11/2026.** O projeto entrega por Crowdin; o
   clone era cópia de leitura, sem commit local, e ficou atrás do `master`. O EN segue em
   `snapshots/better_lyrics_messages_en.json` e a fonte é lida por `gh api`.
4. **Clones que ficam:** clone raso (`--depth 1`) e sem artefato de build.
5. **Nenhuma mudança de governança:** `AGENTS.md`, `README.md` raiz, `metodologia.md` e os documentos
   de projeto não são alterados por esta proposta.

Estrutura resultante:

```text
DNSToggle/
├── snapshots/
│   ├── dnstoggle_strings_pt_BR.xml   ← snapshot da plataforma
│   └── dnstoggle_metadata_pt_BR.zip  ← metadados de cobertura
├── fonte/values/strings.xml          ← EN fixado (novo)
├── glossario.md
└── diretrizes-tecnicas.md
```

---

## 6. Mudanças propostas

| # | Ação | Ganho | Risco |
| :-: | :--- | :--- | :--- |
| 1 | Apagar `TorBox/repo/node_modules` e `TorBox/repo/.next` — **executado em 01/11/2026** | 1.656 MB | nulo (0 arquivos versionados; `npm install` recria) |
| 2 | Remover `BetterLyrics/repo` — **executado em 02/11/2026** | 7,9 MB | nulo (clone raso, sem commit local; o EN segue em `snapshots/`) |
| 3 | Reclonar Nuvio, BitChord, TizenTube, TorBox com `--depth 1` — **executado em 01/11/2026** | 2.188 MB medidos | baixo (histórico completo deixa de existir localmente; commits só locais do BitChord salvos em bundle) |
| 4 | Criar `fonte/` + SHA nos 8 projetos | validação offline | nulo (arquivo novo) — **pendente** |

Ganho total estimado: de ≈ 2.520 MB para algo entre 100 e 300 MB. **Estimativa**, não medição.

---

## 7. Critério de aceite

- [ ] Todo projeto tem `fonte/` com o EN exato usado na tradução e o SHA registrado no README.
- [ ] `validate-ptbr.ps1 -Source <projeto>/fonte/...` roda sem depender de rede.
- [x] Existem clones apenas para Nuvio, BitChord, TizenTube e TorBox.
- [x] Nenhum clone contém `node_modules` ou diretório de build.
- [x] `.gitignore` continua cobrindo `*/repo/` (`.gitignore:2-3`).

---

## 8. O que esta proposta não resolve

- **Passo 3 do método** ("entender o que o usuário vê"): sem clone, o contexto de tela dos projetos de
  plataforma passa a depender do GitHub web ou de capturas guardadas.
- **TorBox no validador**: o erro de JSON (`All`/`all`) é do `validate-ptbr.ps1`, não da organização de
  pastas. Continua exigindo a validação do projeto (`bun scripts/i18n.js verify`).
- **Deriva do YTDLnis**: as 15 pendentes de 02/11/2026 precisam de uma rodada de tradução própria.
- **Crowdin parcial**: só o `en.json` tem snapshot local; os outros 213 arquivos vivem na plataforma.

---

## 9. Execução

| Data | Ação | Resultado medido |
| :--- | :--- | :--- |
| 01/11/2026 | Apagados `TorBox/repo/node_modules` e `TorBox/repo/.next` | TorBox: **1.736,2 MB → 80,0 MB**; `git status` sem alteração versionada |
| 01/11/2026 | Clone do Better Lyrics mantido naquele momento | o item aberto "638 vs 640" continuava verificável no upstream |
| 02/11/2026 | **Clone do Better Lyrics removido** (`BetterLyrics/repo`, 7,9 MB) | `git status` limpo, 0 commits locais, HEAD `99c9ea6`; hub sem `repo/` nesse projeto |
| 02/11/2026 | Documentos do Better Lyrics reescritos para o modelo de plataforma | `diretrizes-tecnicas.md`, `README.md` e `glossario.md` sem referência a clone |
| 01/11/2026 | Reclone raso dos quatro clones de PR | Nuvio 552,7 → **149,6 MB**; BitChord 188,5 → **158,3 MB**; TizenTube 34,4 → **2,8 MB**; TorBox 80,0 → **13,7 MB**. Total: **2.520 → 332,3 MB** |
| 02/11/2026 | Snapshots movidos para `<Projeto>/snapshots/` (19 arquivos) | XML, JSON e zip no mesmo lugar, nos 8 projetos |
| 02/11/2026 | Documentos dos 8 projetos padronizados | mesmo esqueleto: método → onde vive → formato → validação → lacunas |
| — | `fonte/` + SHA nos oito projetos | **pendente** |

### 9.1. Notas da execução do reclone

- **`git clone --depth 1` implica `--single-branch`.** Cada clone rastreia só a branch base; branches de PR precisam de fetch explícito: `git fetch --depth 1 origin <branch>:refs/remotes/origin/<branch>`.
- **Branch de trabalho restaurada** em cada clone, conforme o PR correspondente: Nuvio `cmp-rewrite`, BitChord `i18n/pt-br-182`, TizenTube `i18n/portuguese-complete-pt-br`, TorBox `i18n/pt-br`.
- **Nuvio:** a base local foi alinhada ao upstream (`46febb5`). O fork `origin/cmp-rewrite` pode estar à frente/atrás; `git status` mostrando `ahead/behind` é esperado, não erro.
- **BitChord:** três branches tinham commits só locais. Antes de remover o clone antigo, eles foram salvos em `research/bundle-bitcord-2026-11-01.bundle` (68,6 MB, `git bundle verify` = okay).
- **Validação:** `check-updates.ps1` roda nos quatro clones sem erro (0 erros; `exit 2` = novidades encontradas).

---

## 10. Snapshots (arquivos traduzidos)

Regra: o hub guarda **todos** os arquivos traduzidos de cada projeto, no formato nativo (XML para
Android, JSON para i18n), com sufixo `_pt_BR`, dentro de `<Projeto>/snapshots/`.

| Projeto | Arquivos em `snapshots/` | Observação |
| :--- | :--- | :--- |
| Nuvio Mobile | 7: `NuvioMobile_strings`, `strings_party`, `strings_servers`, `strings_mdblist`, `strings_pip`, `autosync_strings`, `autosync_toast_strings` | completo |
| BitChord | 3: `bitchord`, `sharedUi`, `wearos` | completo |
| TizenTube | 1 JSON | 198 chaves + `__contributors` |
| TorBox | 1 JSON + fonte EN | 1.466 chaves no delta |
| Better Lyrics | 1 JSON + fonte EN | 638 chaves |
| YTDLnis | 1 XML | 670 strings + 9 plurais |
| DNSToggle | 1 XML + zip de metadados | 177 unidades + metadados |
| Crowdin Platform | 1 JSON | **só o `en.json`** (3.637 strings), não os 18.819 do projeto |

Por que manter, mesmo nos projetos entregues por PR: a branch do clone é a fonte da verdade, mas o
snapshot é o que sobrevive se a branch for fechada, rebaseada ou sobrescrita. Nos projetos de
plataforma ele é a **única** cópia local.

Validação dos arquivos em 02/11/2026 com `validate-ptbr.ps1` contra a fonte EN disponível: Nuvio `OK`
(2.496, `-Escape none`), BitChord `OK` (1.159 + 249 + 40), Better Lyrics `OK` (638), TizenTube `OK`
(199, `-Format nested`). DNSToggle, YTDLnis e Crowdin não têm fonte EN local; TorBox não roda no
validador.

---

## 11. Fontes

| Valor | Fonte |
| :--- | :--- |
| Classificação dos projetos | [`metodologia.md`](./metodologia.md) §2 |
| Branch padrão do Nuvio = `cmp-rewrite` | `gh repo view NuvioMedia/NuvioMobile --json defaultBranchRef` |
| Base do BitChord = `main` na PR [#1204](https://github.com/kushagrasinghx/BitChord/pull/1204) | `gh pr view 1204 --json baseRefName` (02/11/2026) |
| Base do TizenTube = `main` | `gh pr view 718 --json baseRefName` |
| Base do TorBox = `main` | `gh pr view 125 --json baseRefName` |
| Tamanhos dos clones | `Measure-Object Length -Sum` em 01/11/2026 |
| Validações | `validate-ptbr.ps1` em 02/11/2026 |
| `fonte/` pendente | este documento, §7 |
