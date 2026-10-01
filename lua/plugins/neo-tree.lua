-- ~/.config/nvim/lua/plugins/neo-tree.lua
-- Configure Neo-tree with NERDTree-style keybindings

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "open_current",
    },
    window = {
      position = "left",
      width = 30,
      mappings = {
        -- NERDTree-style mappings
        ["o"] = "open", -- Open file or toggle directory
        ["t"] = "open_tabnew", -- Open in new tab
        ["i"] = "open_split", -- Open in horizontal split
        ["s"] = "open_vsplit", -- Open in vertical split
        ["p"] = function(state) -- Go to parent directory
          local node = state.tree:get_node()
          if node.type == "directory" then
            require("neo-tree.sources.filesystem.commands").navigate_up(state)
          else
            local parent = state.tree:get_node(node:get_parent_id())
            require("neo-tree.ui.renderer").focus_node(state, parent:get_id())
          end
        end,
        ["r"] = "refresh", -- Refresh current directory
        ["m"] = "show_file_details", -- Show file details (closest to menu)

        -- Keep some useful defaults
        ["<space>"] = "toggle_node",
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["a"] = "add",
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["P"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["q"] = "close_window",
        ["R"] = "rename",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
        ["z"] = "close_all_nodes",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
}
