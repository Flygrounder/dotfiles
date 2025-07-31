if status is-interactive
  set fish_greeting

  export EDITOR=zeditor

  starship init fish | source
  zoxide init fish | source
end
