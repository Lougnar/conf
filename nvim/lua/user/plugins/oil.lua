return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() 
        require("oil").setup({
            float = {
                -- Padding around the floating window
                padding = 4,
                max_width = 200,
                max_height = 0,
            }})
    end
}
