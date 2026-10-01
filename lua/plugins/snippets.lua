-- ~/.config/nvim/lua/plugins/snippets.lua
-- Custom snippets configuration

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      -- Load VSCode-style snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Custom C snippets
      ls.add_snippets("c", {
        s("main", {
          t("int main(int argc, char *argv[]) {"),
          t({ "", "\t" }),
          i(1, "// code"),
          t({ "", "\treturn 0;", "}" }),
        }),
        s("inc", {
          t("#include <"),
          i(1, "stdio.h"),
          t(">"),
        }),
        s("incq", {
          t('#include "'),
          i(1, "header.h"),
          t('"'),
        }),
        s("ifdef", {
          t("#ifdef "),
          i(1, "MACRO"),
          t({ "", "" }),
          i(2, "// code"),
          t({ "", "#endif" }),
        }),
        s("ifndef", {
          t("#ifndef "),
          i(1, "HEADER_H"),
          t({ "", "#define " }),
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t({ "", "", "" }),
          i(2, "// code"),
          t({ "", "", "#endif" }),
        }),
        s("struct", {
          t("struct "),
          i(1, "name"),
          t({ " {", "\t" }),
          i(2, "// members"),
          t({ "", "};" }),
        }),
        s("for", {
          t("for (int "),
          i(1, "i"),
          t(" = 0; "),
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t(" < "),
          i(2, "n"),
          t("; "),
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t({ "++) {", "\t" }),
          i(3, "// code"),
          t({ "", "}" }),
        }),
      })

      -- Custom C++ snippets
      ls.add_snippets("cpp", {
        s("main", {
          t("#include <iostream>"),
          t({ "", "", "int main(int argc, char *argv[]) {", "\t" }),
          i(1, "// code"),
          t({ "", "\treturn 0;", "}" }),
        }),
        s("class", {
          t("class "),
          i(1, "ClassName"),
          t({ " {", "public:", "\t" }),
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t("();"),
          t({ "", "\t~" }),
          f(function(args)
            return args[1][1]
          end, { 1 }),
          t("();"),
          t({ "", "", "private:", "\t" }),
          i(2, "// members"),
          t({ "", "};" }),
        }),
        s("ns", {
          t("namespace "),
          i(1, "name"),
          t({ " {", "", "" }),
          i(2, "// code"),
          t({ "", "", "} // namespace " }),
          f(function(args)
            return args[1][1]
          end, { 1 }),
        }),
      })

      -- Custom Python snippets
      ls.add_snippets("python", {
        s("main", {
          t("if __name__ == '__main__':"),
          t({ "", "\t" }),
          i(1, "pass"),
        }),
        s("def", {
          t("def "),
          i(1, "function"),
          t("("),
          i(2, "args"),
          t({ "):", "\t" }),
          i(3, '"""Docstring."""'),
          t({ "", "\t" }),
          i(4, "pass"),
        }),
        s("class", {
          t("class "),
          i(1, "ClassName"),
          t({ ":", "\t" }),
          i(2, '"""Docstring."""'),
          t({ "", "\t", "\tdef __init__(self" }),
          i(3, ""),
          t({ "):", "\t\t" }),
          i(4, "pass"),
        }),
        s("try", {
          t({ "try:", "\t" }),
          i(1, "# code"),
          t({ "", "except " }),
          i(2, "Exception"),
          t({ " as e:", "\t" }),
          i(3, "# handle exception"),
        }),
        s("with", {
          t("with "),
          i(1, "open('file.txt')"),
          t(" as "),
          i(2, "f"),
          t({ ":", "\t" }),
          i(3, "# code"),
        }),
      })

      -- Snippet expansion keybindings
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      vim.keymap.set("i", "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
}
