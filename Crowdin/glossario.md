# 📗 Glossário de termos — Crowdin Platform

> **O que é este documento:** o vocabulário da **etapa 4** do método de tradução (escrever em pt-BR).
> Ele decide a **palavra**; [`diretrizes-tecnicas.md`](./diretrizes-tecnicas.md) decide **como
> escrevê-la** no formato do projeto. Status em [`README.md`](./README.md).
>
> **Contra o que foi escrito:** snapshot
> [`snapshots/crowdin_translations_pt_BR.json`](./snapshots/crowdin_translations_pt_BR.json)
> (`en.json`, 3.637 strings) e o catálogo do projeto 31, conferidos em **02/11/2026**. As citações são
> de **chave**, não de linha.
>
> **Como usar:** procure o termo, confira a chave citada e escreva igual. Se o termo não estiver aqui,
> decida com a regra da seção 1 e acrescente a linha **no mesmo lote**.

---

## 1. 🔎 Como decidir um termo que não está aqui

Três perguntas, nesta ordem:

1. **É nome próprio, marca, produto, formato ou sigla?**
   Fica em inglês. `Crowdin`, `TM`, `ICU`, `JSON`, `API`.
2. **É termo que o profissional de localização já usa em inglês?**
   Fica. `workflow`, `string`, `target`, `source`, `build`.
3. **É palavra comum com equivalente natural em pt-BR?**
   Traduz. `vendor` ➔ **fornecedor**; `approval` ➔ **aprovação**; `savings` ➔ **economia**.

**Nunca traduza pela metade.** Escolhida a forma, ela vale em toda a interface, e-mails e relatórios.

**A armadilha deste domínio é a sigla.** `TM` é *Translation Memory* (memória de tradução) e `MT` é
*Machine Translation* (tradução automática). As duas aparecem na mesma tela; não troque uma pela
outra.

---

## 2. 🚫 Fica em inglês

| Termo | Como escrever | Onde aparece |
| :--- | :--- | :--- |
| Crowdin | `Crowdin` | nome do produto |
| TM (Translation Memory) | `TM` | memórias de tradução |
| MT (Machine Translation) | `MT` | motores de tradução automática |
| ICU | `ICU` | formato de plural/select |
| JSON / CSV / PHP | `JSON` / `CSV` / `PHP` | formatos e arquivos |
| API / SDK / CLI | `API` / `SDK` / `CLI` | integrações |
| Workflow | `workflow` | fluxo de tradução configurado |
| String | `string` | unidade de texto |
| Source / Target | `source` / `target` | idioma/texto de origem e destino |

---

## 3. ✅ Traduz-se

### 3.1. Conceitos de TMS

| Inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Translation Memory (TM) | `Memória de tradução (TM)` | memórias de tradução |
| Machine Translation (MT) | `Tradução automática (TA)` | motores de tradução |
| Pre-translation | `Pré-tradução` | ação de pré-tradução |
| Proofreading / Proofreader | `Revisão` / `Revisor` | fluxo de revisão |
| In-context localization | `Localização no contexto` | editor in-context |
| Glossary | `Glossário` | glossário do projeto |
| Vendor | `Fornecedor` | fornecedores |
| Cost estimate | `Estimativa de custo` | estimativas |
| Savings summary | `Resumo de economia` | relatórios |
| Source string | `String de origem` | editor |
| Target language | `Idioma de destino` | configuração do projeto |
| Approval | `Aprovação` | revisão |

### 3.2. Interface e projetos

| Inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Project | `Projeto` | lista de projetos |
| File | `Arquivo` | arquivos |
| Folder | `Pasta` | pastas |
| Member / Team | `Membro` / `Equipe` | equipe |
| Role / Permission | `Papel` / `Permissão` | permissões |
| Integration | `Integração` | integrações |
| Report | `Relatório` | relatórios |
| Billing / Invoice | `Cobrança` / `Fatura` | cobrança |
| Workspace | `Workspace` | workspace |
| Dashboard | `Painel` | painel |

### 3.3. Ações

| Inglês | pt-BR | Onde aparece |
| :--- | :--- | :--- |
| Upload / Download | `Enviar` / `Baixar` | ações de arquivo |
| Remove / Delete | `Remover` / `Excluir` | ações de arquivo |
| Save | `Salvar` | botões |
| Cancel | `Cancelar` | botões |
| Retry | `Tentar novamente` | erro e toast |
| Search | `Pesquisar` | lista |
| Filter | `Filtrar` | lista |
| Approve | `Aprovar` | revisão |

---

## 4. ⚠️ Decisões que não são óbvias

### 4.1. `TM` não é `MT`

- **TM** = *Translation Memory* = **Memória de tradução**. É o banco de frases já traduzidas.
- **MT** = *Machine Translation* = **Tradução automática**. É o motor (Google, DeepL, IA).

Na interface, as duas aparecem juntas. Traduzir `TM` como "MT" ou `MT` como "TM" inverte o sentido
do recurso. A correção de 30/10/2026 no catálogo foi exatamente essa.

### 4.2. `AI` vira `IA`

`AI` é traduzido como **IA** em pt-BR. `AI-powered` ➔ **com IA**, não "movido a IA".

### 4.3. `workflow` vira `fluxo de trabalho`

O termo inglês é usado por profissionais, mas a interface oficial usa **fluxo de trabalho**. Mantenha
`workflow` só quando for nome de um recurso configurável (ex.: "Workflow de tradução").

### 4.4. `engine` vira `motor`

`Translation engine` ➔ **motor de tradução**. Não use "engine" no texto de usuário.

### 4.5. `string` fica

É a unidade de tradução e o profissional reconhece. Traduzir para "cadeia" ou "texto" piora a
precisão. `String de origem` e `string de destino` são as formas.

### 4.6. `vendor` é `fornecedor`

O Crowdin usa `vendor` para agência/empresa de tradução. **Fornecedor** é o termo em pt-BR; não
confunda com `provider` (provedor), que é outro conceito.

### 4.7. `workspace` fica

É o nome da área de trabalho da conta. Traduzir para "espaço de trabalho" alonga e não é o termo que
o produto usa.

---

## 5. 📱 Onde o termo aparece muda o tamanho

1. **Botão e menu:** 1 a 3 palavras. `Remover`, `Salvar`, `Aprovar`.
2. **Tabela e coluna:** rótulo curto; o detalhe vai em tooltip.
3. **E-mail:** cabe frase completa; o assunto é curto.
4. **Erro e toast:** uma linha; diga o que falhou e o que fazer.
5. **Interface in-context:** o texto divide espaço com a tela real.

---

## 6. ❓ Ainda não decidido

1. **`Workspace`.** Ficou em inglês; "espaço de trabalho" é mais longo e não é o termo do produto.
   Falta decidir se há um contexto em que a tradução ajude.
2. **`Workflow` como recurso.** Hoje alterna entre `workflow` (nome do recurso) e `fluxo de trabalho`
   (descrição). Falta padronizar quando aparece como título.
3. **`Provider` x `vendor`.** `Provider` é provedor (de serviço); `vendor` é fornecedor (de
   tradução). Se aparecerem juntos, a distinção precisa ficar explícita.
4. **`Build`.** Em "build do projeto", fica; em "build da tradução", pode virar "compilação". Falta
   decidir.

---

## 7. 📌 Como este glossário se mantém honesto

- Toda linha aponta uma **chave** ou um conceito do catálogo. Sem referência, é opinião.
- Termo novo entra **no mesmo lote** da string que o usa.
- Termo que saiu do catálogo sai daqui.
- As 29 traduções corrigidas em 30/10/2026 (placeholders, HTML e truncamento) são a prova de que o
  glossário não substitui a validação técnica.
- Contagem e vocabulário são de **02/11/2026**; o projeto 31 cresce toda semana.
