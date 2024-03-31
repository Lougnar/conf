return {'akinsho/toggleterm.nvim', version = "*", config = function() 
    require("toggleterm").setup({
        close_on_exit = false
    })
end
}
