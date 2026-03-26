# TypeScript + Go debugging workflow

## 1) Prerequisites

- Runtime/tooling:
  - `node` on PATH (for JS/TS adapter runtime)
  - Go toolchain (`go`) on PATH
  - Delve (`dlv`) for Go debugging
- Mason-managed adapters/tools expected:
  - `js-debug-adapter`
  - `delve`
- TS projects should emit sourcemaps (`sourceMap: true` in build/tsconfig path used while debugging).

## 2) Start a debug session

1. Open target file.
2. Set breakpoints with `<leader>db` (or conditional with `<leader>dB`).
3. Press `<F5>` to start/continue.
4. Step through with:
   - `<F10>` step over
   - `<F11>` step into
   - `<F12>` step out
5. Open REPL with `<leader>dr` when needed.

`nvim-dap-ui` opens automatically on launch/attach and closes on terminate/exit.

## 3) TypeScript/JavaScript

- Default configs include:
  - **Debug current file** (`pwa-node`, launch)
  - **Attach to process** (`pwa-node`, attach)
- Best practice:
  - Debug from project root.
  - Ensure transpilation/sourcemaps match the file being debugged.

## 4) Go

- `nvim-dap-go` provides Delve integration.
- Use normal DAP flow (`<F5>`) for launch configs.
- For test-focused debugging, use `require("dap-go").debug_test()` if you want a dedicated keymap.

## 5) Troubleshooting checklist

1. `:Mason` and verify `delve` + `js-debug-adapter` are installed.
2. Confirm executable availability:
   - `:echo executable('node')`
   - `:echo executable('dlv')`
3. Run `:checkhealth vim.lsp` and inspect project-specific diagnostics.
4. If breakpoints are not hit in TS, re-check source maps and build output paths.
