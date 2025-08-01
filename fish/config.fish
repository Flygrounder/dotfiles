if status is-interactive
  set fish_greeting

  export EDITOR=nvim

  starship init fish | source
  zoxide init fish | source

  alias g=lazygit
  alias d=lazydocker
  alias s=lazysql
  alias p=posting
  alias y=yazi
end
