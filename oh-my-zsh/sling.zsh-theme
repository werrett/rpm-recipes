#!/usr/bin/env zsh

## Sling - A minimal, two-line theme for oh-my-zsh.
## Base off Pure by Sindre Sorhus and mods by Julien Nicoulaud
##
## Sindre Sorhus
##   Github:   https://github.com/sindresorhus
##   Twitter:  https://twitter.com/sindresorhus
##
## Julien Nicoulaud
##   Github:   https://github.com/nicoulaj
##   Twitter:  https://twitter.com/nicoulaj
##
## Author: Jonathan Werrett
##   Github:   https://github.com/werrett
##   Twitter:  https://twitter.com/werrett
##
## Date: 15 February 2015

# Variables
NEWLINE=$'\n'
LINEUP=$'\e[1A'
LINEDOWN=$'\e[1B'
SYMBOL="❯"
EXTRAS=""


function prompt_preexec() {
  # shows current dir and command in the title when a process is active
  print -Pn "\e]0;"
  echo -nE "$PWD:t: $2"
  print -Pn "\a"
}

function prompt_setup() {
  prompt_opts=(cr subst percent)

  autoload -U colors && colors
  autoload -Uz add-zsh-hook
  add-zsh-hook preexec prompt_preexec

  # Define prompts
  # File path (bright black)
  PROMPT1="${NEWLINE}%F{8}%~%f"   
                  
  # user@host (red if root, else yellow)
  # See http://unix.stackexchange.com/a/1406
  PROMPT2="${NEWLINE}%(!.%F{1}.%F{3})%n@%m " 
  
  # Red prompt character on error
  PROMPT3="%(?.%F{3}.%F{1})$SYMBOL%f "
  
  PROMPT="$PROMPT1$PROMPT2$PROMPT3"
}
prompt_setup "$@"
