# 📘 Diretrizes Técnicas de Localização — BitChord

> **Manual de Engenharia de Internacionalização (i18n) do app Android, da UI Compose Multiplatform (`sharedUi`), do Wear OS e do Android Auto.**  
> Aplicado à localização em Português do Brasil (`pt-BR`) do aplicativo [BitChord](https://github.com/kushagrasinghx/BitChord).  
> Base de trabalho: branch `main` — PR [#1204](https://github.com/kushagrasinghx/BitChord/pull/1204) (branch `i18n/pt-br-182`).

---

## 1. 🏗️ Arquitetura de Idiomas & `LocaleTags.kt`

Arquivo real no repositório: `shared/src/jvmSharedMain/kotlin/com/music/bitchord/data/LocaleTags.kt`.

### 1.1. Por que a pasta é `values-pt` e não `values-pt-rBR`?
* `LocaleTags.normalizeAppTag()` reduz qualquer tag BCP-47 ao idioma base: `en-US` ➔ `en`, `pt-BR` ➔ `pt`, com correções de legado (`iw` ➔ `he`, `in` ➔ `id`, `ji` ➔ `yi`).
* Apenas o Chinês mantém distinção de escrita (`zh-Hant` / `zh-Hans`), mapeada para região (`zh-TW` / `zh-CN`) só na hora de falar com as APIs.
* **Consequência prática:** o catálogo precisa ficar em `values-pt`. Um `values-pt-rBR` nunca seria lido, porque o app procura pela tag base.
* **Vantagem de compatibilidade:** qualquer falante de português recebe a interface em português, em vez de cair no fallback em inglês.

---

## 2. 🗂️ Módulos e Arquivos de Tradução

| Módulo | Arquivo pt-BR | Strings | Plurais |
| :--- | :--- | :---: | :---: |
| **Android (`app/`)** | `app/src/main/res/values-pt/strings.xml` | 1.112 (de 1.138; 26 marcadas `translatable="false"`) | 23 |
| **UI Multiplataforma (`sharedUi/`)** | `sharedUi/src/commonMain/composeResources/values-pt/strings.xml` | 249 | — |
| **Wear OS (`wearos/`)** | `wearos/src/main/res/values-pt/strings.xml` | 40 | — |
| **Total** | — | **1.401** | **23** |

* O módulo **Desktop foi removido do upstream em 26/10/2026**: não existe mais catálogo desktop nem `DesktopStringsTest`.
* `translatable="false"` marca nome próprio, marca ou texto técnico que não se traduz — essas chaves não entram na conta de paridade.

---

## 3. ⚡ Casos Extremos de XML e Escapes

### 3.1. Escape de Apóstrofo (`'`)
No Android XML, apóstrofo simples precisa ser escapado como `\'`. Em pt-BR preferimos **reescrever a frase** para não precisar de escape — o catálogo atual tem 0 ocorrências de `\'`.

* ❌ `Your device's own panel`
* ✅ `Painel nativo do seu dispositivo`

### 3.2. Porcentagem Literal em Strings Formatadas (`%%`)
Quando a string tem argumento de formatação **e** um `%` literal, o `%` precisa ser duplicado:

```xml
<string name="downloads_progress">Downloads • %1$d%%</string>
<string name="downloading_progress">Baixando • %1$d%%</string>
```

Sem argumento de formatação, `%` solto é válido: `100% em repetição` (`shelf_100_on_repeat`).

### 3.3. Placeholders Posicionais
Sempre usar argumento com índice (`%1$s`, `%2$s`, `%1$d`), porque a ordem das palavras muda na tradução:

* Inglês: `Playing from %1$s`
* Português: `Reproduzindo de %1$s`

O catálogo usa 180 placeholders posicionais. **Exceção:** `party_queue_full` mantém `%d` porque a fonte também usa `%d`; com um único argumento não há risco de troca de posição.

### 3.4. Plurais
As 23 unidades `<plurals>` têm as formas `one` / `many` / `other`. O inglês só tem `one` / `other`; o pt-BR exige `many` (números terminados em 0). Preencher `many` com o mesmo conteúdo de `other` quando a frase não mudar.

---

## 4. 🧪 Conformidade com os Testes Nativos

Existe **um** teste de paridade de strings na pipeline:

### 4.1. `LocaleStringsTest.kt` (`app/src/test/java/com/music/bitchord/LocaleStringsTest.kt`)
* É parametrizado por `SUPPORTED_LANGUAGES` (todos menos `en`).
* Para cada idioma, lê `values/strings.xml`, ignora as chaves `translatable="false"` e exige que `values-<qualifier>/strings.xml` tenha **todas** as chaves de `<string>`, `<plurals>` e `<string-array>`.
* Se faltar uma chave, o teste falha e lista quais são. O motivo está no próprio teste: chave ausente não quebra o app, ela cai silenciosamente no inglês no meio da tela.
* **Cobertura:** apenas o módulo `app` (`resDir = app/src/main/res`).

### 4.2. O que o teste **não** cobre
* `sharedUi/` e `wearos/` não têm teste de paridade — conferir com `scripts/validate-ptbr.ps1`.
* O teste compara **chaves**, não placeholders nem texto. Placeholder trocado passa no CI.

### 4.3. Estado atual (02/11/2026)
* Android: ✅ **1.112 de 1.112 chaves** (0 ausentes) + 23 plurais.
* Shared UI: ✅ **249 de 249** (verificado com `validate-ptbr.ps1`).
* Wear OS: ✅ **40 de 40** (verificado com `validate-ptbr.ps1`).

---

## 5. 📱 Padrões de Interface (Android Auto, Wear OS e App)

1. **Android Auto:** mensagens diretas e legíveis em movimento (*"Faça login no YouTube no seu celular"* em vez de textos longos).
2. **Wear OS:** telas circulares têm espaço mínimo. Rótulos de botão com no máximo 1 ou 2 palavras (*"Tocar"*, *"Pausar"*, *"A seguir"*, *"No celular"*).
3. **Sentence Case:** apenas a primeira letra maiúscula (*"Ajuste de atraso da letra"*). Vale para rótulos e ações; nome próprio e sigla mantêm a grafia.
4. **Termos fixos:** o vocabulário obrigatório está em [`glossario.md`](./glossario.md) — BitChord, Dolby Atmos, Automix, WebDAV, SMB, DSP, Crossfade, addon e afins não se traduzem.

---

## 6. ✅ Checklist de Validação Pré-Submissão

- [ ] Paridade de chaves nos **3** módulos (`app`, `sharedUi`, `wearos`), sem chave sobrando nem faltando?
- [ ] Placeholders idênticos aos da fonte (`%1$s`, `%2$d`, `%d`), mesma quantidade e mesma ordem de índice?
- [ ] `%%` usado em toda string formatada que exibe `%` literal?
- [ ] Plurais com as três formas (`one` / `many` / `other`) preenchidas?
- [ ] Sentence Case aplicado, e nomes próprios/siglas preservados?
- [ ] Rótulos de Wear OS com 1 ou 2 palavras?
- [ ] `validate-ptbr.ps1` retornando `OK` nos três arquivos?
- [ ] Snapshot do hub atualizado (`bitchord_strings_pt_BR.xml`, `sharedUi_strings_pt_BR.xml` e `wearos_strings_pt_BR.xml`)?
