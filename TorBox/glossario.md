# 📘 Glossário — TorBox (pt-BR)

> Termos de domínio do **TorBox App** e como ficam em português do Brasil.
> Referência para manter a tradução coerente com a finalidade do produto: gerenciador de downloads (torrents, Usenet e WebDAV) para usuários avançados.

---

## Regra geral

1. **Fonte:** sempre o `en.json` do projeto (Regra 7 do `AGENTS.md`).
2. **Terminologia de torrents:** segue o [qBittorrent pt-BR](https://github.com/qbittorrent/qBittorrent/blob/master/src/lang/qbittorrent_pt_BR.ts) quando ele traduz.
3. **Marca e recurso proprietário:** não traduzir.
4. **`Admin.*` e `CustomViews.presets.*`:** permanecem em inglês, por regra do projeto.

---

## Termos

| Inglês | pt-BR | Observação |
| :--- | :--- | :--- |
| **TorBox / TBM** | `TorBox` / `TBM` | Marca e abreviação do produto |
| **Airlock / Airlocked** | `Airlock` / `Airlocked` | Recurso exclusivo do TorBox; não traduzir |
| **Torrent / Torrents** | `Torrent` / `Torrents` | Mantido, como no qBittorrent |
| **Usenet** | `Usenet` | Protocolo/rede; manter |
| **WebDL / Webdl** | `WebDL` / `Webdl` | Tipo de download; manter a forma do original |
| **Seed / Seeds** | `Semente` / `Sementes` | Lista de transferências do qBittorrent |
| **Peer / Peers** | `Par` / `Pares` | Idem |
| **Tag / Tags** | `Etiqueta` / `Etiquetas` | Idem |
| **Ratio** | `Proporção` | Relação enviado/baixado |
| **Tracker** | `Rastreador` | |
| **Magnet** | `Magnet` | `Link magnet` |
| **Cache** | `Cache` | Mantido |
| **Download / Upload** | `Download` / `Upload` | Mantidos |
| **Status** | `Status` | Mantido |
| **Hash / ID** | `Hash` / `ID` | Mantidos |
| **Meta DL** | `Meta DL` | Estado de download de metadados |
| **Pro** | `Pro` | Nome do plano |
| **API key** | `Chave de API` | |
| **Rate limit** | `Limite de taxa` | |
| **Webhook** | `Webhook` | Termo técnico mantido |
| **Stalled** | `Parado` | Mesmo termo do qBittorrent para downloads sem atividade |
| **Free / Essential / Standard** | `Grátis` / `Essencial` / `Padrão` | Nomes de plano traduzidos; `Pro` permanece |

---

## Tom

- Botões e ações: imperativo curto — “Arquivar”, “Excluir”, “Tentar novamente”.
- Mensagens de erro: diretas e acionáveis — “Não foi possível conectar aos servidores do TorBox.”
- Configurações: frases curtas, sem jargão desnecessário.
- **Caixa:** Sentence Case em português (só a primeira palavra e nomes próprios em maiúscula), mesmo quando o inglês usa Title Case.
- Nunca traduzir nome de recurso (`Airlock`, `TBM`, `TorBox`) nem alterar `Admin.*`.
