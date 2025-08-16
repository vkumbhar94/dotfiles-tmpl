# Neovim Configuration Shortcuts

I am using nvimdots

This document lists all the keyboard shortcuts defined in this Neovim configuration.

## Package Manager (Lazy.nvim)

| Mode | Shortcut     | Command             | Description      |
| ---- | ------------ | ------------------- | ---------------- |
| n    | `<leader>ph` | `:Lazy<CR>`         | package: Show    |
| n    | `<leader>ps` | `:Lazy sync<CR>`    | package: Sync    |
| n    | `<leader>pu` | `:Lazy update<CR>`  | package: Update  |
| n    | `<leader>pi` | `:Lazy install<CR>` | package: Install |
| n    | `<leader>pl` | `:Lazy log<CR>`     | package: Log     |
| n    | `<leader>pc` | `:Lazy check<CR>`   | package: Check   |
| n    | `<leader>pd` | `:Lazy debug<CR>`   | package: Debug   |
| n    | `<leader>pp` | `:Lazy profile<CR>` | package: Profile |
| n    | `<leader>pr` | `:Lazy restore<CR>` | package: Restore |
| n    | `<leader>px` | `:Lazy clean<CR>`   | package: Clean   |

## File Operations

| Mode | Shortcut  | Command          | Description                |
| ---- | --------- | ---------------- | -------------------------- |
| n    | `<C-s>`   | `:write<CR>`     | edit: Save file            |
| n    | `<C-q>`   | `:wq<CR>`        | edit: Save file and quit   |
| n    | `<A-S-q>` | `:q!<CR>`        | edit: Force quit           |
| i    | `<C-s>`   | `<Esc>:w<CR>`    | edit: Save file            |
| i    | `<C-q>`   | `<Esc>:wq<CR>`   | edit: Save file and quit   |
| n    | `<A-s>`   | `:SudaWrite<CR>` | edit: Save file using sudo |

## Insert Mode Navigation

| Mode | Shortcut | Command       | Description                     |
| ---- | -------- | ------------- | ------------------------------- |
| i    | `<C-u>`  | `<C-G>u<C-U>` | edit: Delete previous block     |
| i    | `<C-b>`  | `<Left>`      | edit: Move cursor to left       |
| i    | `<C-a>`  | `<ESC>^i`     | edit: Move cursor to line start |

## Command Mode Navigation

| Mode | Shortcut | Command                            | Description                         |
| ---- | -------- | ---------------------------------- | ----------------------------------- |
| c    | `<C-b>`  | `<Left>`                           | edit: Left                          |
| c    | `<C-f>`  | `<Right>`                          | edit: Right                         |
| c    | `<C-a>`  | `<Home>`                           | edit: Home                          |
| c    | `<C-e>`  | `<End>`                            | edit: End                           |
| c    | `<C-d>`  | `<Del>`                            | edit: Delete                        |
| c    | `<C-h>`  | `<BS>`                             | edit: Backspace                     |
| c    | `<C-t>`  | `<C-R>=expand("%:p:h") . "/" <CR>` | edit: Complete path of current file |

## Visual Mode Operations

| Mode | Shortcut | Command            | Description               |
| ---- | -------- | ------------------ | ------------------------- |
| v    | `J`      | `:m '>+1<CR>gv=gv` | edit: Move this line down |
| v    | `K`      | `:m '<-2<CR>gv=gv` | edit: Move this line up   |
| v    | `<`      | `<gv`              | edit: Decrease indent     |
| v    | `>`      | `>gv`              | edit: Increase indent     |

## Normal Mode Editing

| Mode | Shortcut    | Command                                | Description                  |
| ---- | ----------- | -------------------------------------- | ---------------------------- |
| n    | `Y`         | `y$`                                   | edit: Yank text to EOL       |
| n    | `D`         | `d$`                                   | edit: Delete text to EOL     |
| n    | `n`         | `nzzzv`                                | edit: Next search result     |
| n    | `N`         | `Nzzzv`                                | edit: Prev search result     |
| n    | `J`         | `mzJ`z`                                | edit: Join next line         |
| n    | `<S-Tab>`   | `:normal za<CR>`                       | edit: Toggle code fold       |
| n    | `<Esc>`     | Clear search highlight                 | edit: Clear search highlight |
| n    | `<leader>o` | `:setlocal spell! spelllang=en_us<CR>` | edit: Toggle spell check     |

## Buffer Management

| Mode | Shortcut           | Command                          | Description                  |
| ---- | ------------------ | -------------------------------- | ---------------------------- |
| n    | `<leader>bn`       | `:enew<CR>`                      | buffer: New                  |
| n    | `<A-q>`            | `:BufDel<CR>`                    | buffer: Close current        |
| n    | `<A-i>`            | `:BufferLineCycleNext<CR>`       | buffer: Switch to next       |
| n    | `<A-o>`            | `:BufferLineCyclePrev<CR>`       | buffer: Switch to prev       |
| n    | `<A-S-i>`          | `:BufferLineMoveNext<CR>`        | buffer: Move current to next |
| n    | `<A-S-o>`          | `:BufferLineMovePrev<CR>`        | buffer: Move current to prev |
| n    | `<leader>be`       | `:BufferLineSortByExtension<CR>` | buffer: Sort by extension    |
| n    | `<leader>bd`       | `:BufferLineSortByDirectory<CR>` | buffer: Sort by directory    |
| n    | `<A-1>` to `<A-9>` | `:BufferLineGoToBuffer N<CR>`    | buffer: Goto buffer N        |

## Tab Management

| Mode | Shortcut | Command            | Description                |
| ---- | -------- | ------------------ | -------------------------- |
| n    | `tn`     | `:tabnew<CR>`      | tab: Create a new tab      |
| n    | `tk`     | `:tabnext<CR>`     | tab: Move to next tab      |
| n    | `tj`     | `:tabprevious<CR>` | tab: Move to previous tab  |
| n    | `to`     | `:tabonly<CR>`     | tab: Only keep current tab |

## Window Management

| Mode | Shortcut     | Command              | Description                    |
| ---- | ------------ | -------------------- | ------------------------------ |
| t    | `<C-w>h`     | `<Cmd>wincmd h<CR>`  | window: Focus left             |
| t    | `<C-w>l`     | `<Cmd>wincmd l<CR>`  | window: Focus right            |
| t    | `<C-w>j`     | `<Cmd>wincmd j<CR>`  | window: Focus down             |
| t    | `<C-w>k`     | `<Cmd>wincmd k<CR>`  | window: Focus up               |
| n    | `<C-h>`      | SmartCursorMoveLeft  | window: Focus left             |
| n    | `<C-j>`      | SmartCursorMoveDown  | window: Focus down             |
| n    | `<C-k>`      | SmartCursorMoveUp    | window: Focus up               |
| n    | `<C-l>`      | SmartCursorMoveRight | window: Focus right            |
| n    | `<A-h>`      | SmartResizeLeft      | window: Resize -3 horizontally |
| n    | `<A-j>`      | SmartResizeDown      | window: Resize -3 vertically   |
| n    | `<A-k>`      | SmartResizeUp        | window: Resize +3 vertically   |
| n    | `<A-l>`      | SmartResizeRight     | window: Resize +3 horizontally |
| n    | `<leader>Wh` | SmartSwapLeft        | window: Move window leftward   |
| n    | `<leader>Wj` | SmartSwapDown        | window: Move window downward   |
| n    | `<leader>Wk` | SmartSwapUp          | window: Move window upward     |
| n    | `<leader>Wl` | SmartSwapRight       | window: Move window rightward  |

## Session Management

| Mode | Shortcut     | Command              | Description           |
| ---- | ------------ | -------------------- | --------------------- |
| n    | `<leader>ss` | `:SessionSave<CR>`   | session: Save         |
| n    | `<leader>sl` | `:SessionLoad<CR>`   | session: Load current |
| n    | `<leader>sd` | `:SessionDelete<CR>` | session: Delete       |

## Code Formatting

| Mode | Shortcut  | Command             | Description                       |
| ---- | --------- | ------------------- | --------------------------------- |
| n    | `<A-f>`   | `:FormatToggle<CR>` | formatter: Toggle format on save  |
| n    | `<A-S-f>` | `:Format<CR>`       | formatter: Format buffer manually |

## Code Comments

| Mode | Shortcut | Command                           | Description                                   |
| ---- | -------- | --------------------------------- | --------------------------------------------- |
| n    | `gcc`    | Comment toggle linewise           | edit: Toggle comment for line                 |
| n    | `gbc`    | Comment toggle blockwise          | edit: Toggle comment for block                |
| n    | `gc`     | Comment toggle linewise operator  | edit: Toggle comment for line with operator   |
| n    | `gb`     | Comment toggle blockwise operator | edit: Toggle comment for block with operator  |
| x    | `gc`     | Comment toggle linewise visual    | edit: Toggle comment for line with selection  |
| x    | `gb`     | Comment toggle blockwise visual   | edit: Toggle comment for block with selection |

## LSP (Language Server Protocol)

| Mode | Shortcut     | Command                                          | Description                      |
| ---- | ------------ | ------------------------------------------------ | -------------------------------- |
| n    | `<leader>li` | `:LspInfo<CR>`                                   | lsp: Info                        |
| n    | `<leader>lr` | `:LspRestart<CR>`                                | lsp: Restart                     |
| n    | `go`         | `:Trouble symbols toggle win.position=right<CR>` | lsp: Toggle outline              |
| n    | `gto`        | Toggle outline in Telescope/FzfLua               | lsp: Toggle outline in Telescope |
| n    | `g[`         | `:Lspsaga diagnostic_jump_prev<CR>`              | lsp: Prev diagnostic             |
| n    | `g]`         | `:Lspsaga diagnostic_jump_next<CR>`              | lsp: Next diagnostic             |
| n    | `<leader>lx` | `:Lspsaga show_line_diagnostics ++unfocus<CR>`   | lsp: Line diagnostic             |
| n    | `gs`         | Signature help                                   | lsp: Signature help              |
| n    | `gr`         | `:Lspsaga rename<CR>`                            | lsp: Rename in file range        |
| n    | `gR`         | `:Lspsaga rename ++project<CR>`                  | lsp: Rename in project range     |
| n    | `K`          | `:Lspsaga hover_doc<CR>`                         | lsp: Show doc                    |
| nv   | `ga`         | `:Lspsaga code_action<CR>`                       | lsp: Code action for cursor      |
| n    | `gd`         | `:Glance definitions<CR>`                        | lsp: Preview definition          |
| n    | `gD`         | `:Lspsaga goto_definition<CR>`                   | lsp: Goto definition             |
| n    | `gh`         | `:Glance references<CR>`                         | lsp: Show reference              |
| n    | `gm`         | `:Glance implementations<CR>`                    | lsp: Show implementation         |
| n    | `gci`        | `:Lspsaga incoming_calls<CR>`                    | lsp: Show incoming calls         |
| n    | `gco`        | `:Lspsaga outgoing_calls<CR>`                    | lsp: Show outgoing calls         |
| n    | `<leader>lv` | Toggle virtual lines                             | lsp: Toggle virtual lines        |
| n    | `<leader>lh` | Toggle inlay hints                               | lsp: Toggle inlay hints          |
| n    | `gt`         | `:Trouble diagnostics toggle<CR>`                | lsp: Toggle trouble list         |
| n    | `<leader>lw` | `:Trouble diagnostics toggle<CR>`                | lsp: Show workspace diagnostics  |
| n    | `<leader>lp` | `:Trouble project_diagnostics toggle<CR>`        | lsp: Show project diagnostics    |
| n    | `<leader>ld` | `:Trouble diagnostics toggle filter.buf=0<CR>`   | lsp: Show document diagnostics   |

## Git Operations

| Mode | Shortcut     | Command                 | Description                                    |
| ---- | ------------ | ----------------------- | ---------------------------------------------- |
| n    | `gps`        | `:G push<CR>`           | git: Push                                      |
| n    | `gpl`        | `:G pull<CR>`           | git: Pull                                      |
| n    | `<leader>gG` | `:Git<CR>`              | git: Open git-fugitive                         |
| n    | `<leader>gd` | `:DiffviewOpen<CR>`     | git: Show diff                                 |
| n    | `<leader>gD` | `:DiffviewClose<CR>`    | git: Close diff                                |
| n    | `<leader>gg` | Toggle lazygit          | git: Toggle lazygit                            |
| n    | `]g`         | Next hunk               | git: Goto next hunk                            |
| n    | `[g`         | Prev hunk               | git: Goto prev hunk                            |
| n    | `<leader>gs` | Stage hunk              | git: Toggle staging/unstaging of hunk          |
| v    | `<leader>gs` | Stage hunk selection    | git: Toggle staging/unstaging of selected hunk |
| n    | `<leader>gr` | Reset hunk              | git: Reset hunk                                |
| v    | `<leader>gr` | Reset hunk selection    | git: Reset hunk                                |
| n    | `<leader>gR` | Reset buffer            | git: Reset buffer                              |
| n    | `<leader>gp` | Preview hunk            | git: Preview hunk                              |
| n    | `<leader>gb` | Blame line              | git: Blame line                                |
| ox   | `ih`         | Select hunk text object | git: Select hunk                               |

## File Tree (NvimTree/Edgy)

| Mode | Shortcut     | Command                 | Description         |
| ---- | ------------ | ----------------------- | ------------------- |
| n    | `<C-n>`      | Toggle edgy left        | filetree: Toggle    |
| n    | `<leader>nf` | `:NvimTreeFindFile<CR>` | filetree: Find file |
| n    | `<leader>nr` | `:NvimTreeRefresh<CR>`  | filetree: Refresh   |

## Search and Find

| Mode | Shortcut     | Command                    | Description                      |
| ---- | ------------ | -------------------------- | -------------------------------- |
| n    | `<C-p>`      | Toggle command panel       | tool: Toggle command panel       |
| n    | `<leader>fc` | Open Telescope collections | tool: Open Telescope collections |
| n    | `<leader>ff` | Find files                 | tool: Find files                 |
| n    | `<leader>fp` | Find patterns              | tool: Find patterns              |
| v    | `<leader>fs` | Find word under cursor     | tool: Find word under cursor     |
| n    | `<leader>fg` | Locate Git objects         | tool: Locate Git objects         |
| n    | `<leader>fd` | Retrieve dossiers          | tool: Retrieve dossiers          |
| n    | `<leader>fm` | Miscellaneous              | tool: Miscellaneous              |
| n    | `<leader>fr` | `:Telescope resume<CR>`    | tool: Resume last search         |
| n    | `<leader>fR` | FzfLua resume              | tool: Resume last search         |

## Search & Replace (Grug-far)

| Mode | Shortcut     | Command                                 | Description                                   |
| ---- | ------------ | --------------------------------------- | --------------------------------------------- |
| n    | `<leader>Ss` | Open grug-far                           | edit: Toggle search & replace panel           |
| n    | `<leader>Sp` | Search & replace current word (project) | edit: search&replace current word (project)   |
| v    | `<leader>Sp` | Search & replace selection (project)    | edit: search & replace current word (project) |
| n    | `<leader>Sf` | Search & replace current word (file)    | edit: search & replace current word (file)    |

## Jump/Movement (Hop)

| Mode | Shortcut    | Command           | Description                      |
| ---- | ----------- | ----------------- | -------------------------------- |
| nv   | `<leader>w` | `:HopWordMW<CR>`  | jump: Goto word                  |
| nv   | `<leader>j` | `:HopLineMW<CR>`  | jump: Goto line                  |
| nv   | `<leader>k` | `:HopLineMW<CR>`  | jump: Goto line                  |
| nv   | `<leader>c` | `:HopChar1MW<CR>` | jump: Goto one char              |
| nv   | `<leader>C` | `:HopChar2MW<CR>` | jump: Goto two chars             |
| o    | `m`         | Treehopper nodes  | jump: Operate across syntax tree |

## Terminal (ToggleTerm)

| Mode | Shortcut     | Command                                | Description                       |
| ---- | ------------ | -------------------------------------- | --------------------------------- |
| t    | `<Esc><Esc>` | `<C-\><C-n>`                           | Switch to normal mode in terminal |
| n    | `<C-\>`      | `:ToggleTerm direction=horizontal<CR>` | terminal: Toggle horizontal       |
| i    | `<C-\>`      | `:ToggleTerm direction=horizontal<CR>` | terminal: Toggle horizontal       |
| t    | `<C-\>`      | `:ToggleTerm<CR>`                      | terminal: Toggle horizontal       |
| n    | `<A-\>`      | `:ToggleTerm direction=vertical<CR>`   | terminal: Toggle vertical         |
| i    | `<A-\>`      | `:ToggleTerm direction=vertical<CR>`   | terminal: Toggle vertical         |
| t    | `<A-\>`      | `:ToggleTerm<CR>`                      | terminal: Toggle vertical         |
| n    | `<F5>`       | `:ToggleTerm direction=vertical<CR>`   | terminal: Toggle vertical         |
| i    | `<F5>`       | `:ToggleTerm direction=vertical<CR>`   | terminal: Toggle vertical         |
| t    | `<F5>`       | `:ToggleTerm<CR>`                      | terminal: Toggle vertical         |
| n    | `<A-d>`      | `:ToggleTerm direction=float<CR>`      | terminal: Toggle float            |
| i    | `<A-d>`      | `:ToggleTerm direction=float<CR>`      | terminal: Toggle float            |
| t    | `<A-d>`      | `:ToggleTerm<CR>`                      | terminal: Toggle float            |

## Code Execution (SnipRun)

| Mode | Shortcut    | Command         | Description             |
| ---- | ----------- | --------------- | ----------------------- |
| v    | `<leader>r` | `:SnipRun<CR>`  | tool: Run code by range |
| n    | `<leader>r` | `:%SnipRun<CR>` | tool: Run code by file  |

## Debugging (DAP)

| Mode | Shortcut     | Command                         | Description                          |
| ---- | ------------ | ------------------------------- | ------------------------------------ |
| n    | `<F6>`       | Continue                        | debug: Run/Continue                  |
| n    | `<F7>`       | Terminate                       | debug: Stop                          |
| n    | `<F8>`       | Toggle breakpoint               | debug: Toggle breakpoint             |
| n    | `<F9>`       | Step into                       | debug: Step into                     |
| n    | `<F10>`      | Step out                        | debug: Step out                      |
| n    | `<F11>`      | Step over                       | debug: Step over                     |
| n    | `<leader>db` | Set breakpoint with condition   | debug: Set breakpoint with condition |
| n    | `<leader>dc` | Run to cursor                   | debug: Run to cursor                 |
| n    | `<leader>dl` | Run last                        | debug: Run last                      |
| n    | `<leader>do` | Open REPL                       | debug: Open REPL                     |
| nv   | `K`          | Evaluate expression (debugging) | Evaluate expression under cursor     |

## AI Code Companion

| Mode | Shortcut     | Command                      | Description                               |
| ---- | ------------ | ---------------------------- | ----------------------------------------- |
| n    | `<leader>cs` | Select chat model            | tool: Select Chat Model                   |
| nv   | `<leader>cc` | Toggle CodeCompanion         | tool: Toggle CodeCompanion                |
| nv   | `<leader>ck` | `:CodeCompanionActions<CR>`  | tool: CodeCompanion Actions               |
| v    | `<leader>ca` | `:CodeCompanionChat Add<CR>` | tool: Add selection to CodeCompanion Chat |

## Markdown

| Mode | Shortcut | Command                      | Description                               |
| ---- | -------- | ---------------------------- | ----------------------------------------- |
| n    | `<F1>`   | `:RenderMarkdown toggle<CR>` | tool: toggle markdown preview within nvim |
| n    | `<F12>`  | `:MarkdownPreviewToggle<CR>` | tool: Preview markdown                    |

## Rust Crates (Cargo.toml)

| Mode | Shortcut     | Command                 | Description                                |
| ---- | ------------ | ----------------------- | ------------------------------------------ |
| n    | `<leader>ct` | Toggle crates           | crates: Toggle spec activities             |
| n    | `<leader>cr` | Reload crates           | crates: Reload crate specs                 |
| n    | `<leader>cs` | Show popup              | crates: Toggle pop-up window               |
| n    | `<leader>cv` | Show versions           | crates: Select spec versions               |
| n    | `<leader>cf` | Show features           | crates: Select spec features               |
| n    | `<leader>cd` | Show dependencies       | crates: Show project dependencies          |
| n    | `<leader>cu` | Update crate            | crates: Update current crate's spec        |
| v    | `<leader>cu` | Update selected crates  | crates: Update selected crate's spec       |
| n    | `<leader>ca` | Update all crates       | crates: Update all crates' specs           |
| n    | `<leader>cU` | Upgrade crate           | crates: Upgrade current crate              |
| v    | `<leader>cU` | Upgrade selected crates | crates: Upgrade selected crates            |
| n    | `<leader>cA` | Upgrade all crates      | crates: Upgrade all crates                 |
| n    | `<leader>cH` | Open homepage           | crates: Open current crate's homepage      |
| n    | `<leader>cR` | Open repository         | crates: Open current crate's repository    |
| n    | `<leader>cD` | Open documentation      | crates: Open current crate's documentation |
| n    | `<leader>cC` | Browse on crates.io     | crates: Browse current crate on crates.io  |

## Mode Legend

- `n` = Normal mode
- `i` = Insert mode
- `v` = Visual mode
- `x` = Visual mode (linewise)
- `c` = Command mode
- `t` = Terminal mode
- `o` = Operator-pending mode
- `nv` = Normal and Visual mode
- `ox` = Operator-pending and Visual mode

## Leader Key

The leader key in this configuration is typically `<Space>` or another key configured in the settings.

## Notes

- Some shortcuts are context-sensitive and only work in specific file types or when certain plugins are loaded
- Shortcuts marked with buffer-specific binding only work in buffers where the corresponding functionality is available
- Debug shortcuts in the DAP section are only active during debugging sessions
- Crates shortcuts are only available in Rust `Cargo.toml` files
