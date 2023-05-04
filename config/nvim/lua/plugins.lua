return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        opts = {
            style = 'darker',
            transparent = true
        },
        config = function(_, opts)
            require("onedark").setup(opts)
            require("onedark").load()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        lazy = false,
        config = function()
            require'colorizer'.setup(
                {'*';},
                {
                    RGB      = true;         -- #RGB hex codes
                    RRGGBB   = true;         -- #RRGGBB hex codes
                    names    = true;         -- "Name" codes like Blue
                    RRGGBBAA = true;         -- #RRGGBBAA hex codes
                    rgb_fn   = true;         -- CSS rgb() and rgba() functions
                    hsl_fn   = true;         -- CSS hsl() and hsla() functions
                    css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
                })
        end,
    },
    -- {
    --     "nvim-lualine/lualine.nvim",
    --     config = function()
    --         -- get lualine nightfly theme
    --         local lualine_onedark = require("lualine.themes.onedark")

    --         -- new colors for theme
    --         local new_colors = {
    --         blue = "#65D1FF",
    --         green = "#3EFFDC",
    --         violet = "#FF61EF",
    --         yellow = "#FFDA7B",
    --         black = "#000000",
    --         }

    --         -- change nightlfy theme colors
    --         lualine_onedark.normal.a.bg = new_colors.blue
    --         lualine_onedark.insert.a.bg = new_colors.green
    --         lualine_onedark.visual.a.bg = new_colors.violet
    --         lualine_onedark.command = {
    --         a = {
    --             gui = "bold",
    --             bg = new_colors.yellow,
    --             fg = new_colors.black, -- black
    --         },
    --         }

    --         -- configure lualine with modified theme
    --         require("lualine").setup({
    --         options = {
    --             theme = lualine_onedark,
    --         },
    --         })
    --     end,
    -- },
    -- {
    --     "nvim-tree/nvim-tree.lua",
    --     config = function()
    --         -- recommended settings from nvim-tree documentation
    --         vim.g.loaded_netrw = 1
    --         vim.g.loaded_netrwPlugin = 1

    --         -- change color for arrows in tree to light blue
    --         vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

    --         -- configure nvim-tree
    --         require("nvim-tree").setup({
    --         -- change folder arrow icons
    --         renderer = {
    --             icons = {
    --             glyphs = {
    --                 folder = {
    --                 arrow_closed = "", -- arrow when folder is closed
    --                 arrow_open = "", -- arrow when folder is open
    --                 },
    --             },
    --             },
    --         },
    --         -- disable window_picker for
    --         -- explorer to work well with
    --         -- window splits
    --         actions = {
    --             open_file = {
    --             window_picker = {
    --                 enable = false,
    --             },
    --             },
    --         },
    --         -- 	git = {
    --         -- 		ignore = false,
    --         -- 	},
    --         })
    --     end,
    -- },
    { 
        "nvim-tree/nvim-web-devicons",
        lazy = true 
    }
}