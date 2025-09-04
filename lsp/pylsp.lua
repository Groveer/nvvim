return {
   settings = {
     pylsp = {
       plugins = {
         pycodestyle = {
           ignore = {'W391'},
           maxLineLength = 100
         },
       },
     },
   },
    cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
  },
}
