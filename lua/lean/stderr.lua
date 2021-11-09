local log = require'vim.lsp.log'
local stderr = {}

-- Show stderr output in separate buffer
-- TODO: add upstream neovim API
function stderr.enable()
  local old_error = log.error
  local stderr_bufnr, stderr_winnr
  log.error = function(...)
    local argc = select('#', ...)
    if argc == 0 then return true end -- always enable error messages
    if argc == 4 and select(1, ...) == 'rpc' and select(3, ...) == 'stderr'
        and string.match(select(2, ...), 'lean') then
      local chunk = select(4, ...)
      vim.schedule(function()
        if not stderr_bufnr or not vim.api.nvim_buf_is_valid(stderr_bufnr) then
          stderr_bufnr = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_name(stderr_bufnr, "lean://stderr")
          stderr_winnr = nil
        end
        if not stderr_winnr or not vim.api.nvim_win_is_valid(stderr_winnr) then
          local old_win = vim.api.nvim_get_current_win()
          vim.cmd(('botright sbuffer %d'):format(stderr_bufnr))
          vim.cmd'resize 5'
          stderr_winnr = vim.api.nvim_get_current_win()
          vim.opt_local.number = true
          vim.opt_local.bufhidden = 'hide'
          vim.opt_local.spell = false
          vim.opt_local.undolevels = -1
          vim.opt_local.signcolumn = 'no'
          vim.api.nvim_set_current_win(old_win)
        end
        local lines = vim.split(chunk, '\n')
        local num_lines = vim.api.nvim_buf_line_count(stderr_bufnr)
        if lines[#lines] == '' then table.remove(lines) end
        vim.api.nvim_buf_set_lines(stderr_bufnr, num_lines, num_lines, false, lines)
        if vim.api.nvim_get_current_win() ~= stderr_winnr then
          vim.api.nvim_win_set_cursor(stderr_winnr, {num_lines, 0})
        end
      end)
    end
    old_error(...)
  end
end

return stderr
