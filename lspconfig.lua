return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local diagnostic_signs = require("util.icons").diagnostic_signs

			for type, icon in pairs(diagnostic_signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

      vim.keymap.set("n", ",Fl", "<cmd>Format<cr>", { desc = "LSP | Format", silent = true })
      vim.keymap.set("n", "<leader>Oi", "<cmd>LspInfo<cr>", { desc = "LSP | Info", silent = true })
      vim.keymap.set("n", "<leader>OR", "<cmd>LspRestart<cr>", { desc = "LSP | Restart", silent = true })
      vim.keymap.set("n", "<leader>OH", function()
        if vim.lsp.inlay_hint.is_enabled(0) and vim.fn.has("nvim-0.10") == 1 then
          vim.cmd("lua=vim.lsp.inlay_hint.enable(0, false)")
        else
          vim.cmd("lua=vim.lsp.inlay_hint.enable(0, true)")
        end
      end, { desc = "LSP | Inlay Hints", silent = true })

      -- vim.keymap.set("n", "<F12>", function()
      --   require'lspconfig'.lua_ls.setup{
      --     capabilities = cmp_nvim_lsp.default_capabilities(),
      --     on_attach = require("map").on_attach,
      --     settings = { -- custom settings for lua
      --       Lua = {
      --         -- make the language server recognize "vim" global
      --         diagnostics = {
      --           globals = { "vim" },
      --         },
      --         -- workspace = {
      --         -- 	-- make language server aware of runtime files
      --         -- 	library = {
      --         -- 		[vim.fn.expand("$VIMRUNTIME/lua")] = true,
      --         -- 		[vim.fn.stdpath("config") .. "/lua"] = true,
      --         -- 	},
      --         -- },
      --       },
      --     },
      --   }
      -- end, { desc = "LSP | reset", silent = true })



			-- -- json
			-- lspconfig.jsonls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	filetypes = { "json", "jsonc" },
			-- })

			-- -- python
			-- lspconfig.pyright.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	settings = {
			-- 		pyright = {
			-- 			disableOrganizeImports = false,
			-- 			analysis = {
			-- 				useLibraryCodeForTypes = true,
			-- 				autoSearchPaths = true,
			-- 				diagnosticMode = "workspace",
			-- 				autoImportCompletions = true,
			-- 			},
			-- 		},
			-- 	},
			-- })

			-- -- typescript
			-- lspconfig.tsserver.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	filetypes = {
			-- 		"typescript",
			-- 		"javascript",
			-- 		"typescriptreact",
			-- 		"javascriptreact",
			-- 	},
			-- 	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
			-- })

			-- -- bash
			-- lspconfig.bashls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	filetypes = { "sh", "aliasrc" },
			-- })

			-- -- solidity
			-- lspconfig.solidity.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	filetypes = { "solidity" },
			-- })

			-- -- typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
			-- lspconfig.emmet_ls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	filetypes = {
			-- 		"typescriptreact",
			-- 		"javascriptreact",
			-- 		"javascript",
			-- 		"css",
			-- 		"sass",
			-- 		"scss",
			-- 		"less",
			-- 		"svelte",
			-- 		"vue",
			-- 		"html",
			-- 	},
			-- })

			-- -- docker
			-- lspconfig.dockerls.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- })

			-- -- C/C++
			-- lspconfig.clangd.setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--offset-encoding=utf-16",
			-- 	},
			-- })

			-- local luacheck = require("efmls-configs.linters.luacheck")
			-- local stylua = require("efmls-configs.formatters.stylua")
			-- local flake8 = require("efmls-configs.linters.flake8")
			-- local black = require("efmls-configs.formatters.black")
			-- local eslint = require("efmls-configs.linters.eslint")
			-- local prettier_d = require("efmls-configs.formatters.prettier_d")
			-- local fixjson = require("efmls-configs.formatters.fixjson")
			-- local shellcheck = require("efmls-configs.linters.shellcheck")
			-- local shfmt = require("efmls-configs.formatters.shfmt")
			-- local hadolint = require("efmls-configs.linters.hadolint")
			-- local solhint = require("efmls-configs.linters.solhint")
			-- local cpplint = require("efmls-configs.linters.cpplint")
			-- local clangformat = require("efmls-configs.formatters.clang_format")

			-- -- configure efm server
			-- lspconfig.efm.setup({
			-- 	filetypes = {
			-- 		"lua",
			-- 		"python",
			-- 		"json",
			-- 		"jsonc",
			-- 		"sh",
			-- 		"javascript",
			-- 		"javascriptreact",
			-- 		"typescript",
			-- 		"typescriptreact",
			-- 		"svelte",
			-- 		"vue",
			-- 		"markdown",
			-- 		"docker",
			-- 		"solidity",
			-- 		"html",
			-- 		"css",
			-- 		"c",
			-- 		"cpp",
			-- 	},
			-- 	init_options = {
			-- 		documentFormatting = true,
			-- 		documentRangeFormatting = true,
			-- 		hover = true,
			-- 		documentSymbol = true,
			-- 		codeAction = true,
			-- 		completion = true,
			-- 	},
			-- 	settings = {
			-- 		languages = {
			-- 			lua = { luacheck, stylua },
			-- 			python = { flake8, black },
			-- 			typescript = { eslint, prettier_d },
			-- 			json = { eslint, fixjson },
			-- 			jsonc = { eslint, fixjson },
			-- 			sh = { shellcheck, shfmt },
			-- 			javascript = { eslint, prettier_d },
			-- 			javascriptreact = { eslint, prettier_d },
			-- 			typescriptreact = { eslint, prettier_d },
			-- 			svelte = { eslint, prettier_d },
			-- 			vue = { eslint, prettier_d },
			-- 			markdown = { prettier_d },
			-- 			docker = { hadolint, prettier_d },
			-- 			solidity = { solhint },
			-- 			html = { prettier_d },
			-- 			css = { prettier_d },
			-- 			c = { clangformat, cpplint },
			-- 			cpp = { clangformat, cpplint },
			-- 		},
			-- 	},
			 --[[ 
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client then
            if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
              })
            end

            -- The following code creates a keymap to toggle inlay hints in your
            -- code, if the language server you are using supports them
            --
            -- This may be unwanted, since they displace some of your code
            if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              require('snacks').toggle.inlay_hints():map '<leader>th'
            end}) 

            --- Guard against servers without the signatureHelper capability
            if client.server_capabilities.signatureHelpProvider then
              ---@diagnostic disable-next-line: missing-fields
              require('lsp-overloads').setup(client, {
                ---@diagnostic disable-next-line: missing-fields
                keymaps = {
                  close_signature = '<A-i>',
                },
              })
              map('<leader>tO', '<cmd>LspOverloadsSignatureAutoToggle<CR>', 'Toggle Lsp Signature Auto' )
              map('<A-i>', '<cmd>LspOverloadsSignature<CR>', 'Show Signature Overloads', { 'i', 'n' }, true)
            end

            if client.server_capabilities.declarationProvider then
              -- WARN: This is not Goto Definition, this is Goto Declaration.
              --  For example, in C this would take you to the header.
              map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            end

            if client.server_capabilities.referencesProvider then
              -- Find references for the word under your cursor.
              map('gr', function()
                require('telescope.builtin').lsp_references { layout_strategy = 'vertical', show_line = false }
              end, '[G]oto [R]eferences')
            end

            if client.server_capabilities.definitionProvider then
              -- Jump to the definition of the word under your cursor.
              --  This is where a variable was first declared, or where a function is defined, etc.
              --  To jump back, press <C-t>.
              map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
              map('<F12>', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            end

            if client.server_capabilities.implementationProvider then
              -- Jump to the implementation of the word under your cursor.
              --  Useful when your language has ways of declaring types without an actual implementation.
              map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
              map('<C-F12>', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            end

            if client.server_capabilities.typeDefinitionProvider then
              -- Jump to the type of the word under your cursor.
              --  Useful when you're not sure what type a variable is and you want to see
              --  the definition of its *type*, not where it was *defined*.
              map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
            end

            if client.server_capabilities.codeLensProvider then
              map('<leader>cc', vim.lsp.codelens.run, 'Run [c]odelens', { 'n', 'v' })
              map('<leader>cC', vim.lsp.codelens.refresh, 'Refresh e Display [C]odelens')
            end

            if client.server_capabilities.documentSymbolProvider then
              -- Fuzzy find all the symbols in your current document.
              --  Symbols are things like variables, functions, types, etc.
              map('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Document [s]ymbols')
            end

            if client.server_capabilities.workspaceSymbolProvider then
              -- Fuzzy find all the symbols in your current workspace.
              --  Similar to document symbols, except searches over your entire project.
              map('<leader>cS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')
            end

            -- Change diagnostic symbols in the sign column (gutter)
            if vim.g.have_nerd_font then
              local signs = {
                ERROR = local_icons.diagnostics.error_lsp,
                WARN = local_icons.diagnostics.warn_lsp,
                INFO = local_icons.diagnostics.info_lsp,
                HINT = local_icons.diagnostics.hint_lsp,
              }
              local diagnostic_signs = {}
              for type, icon in pairs(signs) do
                if vim.fn.has 'nvim-0.10.2' == 1 then
                  diagnostic_signs[vim.diagnostic.severity[type] ] = icon
                else
                  local hl = 'DiagnosticSign' .. type
                  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
                end
              end
              if vim.fn.has 'nvim-0.10.2' == 1 then
                vim.diagnostic.config { signs = { text = diagnostic_signs } }
              end
            end

            if server_local_configs[client.name] ~= nil and server_local_configs[client.name].keys ~= nil then
              local keys = server_local_configs[client.name].keys
              for _, k in ipairs(keys) do
                if type(k.key) == 'table' then
                  for _, kl in ipairs(k.key) do
                    map(kl, k.func, k.desc, k.mode)
                  end
                else
                  map(k.key, k.func, k.desc, k.mode)
                end
              end
            end
          end
        end,
      })


            ]]



		end,
	},
}
