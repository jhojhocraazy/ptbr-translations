# 🗂️ Organização dos Repositórios e das Fontes EN

> **Proposta de reorganização das pastas do hub.**  
> Status: **aguardando validação do mantenedor** — nenhuma remoção foi executada.  
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
  (`better_lyrics_messages_en.json`): o clone é redundante.

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
3. **Remover o clone do Better Lyrics** (projeto de plataforma, EN já local).
4. **Clones que ficam**: clone raso (`--depth 1`) e sem artefato de build.
5. **Nenhuma mudança de governança**: `AGENTS.md`, `README.md` raiz, `metodologia.md` e os
   documentos de projeto não são alterados por esta proposta.

Estrutura resultante:

```text
DNSToggle/
├── fonte/values/strings.xml      ← EN fixado (novo)
├── dnstoggle_strings_pt_BR.xml   ← snapshot da plataforma
├── glossario.md
└── diretrizes-tecnicas.md
```

---

## 6. Mudanças propostas (pendentes de aprovação)

| # | Ação | Ganho | Risco |
| :-: | :--- | :--- | :--- |
| 1 | Apagar `TorBox/repo/node_modules` e `TorBox/repo/.next` | ~1.656 MB | nulo (0 arquivos versionados; `npm install` recria) |
| 2 | Remover `BetterLyrics/repo` | 8,2 MB | baixo (EN já local; clone pode ser recriado) |
| 3 | Reclonar Nuvio, BitChord, TizenTube, TorBox com `--depth 1` | ~1 GB estimado | baixo (histórico completo deixa de existir localmente) |
| 4 | Criar `fonte/` + SHA nos 9 projetos | nenhum | nulo (arquivo novo) |

Ganho total estimado: de ≈ 2.520 MB para algo entre 100 e 300 MB. **Estimativa**, não medição.

---

## 7. Critério de aceite

- [ ] Todo projeto tem `fonte/` com o EN exato usado na tradução e o SHA registrado no README.
- [ ] `validate-ptbr.ps1 -Source <projeto>/fonte/...` roda sem depender de rede.
- [ ] Existem clones apenas para Nuvio, BitChord, TizenTube e TorBox.
- [ ] Nenhum clone contém `node_modules` ou diretório de build.
- [ ] `.gitignore` continua cobrindo `*/repo/` (`.gitignore:2-3`) — sem alteração necessária.

---

## 8. O que esta proposta não resolve

- **Passo 3 do método** ("entender o que o usuário vê"): sem clone, o contexto de tela dos
  projetos de plataforma passa a depender do GitHub web ou de capturas guardadas.
- **TorBox no validador**: o erro de JSON (`All`/`all`) é do `validate-ptbr.ps1`, não da
  organização de pastas. Continua exigindo validação manual.
- **Deriva do YTDLnis**: as 5 chaves novas precisam de uma rodada de tradução própria.
