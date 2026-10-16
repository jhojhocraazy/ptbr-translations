# 📘 Diretrizes Técnicas de Localização — Better Lyrics

> **Manual de Engenharia de Tradução, ICU MessageFormat e Integração com a API Crowdin v2.**  
> Aplicado à localização em Português do Brasil (`pt-BR`) do aplicativo [Better Lyrics](https://github.com/khanhas/better-lyrics).

---

## 1. 🏗️ Arquitetura do Sistema de Mensagens (JSON i18n)

O Better Lyrics utiliza o formato de catálogo de mensagens em JSON, onde cada entrada consiste em uma chave semântica única e seu respectivo valor textual:

```json
{
  "settings_appearance_theme": "Tema",
  "picture_in_picture_fitWindow": "Ajustar à janela",
  "playback_status_nowPlaying": "Reproduzindo agora: {track} de {artist}"
}
```

### 1.1. Escopo e Integridade das Chaves
* As chaves identificadoras (`settings_*`, `player_*`, `lyrics_*`) são gerenciadas diretamente pelo código TypeScript/Electron da aplicação.
* **Proibição Estrita:** O identificador da chave nunca deve ser traduzido ou modificado. Apenas o valor textual associado (`text`) é localizado.

---

## 2. ⚡ Interpolação de Variáveis & ICU MessageFormat

Diferente do formato Android XML (`%s`, `%d`), o Better Lyrics utiliza interpolação no padrão **ICU MessageFormat** com delimitadores de chaves (`{` e `}`):

### 2.1. Variáveis Simples Nomeadas
* Exemplo original: `"{current} of {total} lyrics providers available"`
* Tradução correta: `"{current} de {total} provedores de letras disponíveis"`
* **Regra Inviolável:** O nome exato da variável interna entre as chaves (`{current}`, `{total}`, `{artist}`, `{track}`) **NUNCA DEVE SER TRADUZIDO**.
  * ❌ Incorreto: `"{atual} de {total} provedores..."` (Causa erro de runtime `undefined` na UI).
  * ✅ Correto: `"{current} de {total} provedores..."`.

### 2.2. Sintaxe de Plurais em ICU
Quando uma string utiliza condicionais de quantidade:
```icu
{count, plural,
  one {# música encontrada}
  other {# músicas encontradas}
}
```
* O caractere `#` é automaticamente substituído pelo número da contagem.
* As tags `one` e `other` devem conter a concordância gramatical precisa do Português do Brasil.

---

## 3. 🛡️ Sintaxe Estrita de Escapes em JSON

Como o arquivo final é serializado em JSON puro, regras específicas de escape devem ser observadas:
1. **Aspas Duplas:** Qualquer ocorrência de aspas duplas no corpo da mensagem deve ser escapada com barra invertida (`\"`).
   * Exemplo: `"Clique em \"Configurações\" para continuar"`
2. **Barras Invertidas:** Devem ser escapadas como barra dupla (`\\`).
3. **Quebras de Linha:** Devem utilizar o caractere de escape literal `\n`.
4. **Encoding:** O arquivo deve ser sempre salvo e transmitido em **UTF-8 estrito sem BOM** para evitar corrupção de caracteres acentuados (`ç`, `ã`, `é`).

---

## 4. 🌐 Automação & Integração com a API Crowdin v2

O Better Lyrics permite manutenção contínua e instantânea utilizando a API REST v2 do Crowdin.

### 4.1. Configuração de Acesso
* **Base URL:** `https://api.crowdin.com/api/v2`
* **Project ID:** `863186`
* **Language ID:** `pt-BR`
* **Header de Autenticação:** `Authorization: Bearer <CROWDIN_PAT>`

### 4.2. Fluxo de Trabalho por API:
1. **Consultar Strings Pendentes de Tradução:**
   ```http
   GET /projects/863186/strings?languageId=pt-BR&filter=untranslated
   ```
2. **Submeter Nova Tradução:**
   ```http
   POST /projects/863186/translations
   Content-Type: application/json

   {
     "stringId": 12345,
     "languageId": "pt-BR",
     "text": "Ajustar à janela"
   }
   ```
3. **Aprovar Tradução (Proofreading):**
   ```http
   POST /projects/863186/approvals
   Content-Type: application/json

   {
     "translationId": 67890
   }
   ```

---

## 5. 🖥️ Adaptação de Interface Desktop (Spotify / Apple Music)

O Better Lyrics funciona como um widget overlay flutuante ou janela dedicada:
* **Espaço de Overlay:** Telas de overlay musical exigem termos ultra-compactos para não cobrir a arte do álbum ou o vídeo de fundo (**Canvas**).
* **Consistência de Menu:** Utilizar verbos no infinitivo para ações do usuário (*"Sincronizar"*, *"Fixar no topo"*, *"Alternar modo compacto"*).
* **Padrão Sentence Case:** No português, manter apenas a primeira letra maiúscula nos itens de menu e botões (*"Ajustar tamanho da fonte"* em vez de *"Ajustar Tamanho Da Fonte"*).

---

## 6. 🧪 Checklist de Validação Pré-Submissão no Crowdin

- [ ] Todas as variáveis `{nome}` estão com o nome exatamente igual ao original em inglês?
- [ ] As aspas duplas foram devidamente escapadas como `\"`?
- [ ] O texto segue as diretrizes do **Glossário Musical** para termos como *Canvas*, *Time-synced* e *Furigana*?
- [ ] O significado do comando condiz com o ecossistema de tocadores de música de desktop?
- [ ] O status de aprovação foi aplicado para que a tradução seja incluída no próximo PR upstream?
