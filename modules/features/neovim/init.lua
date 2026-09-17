-- ============================================================================
-- General options
-- ============================================================================

vim.g.mapleader = " "

-- Netrw
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.opt.timeoutlen = 325
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.textwidth = 0
vim.opt.scrolloff = 5
vim.opt.cursorline = true
vim.opt.confirm = true


-- ============================================================================
-- Colorscheme
-- ============================================================================

vim.cmd.colorscheme("tokyonight")


-- ============================================================================
-- Highlighting
-- ============================================================================

vim.api.nvim_set_hl(0, "DiagnosticFloatingError",	{ fg = "#f7768e", bg = "#ffffff", })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn",	{ fg = "#e0af68", bg = "#ffffff", })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo",	{ fg = "#7dcfff", bg = "#ffffff", })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint",	{ fg = "#1abc9c", bg = "#ffffff", })

vim.api.nvim_set_hl(0, "NormalFloat",	{ fg = "#c0caf5", bg = "#16161e", })
vim.api.nvim_set_hl(0, "FloatBorder",	{ fg = "#7dcfff", bg = "#16161e", })

-- ============================================================================
-- AZERTY number mappings
-- ============================================================================

local number_map = {
    ["à"] = "0",
    ["&"] = "1",
    ["é"] = "2",
    ['"'] = "3",
    ["'"] = "4",
    ["("] = "5",
    ["-"] = "6",
    ["è"] = "7",
    ["_"] = "8",
    ["ç"] = "9",
    ["."] = ";",
}

for key, number in pairs(number_map) do
    vim.keymap.set( { "n", "o", "x" }, key, number, { silent = true, desc = "azerty numbers remap", })
    vim.keymap.set( { "n", "o", "x" }, number, key, { silent = true, desc = "azerty numbers remap", })
end


-- ============================================================================
-- Netrw
-- ============================================================================

vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<CR>", { silent = true, desc = "Toggle Netrw sidebar", })
vim.keymap.set("n", "<leader>w", "<C-w>w", { silent = true, desc = "Switch window focus", })
vim.keymap.set("n", "<leader>>", "<cmd>vertical resize +5<CR>", { silent = true, desc = "Make sidebar wider", })
vim.keymap.set("n", "<leader><", "<cmd>vertical resize -5<CR>", { silent = true, desc = "Make sidebar thinner", })


-- ============================================================================
-- Telescope
-- ============================================================================

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { silent = true, })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { silent = true, })
vim.keymap.set("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", { silent = true, })
vim.keymap.set("n", "<leader>sw", "<cmd>Telescope lsp_workspace_symbols<CR>", { silent = true, })


-- ============================================================================
-- Bufferline
-- ============================================================================

vim.keymap.set("n", "<C-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<A-h>", "<cmd>BufferLineMovePrev<CR>", { silent = true })
vim.keymap.set("n", "<A-l>", "<cmd>BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { silent = true })


-- ============================================================================
-- LSP keymaps
-- ============================================================================

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "LSP: go to definition", })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, desc = "LSP: references", })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true, desc = "LSP: implementation", })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "LSP: declaration", })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, desc = "LSP: rename symbol", })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "LSP: code action", })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { silent = true, desc = "Show diagnostic message", })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Prev diagnostic", })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic", })


-- ============================================================================
-- Rust / tmux
-- ============================================================================

-- vim.keymap.set("n", "<leader>rr", "<cmd>w<CR><cmd>silent !tmux send-keys -t .+ 'cargo run' Enter<CR>", {desc = "save & cargo run in next pane",})
-- vim.keymap.set("n","<leader>rb","<cmd>w<CR><cmd>silent !tmux send-keys -t .+ 'cargo build' Enter<CR>",{ desc = "save & cargo build in next pane",})
-- vim.keymap.set("n","<leader>rc","<cmd>w<CR><cmd>silent !tmux send-keys -t .+ 'cargo check' Enter<CR>",{    desc = "save & cargo check in next pane",})
-- vim.keymap.set("n","<leader>rl","<cmd>w<CR><cmd>silent !tmux send-keys -t .+ Up Enter<CR>",{    desc = "rerun last command in next pane",})


-- ============================================================================
-- Telescope
-- ============================================================================

require("telescope").setup({})


-- ============================================================================
-- Lualine
-- ============================================================================

require("lualine").setup({})


-- ============================================================================
-- Bufferline
-- ============================================================================

require("bufferline").setup({})


-- ============================================================================
-- Mini
-- ============================================================================

require("mini.surround").setup({})
require("mini.pairs").setup({})


-- ============================================================================
-- Completion (nvim-cmp)
-- ============================================================================

local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
        }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
})


-- ============================================================================
-- Treesitter
-- ============================================================================

require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "rust",
        "wgsl",
	"lua",
	"nix",
	"python",
    },
    callback = function()
        vim.treesitter.start()
    end,
})

-- ============================================================================
-- LSP
-- ============================================================================

-- Work in progress

vim.lsp.config("pyright", {})
vim.lsp.config("nil_ls", {})
vim.lsp.config("rust_analyzer", { cmd = {"rust-analyzer"}, })
vim.lsp.config("gdscript", {})
vim.lsp.config("wgsl_analyzer", {})

vim.lsp.enable({
    "pyright",
    "nil_ls",
    "rust_analyzer",
    "gdscript",
    "wgsl_analyzer",
})


-- ============================================================================
-- Autocommands
-- ============================================================================

vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*/.cargo/registry/*",
    callback = function()
        vim.bo.modifiable = false
        vim.bo.readonly = true
    end,
    desc = "Prevent accidental edits to downloaded Cargo sources",
})
