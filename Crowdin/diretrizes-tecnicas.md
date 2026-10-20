# 📐 Diretrizes Técnicas — Localização Crowdin Platform (pt-BR)

> **Padrões de Engenharia Linguística e Rigor Técnico para a Tradução Oficial da Plataforma Crowdin.**

---

## 🎯 1. Padrões de Interpolação & Variáveis

O Crowdin utiliza principalmente o padrão de interpolação em chaves simples (`{name}`, `{count}`) na interface moderna, e chaves duplas ou Jinja/Blade em e-mails e páginas de servidor.

### 🚨 Regra Inviolável:
**NUNCA altere, renomeie, remova ou traduza identificadores dentro de chaves.**

| Variável Original | Exemplo de Aplicação em pt-BR |
| :--- | :--- |
| `{name}` | `"O arquivo \"{name}\" excede o tamanho máximo de 8 MB"` |
| `{count}` | `"Você pode enviar até {count} arquivos."` |
| `{vendor}` | `"Acompanhe gastos por idioma e {vendor} para manter orçamentos previsíveis."` |
| `{percent}%` | `"Progresso atual: {percent}%"` |

---

## 🇧🇷 2. Naturalidade e Ergonomia no Português do Brasil

1. **Voz Ativa e Concisão:**
   * Evite prolixidade desnecessária em botões e tooltips. Ações devem ser diretas no infinitivo ou imperativo padrão (*"Remover arquivo"*, *"Calcular estimativa"*).
2. **Consistência em Ambientes Corporativos e Open Source:**
   * O Crowdin atende desde desenvolvedores individuais até grandes corporações. O tom deve ser profissional, polido e claro.
3. **Sem Anglicismos Forçados ou Termos de Portugal:**
   * Use **"arquivo"** (e não *ficheiro*).
   * Use **"salvar"** (e não *guardar*).
   * Use **"tela"** (e não *ecrã*).
   * Use **"equipe"** (e não *equipa*).
