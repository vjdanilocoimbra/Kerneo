# ⚡ Kerneo Lite

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Node](https://img.shields.io/badge/Node.js-20%2B-brightgreen)](https://nodejs.org)
[![Status](https://img.shields.io/badge/status-v0.4_beta-blue)]()
[![PT-BR](https://img.shields.io/badge/lang-pt--BR-yellow)]()

> **O assistente que aprende a fazer o que você pede.**
> Sem código. Sem terminal. Em português.

---

## 🧠 O que é o Kerneo?

Kerneo é um **orquestrador de IA** que mora no **seu computador**.
Fala português, age no seu sistema, lembra de você entre sessões —
e quando não sabe fazer algo, **cria a skill em segundos**.

Não é mais um chatbot na nuvem. É uma IA que **evolui com você**.

```
Você:    "cria uma skill que controla o volume do PC"
Kerneo:  ✨ Skill "volume_control" criada. Pode usar agora.

Você:    "abaixa o volume"
Kerneo:  ✓ Volume diminuído.
```

Cada skill criada é um **arquivo JavaScript real** em `src/tools/user-tools/`,
que você pode revisar, editar, versionar com git, ou compartilhar com qualquer pessoa.

---

## ⚡ O diferencial

🤖 **Auto-evolução** — único orquestrador open source com `skill_create` dinâmico
🎙️ **Voz nativa em PT-BR** — segura espaço, fala
🧠 **Memória persistente** — lembra de você entre sessões (SQLite local)
🔌 **8 providers LLM** — Groq (free), OpenAI, Anthropic, DeepSeek, Gemini, OpenRouter, Ollama (offline), Custom
🔄 **Fallback automático** — se um provider cai, outro assume
🖥️ **Age no SEU PC** — abre programas, navega, controla sistema
🔓 **MIT** — use, modifique, compartilhe

---

## 🧠 Kernel Palace — sua IA lembra de você

> Outros assistentes te esquecem quando você fecha a aba.
> O Kerneo lembra. **Entre sessões. Entre dias. Entre updates.**

```
Você:    "salva: meu CEP é 01310-100"
Kerneo:  ✓ Pronto.

( 3 dias depois, sessão nova )

Você:    "qual meu CEP?"
Kerneo:  Seu CEP é 01310-100.
```

**3 camadas locais (SQLite no seu PC)**:
- 🗂️ **Facts** — chave/valor sobre você (CEP, preferências, contexto)
- 💬 **History** — últimos turnos da conversa
- 🎯 **Sessions** — estado por sessão (último plano, retry, etc)

### 🔒 Privacidade real

Tudo em `data/kerneo.db`. **Nada vai pra nuvem**. Quer apagar? Delete o arquivo.
Funciona até offline (com Ollama). Sua memória é sua.

---

## 🚀 Como começar (5 minutos)

### 📋 Antes de tudo — o que são "pré-requisitos"?

Pra rodar o Kerneo, seu PC precisa ter **alguns programas básicos** instalados:

- 🟢 **Node.js 20+** (obrigatório) — é o "motor" que faz o Kerneo rodar
- 🔵 **Python 3.12+** (opcional) — pra futuras integrações
- 🔵 **ffmpeg** (opcional) — pra processamento de áudio

Se você nunca ouviu falar disso, sem stress. Tem **2 caminhos** pra você escolher:

---

### 🟢 Opção A — Caminho automático (recomendado pra leigos)

Pra quem **não quer ter trabalho** instalando programa por programa:

1. **Baixa esse repo**: clica no botão verde **Code** (no topo) → **Download ZIP** → extrai
2. **Abre a pasta** `installer-prereqs/` dentro do que você baixou
3. **Double-click em `Verificar_Requisitos.exe`**
   - Aceita "Sim" quando pedir permissão de administrador
   - Clica em **VERIFICAR** → mostra o que tá faltando no seu PC
   - Clica em **INSTALAR FALTANDO** → instala tudo automaticamente
4. **Volta pra pasta principal** do Kerneo
5. **Double-click em `install.bat`**
6. Escolhe provider quando perguntar:
   - **Groq** (recomendado: free tier, sem cartão)
   - **OpenAI** (full features incluindo voz)
   - Pular (configurar manualmente em `config.json`)
7. Cola tua API key
8. Pronto — abre `http://localhost:5070`

> ⚠️ **Windows Defender pode avisar** que o `.exe` é arquivo desconhecido. É falso positivo (arquivo sem assinatura digital). Clica em **"Mais informações" → "Executar mesmo assim"**.

---

### 🔧 Opção B — Caminho manual (pra quem prefere instalar na mão)

Pra quem **prefere controlar cada passo** ou já tem alguns programas instalados:

#### Windows / macOS

1. **Instala Node.js 20+**: https://nodejs.org → botão verde **LTS** → next, next, finish
2. **Baixa esse repo** (Code → Download ZIP, ou `git clone`)
3. **Double-click em `install.bat`** (Windows) ou `bash install.sh` (Mac)
4. Escolhe provider quando perguntar:
   - **Groq** (recomendado: free tier, sem cartão)
   - **OpenAI** (full features incluindo voz)
   - Pular (configurar manualmente em `config.json`)
5. Cola tua API key
6. Pronto — abre `http://localhost:5070`

#### Linux

```bash
# Instala Node.js 20+
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Clona e roda
git clone https://github.com/vjdanilocoimbra/Kerneo.git
cd Kerneo
bash install.sh
```

> 💡 **Não sabe qual caminho escolher?** Vai na **Opção A** — o `Verificar_Requisitos.exe` te diz o que falta e resolve sozinho. Se já tem Node.js instalado, ele só confirma e segue.

📖 **Documentação completa**: [COMECE-AQUI.md](COMECE-AQUI.md) · [INSTALL.md](INSTALL.md)

---

## 🎯 Comandos pra testar

```
# Apps nativos
"abre a calculadora"
"abre o paint"
"abre o vscode"

# Sites
"abre o youtube"
"pesquisa pizza no ifood"

# Sistema
"que horas são"
"salva: meu cep é 01310-100"

# ✨ Auto-evolução (DIFERENCIAL!)
"cria uma skill que tira screenshot"
"cria uma skill que mostra uso de CPU"
"quais skills você tem?"
"refaz a skill X" (se quebrar)

# Compartilhamento
"exporta a skill volume_control"
"instala a skill desse link: https://gist.github.com/..."
```

---

## 🛠️ 15 tools nativas (out-of-the-box)

| Categoria | Tools |
|-----------|-------|
| **Auto-evolução** | `skill_create`, `skill_iterate`, `skill_list`, `skill_remove` |
| **Marketplace** | `skill_share`, `skill_install_url` |
| **Onboarding** | `kerneo_help`, `kerneo_self_update` |
| **Sistema** | `system_app_open`, `system_info`, `file_io` |
| **Browser** | `browser_open`, `browser_search` |
| **Web** | `web_search` |
| **Memória** | `memory_op` |

E você pode criar quantas mais quiser, dinamicamente.

---

## 🧩 Stack & decisões

- **Backend**: Node.js 20+ (sem framework, http+ws nativos)
- **LLM**: provider chain com fallback automático
- **Voz**: Web Speech API + OpenAI TTS streaming + Whisper fallback
- **Storage**: SQLite via better-sqlite3 (local, zero config)
- **Frontend**: vanilla HTML/CSS/JS (zero framework, zero build step)
- **HTTPS**: cert self-signed auto-gerado
- **Total**: ~280 KB de código, 80MB com node_modules

---

## 📚 Documentação

- 🎯 [COMECE-AQUI.md](COMECE-AQUI.md) — tutorial pra leigos
- 🔧 [INSTALL.md](INSTALL.md) — instalação detalhada
- 📖 [TUTORIAL.md](TUTORIAL.md) — extender com IA-assisted dev
- 🏗️ [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — arquitetura técnica
- 🔌 [docs/API.md](docs/API.md) — endpoints HTTP

---

## 🤝 Contribua

Esse projeto vive da comunidade.

- 🐛 **Reportou bug?** [Issues](../../issues/new)
- ✨ **Tem ideia?** [Feature requests](../../issues/new)
- 🪄 **Criou skill legal?** Compartilha! Veja [CONTRIBUTING.md](CONTRIBUTING.md)
- 🤝 **Quer mexer no código?** Fork → branch → PR

Skills criadas são apenas arquivos `.js` — qualquer um pode revisar, melhorar, compartilhar.

---

## 🗺️ Roadmap

- [ ] Standalone `.exe` (build via `pkg`) — sem precisar instalar Node
- [ ] Skill marketplace (galeria pública de skills da comunidade)
- [ ] Tool `screen_help` (vision: "o que tá errado nessa tela?")
- [ ] Tool `daily_summary` (resumo do dia: emails, calendar, tarefas)
- [ ] Mobile app (React Native)
- [ ] Discord bot

Veja [issues](../../issues) pra acompanhar.

---

## 💚 Apoie o projeto

Kerneo Lite é **open source e gratuito** — pra sempre.

Se ele te ajudou, e você quiser apoiar a evolução do projeto (servidores, infra, novas features pra todo mundo):

### 🇧🇷 PIX (Brasil)

```
Chave: kerneolabs@gmail.com
```

Toda contribuição ajuda a manter o desenvolvimento ativo. **Obrigado!** 🙏

> Você não precisa pagar nada pra usar.
> O Kerneo é seu, gratuito, pra sempre.
> Mas se quiser ajudar a evoluir — vai fazer diferença.

---

## 📜 License

[MIT](LICENSE) — faça o que quiser, sem garantia.

---

## 🔧 Pra dev — comandos úteis

```bash
npm install            # instala deps
npm start              # roda servidor (HTTP+HTTPS)
npm run dev            # auto-reload ao salvar
npm test               # smoke test (8 queries reais)
LOG_LEVEL=debug npm start   # logs verbosos
```

---

**Travou?** Roda `troubleshoot.bat` (Windows) ou `bash troubleshoot.sh` (Mac/Linux) — gera `diagnostico.txt` com tudo sobre o sistema.

**Ajude o projeto** ⭐ — dá uma estrela no GitHub. É gratuito e ajuda muito.
