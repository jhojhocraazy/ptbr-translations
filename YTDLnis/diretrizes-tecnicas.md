# 📘 Diretrizes Técnicas de Localização — YTDLnis

> **Manual de Engenharia de Internacionalização (i18n) e Boas Práticas para o YTDLnis.**  
> Aplicado à localização em Português do Brasil (`pt-BR`) do aplicativo [YTDLnis](https://github.com/deniscerri/ytdlnis).

---

## 1. 🏗️ Arquitetura de Recursos (Android XML)

O YTDLnis utiliza o sistema de recursos padrão do Android:
* O arquivo principal de Português do Brasil localiza-se em `app/src/main/res/values-pt-rBR/strings.xml`.
* O aplicativo possui também uma pasta `values-pt` (para Português europeu).
* No Weblate, o componente oficial para o Brasil é **`pt_BR`**.

---

## 2. ⚡ Sintaxe XML Estrita & Escapes

### 2.1. Escape de Apóstrofo (`'`)
No Android XML, todo apóstrofo deve ser escapado como `\'`:
* ❌ `Let's get a few things set up first.`
* ✅ `Vamos configurar algumas coisas primeiro.` (ou caso contenha apóstrofo: `d\'água`)

### 2.2. Entidades Reservadas do XML
* O caractere `&` solto quebra o parser do Android. Ele deve ser sempre escrito como `&amp;` (por exemplo: `evite \"&amp;\" e espaços em nomes de arquivos`).
* Aspas duplas devem ser escapadas com barra invertida: `\"`.

### 2.3. Placeholders Posicionais
* Preservar rigorosamente `%1$s`, `%2$s`, `%d`.
* Exemplo: `Checked %1$s` ➔ `Verificado %1$s`.
* Exemplo de versão: `%1$s \u2192 %2$s` (com seta Unicode de transição entre versões).

---

## 3. 🛡️ Telas de Boas-Vindas & Permissões do Android (`welcome_*`)

O fluxo de onboarding do YTDLnis instrui o usuário sobre permissões críticas do sistema Android:

1. **Uso Irrestrito da Bateria (`welcome_perm_battery`):**
   * Essencial para que downloads em segundo plano de arquivos grandes (filmes de 4K, áudios longos) não sejam suspensos pelo gerenciador de bateria do Android (Doze Mode).
   * Tradução recomendada: *"Uso irrestrito da bateria"* / *"Evita que downloads longos sejam interrompidos em segundo plano."*
2. **Acesso ao Armazenamento (`welcome_perm_storage`):**
   * Necessário para gravar arquivos na pasta Downloads/Vídeos do celular (Scoped Storage).
3. **Alarmes e Lembretes (`welcome_perm_alarms`):**
   * Permite que downloads agendados comecem no minuto exato programado via AlarmManager.

---

## 4. 🎵 Integração de Letras LRCLIB (`lyrics_*`)

O YTDLnis integra com a API aberta do **lrclib.net** para embutir letras diretamente nas tags ID3/MP4 ou salvar arquivos `.lrc` separados:
* `lyrics_synced`: *"Sincronizadas"* (com marcações de tempo).
* `lyrics_plain`: *"Texto simples"* (sem temporização).
* `lyrics_offset`: *"Ajuste de atraso (offset)"* (correção de milissegundos).
* `embed_lyrics`: *"Embutir letras"* (inclusão das letras nos metadados do arquivo de áudio).

---

## 5. 🧪 Checklist de Validação Pré-Submissão no Weblate

- [ ] Todos os apóstrofos simples estão escapados como `\'`?
- [ ] O E comercial solto (`&`) foi substituído por `&amp;`?
- [ ] Todas as variáveis (`%1$s`, `%2$s`, `%d`) estão presentes e na posição gramatical correta?
- [ ] O vocabulário segue os padrões do **Glossário Técnico de Mídia e yt-dlp**?
- [ ] As regras de plural (`quantity="one"` e `quantity="other"`) foram respeitadas?
