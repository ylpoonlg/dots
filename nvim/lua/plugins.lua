local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself

    use 'tanvirtin/monokai.nvim'
    use 'lukas-reineke/virt-column.nvim'
    --use 'itchyny/lightline.vim'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'lervag/vimtex'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'simrat39/symbols-outline.nvim'
    use 'karb94/neoscroll.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip-integ'
    use 'numToStr/Comment.nvim'

    use 'dart-lang/dart-vim-plugin'
    use 'vim-python/python-syntax'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
