return {
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    keys = {
      { "<leader>Om", "<cmd>Mason<CR>", desc = "Open Mason" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()
      local on_attach = require("util.opts").on_attach

      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- jdtls = {},
        -- pyright = {},
        omnisharp = {},
        -- rust_analyzer = {},
        -- tsserver = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },

        --[[ -- "efm",
        -- "bashls",
        -- "tsserver",
        -- "solidity",
          -- "tailwindcss",
          -- "pyright",
          "csharp_ls",
          "jdtls",
          "lua_ls",
          -- "emmet_ls",
          -- "jsonls",
          -- "clangd", ]]

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
      require("mason").setup({
        ui = {
          border = require("utils").border,
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
          },
        },
        max_concurrent_installers = 10,
      })
      require("mason-lspconfig").setup({
        ensure_installed = {
        },
        automatic_installation = true,
      })
      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        on_attach = on_attach,

        cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },

        settings = {
          FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = nil,
          },
          MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = nil,
          },
          RoslynExtensionsOptions = {
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = nil,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = true,
            enableDecompilationSupport = true,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = nil,
          },
          Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
          },
        },
        handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
          ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
          ["textDocument/references"] = require('omnisharp_extended').references_handler,
          ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
        },
      })
      lspconfig.csharp_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            -- workspace = {
            -- 	-- make language server aware of runtime files
            -- 	library = {
            -- 		[vim.fn.expand("$VIMRUNTIME/lua")] = true,
            -- 		[vim.fn.stdpath("config") .. "/lua"] = true,
            -- 	},
            -- },
          },
        },
      })
      require 'lspconfig'.jdtls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end,

  },
}
