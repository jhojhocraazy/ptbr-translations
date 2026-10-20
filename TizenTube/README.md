# 📺 TizenTube & TizenTube Cobalt — Central de Localização pt-BR

> **Módulo de Localização & Engenharia de Internacionalização (i18n & l10n) para o ecossistema [TizenTube](https://github.com/reisxd/TizenTube) e [TizenTube Cobalt](https://github.com/reisxd/TizenTubeCobalt).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📊 Status do Projeto

| Métrica | Status Oficial |
| :--- | :--- |
| **Ecossistema Tecnológico** | JavaScript (ESM / Rollup) + Cobalt C++ Container (Chromium/Starboard) |
| **Dispositivos Suportados** | Smart TVs Samsung (Tizen OS), Android TV, Google TV e Amazon Fire TV |
| **Cobertura Geral** | 🟢 **100% Traduzido & Refinado** (197 strings revisadas; 96 refinadas em 20/10/2026) |
| **Repositórios Oficiais** | [`reisxd/TizenTube`](https://github.com/reisxd/TizenTube) & [`reisxd/TizenTubeCobalt`](https://github.com/reisxd/TizenTubeCobalt) |
| **Branch de Trabalho** | `i18n/portuguese-complete-pt-br` |
| **Pull Request** | [#718](https://github.com/reisxd/TizenTube/pull/718) — aberto e mergeable (3 commits) |

---

## 🎬 Sobre o TizenTube & TizenTube Cobalt

O **TizenTube** é a solução definitiva de código aberto para aprimorar a experiência de streaming em televisores conectados:

* 🛑 **Bloqueio de Anúncios Nativo:** Elimina propagandas intrusivas sem interrupções.
* ❗ **Integração com SponsorBlock:** Pula automaticamente segmentos patrocinados, intros, encerramentos, avisos de inscrição e piadas irrelevantes.
* 🔺 **Suporte ao DeArrow:** Substitui títulos e miniaturas sensacionalistas (*clickbaits*) por versões precisas criadas pela comunidade.
* 🎛️ **Controle Fino de Velocidade e Resolução:** Incrementos customizados de velocidade de reprodução e taxa de quadros automática (**AFR**).
* ⏰ **Relógio em Tela & Personalização da Barra Lateral:** Relógio integrado com modo 12h/24h e reordenação dinâmica de menus.
* 🔄 **Atualizador Automático:** Sistema embutido de verificação de atualizações no TizenTube Cobalt.

---

## 🗂️ Arquitetura da Localização

A tradução central do projeto está concentrada no repositório core `reisxd/TizenTube`, que compila o bundle `@foxreis/tizentube` consumido tanto por Smart TVs Samsung (Tizen) quanto por Android TVs (Cobalt):

| Arquivo de Tradução | Strings Totais | Strings Iniciais em Inglês | Status Atual pt-BR |
| :--- | :---: | :---: | :---: |
| [`mods/translations/resources/pt-BR.json`](./tizentube_pt_BR.json) | **197** | 92 (~47%) | 🟢 **100% Traduzido & Refinado** (96 ajustes) |

---

## 🚀 O que foi Feito Nesta Localização

1. **Eliminação de 92 Strings em Inglês:** Cerca de metade do aplicativo utilizava textos em inglês copiados diretamente do `en.json`. Todas as 92 strings foram traduzidas para um português do Brasil fluído e natural.
2. **Localização Completa da Barra Lateral & Categorias:** Menus como *Início*, *Pesquisar*, *Filmes e TV*, *Ao Vivo*, *Jogos*, *Inscrições*, *Shorts* e comandos de reordenação agora estão 100% em pt-BR.
3. **Módulo de Atualização do Cobalt:** Tradução completa dos diálogos de verificação de atualização, download e notas de versão.
4. **Preservação Absoluta de Placeholders:** Variáveis como `{{count}}`, `{{version}}`, `{{latestVersion}}`, `{{currentVersion}}`, `{{name}}` e `{{date}}` foram rigorosamente mantidas.
5. **Reconhecimento nos Créditos:** Atualizado o array oficial `__contributors` com a inclusão de **Joseph Alves**.
6. **Refinamento de Qualidade (20/10/2026):** 96 strings ajustadas para Sentence Case, ergonomia de controle remoto (*selecione* em vez de *clique*), leitura de QR Code, naturalidade e precisão terminológica (ex.: *cartões*, *abrir em*, *preferencialmente*), preservando 100% dos placeholders e as 5 strings intencionalmente idênticas ao inglês.

---

## 📁 Estrutura de Arquivos Locais

```text
TizenTube/
├── diretrizes-tecnicas.md     # Regras de sintaxe JSON, placeholders e boas práticas
├── glossario.md               # Harmonização terminológica para Smart TVs e streaming
├── README.md                  # Este documento
└── tizentube_pt_BR.json       # Backup completo com 197 strings traduzidas
```
