# Local LLM Setup

Guide for running local LLMs on macOS with 16GB RAM.

## Prerequisites

- macOS with Apple Silicon (M1/M2/M3/M4)
- 16GB RAM
- Homebrew installed

## Install Ollama

```bash
mise use -g ollama
```

Start the server:

```bash
ollama serve
```

## Recommended Models

### General Purpose (16GB RAM)

| Model | Size | Pull Command | Notes |
| --- | --- | --- | --- |
| `qwen2.5:3b` | ~2GB | `ollama pull qwen2.5:3b` | Fast, surprisingly capable |
| `phi4-mini` | ~2.5GB | `ollama pull phi4-mini` | Strong reasoning for size |
| `llama3.2:3b` | ~2GB | `ollama pull llama3.2:3b` | Meta's small model |
| `gemma3:4b` | ~3GB | `ollama pull gemma3:4b` | Google's efficient model |
| `gemma4:12b` | ~8GB | `ollama pull gemma4:12b` | Multimodal, vision + text |
| `mistral:7b` | ~4GB | `ollama pull mistral:7b` | Best quality-to-size ratio |

### Coding Models

| Model | Size | Pull Command | Notes |
| --- | --- | --- | --- |
| `qwen2.5-coder:7b` | ~4.5GB | `ollama pull qwen2.5-coder:7b` | Best coding model at this size |
| `qwen2.5-coder:3b` | ~2GB | `ollama pull qwen2.5-coder:3b` | Faster, good for simple tasks |
| `deepseek-coder-v2:16b` | ~9GB | `ollama pull deepseek-coder-v2:16b` | Tight fit, excellent quality |
| `codellama:7b` | ~4GB | `ollama pull codellama:7b` | Good for code infilling |

## OpenCode with Local LLM

OpenCode is an open-source terminal AI coding agent that works with Ollama.

### Install OpenCode

```bash
brew install opencode
```

### Configure for Ollama

Create `opencode.json` in your project root or globally at `~/.config/opencode/opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "ollama/qwen2.5-coder:7b",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        "qwen2.5-coder:7b": {
          "name": "qwen2.5-coder:7b"
        },
        "qwen2.5-coder:3b": {
          "name": "qwen2.5-coder:3b"
        },
        "deepseek-coder-v2:16b": {
          "name": "deepseek-coder-v2:16b"
        },
        "codellama:7b": {
          "name": "codellama:7b"
        }
      }
    }
  }
}
```

### Context Window

OpenCode requires 64k+ context for agentic features. To set context size, create a custom Modelfile:

```bash
echo 'FROM qwen2.5-coder:7b
PARAMETER num_ctx 32768' | ollama create qwen2.5-coder:7b-32k -f -
```

Then update your config to use `ollama/qwen2.5-coder:7b-32k`.

With 16GB RAM, 64k context on a 7B model will be tight — 32k is a safer option.

## Neovim Integration

### gen.nvim (simple prompts/generation)

Lightweight plugin for sending selections to Ollama:

```lua
-- lazy.nvim
{
  "David-Kunz/gen.nvim",
  opts = {
    model = "qwen2.5-coder:7b",
    host = "localhost",
    port = "11434",
  },
}
```

Usage: select code, then `:Gen` to pick a prompt (explain, refactor, fix, etc).

### ollama.nvim (workflow integration)

More structured Ollama management inside Neovim:

```lua
{
  "nomnivore/ollama.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
  opts = {
    model = "qwen2.5-coder:7b",
    url = "http://127.0.0.1:11434",
  },
}
```

### minuet-ai.nvim (Copilot-style completions)

Ghost-text completions powered by local models:

```lua
{
  "milanglacier/minuet-ai.nvim",
  opts = {
    provider = "openai_compatible",
    provider_options = {
      openai_compatible = {
        api_key = "TERM",
        end_point = "http://localhost:11434/v1/chat/completions",
        model = "qwen2.5-coder:7b",
      },
    },
  },
}
```

## RAM Budget Guidelines

With 16GB total system RAM (~10-12GB available for models):

- **3B models**: ~2-3GB, leaves plenty of headroom
- **7B models**: ~4-5GB, comfortable with other apps open
- **7B + 64k context**: ~8-10GB, close to limit — close other apps
- **16B models**: ~9-10GB, tight — dedicated use only

## Tips

- Start `ollama serve` before using OpenCode or Neovim plugins
- Use `ollama list` to see downloaded models
- Use `ollama rm <model>` to free disk space
- Models are stored in `~/.ollama/models/`
- Apple Silicon runs models on GPU (Metal) automatically — no config needed
