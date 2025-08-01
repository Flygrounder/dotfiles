if status is-interactive
  set fish_greeting

  export EDIITOR=nvim

  starship init fish | source
  zoxide init fish | source

  alias lg=lazygit
end
