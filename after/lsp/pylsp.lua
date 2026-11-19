-- Make pylsp see the project's own virtualenv.
--
-- Mason installs pylsp into its own isolated venv, so out of the box it knows
-- nothing about `./.venv` in your project and reports every third-party import
-- as unresolved. Pointing the Jedi plugin at the project interpreter fixes
-- completion / go-to-definition without installing pylsp into that venv.
--
-- `vim.g.python3_host_prog` does NOT affect this: it only configures Neovim's
-- embedded :python3 provider.

---@param start string?
---@return string?
local function find_project_python(start)
  if not start or start == "" then
    return nil
  end

  local venv = vim.fs.find(".venv", { path = start, upward = true, type = "directory" })[1]
  if not venv then
    return nil
  end

  local python = venv .. "/bin/python"
  return vim.uv.fs_stat(python) and python or nil
end

---@type vim.lsp.Config
return {
  -- `before_init` runs too late to influence the spawn, and `settings` is read
  -- when the client is created, so push the setting over
  -- workspace/didChangeConfiguration once the server is up instead.
  on_init = function(client)
    local python = find_project_python(client.root_dir) or find_project_python(vim.fn.getcwd())
    if not python then
      return
    end

    client:notify("workspace/didChangeConfiguration", {
      settings = {
        pylsp = {
          plugins = {
            jedi = { environment = python },
          },
        },
      },
    })
  end,
}
