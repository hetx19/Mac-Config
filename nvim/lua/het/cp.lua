local M = {}

function M.setup()
    -- ================================
    -- 🏆 Competitive Programming Setup
    -- ================================
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.cpp",
        callback = function()
            local file_dir = vim.fn.expand("%:p:h")
            local makefile = file_dir .. "/Makefile"

            if vim.fn.filereadable(makefile) == 0 then
                return
            end

            if vim.b.cp_loaded then
                return
            end
            vim.b.cp_loaded = true

            if vim.fn.isdirectory(file_dir) == 1 then
                vim.api.nvim_set_current_dir(file_dir)
            end

            vim.opt_local.makeprg = "make"

            local function run_make(target)
                vim.cmd("write")
                local ok, err = pcall(vim.cmd, "silent make " .. target)
                if not ok then
                    print("❌ Error running make: " .. err)
                    return
                end
                vim.cmd("checktime")
                vim.cmd("redraw!")
                print("✅ Make target '" .. target .. "' executed")
            end

            local cp_keymaps = {
                b = { "run", "Build & Run" },
                d = { "rund", "Debug Run" },
                c = { "release", "Compile Only" },
                x = { "clean", "Clean Build" },
            }

            for key, tbl in pairs(cp_keymaps) do
                vim.keymap.set("n", "<leader>" .. key, function()
                    run_make(tbl[1])
                end, { buffer = 0, desc = tbl[2] })
            end

            print("🏆 CP Mode Activated")
        end,
    })

    -- ================================
    -- 🧠 Layout
    -- ================================
    local function cp_layout_create()
        local file_dir = vim.fn.expand("%:p:h")

        if vim.fn.isdirectory(file_dir) == 0 then
            print("⚠️ Invalid directory")
            return
        end

        vim.api.nvim_set_current_dir(file_dir)

        local files = { "input.txt", "output.txt", "time.txt" }

        for _, f in ipairs(files) do
            local path = file_dir .. "/" .. f
            if vim.fn.filereadable(path) == 0 then
                vim.fn.writefile({}, path)
            end
        end

        vim.cmd("only")

        vim.cmd("vsplit input.txt")
        vim.cmd("wincmd l")
        vim.cmd("split output.txt")
        vim.cmd("wincmd j")
        vim.cmd("split time.txt")
        vim.cmd("wincmd h")
        vim.cmd("vertical resize 100")

        print("🏆 CP Layout Loaded")
    end

    vim.keymap.set("n", "<leader>ly", cp_layout_create, { desc = "Load CP Layout" })

    vim.keymap.set("n", "<leader>lo", function()
        vim.cmd("only")
        print("🗑 Layout Closed")
    end, { desc = "Close CP Layout" })

    vim.keymap.set("n", "<leader>ls", function()
        vim.cmd("silent! wall")
        print("💾 All files saved")
    end, { desc = "Save All Buffers" })

    vim.keymap.set("n", "<leader>qq", function()
        vim.cmd("qa!")
    end, { desc = "Quit All" })
end

return M
