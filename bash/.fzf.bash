# Setup fzf
# ---------
if [[ ! "$PATH" == */home/chaospie/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/chaospie/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/chaospie/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/chaospie/.fzf/shell/key-bindings.bash"
