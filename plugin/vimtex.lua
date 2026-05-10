vim.g.vimtex_view_method = "zathura"

vim.g.vimtex_compiler_latexmk = {
  aux_dir = "_aux",
  out_dir = "_build"
}

vim.g.vimtex_compiler_latexmk_engines = {
  ['_'] = '-pdf',
  ['pdf_escaped'] = '-pdf -pdflatex="pdflatex -shell-escape %O %S"'
}
