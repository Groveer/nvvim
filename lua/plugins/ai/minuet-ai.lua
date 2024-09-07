return {
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  opts = function()
    return {
      notify = false,
      provider = "openai_compatible",
      provider_options = {
        openai_compatible = {
          end_point = "http://chat.groveer.com:11434/v1/chat/completions",
          model = "codellama",
          name = "Ollama",
          stream = true,
          api_key = "OPENAI_API_KEY",
        },
      },
    }
  end,
  config = function(_, opts)
    local has_cmp, cmp = pcall(require, "cmp")
    if has_cmp then
      local config = cmp.get_config()
      table.insert(config.sources, 2, {
        name = "minuet",
        max_item_count = 5,
      })
      cmp.setup(config)
    end
    require("minuet").setup(opts)
  end,
}
