# 🗂️ Organização dos Repositórios e das Fontes EN

> **Proposta de reorganização das pastas do hub.**  
> Status: **validada e parcialmente executada em 01/11/2026** — ver §9.  
> Medições de 01/11/2026.

---

## 1. Pergunta que este documento responde

Precisamos manter o clone completo de cada projeto dentro do hub, ou basta guardar o arquivo de strings em inglês (a fonte)?

**Resposta:** depende de como o projeto é entregue. O clone só se paga onde ele **é** o veículo de entrega.

---

## 2. Regra de decisão

| Entrega | Projetos | Clone local? | O que basta |
| :--- | :--- | :---: | :--- |
| Pull Request no GitHub | Nuvio Mobile, BitChord, TizenTube, TorBox | **Sim** | clone raso + fonte EN |
| Plataforma (Weblate/Crowdin) | DNSToggle, YTDLnis, Better Lyrics, Crowdin Platform | **Não** | fonte EN fixada |

Fonte da classificação: `metodologia.md:24-38` e `research/README.md:152-159`.

**Base do clone:** sempre a **branch padrão do upstream**. Na prática é `main` em BitChord, TizenTube e
TorBox. O Nuvio Mobile é a exceção: o upstream não tem `main` — a branch padrão é `cmp-rewrite`.

O clone serve a quatro funções: entregar por PR, fornecer a fonte EN para o validador,
detectar deriva no upstream (`scripts/check-updates.ps1:240`) e dar contexto de tela.
Só a primeira e a última exigem o clone; as outras duas exigem apenas **um arquivo EN de versão fixa**.

---

## 3. Estado atual medido

| Pasta | Total | Composição |
| :--- | ---: | :--- |
| TorBox | 1.736,2 MB | `node_modules` 876,2 MB + `.next` 780,0 MB (artefato de build) + `.git` 11,0 MB |
| NuvioMobile | 552,7 MB | `.git` 478,2 MB (histórico) |
| BitChord | 188,5 MB | `.git` 75,8 MB |
| TizenTube | 34,4 MB | `.git` 32,5 MB |
| BetterLyrics | 8,2 MB | `.git` 2,3 MB — projeto de plataforma |
| **Soma dos clones** | **≈ 2.520 MB** | para 9 projetos |

Medição: `Get-ChildItem -Recurse -File | Measure-Object Length -Sum`, por pasta, em 01/11/2026.

Fatos que sustentam a proposta:

- `git -C TorBox/repo ls-files node_modules .next` devolve **0** arquivos, e `git check-ignore`
  confirma que ambos são ignorados: apagar não perde nada versionado.
- DNSToggle, YTDLnis e Crowdin **não têm fonte EN nenhuma** no hub — são justamente os que mais
  precisam dela para validar.
- Better Lyrics é entregue por Crowdin e mantém clone de 8,2 MB **e** o EN local
  (`better_lyrics_messages_en.json`). O clone é redundante para **validar**, mas ainda é a única
  referência viva do upstream para o item aberto "638 no Crowdin vs 640 no upstream"
  (`research/README.md:113`): mantê-lo até esse item fechar.

---

## 4. O problema que a fonte fixada resolve

Sem EN fixada, a validação depende de baixar a fonte do GitHub na hora. Duas consequências
medidas em 01/11/2026 com `scripts/validate-ptbr.ps1`:

| Projeto | Resultado | Leitura |
| :--- | :--- | :--- |
| Nuvio Mobile | OK — 2.496 unidades | paridade com a fonte |
| BitChord | OK — 1.159 unidades | paridade com a fonte |
| Better Lyrics | OK — 638 unidades | paridade com a fonte |
| DNSToggle | OK — 177 unidades | única chave ausente: `app_name` (nome do app) |
| YTDLnis | FALHA — 5 chaves "ausentes" | são strings **novas no upstream**, não defeito da tradução |
| TorBox | não executa | JSON com chaves `All`/`all` quebra o validador |

O caso YTDLnis é o argumento central: "ausente" hoje mistura duas coisas diferentes —
erro do tradutor e novidade do upstream. Com o EN fixado no commit traduzido, "ausente"
passa a significar apenas a primeira. Deriva vira um passo separado e explícito
(`check-updates.ps1`), não ruído na validação.

---

## 5. Recomendação

1. **Fonte EN fixada por projeto**, em `fonte/`, com o **SHA do commit** anotado no README do projeto.
   Custo: ~30 KB por projeto.
2. **Clone apenas nos quatro projetos entregues por PR.** Não criar clone para DNSToggle,
   YTDLnis e Crowdin.
3. **Manter o clone do Better Lyrics por enquanto** — é a única referência viva do upstream
   enquanto o item aberto "638 vs 640" não fechar; remover depois disso.
4. **Clones que ficam**: clone raso (`--depth 1`) e sem artefato de build.
5. **Nenhuma mudança de governança**: `AGENTS.md`, `README.md` raiz, `metodologia.md` e os
   documentos de projeto não são alterados por esta proposta.

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

## 6. Mudanças propostas (pendentes de aprovação)

| # | Ação | Ganho | Risco |
| :-: | :--- | :--- | :--- |
| 1 | Apagar `TorBox/repo/node_modules` e `TorBox/repo/.next` — **executado em 01/11/2026** | 1.656 MB | nulo (0 arquivos versionados; `npm install` recria) |
| 2 | Manter `BetterLyrics/repo` até o item aberto "638 vs 640" fechar | — | removê-lo agora perderia a única referência viva do upstream |
| 3 | Reclonar Nuvio, BitChord, TizenTube, TorBox com `--depth 1` — **executado em 01/11/2026** | 2.188 MB medidos | baixo (histórico completo deixa de existir localmente; commits só locais do BitChord salvos em bundle) |
| 4 | Criar `fonte/` + SHA nos 9 projetos | nenhum | nulo (arquivo novo) |

Ganho total estimado: de ≈ 2.520 MB para algo entre 100 e 300 MB. **Estimativa**, não medição.

---

## 7. Critério de aceite

- [ ] Todo projeto tem `fonte/` com o EN exato usado na tradução e o SHA registrado no README.
- [ ] `validate-ptbr.ps1 -Source <projeto>/fonte/...` roda sem depender de rede.
- [x] Existem clones apenas para Nuvio, BitChord, TizenTube e TorBox.
- [x] Nenhum clone contém `node_modules` ou diretório de build.
- [ ] `.gitignore` continua cobrindo `*/repo/` (`.gitignore:2-3`) — sem alteração necessária.

---

## 8. O que esta proposta não resolve

- **Passo 3 do método** ("entender o que o usuário vê"): sem clone, o contexto de tela dos
  projetos de plataforma passa a depender do GitHub web ou de capturas guardadas.
- **TorBox no validador**: o erro de JSON (`All`/`all`) é do `validate-ptbr.ps1`, não da
  organização de pastas. Continua exigindo validação manual.
- **Deriva do YTDLnis**: as 5 chaves novas precisam de uma rodada de tradução própria.

---

## 9. Execução

| Data | Ação | Resultado medido |
| :--- | :--- | :--- |
| 01/11/2026 | Apagados `TorBox/repo/node_modules` e `TorBox/repo/.next` | TorBox: **1.736,2 MB → 80,0 MB**; `git status` do clone sem nenhuma alteração versionada |
| 01/11/2026 | Clone do Better Lyrics mantido (era remoção na proposta original) | o item aberto "638 vs 640" continua verificável no upstream |
| 01/11/2026 | Reclone raso dos quatro clones de PR | Nuvio 552,7 → **149,6 MB**; BitChord 188,5 → **158,3 MB**; TizenTube 34,4 → **2,8 MB**; TorBox 80,0 → **13,7 MB**. Total dos clones: **2.520 → 332,3 MB** |
| 02/11/2026 | Snapshots movidos para `<Projeto>/snapshots/` (19 arquivos) | XML, JSON e zip de metadados no mesmo lugar, nos 8 projetos |
| — | `fonte/` + SHA nos nove projetos | pendente |

### 9.1 Notas da execução do reclone

- **`git clone --depth 1` implica `--single-branch`.** Cada clone rastreia só a branch base; branches de PR precisam de
  fetch explícito: `git fetch --depth 1 origin <branch>:refs/remotes/origin/<branch>`.
- **Branch de trabalho restaurada** em cada clone, conforme o PR correspondente: Nuvio `cmp-rewrite` (#2435, merged),
  BitChord `i18n/pt-br-182` (#1204), TizenTube `i18n/portuguese-complete-pt-br` (#718), TorBox `i18n/pt-br` (#125).
- **Nuvio:** a base local foi alinhada ao upstream (`46febb5`). O fork `origin/cmp-rewrite` está 1 commit atrás e
  1 à frente (commit próprio `229c083`), então `git status` mostra `ahead 1, behind 1` — é o esperado, não erro.
- **BitChord:** três branches tinham commits só locais. Antes de remover o clone antigo, eles foram salvos em
  `research/bundle-bitcord-2026-11-01.bundle` (68,6 MB, `git bundle verify` = okay, histórico completo).
- **Validação:** `check-updates.ps1` roda nos quatro clones sem erro (0 erros; `exit 2` = novidades encontradas,
  comportamento documentado em `scripts/README.md:139`).

---

## 10. Snapshots (arquivos traduzidos)

Regra: o hub guarda **todos** os arquivos traduzidos de cada projeto, no formato nativo
(XML para Android, JSON para i18n), com sufixo `_pt_BR`, dentro de `<Projeto>/snapshots/`.

| Projeto | Arquivos em `snapshots/` | Observação |
| :--- | :--- | :--- |
| Nuvio Mobile | 7: `strings`, `strings_party`, `strings_servers`, `strings_mdblist`, `strings_pip`, `autosync_strings`, `autosync_toast_strings` | completado em 02/11/2026 |
| BitChord | 3: `bitchord` (app), `sharedUi`, `wearos` | completado em 02/11/2026 |
| TizenTube | 1 JSON | completo |
| TorBox | 1 JSON (+ fonte EN) | completo |
| Better Lyrics | 1 JSON (+ fonte EN) | completo |
| YTDLnis | 1 XML | completo |
| DNSToggle | 1 XML + zip de metadados | completo |
| Crowdin Platform | 1 JSON | completo |

Por que manter, mesmo nos projetos entregues por PR: a branch do clone é a fonte da verdade, mas o
snapshot é o que sobrevive se a branch for fechada, rebaseada ou sobrescrita. Nos projetos de
plataforma ele é a **única** cópia local.

Validação dos 8 arquivos adicionados em 02/11/2026 com `validate-ptbr.ps1` contra a fonte EN do clone:
todos `OK`, com avisos de "idêntica à fonte" apenas em nome próprio/termo técnico.
