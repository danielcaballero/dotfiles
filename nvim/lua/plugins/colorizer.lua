return {
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "scss", "html", "javascript", "typescript", "lua" },
        user_default_options = {
          RGB = true, -- #RGB
          RRGGBB = true, -- #RRGGBB
          names = true, -- "blue"
          RRGGBBAA = true, -- #RRGGBBAA
          AARRGGBB = true, -- 0xAARRGGBB
          rgb_fn = true, -- rgb(255, 0, 0)
          hsl_fn = true, -- hsl(0, 100%, 50%)
          css = true, -- Enable all CSS features
          css_fn = true, -- Enable all CSS functions
          mode = "background", -- Display style: "background", "foreground", or "virtualtext"
        },
      })
    end,
  },
}
