# 📗 Glossário Terminológico de Redes & DNS — DNSToggle

> **Dicionário Técnico de Padronização para Português do Brasil (`pt-BR`).**  
> Mantido por [**Joseph Alves** (@jhojhocraazy)](https://github.com/jhojhocraazy).

---

## 📌 Introdução

O DNSToggle conecta o sistema operacional Android com protocolos de rede e segurança da informação.  
Este glossário garante a harmonia entre termos técnicos universais da internet e as convenções oficiais de tradução adotadas pela Google no ecossistema Android brasileiro.

---

## 1. 🚫 Termos que NUNCA Devem Ser Traduzidos

Estes termos são siglas consagradas, marcas de provedores ou ferramentas técnicas de desenvolvimento:

| Termo em Inglês | Tradução no DNSToggle | Justificativa / Contexto |
| :--- | :--- | :--- |
| **DNS** | `DNS` | Domain Name System. Sigla universal da internet. |
| **DoT** | `DoT` | DNS over TLS (protocolo nativo do Android para criptografar DNS). |
| **DoH** | `DoH` | DNS over HTTPS. |
| **Cloudflare / 1.1.1.1** | *Manter nome exato* | Provedor de DNS de alta velocidade e privacidade. |
| **AdGuard DNS** | *Manter nome exato* | Provedor focado em bloqueio de anúncios e rastreadores. |
| **NextDNS** | *Manter nome exato* | Provedor de DNS configurável em nuvem. |
| **Quad9** | *Manter nome exato* | Provedor de DNS seguro sem fins lucrativos. |
| **Shizuku** | `Shizuku` | Aplicativo Android que concede permissões de sistema via ADB sem root. |
| **ADB** | `ADB` | Android Debug Bridge (ferramenta de depuração da Google). |
| **Tile / Tiles** | `Bloco` / `Blocos` ou `Tile` | Elementos de botão da barra de Configurações Rápidas do Android. |

---

## 2. 📱 Configurações do Android OS & Estados dos Blocos (Tiles)

| Termo em Inglês | Tradução Oficial pt-BR | Contexto / Exemplo |
| :--- | :--- | :--- |
| **Private DNS** | `DNS Privado` | Nome oficial do recurso no Android 9+ (Settings ➔ Network ➔ Private DNS). |
| **Off** | `Desativado` | Estado onde o DNS Privado está desligado. |
| **Automatic** | `Automático` | Resolução gerenciada automaticamente pelo Android/operadora. |
| **Toggle** | `Alternar` | Ação de ligar/desligar ou trocar de servidor com 1 toque. |
| **Active / Enabled** | `Ativo` / `Ativado` | Estado atual do bloco na barra de notificações. |
| **Inactive / Disabled** | `Inativo` / `Desativado` | Bloco apagado ou desligado. |
| **Switching...** | `Alternando...` | Estado transitório enquanto o sistema aplica a nova rota. |
| **Custom DNS** | `DNS personalizado` | Servidor customizado inserido manualmente pelo usuário. |
| **Hostname** | `Nome do host` | Endereço de domínio do servidor (ex: `dns.adguard.com`). |

---

## 3. 🔒 Permissões, Segurança & Sistema

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Secure Settings** | `Configurações seguras` | Tabela protegida do sistema operacional Android. |
| **Grant permission** | `Conceder permissão` | Ação de autorizar o app a alterar ajustes protegidos. |
| **Root required?** | `Requer root?` | Pergunta frequente em diálogos de ajuda. |
| **No root needed** | `Não é necessário root` | Frase explicativa para tranquilizar o usuário. |
| **Reboot / Restart** | `Reiniciar` | Reinicialização do dispositivo ou do serviço. |
| **Persistent Notification** | `Notificação fixa` / `persistente` | Notificação que mantém o serviço ativo em segundo plano. |
| **Fallback Provider** | `Provedor de contingência` | Servidor alternativo caso o principal não responda. |

---

## 4. 🛒 Metadados de Lojas (F-Droid & Google Play)

| Termo em Inglês | Tradução Oficial pt-BR | Contexto |
| :--- | :--- | :--- |
| **Quick Settings** | `Configurações Rápidas` | Área de atalhos expansível da barra de notificações. |
| **Notification Shade** | `Barra de notificações` | Área superior que desce ao arrastar a tela para baixo. |
| **One-tap toggle** | `Alternância com um toque` | Destaque de facilidade de uso nos metadados. |
| **Open Source** | `Código aberto` | Licenciamento livre e auditável do aplicativo. |
| **Changelog** | `Notas da versão` / `Novidades` | Lista de melhorias e correções de bugs. |
