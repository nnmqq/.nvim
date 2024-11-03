local colorscheme = 'kanagawa-paper'

---@diagnostic disable-next-line: param-type-mismatch
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
