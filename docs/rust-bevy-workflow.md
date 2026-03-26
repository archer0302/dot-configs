# Rust + Bevy workflow

## 1) Prerequisites

- Rust toolchain installed via `rustup`.
- Rust components:
  - `rustfmt`
  - `clippy`
- Mason-managed tools expected:
  - `rust-analyzer`
  - `codelldb`
  - `taplo`
  - `wgsl-analyzer`

## 2) Edit, format, and lint loop

1. Open a Rust file to start `rustaceanvim` + `rust-analyzer`.
2. Save and confirm formatting when prompted by `conform.nvim`.
3. Run project checks from terminal:
   - `cargo check`
   - `cargo clippy`
   - `cargo test`
4. Open `Cargo.toml` and use `:Crates` for dependency updates.

## 3) Bevy and WGSL

- Open `.wgsl` shaders to get `wgsl-analyzer` diagnostics.
- Typical run loop:
  - `cargo run`
  - `cargo run --features bevy/dynamic_linking` (optional faster native iteration setup)

## 4) Debugging

1. Build your binary: `cargo build`.
2. Set breakpoints (`<leader>db`).
3. Press `<F5>` and choose:
   - `Debug executable`
   - `Debug Bevy app`
4. Provide the binary path under `target/debug/`.
5. Use existing DAP controls (`<F10>`, `<F11>`, `<F12>`, `<leader>dr`).
