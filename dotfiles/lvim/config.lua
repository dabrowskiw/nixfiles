-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.rtp:append (vim.fn.stdpath ('data') .. '/site')

lvim.plugins = {
  'glepnir/template.nvim', cmd = {'Template','TemProject'}, config = function()
    require('template').setup({
        temp_dir = "/home/wojtek/Documents/Private/Obsidian/Notes/Templates/",
        author = "Wojtek Dabrowski",
        email = "piotr.dabrowski@htw-berlin.de"
    })
  end
}

