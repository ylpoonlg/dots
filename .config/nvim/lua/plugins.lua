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

    -- Interface
    use 'tanvirtin/monokai.nvim'
    use 'lukas-reineke/virt-column.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'lervag/vimtex'
    use {
        'kyazdani42/nvim-tree.lua',
        config = function ()
            require('plugins-configs.nvim_tree')
        end,
    }
    use 'kyazdani42/nvim-web-devicons'
    use 'simrat39/symbols-outline.nvim'
    use 'karb94/neoscroll.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
    use 'norcalli/nvim-colorizer.lua'
    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function ()
            require('plugins-configs.dashboard')
        end,
        requires = {'nvim-tree/nvim-web-devicons'},
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use {'glepnir/lspsaga.nvim', branch = 'main'}
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip-integ'
    use 'onsails/lspkind.nvim'
    use 'numToStr/Comment.nvim'
    use 'ur4ltz/surround.nvim'

    -- Language
    use 'dart-lang/dart-vim-plugin'
    use 'vim-python/python-syntax'
    use 'elkowar/yuck.vim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
