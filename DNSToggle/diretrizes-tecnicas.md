# 📘 Diretrizes Técnicas de Localização — DNSToggle

> **Manual de Engenharia de Tradução, Limites de Interface de Tiles e Alinhamento com o Android OS.**  
> Aplicado à localização em Português do Brasil (`pt-BR`) do aplicativo [DNSToggle](https://github.com/ELowry/DNSToggle).

---

## 1. 📏 O Desafio dos Quick Settings Tiles (Limites Estritos de Espaço)

Os **Blocos das Configurações Rápidas (Quick Settings Tiles)** da barra de notificações do Android possuem o layout mais restrito de todo o sistema operacional:

### 1.1. Limite de Caracteres por Linha
* **Rótulo Principal (Title):** Máximo recomendado de **10 a 14 caracteres**.  
  * Se ultrapassar, o Android corta o texto com reticências (`...`) ou quebra de forma feia.
  * ❌ *Servidor de DNS Privado* (Cortado na tela: *Servidor de D...*)
  * ✅ *DNS Privado* (Renderiza perfeitamente em 100% dos celulares)
* **Subtítulo de Estado (Subtitle):** Máximo de **12 a 16 caracteres**.
  * Deve indicar o estado de forma instantânea: *Ativo*, *Inativo*, *Alternando*, *Desativado*, *Automático*.

---

## 2. 📱 Alinhamento Estrito com o Vocabulário do Android OS da Google

O DNSToggle manipula diretamente o ajuste de sistema de **DNS Privado** introduzido no Android 9 (Pie).  
Para que o usuário brasileiro não fique confuso, as traduções do DNSToggle devem bater **100% com os termos nativos do Android em pt-BR**:

| Configuração do Android (Inglês) | Tradução Oficial Google Android (pt-BR) | Regra no DNSToggle |
| :--- | :--- | :--- |
| **Private DNS** | `DNS Privado` | Sempre utilizar *DNS Privado* (com iniciais maiúsculas por ser nome do recurso no OS). |
| **Off** | `Desativado` | Padrão do sistema (não usar "Desligado"). |
| **Automatic** | `Automático` | Resolução padrão do provedor de internet/DHCP. |
| **Private DNS provider hostname** | `Nome do host do provedor de DNS privado` | Texto do diálogo de configuração manual. |

---

## 3. 🔒 Diálogos de Segurança & Comandos ADB

O DNSToggle necessita da permissão especial `WRITE_SECURE_SETTINGS` para alternar o DNS do sistema sem acesso root.

### 3.1. Preservação Absoluta de Comandos de Terminal
Os blocos de código com comandos ADB nunca devem sofrer alterações ou traduções acidentais:
```bash
adb shell pm grant com.draco.dnstoggle android.permission.WRITE_SECURE_SETTINGS
```

### 3.2. Clareza Didática para o Usuário
Muitos usuários comuns têm receio de usar o terminal ADB. As mensagens de diálogo em português devem ser didáticas, amigáveis e estruturadas:
* Explique claramente que **não é necessário fazer root**.
* Mencione a alternativa simples via **Shizuku** para quem não tem computador por perto.
* Destaque que a permissão só precisa ser concedida **uma única vez**.

---

## 4. 🌐 Padrões de Localização no Weblate

O DNSToggle utiliza a plataforma Weblate integrada ao repositório GitHub upstream:

1. **Placeholders e Variáveis:**
   * Preservar rigorosamente `%s`, `%d` e variáveis nomeadas `{server_name}`.
2. **Flags de Tradução do Weblate:**
   * Prestar atenção às marcações de qualidade automáticas do Weblate (ex: *Verificação de pontuação final*, *Placeholders faltantes*, *Tamanho máximo excedido*).
3. **Commit Messages do Weblate:**
   * Os commits gerados pelo Weblate no branch `translation` trazem o autor registrado na plataforma. Mantenha o perfil no Weblate sempre com o nome **Joseph Alves** e email `jhojhocraazy@gmail.com`.

---

## 5. 🧪 Checklist de Validação Pré-Submissão

- [ ] Os títulos dos blocos (Tiles) respeitam o limite de até 14 caracteres para evitar cortes com reticências?
- [ ] O vocabulário utilizado é 100% fiel às palavras oficiais das configurações do Android em pt-BR?
- [ ] Os comandos técnicos de permissão (`adb shell pm grant...`) estão intactos sem nenhuma alteração?
- [ ] Os nomes dos serviços (Cloudflare, AdGuard, NextDNS, Shizuku) foram preservados?
- [ ] Todos os 5 componentes oficiais (`app`, `tiles`, `notifications`, `dialogs`, `metadata`) continuam com 100% de cobertura?
