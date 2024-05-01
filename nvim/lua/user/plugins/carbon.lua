return {
    'Lougnar/carbon-now.nvim',
    branch = 'fix/open-cmd-fallback-conditions',
    lazy = true,
    cmd = 'CarbonNow',
    config = function()
        require(
            'carbon-now'
        ).setup()
    end,
}
