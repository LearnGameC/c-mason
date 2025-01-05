local M = {}
local function lk(client, bufnr)
  local x = function(l, r, d, m)
    m = m or "x"
    vim.keymap.set(m, l, r, { desc = d, noremap = true, silent = true, nowait = true, buffer = bufnr })
  end
  local i = function(l, r, d, m)
    m = m or "i"
    vim.keymap.set(m, l, r, { desc = d, noremap = true, silent = true, nowait = true, buffer = bufnr })
  end
  local n = function(l, r, d, m)
    m = m or "n"
    vim.keymap.set(m, l, r, { desc = d, noremap = true, silent = true, nowait = true, buffer = bufnr })
  end
  local e = function(l, r, d, m)
    m = m or "n"
    d = d or r
    vim.keymap.set(m, l, r, { desc = d, noremap = true, silent = true, nowait = true, expr = true })
  end
  local Ej = function(l, r, d, r2)
    r2 = r2 or l
    e(l, function()
      if client.name == "jdtls" then
        if vim.fn.col(".") == vim.fn.col("$") then
          return r
        end
        return r2
      end
      return l
    end, d, "i")
  end


  -- vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
  --   pattern = { "*.java", --[[ "*.h" ]] },
  --   callback = function(ev)
  --   end
  -- })
  -- vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
  --   pattern = { "*.lua", --[[ "*.h" ]] },
  --   callback = function(ev)
  --     print(vim.fn.strftime('%H:%M:%S'))
  --   end
  -- })
  -- print(vim.fn.strftime('%H:%M:%S'))

  -- vim.keymap.set("n", "K", function()
  --   local winid = require("ufo").peekFoldedLinesUnderCursor(jklh)
  --   if not winid then
  --     vim.lsp.buf.hover()
  --   end
  -- end)


  n(",do", vim.diagnostic.open_float, "Show line diagnostics")
  n(",dp", vim.diagnostic.goto_prev, "Go to previous diagnostic")
  n(",dn", vim.diagnostic.goto_next, "Go to next diagnostic")
  n(",dl", vim.diagnostic.setloclist, "Thêm chẩn đoán bộ đệm vào danh sách vị trí")
  n(",dq", vim.diagnostic.setqflist, "Thêm tất cả các chẩn đoán vào danh sách sửa lỗi nhanh")
  n(",ds", function()
    local float = vim.diagnostic.config().float
    if float then
      local config = type(float) == "table" and float or {}
      config.scope = "line"
      vim.diagnostic.open_float(config)
    end
  end, "Show line diagnostics")
  n(",dg", vim.diagnostic.get, "Nhận chẩn đoán hiện tại")
  n(",da", vim.diagnostic.get_namespaces, "Lấy không gian tên chẩn đoán")
  n(",dH", vim.diagnostic.hide, "Ẩn các chẩn đoán")
  -- n(",dj", vim.diagnostic.jump, "Di chuyển đến chẩn đoán")
  n(",ds", vim.diagnostic.show, "Hiển thị chẩn đoán")

  -- lsp
  i(",.l", vim.lsp.buf.completion, "vim.lsp.buf.completion")
  n(",lc", vim.lsp.buf.code_action, "Code actions")
  n(",lC", function()
    vim.lsp.buf.code_action({
      context = {
        only = {
          "source",
        },
        diagnostics = {},
      },
    })
  end, "Code actions")
  n(",lR", "<cmd>lua vim.lsp.codelens.run()<cr>", "Run Codelens")
  n(",ls", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
  x("<A-;>", "<CMD>lua vim.lsp.buf.range_code_action()<CR>", "Code actions")
  n(",lW", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  n(",lw", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  n(",lF", function()
    vim.lsp.buf.format({ async = true })
  end, "Format file")
  n(",l?", vim.lsp.buf.signature_help, "Show signature information")
  n(",lr", vim.lsp.buf.rename, "Rename")
  n(",K", vim.lsp.buf.hover, "Hover text")
  n(",lP", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
  n(",lt", vim.lsp.buf.typehierarchy, "Lists all typehierarchy")
  n(",lX", vim.lsp.codelens.clear, "Xóa các thấu kính")
  n(",lS", vim.lsp.codelens.display, "Hiển thị các thấu kính")
  n(",lg", vim.lsp.codelens.get, "Trả về tất cả các ống kính")
  n(",la", vim.lsp.codelens.on_codelens, "lsp cho phương pháptextDocument/codeLens")
  n(",lb", vim.lsp.codelens.refresh, "Làm mới các thấu kính")
  n(",lB", function() vim.lsp.codelens.refresh({ bufnr = 0 }) end, "Làm mới các thấu kính")
  n(",lb", vim.lsp.codelens.save, "Lưu trữ các ống kính cho một bộ đệm")
  n(",le", vim.lsp.util.rename, "Đổi tên old_fname thành new_fname")
  n(",le", vim.lsp.util.show_document, "Hiển thị tài liệu và nhảy đến vị trí")
  n(",o!", function()
    if vim.o.scrolloff == 5 then
      vim.o.scrolloff = 99
    else
      vim.o.scrolloff = 5
    end
  end, "Toggle scrolloff 99")
  n(",o.", function()
    local function lf()
      vim.opt.iskeyword:append "."
      -- vim.cmd([[set iskeyword += .]])
      n(",o.", function()
        vim.opt.iskeyword:remove "."
        n(",o.", function()
          lf()
        end, "iskeyword add .")
      end, "iskeyword remove .")
    end
    lf()
  end, "iskeyword add .")

  n("si", "<cmd>Telescope lsp_implementations<cr>", "Organize imports")
  n("sw", function() require("telescope.builtin").lsp_workspace_symbols() end, "lsp_workspace_symbols")
  n("sW", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "lsp_dynamic_workspace_symbols")
  n("sD", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, "lsp_type_definitions")
  n("sI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, "Goto Implementation")
  n("sr", "<cmd>Telescope lsp_references<cr>", "lsp_references")
  n("sd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, "Go to definition")

  n("zd", "<cmd>Lspsaga goto_definition<cr>", "Go to definition")
  n("zD", "<cmd>Lspsaga goto_type_definition<cr>", "goto_type_definition")
  n("<space>ll", "<cmd>Lspsaga show_line_diagnostics<cr>", "Organize imports")
  n("<space>lp", "<cmd>Lspsaga peek_definition<cr>", "peek_definition")

  n("<space>lI", "<cmd>Lspsaga incoming_calls<cr>", "Lists all the call")
  n("<space>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Prev Diagnostic")
  n("<space>lo", "<cmd>Lspsaga outline<cr>", "Code Outline")
  n("<space>lO", "<cmd>Lspsaga outgoing_calls<cr>", "Outgoing Calls")
  n("K", "<cmd>Lspsaga hover_doc<cr>", "Hover text")
  n("<space>lR", "<cmd>Lspsaga rename<cr>", "Rename")
  n("<space>lr", "<cmd>Lspsaga rename mode=n<CR>", "Rename mode")
  n("<space>lP", "<cmd>Lspsaga lsp_rename ++project<CR>", "Rename project")
  n("<space>la", "yiw<cmd>Lspsaga project_replace <C-r>* <C-r>*", "project_replace")
  n("<space>lf", "<cmd>Lspsaga finder ref<CR>", "finder ref")
  n("<space>lF", "<cmd>Lspsaga finder def+ref<CR>", "finder def+ref")
  n("<space>lp", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, "jump over error")
  n("<space>lSn", "<cmd>Lspsaga show_workspace_diagnostics ++normal<CR>", "show_workspace_diagnostics ++normal")
  n("<space>lSf", "<cmd>Lspsaga show_workspace_diagnostics ++float<CR>", "show_workspace_diagnostics ++float")
  n("<A-a>", "<cmd>Lspsaga code_action<cr>", "Code actions", { "x", "n", "i" })
  n(",q", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>", "Code actions", "x")
end

-- local function java_keymaps(bufnr)
-- local kk = function(l, r, o, m)
--   m = m or "n"
--   vim.keymap.set("n", l, r, { desc = o, noremap = true, silent = true, nowait = true , buffer = bufnr})
-- end
-- 	-- Java extensions provided by jdtls
-- 	kk("<C-o>", jdtls.organize_imports, "Organize imports")
-- 	kk("<space>ev", jdtls.extract_variable, "Extract variable")
-- 	kk("<space>ec", jdtls.extract_constant, "Extract constant")
-- end

-- local function lsp_jdtls(bufnr)
-- 	local wk = require("which-key")
-- 	wk.register({
-- 		["<leader>cV"] = { require("jdtls").extract_variable_all, "Extract Variable replace all" },
-- 		["gs"] = { require("jdtls").super_implementation, "Goto Super implementation" },
-- 		["gS"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
-- 		["<leader>co"] = { require("jdtls").organize_imports, "Organize Imports" },
-- 	}, { mode = "n", buffer = bufnr })
-- 	wk.register({
-- 		["em"] = { [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], "Extract Method" },
-- 		["<leader>cxv"] = { [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]], "Extract Variable" },
-- 		["ec"] = { [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]], "Extract Constant" },
-- 	}, { mode = "x", buffer = bufnr })
-- 	wk.register({
-- 		["<leader>tt"] = { require("jdtls.dap").test_class, "Run All Test" },
-- 		["<leader>td"] = { require("jdtls.dap").test_nearest_method, "Debug Nearest Test" },
-- 		["<leader>tT"] = { require("jdtls.dap").pick_test, "Run Test" },
-- 		["<leader>t/d"] = { require("jdtls.dap").fetch_main_configs, "Discover executable main functions" },
-- 		["<leader>tC"] = { require("jdtls.dap").setup_dap_main_class_configs, "Discover main classes" },
-- 	}, { mode = "n", buffer = bufnr })
-- end

local function lsp_highlight(client, bufnr)
  -- Highlight symbol under cursor
  if client.supports_method("textDocument/documentHighlight") then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
  if client.supports_method('textDocument/completion') then
    -- Enable auto-completion
    -- vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger = true})
  end
  -- if client.supports_method('textDocument/formatting') then
  --   -- Format the current buffer on save
  --   vim.api.nvim_create_autocmd('BufWritePre', {
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
  --     end,
  --   })
  -- end
end

M.on_attach = function(client, bufnr)
  lk(client, bufnr)
  vim.api.nvim_create_autocmd({ "BufLeave" }, {
    pattern = { "*.cs", "*.java" },
    callback = function(ev)
      local n = function(l, r, d, m)
        m = m or "n"
        vim.keymap.set(m, l, r, { desc = d, noremap = true, silent = true, nowait = true, buffer = bufnr })
      end
      if client.name == "csharp_ls" then
        n(",ld", require('omnisharp_extended').lsp_definition, "definition")
        n(",lD", require('omnisharp_extended').lsp_type_definition, "definition")
        n(",ll", require('omnisharp_extended').lsp_references, "Lists all references")
        n(",lI", require('omnisharp_extended').lsp_implementation, "Lists all implementations")
        n("s,l", require('omnisharp_extended').telescope_lsp_references, "Lists all references")
        n("s,d", "<cmd>lua require('omnisharp_extended').telescope_lsp_definition({ jump_type = 'vsplit' })<cr>",
          "Go to definition")
        n("s,D", require('omnisharp_extended').telescope_lsp_type_definition, "Go to type definition")
        n("s,I", require('omnisharp_extended').telescope_lsp_implementation, "Lists all references")
      elseif client.name == "jdtls" then
      else
        n(",ll", vim.lsp.buf.references, "Lists all references")
        n(",ld", vim.lsp.buf.definition, "Go to definition")
        n(",lD", vim.lsp.buf.type_definition, "Go to type definition")
        n(",lI", vim.lsp.buf.implementation, "Lists all implementations")
      end
      -- print("save hi")
      -- require("util.opts").on_attach(client, bufnr)
      vim.keymap.set("n", ",;o", function()
        lk(client, bufnr)
      end, { desc = "reset lua", noremap = true, silent = true, nowait = true, buffer = bufnr })
      -- lk(client, bufnr)
    end
  })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "/Users/macbook/.config/nvim/lua/util/opts.lua", --[[ "*.h" ]] },
    callback = function(ev)
      -- print("save hi")
      -- require("util.opts").on_attach(client, bufnr)
      vim.keymap.set("n", ",;o", function()
        lk(client, bufnr)
      end, { desc = "reset lua", noremap = true, silent = true, nowait = true, buffer = bufnr })
      -- lk(client, bufnr)
    end
  })

  -- if client.supports_method "textDocument/inlayHint" then
  --   vim.lsp.inlay_hint.enable(bufnr, true)
  -- end
  lsp_highlight(client, bufnr)
end

M.on_attach_java = function(client, bufnr)
  lk(bufnr)
  if client.name == "jdtls" then
    if vim.fn.col(".") == vim.fn.col("$") then
      return "<End>;<ESC>==o"
    end
  end
  lsp_highlight(client, bufnr)
end

return M
