# 📐 Diretrizes Técnicas — Localização TizenTube (pt-BR)

> **Documento de Engenharia e Controle de Qualidade para localização em Português do Brasil (`pt-BR`).**

---

## 🎯 1. Padrões de Sintaxe JSON

* **Codificação:** UTF-8 estrito (sem BOM).
* **Indentação:** 2 espaços.
* **Caracteres Especiais & Emojis:** Os emojis oficiais presentes nos títulos originais (ex: `❤️`, `ℹ️`) devem ser preservados sem alteração de codificação.
* **Aspas:** Todas as chaves e valores devem utilizar aspas duplas (`"`). Aspas simples internas devem ser usadas diretamente sem necessidade de escape em JSON: `"Ativar Aviso de 'Você ainda está assistindo?'"`.

---

## 🛡️ 2. Regras Fundamentais de Placeholders

O TizenTube utiliza o motor de interpolação do **i18next** com sintaxe de chaves duplas: `{{variavel}}`.

### 🚨 Regra Inviolável:
**NUNCA traduza, renomeie, adicione espaços ou remova os identificadores internos das variáveis.**

| Placeholder Original | Exemplo de Aplicação em pt-BR |
| :--- | :--- |
| `{{count}}` | `"{{count}} segundo"`, `"{{count}} minutos"` |
| `{{name}}` | `"Você pode acessar a página {{name}} lendo o código QR abaixo."` |
| `{{version}}` | `"Versão atual: {{version}}"` |
| `{{latestVersion}}` / `{{currentVersion}}` | `"Uma nova versão do TizenTube Cobalt está disponível: {{latestVersion}}, atual: {{currentVersion}}"` |
| `{{date}}` | `"Data de lançamento: {{date}}"` |
| `{{segment}}` | `"Pulando {{segment}}"`, `"Pular {{segment}}"` |

---

## 🇧🇷 3. Adaptação Cultural e Fluidez Linguística

1. **Evitar Construções Literais:**
   * Inglês: *"To view chapters, press the up arrow button"*
   * Tradução literal: *"Para ver capítulos, pressione o botão de seta para cima"*
   * Tradução refinada: *"Para ver os capítulos, pressione o botão de seta para cima"*
2. **Contexto de Controle Remoto de TV:**
   * A interface é operada via D-Pad (direcional do controle remoto). Termos como "pressione", "selecione" e "seta para cima/baixo" devem refletir a ergonomia da televisão de 10 pés (*10-foot UI*).
3. **Padrão Brasileiro de Plataformas de Streaming:**
   * "Watch Later" ➔ **Assistir mais tarde**
   * "Subscriptions" ➔ **Inscrições**
   * "Library" ➔ **Biblioteca**
   * "Picture-in-Picture" ➔ **Picture-in-Picture (PiP)**
