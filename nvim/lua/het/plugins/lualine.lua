return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        local colors = {
            blue = "#65D1FF",
            cyan = "#3EFFDC",
            violet = "#FF61EF",
            yellow = "#FFDA7B",
            red = "#FF4A4A",
            orange = "#ff9e64",
            green = "#3EFF6D",

            fg = "#c3ccdc",
            bg = "#0f1a28",
            section_bg = "#1a2a3a",
            inactive_bg = "#2c3043",
            gray = "#9aa5ce",
        }

        local my_lualine_theme = {
            normal = {
                a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
                b = { bg = colors.section_bg, fg = colors.violet },
                c = { bg = colors.bg, fg = colors.fg },
            },
            insert = {
                a = { bg = colors.green, fg = colors.bg, gui = "bold" },
            },
            visual = {
                a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
            },
            command = {
                a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
            },
            replace = {
                a = { bg = colors.red, fg = colors.bg, gui = "bold" },
            },
            inactive = {
                a = { bg = colors.inactive_bg, fg = colors.gray, gui = "bold" },
                b = { bg = colors.inactive_bg, fg = colors.gray },
                c = { bg = colors.inactive_bg, fg = colors.gray },
            },
        }

        lualine.setup({
            options = {
                theme = my_lualine_theme,
                section_separators = { left = "", right = "" },
                component_separators = { left = "▸", right = "◂" },
                globalstatus = true,
            },

            sections = {
                lualine_a = {
                    { "mode", icon = "" },
                },
                lualine_b = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = colors.violet, bg = colors.section_bg, gui = "bold" },
                    },
                    {
                        "diff",
                        symbols = { added = " ", modified = " ", removed = " " },
                        diff_color = {
                            added = { fg = colors.green },
                            modified = { fg = colors.yellow },
                            removed = { fg = colors.red },
                        },
                    },
                },
                lualine_c = {
                    { "filename", color = { fg = colors.orange, gui = "bold" } },
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = colors.orange, gui = "bold" },
                    },
                    { "encoding", color = { fg = colors.violet } },
                    { "fileformat", symbols = { unix = "" }, color = { fg = colors.cyan } },
                    { "filetype", icon_only = false, color = { fg = colors.green } },
                },
                lualine_y = {
                    { "progress", color = { fg = colors.yellow, gui = "bold" } },
                },
                lualine_z = {
                    {
                        "location",
                        color = { fg = colors.bg, bg = colors.blue, gui = "bold" },
                    },
                },
            },
        })
    end,
}
