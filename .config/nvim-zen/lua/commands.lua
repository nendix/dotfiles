local pack_builds = {
  ["peek.nvim"] = "cd " .. vim.fn.stdpath("data") .. "/site/pack/core/opt/peek.nvim && deno task --quiet build:fast",
}

vim.api.nvim_create_user_command("PackBuild", function(opts)
  local targets = opts.args ~= "" and { [opts.args] = pack_builds[opts.args] } or pack_builds
  for plugin, cmd in pairs(targets) do
    if not cmd then
      vim.notify("No build step for: " .. plugin, vim.log.levels.WARN)
    else
      vim.notify("Building " .. plugin .. "...")
      vim.fn.jobstart(cmd, {
        on_exit = function(_, code)
          if code == 0 then
            vim.notify(plugin .. " built")
          else
            vim.notify(plugin .. " build failed (exit " .. code .. ")", vim.log.levels.ERROR)
          end
        end,
      })
    end
  end
end, { nargs = "?", desc = "Build plugins with post-install steps (:PackBuild [plugin])" })

vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

vim.api.nvim_create_user_command("PackClean", function()
  local pack_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt"
  local plugins_file = vim.fn.stdpath("config") .. "/lua/plugins.lua"

  local declared = {}
  for line in io.lines(plugins_file) do
    local repo = line:match('gh%(".-/(.-)"%)')
    if repo then declared[repo] = true end
  end

  local unused = {}
  for name in vim.fs.dir(pack_dir) do
    if not declared[name] then
      table.insert(unused, name)
    end
  end

  if #unused == 0 then
    vim.notify("No unused plugins")
    return
  end

  vim.notify("Removing: " .. table.concat(unused, ", "))
  vim.pack.del(unused)
end, { desc = "Remove plugins not declared in plugins.lua" })

-- Pack Delete and Update cmds are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PeekOpen", function() require("peek").open() end, { desc = "Open markdown preview" })
vim.api.nvim_create_user_command("PeekClose", function() require("peek").close() end, { desc = "Close markdown preview" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	-- checks if any argument is passed
    if opts.args:match("%S") then
        -- update specific plugins
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
		-- update only specified plugins
        vim.pack.update(plugins)
    else
        -- update all
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })
