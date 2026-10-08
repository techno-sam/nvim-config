local ft = {
  "clojure",
  "fennel",
  "janet",
  "hy",
  "julia",
  "racket",
  "scheme",
  --"lua",
  "lisp",
  --"python",
  --"rust",
  "sql",
}

return {
  {
    "Olical/conjure",
    ft = ft,
    init = function()
      vim.g["conjure#filetypes"] = ft
      --vim.g["conjure#log#level"] = "debug"
    end,
  },
}
