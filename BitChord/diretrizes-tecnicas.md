# 📘 Diretrizes Técnicas de Localização — BitChord

> **Manual de Engenharia de Internacionalização (i18n) e Arquitetura Multiplataforma (Android, Desktop e Wear OS).**  
> Aplicado à localização em Português do Brasil (`pt-BR`) do aplicativo [BitChord](https://github.com/kushagrasinghx/BitChord).

---

## 1. 🏗️ Arquitetura de Idiomas & `LocaleTags.kt`

O BitChord possui uma arquitetura centralizada para o gerenciamento de idiomas definida no arquivo `shared/.../LocaleTags.kt`:

### 1.1. Por que o identificador é `pt` e não `pt-BR`?
* A função `LocaleTags.normalizeAppTag()` simplifica as tags BCP-47 para o código de duas letras base (`pt-BR` ➔ `pt`).
* Apenas o Chinês possui tratamento diferenciado (`zh-Hant` e `zh-Hans`) devido às variações de escrita Tradicional e Simplificada.
* **Vantagem de Compatibilidade:** Manter o Português do Brasil na pasta `values-pt` garante que tanto usuários com dispositivos configurados como `pt-BR` quanto qualquer outro falante de português no mundo receba a interface em português (em vez de cair no fallback em inglês).

---

## 2. ⚡ Casos Extremos de XML e Escapes

### 2.1. Escape de Apóstrofo (`'`)
No Android XML, apóstrofos simples devem ser rigorosamente escapados como `\'`:
* ❌ `Your device's own panel`
* ✅ `Painel nativo do seu dispositivo` (ou com escape: `device\'s`)

### 2.2. Porcentagem Literal em Strings Formatadas (`%%`)
Quando uma string contém o caractere de porcentagem acompanhado de placeholders:
```xml
<string name="downloads_progress">Downloads • %1$d%%</string>
```
O `%` literal deve ser duplicado (`%%`) para não quebrar o formatador do Kotlin.

### 2.3. Placeholders Posicionais
Sempre utilizar argumentos com número de índice (`%1$s`, `%2$s`, `%1$d`) para permitir a inversão natural da ordem das palavras no português:
* Inglês: `Playing from %1$s`
* Português: `Reproduzindo de %1$s`

---

## 3. 🧪 Conformidade com os Testes Unitários Nativos

O repositório do BitChord possui dois testes automatizados fundamentais que rodam na pipeline de CI:

### 3.1. `LocaleStringsTest.kt` (Módulo Android)
* O teste verifica se **todas as chaves translatáveis** (`translatable != "false"`) presentes em `values/strings.xml` existem no arquivo `values-pt/strings.xml`.
* Se faltar uma única chave, o teste lança uma asserção de falha.
* **Resultado da nossa implementação:** ✅ **1.053 de 1.053 chaves sincronizadas (0 ausentes)**.

### 3.2. `DesktopStringsTest.kt` (Módulo Desktop)
* O teste verifica se o catálogo de desktop (`desktop-pt.xml` e `pt.xml`) possui paridade com os catálogos em inglês.
* **Resultado da nossa implementação:** ✅ **100% de paridade (0 ausentes)**.

---

## 4. 📱 Padrões de Interface (Android Auto, Desktop e Wear OS)

1. **Android Auto:** Mensagens de aviso devem ser diretas e fáceis de ler rapidamente em movimento (*"Faça login no YouTube no seu celular"* em vez de textos longos).
2. **Wear OS:** Telas circulares de relógios possuem espaço mínimo. Rótulos de botões devem conter no máximo 1 ou 2 palavras (*"Tocar"*, *"Pausar"*, *"A seguir"*, *"No celular"*).
3. **Sentence Case:** Seguir o padrão de design com apenas a primeira letra maiúscula (*"Ajuste de atraso da letra"*).
