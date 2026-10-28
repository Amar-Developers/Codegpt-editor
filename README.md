# Code GPT Editor

**The code editor with Code GPT built in.** A desktop app for Windows, macOS and Linux by [AMAR Developers](https://codegpt.it.com/about).

- The Code GPT coding agent, inline edits (Ctrl+Alt+K) and every Code GPT model, ready on first start
- Built on the open-source code of VS Code, so your extensions (from [Open VSX](https://open-vsx.org)), themes and shortcuts work
- Microsoft telemetry removed; secret files like `.env` are never read by the agent

Download: **https://codegpt.it.com/editor**

## How this repository works

This repository contains the build scripts. It does not contain VS Code itself: each build downloads the official open-source
VS Code code, applies the patches in `patches/` and our branding in `src/stable/`, and builds installers.

To build and publish a new version, open **Actions › Build Code GPT Editor › Run workflow**. The full guide is in
[CODEGPT_BUILD.md](CODEGPT_BUILD.md).

The Code GPT agent itself lives in `src/stable/extensions/codegpt-agent`.

## License

The build scripts are MIT licensed (see `LICENSE` and `NOTICE.md`). Code GPT Editor is not made or endorsed by Microsoft or the VSCodium project.
