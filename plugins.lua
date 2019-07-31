local iron = require('iron')

iron.core.add_repl_definitions {
  python = {
    venv_python = {
      command = "/Users/mwcmitchell/.virtualenvs/ipython/bin/ipython3 --no-autoindent"
    }
  }
}

iron.core.set_config {
  preferred = {
    python = "venv_python",
  }
}
