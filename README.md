# Sandboxed Claude Code

Runs Claude Code inside Docker, with access restricted to only the
directory you launch it from (mounted as `/workspace`). No other host
directory is visible to the container.

## One-time setup

1. Put this folder somewhere permanent, e.g. `~/tools/claude-sandbox`.
2. Make the wrapper available on your `PATH`:

   ```bash
   ln -s ~/tools/claude-sandbox/claude-sandbox /usr/local/bin/claude-sandbox
   ```

   (or add `~/tools/claude-sandbox` to your `PATH` in `.bashrc`/`.zshrc`)

3. Build the image once (optional — it also auto-builds on first run):

   ```bash
   cd ~/tools/claude-sandbox
   docker compose build
   ```

## Usage

From any project directory:

```bash
cd ~/some/project
claude-sandbox
```

This starts the container with:
- `~/some/project` mounted read/write as `/workspace` (and set as the working dir)
- no other host paths mounted at all
- your login/config persisted in a Docker-managed volume (`claude-home`),
  so you only need to `claude login` (or set `ANTHROPIC_API_KEY`) once

Any arguments you pass go straight to `claude`, e.g.:

```bash
claude-sandbox --help
```

## Auth

Either:
- Run `claude-sandbox` and follow the interactive `claude login` flow the
  first time (it'll persist in the `claude-home` volume), **or**
- Export `ANTHROPIC_API_KEY` in your shell before running — it gets
  passed through automatically.

## Resetting

To wipe persisted login/config:

```bash
docker volume rm claude-sandbox_claude-home
```

To rebuild the image from scratch (e.g. after a Claude Code update):

```bash
docker compose build --no-cache
```
