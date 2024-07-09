local function map(mode, lhs, rhs, opts)
  local options = {
    noremap = true,
    silent = true
  }
  if opts then
    if opts.desc then
      opts.desc = opts.desc
    end
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- insert Navigation
map('i', '<C-h>', '<Left>', {
  desc = 'Left'
})
map('i', '<C-j>', '<Down>', {
  desc = 'Down'
})
map('i', '<C-k>', '<Up>', {
  desc = 'Up'
})
map('i', '<C-l>', '<Right>', {
  desc = 'Right'
})
map('i', '<C-b>', '<ESC>^i', {
  desc = 'Insert at beginning of line'
})
map('i', '<C-e>', '<ESC>$a', {
  desc = 'Insert at end of line'
})
map('n', 'gD', function()
  vim.lsp.buf.declaration()
end, {
  desc = "LSP declaration"
})
map('n', 'gd', function()
  vim.lsp.buf.definition()
end, {
  desc = "LSP definition"
})
map('n', 'K', function()
  vim.lsp.buf.hover()
end, {
  desc = "LSP hover"
})
map('n', 'gi', function()
  vim.lsp.buf.implementation()
end, {
  desc = "LSP implementation"
})
map('n', 'gr', function()
  vim.lsp.buf.references()
end, {
  desc = "LSP references"
})
map('n', '<leader>lf', function()
  vim.diagnostic.open_float {
    border = "rounded"
  }
end, {
  desc = "Floating diagnostic"
})
map('n', ']d', function()
  vim.diagnostic.goto_next {
    float = {
      border = "rounded"
    }
  }
end, {
  desc = "Goto next"
})
map('n', '[d', function()
  vim.diagnostic.goto_prev {
    float = {
      border = "rounded"
    }
  }
end, {
  desc = "Goto previous"
})
map('n', '<leader>ls', function()
  vim.lsp.buf.signature_help()
end, {
  desc = "LSP signature help"
})
map('n', '<leader>ls', function()
  vim.lsp.buf.type_definition()
end, {
  desc = "LSP definition type"
})
map({'n', 'v'}, '<leader>ca', function()
  vim.lsp.buf.code_action()
end, {
  desc = "LSP code actions"
})

-- miscellanous
map('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', {
  desc = 'Dont copy replaced text'
})

map('n', '<Esc>', ':noh<CR>', {
  desc = 'Clear highlights'
})

map('n', '<C-n>', ':NvimTreeToggle<CR>', {
  desc = 'Toggle NvimTree'
})
map('n', '<C-s>', ':wa<CR>', {
  desc = 'Save All'
})
map('n', '<leader>e', ':NvimTreeFocus<CR>', {
  desc = 'Focus NvimTree'
})
map('n', '<leader>fm', function()
  require("conform").format()
end, {
  desc = 'Format with Conform'
})

-- Telescope
map('n', '<leader>fa', ':Telescope find_files follow=true no_ignore=true hidden=true<CR>', {
  desc = 'Find all'
})
map('n', '<leader>ff', ':Telescope find_files<CR>', {
  desc = 'Find files'
})
map('n', '<leader>fw', ':Telescope live_grep<CR>', {
  desc = 'Grep'
})
map('n', '<leader>fb', ':Telescope buffers<CR>', {
  desc = 'Buffers'
})
map('n', '<leader>fh', ':Telescope help_tags<CR>', {
  desc = 'Help tags'
})
map('n', '<leader>fo', ':Telescope oldfiles<CR>', {
  desc = 'Old files'
})
map('n', '<leader>fz', ':Telescope current_buffer_fuzzy_find<CR>', {
  desc = 'Current buffer fuzzy find'
})
map('n', '<leader>db', ':DapToggleBreakpoint<CR>', {
  desc = 'Add breakpoint at line'
})
map('n', '<leader>dr', ':DapContinue<CR>', {
  desc = 'Continue'
})
map('n', '<leader>do', ':DapStepOver<CR>', {
  desc = 'Step Over'
})
map('n', '<leader>du', ':DapStepOut<CR>', {
  desc = 'Step Out'
})
map('n', '<leader>di', ':DapStepInto<CR>', {
  desc = 'Step Into'
})
map('n', '<leader>ds', ':Telescope dap configurations<CR>', {
  desc = 'Debug Start'
})
map('n', '<leader>dt', ':DapToggle<CR>', {
  desc = 'Toggle Debug'
})

-- terminal
map({'t', 'n'}, '<A-i>', function()
  require("nvterm.terminal").toggle "float"
end, {
  desc = 'Toggle floating term'
})
map({'t', 'n'}, '<A-h>', function()
  require("nvterm.terminal").toggle "horizontal"
end, {
  desc = 'Toggle horizontal term'
})
map({'t', 'n'}, '<A-v>', function()
  require("nvterm.terminal").toggle "vertical"
end, {
  desc = 'Toggle vertical term'
})
map('t', '<C-x>', vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), {
  desc = 'Escape terminal mode'
})
map('n', '<leader>h', function()
  require("nvterm.terminal").new "horizontal"
end, {
  desc = 'New horizontal term'
})
map('n', '<leader>v', function()
  require("nvterm.terminal").new "vertical"
end, {
  desc = 'New vertical term'
})

-- window
map('n', '<C-h>', '<C-w>h', {
  desc = 'Window left'
})
map('n', '<C-j>', '<C-w>j', {
  desc = 'Window down'
})
map('n', '<C-k>', '<C-w>k', {
  desc = 'Window up'
})
map('n', '<C-l>', '<C-w>l', {
  desc = 'Window right'
})

-- git
map('n', '<leader>rh', function()
  require("gitsigns").reset_hunk()
end, {
  desc = 'Reset hunk'
})
map('n', '<leader>ph', function()
  require("gitsigns").preview_hunk()
end, {
  desc = 'Preview hunk'
})
map('n', '<leader>gb', function()
  require("gitsigns").blame_line()
end, {
  desc = 'Blame line'
})

-- tabs
map('n', '<Tab>', ':BufferLineCycleNext<CR>', {
  desc = 'Next buffer'
})
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {
  desc = 'Previous buffer'
})
map('n', '<C-Tab>', ':BufferLineMoveNext<CR>', {
  desc = 'Move next'
})
map('n', '<C-S-Tab>', ':BufferLineMovePrev<CR>', {
  desc = 'Move previous'
})
map('n', '<leader>x', function()
  require('bufdelete').bufdelete(0)
end, {
  desc = 'Close buffer'
})
map('n', '<leader>bb', ':BufferLinePick<CR>', {
  desc = 'Pick buffer'
})
map('n', '<leader>bx', ':BufferLinePickClose<CR>', {
  desc = 'Pick buffer and close'
})
map('n', '<leader>ox', ':BufferLineCloseOthers<CR>', {
  desc = 'Close other buffers'
})
map('n', '<leader>lx', ':BufferLineCloseLeft<CR>', {
  desc = 'Close buffers to the left'
})
map('n', '<leader>rx', ':BufferLineCloseRight<CR>', {
  desc = 'Close buffers to the right'
})

-- Copilot
map('n', '<leader>ccc', ':CopilotChatOpen<CR>', {
  desc = 'Open Chat'
})
map('n', '<leader>ccff', ':CopilotChatFix<CR>', {
  desc = 'Fix Code'
})
map('n', '<leader>ccfd', ':CopilotChatFixDiagnostic<CR>', {
  desc = 'Fix Diagnostics'
})
map('v', '<leader>cce', ':CopilotChatExplain<CR>', {
  desc = 'Explain'
})
map('v', '<leader>ccr', ':CopilotChatReview<CR>', {
  desc = 'Review'
})
map('v', '<leader>cco', ':CopilotChatOptimize<CR>', {
  desc = 'Optimize Selection'
})
map('v', '<leader>ccd', ':CopilotChatDocs<CR>', {
  desc = 'Document Selection'
})
map('v', '<leader>cct', ':CopilotChatTests<CR>', {
  desc = 'Generate Tests'
})

-- comments
map('n', '<leader>/', function()
  require("Comment.api").toggle.linewise.current()
end, {
  desc = 'Toggle comment'
})
map('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {
  desc = 'Toggle comment'
})
