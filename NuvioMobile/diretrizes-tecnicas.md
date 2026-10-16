# 📘 Diretrizes Técnicas de Localização — Nuvio Mobile

> **Manual de Engenharia de Internacionalização (i18n) e Boas Práticas para Compose Multiplatform (CMP).**  
> Este documento reúne todas as regras e casos extremos aplicados nos Pull Requests oficiais do Nuvio Mobile.

---

## 1. 🏗️ Arquitetura do Compose Multiplatform (CMP)

O Nuvio Mobile utiliza o sistema de recursos unificado do Compose Multiplatform (`org.jetbrains.compose.resources`).  
Diferente do Android nativo antigo:
1. **Localização Obrigatória:**  
   As strings traduzidas devem residir exclusivamente em:  
   `composeApp/src/commonMain/composeResources/values-pt-rBR/`
2. **Escopo Global de Símbolos (`Res.string.*`):**  
   O compilador Kotlin gera uma classe estática única para todos os arquivos XML.
   * **Colisão de Nomes:** Duas strings com o mesmo atributo `name` em arquivos diferentes (ex: em `strings.xml` e em `strings_party.xml`) causarão falha de compilação por símbolo duplicado.
   * **Integridade das Chaves:** O atributo `name` nunca deve ser alterado ou traduzido. Deve ser rigorosamente idêntico ao arquivo base em inglês (`values/*.xml`).
3. **Tags Raiz Puras:**  
   Utilizar `<resources>` sem atributos de namespace legados do Android (`xmlns:android`), garantindo compatibilidade multiplataforma nativa (Android e iOS).

---

## 2. ⚡ Sintaxe XML Estrita & Escapes Obrigatórios

O parser do Android Asset Packaging Tool (AAPT2) e o parser CMP tratam caracteres especiais de forma rigorosa:

### 2.1. Escape de Apóstrofo (`'`)
No Android XML, apóstrofos não escapados quebram o parser do compilador com o erro fatal `AAPT: error: unescaped apostrophe`.
* ❌ **Incorreto:** `<string name="load_error">Não foi possível carregar d'água</string>`
* ✅ **Correto:** `<string name="load_error">Não foi possível carregar d\'água</string>`
* ✅ **Alternativa Válida:** Envolver a frase inteira em aspas duplas: `"Não foi possível carregar d'água"` (a convenção adotada no Nuvio é o escape com barra invertida `\'`).

### 2.2. Entidades XML Reservadas
* **E comercial (`&`):** Deve ser sempre escrito como `&amp;`. Nunca utilize `&` solto.
* **Símbolos de Menor e Maior (`<` e `>`):** Devem ser escritos como `&lt;` e `&gt;`, exceto quando formarem tags HTML permitidas.
* **Aspas duplas (`"`):** Devem ser escapadas como `\"`.

### 2.3. Símbolo de Porcentagem Literal (`%%`)
Se uma string contiver um símbolo de `%` que represente uma porcentagem real (e não uma variável de formatação):
* No XML onde houver outras variáveis formatadas, o símbolo deve ser duplicado: `%%` (ex: `Buffer atingiu 100%%`).
* Caso contrário, o formatador de runtime tentará interpretar `%` como início de uma variável e causará um `UnknownFormatConversionException` (crash em produção).

---

## 3. 🎯 Placeholders, Variáveis e Argumentos Posicionais

### 3.1. Placeholders Posicionais Obrigatórios
Em traduções, a estrutura gramatical do português frequentemente exige inverter a ordem dos termos em relação ao inglês. Por isso, **sempre utilize especificadores posicionais**:

* Exemplo em Inglês:
  ```xml
  <string name="sync_status">Syncing %1$s of %2$s items</string>
  ```
* Exemplo em Português:
  ```xml
  <string name="sync_status">Sincronizando %1$s de %2$s itens</string>
  ```
* Se for necessário reordenar:
  ```xml
  <string name="server_log">Failed on server %1$s at %2$s</string>
  <!-- Invertendo a ordem mantendo a injeção correta das variáveis: -->
  <string name="server_log">Às %2$s, houve falha no servidor %1$s</string>
  ```

### 3.2. Tipos de Variáveis Suportados:
* `%s` / `%1$s`: Strings (nomes de filmes, URLs, títulos).
* `%d` / `%1$d`: Inteiros (contadores, temporadas, números de porta).
* `%f` / `%1$f`: Ponto flutuante (taxas de quadros, notas com decimais).

### 3.3. Regras para Plurais (`<plurals>`)
No Compose Multiplatform, as tags de plural seguem as regras de pluralização da língua portuguesa do Brasil (pt-BR):
* `quantity="one"`: Aplicado estritamente para o número 1.
* `quantity="other"`: Aplicado para 0 e qualquer valor maior que 1.

```xml
<plurals name="items_count">
    <item quantity="one">%d item selecionado</item>
    <item quantity="other">%d itens selecionados</item>
</plurals>
```

---

## 4. 🔠 Tags HTML Inline e Rich Text

O Compose Multiplatform suporta formatação rica básica nas strings.
* **Tags Permitidas:** `<b>` (negrito), `<i>` (itálico), `<u>` (sublinhado), `<br/>` (quebra de linha).
* **Regra de Fechamento:** Toda tag aberta deve ser obrigatoriamente fechada. Uma tag `<b>` sem o respectivo `</b>` aborta a compilação.
* **Preservação de Espaçamento:**
  * ❌ `<b>%1$s</b>episódios` (Faltando espaço, vai renderizar grudado na tela).
  * ✅ `<b>%1$s</b> episódios` (Espaçamento natural preservado).

---

## 5. 📱 Design de Interface Mobile & Estilo pt-BR

### 5.1. Sentence Case vs Title Case
* No inglês, é padrão usar **Title Case** nos botões e títulos (*"Add To Watchlist"*, *"Clear Search History"*).
* No Português do Brasil (seguindo o padrão Material Design 3 e Apple HIG), utiliza-se **Sentence Case** (apenas a primeira letra maiúscula, exceto nomes próprios):
  * ❌ *Adicionar À Lista De Interesses*
  * ✅ *Adicionar à lista de interesses*

### 5.2. Concisão e Prevenção de Estouro de Layout (Truncation)
Telas mobile possuem largura física reduzida. O português é, em média, **20% a 30% mais longo** que o inglês.
* Em botões de ação e títulos de abas, priorize verbos diretos e objetivos:
  * Em vez de: *"Pressione aqui para sincronizar seus dados"* ➔ Use: *"Sincronizar dados"*.
  * Em vez de: *"Configurações do reprodutor de vídeo"* ➔ Use: *"Configurações do player"*.

### 5.3. Neutralidade e Naturalidade Gramatical
* Evite construções literais e traduções automáticas (ex: *"Vocês está conectado com sucesso"*).
* Prefira voz ativa e frases naturais para o usuário brasileiro.
* Evite termos do Português europeu: use *"Tela"* (não ecrã), *"Salvar"* (não guardar), *"Arquivo"* (não ficheiro).

---

## 6. 🤖 Pipeline de CI/CD (GitHub Actions) do Nuvio

Todo Pull Request enviado ao upstream passa por dois testes automatizados:

1. **`validate_pr_body` (PR Template Check):**
   * O corpo do PR deve conter a marcação exata das caixas de checagem:
     ```markdown
     ### Type of change
     - [x] Localization
     ```
   * Deve conter uma descrição clara e concisa em inglês do que foi alterado para que os mantenedores possam revisar rapidamente.

2. **`Build fullDebug APK` (PR Full Debug Build):**
   * O runner do GitHub executa `./gradlew assembleFullDebug`.
   * Qualquer erro de sintaxe XML, escape ausente ou encoding incorreto (não-UTF-8) causará a falha deste job.

---

## 7. 🧪 Checklist de Validação Pré-Commit

Antes de abrir qualquer commit ou PR:
- [ ] Todos os apóstrofos (`'`) foram escapados como `\'`?
- [ ] Todos os E comerciais soltos foram substituídos por `&amp;`?
- [ ] Todas as variáveis do original em inglês (`%1$s`, `%2$d`, etc.) estão presentes na tradução?
- [ ] Nenhuma tag `<string name="...">` teve seu atributo `name` modificado?
- [ ] O arquivo XML foi salvo com codificação **UTF-8 sem BOM**?
- [ ] O texto foi formatado em **Sentence Case**?
