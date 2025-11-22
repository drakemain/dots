-- Dark Forest Theme
-- Matching Ghostty terminal colorscheme

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.termguicolors = true
vim.g.colors_name = 'darkforest'

local colors = {
  bg = '#1a1f1a',
  fg = '#d4d9c7',

  -- Normal colors (0-7)
  black = '#0f140f',
  red = '#b85c5c',
  green = '#6b8558',
  yellow = '#a88d5a',
  blue = '#5d7a8a',
  magenta = '#8a6e94',
  cyan = '#5e8888',
  white = '#b8bcaa',

  -- Bright colors (8-15)
  bright_black = '#3d4a3d',
  bright_red = '#c96b6b',
  bright_green = '#7a9a65',
  bright_yellow = '#b89a65',
  bright_blue = '#6d8fa0',
  bright_magenta = '#9d82a8',
  bright_cyan = '#739999',
  bright_white = '#e8ead6',
}

local function hi(group, opts)
  local cmd = 'highlight ' .. group
  if opts.fg then cmd = cmd .. ' guifg=' .. opts.fg end
  if opts.bg then cmd = cmd .. ' guibg=' .. opts.bg end
  if opts.gui then cmd = cmd .. ' gui=' .. opts.gui end
  if opts.sp then cmd = cmd .. ' guisp=' .. opts.sp end
  vim.cmd(cmd)
end

-- Editor highlights
hi('Normal', { fg = colors.fg, bg = colors.bg })
hi('NormalFloat', { fg = colors.fg, bg = colors.bright_black })
hi('NormalNC', { fg = colors.fg, bg = colors.bg })
hi('Comment', { fg = colors.bright_black, gui = 'italic' })
hi('Cursor', { fg = colors.bg, bg = colors.fg })
hi('CursorLine', { bg = colors.black })
hi('CursorColumn', { bg = colors.black })
hi('LineNr', { fg = colors.bright_black })
hi('CursorLineNr', { fg = colors.bright_yellow, gui = 'bold' })
hi('Visual', { bg = colors.bright_black })
hi('VisualNOS', { bg = colors.bright_black })
hi('Search', { fg = colors.bg, bg = colors.yellow })
hi('IncSearch', { fg = colors.bg, bg = colors.bright_yellow })
hi('MatchParen', { fg = colors.bright_yellow, gui = 'bold' })

-- Syntax highlighting
hi('Constant', { fg = colors.bright_magenta })
hi('String', { fg = colors.green })
hi('Character', { fg = colors.bright_green })
hi('Number', { fg = colors.bright_magenta })
hi('Boolean', { fg = colors.bright_magenta })
hi('Float', { fg = colors.bright_magenta })
hi('Identifier', { fg = colors.blue })
hi('Function', { fg = colors.bright_green })
hi('Statement', { fg = colors.red })
hi('Conditional', { fg = colors.red })
hi('Repeat', { fg = colors.red })
hi('Label', { fg = colors.red })
hi('Operator', { fg = colors.cyan })
hi('Keyword', { fg = colors.red })
hi('Exception', { fg = colors.bright_red })
hi('PreProc', { fg = colors.cyan })
hi('Include', { fg = colors.cyan })
hi('Define', { fg = colors.cyan })
hi('Macro', { fg = colors.cyan })
hi('PreCondit', { fg = colors.cyan })
hi('Type', { fg = colors.yellow })
hi('StorageClass', { fg = colors.yellow })
hi('Structure', { fg = colors.yellow })
hi('Typedef', { fg = colors.yellow })
hi('Special', { fg = colors.bright_cyan })
hi('SpecialChar', { fg = colors.bright_cyan })
hi('Tag', { fg = colors.bright_green })
hi('Delimiter', { fg = colors.fg })
hi('SpecialComment', { fg = colors.bright_black, gui = 'italic' })
hi('Debug', { fg = colors.bright_red })
hi('Underlined', { fg = colors.blue, gui = 'underline' })
hi('Ignore', { fg = colors.bright_black })
hi('Error', { fg = colors.bright_red, bg = colors.bg })
hi('Todo', { fg = colors.bright_yellow, bg = colors.bg, gui = 'bold' })

-- UI elements
hi('Pmenu', { fg = colors.fg, bg = colors.bright_black })
hi('PmenuSel', { fg = colors.bg, bg = colors.bright_green })
hi('PmenuSbar', { bg = colors.bright_black })
hi('PmenuThumb', { bg = colors.white })
hi('StatusLine', { fg = colors.fg, bg = colors.bright_black })
hi('StatusLineNC', { fg = colors.bright_black, bg = colors.black })
hi('TabLine', { fg = colors.bright_black, bg = colors.black })
hi('TabLineFill', { bg = colors.black })
hi('TabLineSel', { fg = colors.fg, bg = colors.bg })
hi('VertSplit', { fg = colors.bright_black, bg = colors.bg })
hi('Folded', { fg = colors.bright_black, bg = colors.black })
hi('FoldColumn', { fg = colors.bright_black, bg = colors.bg })
hi('SignColumn', { fg = colors.bright_black, bg = colors.bg })
hi('Directory', { fg = colors.blue })
hi('Title', { fg = colors.bright_green, gui = 'bold' })
hi('ErrorMsg', { fg = colors.bright_red })
hi('WarningMsg', { fg = colors.bright_yellow })
hi('Question', { fg = colors.bright_green })
hi('MoreMsg', { fg = colors.bright_green })
hi('ModeMsg', { fg = colors.bright_green })

-- Diff
hi('DiffAdd', { fg = colors.bright_green, bg = colors.black })
hi('DiffChange', { fg = colors.bright_yellow, bg = colors.black })
hi('DiffDelete', { fg = colors.bright_red, bg = colors.black })
hi('DiffText', { fg = colors.bright_blue, bg = colors.black })

-- Spell
hi('SpellBad', { sp = colors.bright_red, gui = 'undercurl' })
hi('SpellCap', { sp = colors.bright_blue, gui = 'undercurl' })
hi('SpellLocal', { sp = colors.bright_cyan, gui = 'undercurl' })
hi('SpellRare', { sp = colors.bright_magenta, gui = 'undercurl' })

-- Treesitter
hi('@variable', { fg = colors.fg })
hi('@variable.builtin', { fg = colors.bright_magenta })
hi('@function', { fg = colors.bright_green })
hi('@function.builtin', { fg = colors.bright_green })
hi('@keyword', { fg = colors.red })
hi('@keyword.function', { fg = colors.red })
hi('@keyword.operator', { fg = colors.red })
hi('@operator', { fg = colors.cyan })
hi('@punctuation.delimiter', { fg = colors.fg })
hi('@punctuation.bracket', { fg = colors.fg })
hi('@string', { fg = colors.green })
hi('@string.escape', { fg = colors.bright_cyan })
hi('@comment', { fg = colors.bright_black, gui = 'italic' })
hi('@type', { fg = colors.yellow })
hi('@type.builtin', { fg = colors.yellow })
hi('@constant', { fg = colors.bright_magenta })
hi('@constant.builtin', { fg = colors.bright_magenta })
hi('@parameter', { fg = colors.blue })

-- LSP
hi('DiagnosticError', { fg = colors.bright_red })
hi('DiagnosticWarn', { fg = colors.bright_yellow })
hi('DiagnosticInfo', { fg = colors.bright_blue })
hi('DiagnosticHint', { fg = colors.bright_cyan })
