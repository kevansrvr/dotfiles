# --- Modern Debian 13 Bashrc (tp01) ---

# 1. Ble.sh (Only run if installed)
if [[ $- == *i* ]] && [ -f ~/.local/share/blesh/ble.sh ]; then
    source ~/.local/share/blesh/ble.sh --noattach
fi

# 2. Standard Bash Settings
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# 3. Debian Chroot & Prompt
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# 4. Color Support & Aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
fi

# LS -> EZA (Modern)
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias tree='eza --tree --icons'

# CAT -> BAT (Debian name: batcat)
alias bat='batcat'
alias cat='batcat --paging=never'
alias preview='batcat'

# FD -> FDFIND (Debian name: fdfind)
alias fd='fdfind'

# System
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# 5. Functions
cht() { curl "cheat.sh/${1}"; }

# 6. FZF & FD Config (Debian Native)
# Initialize FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

# Use 'fdfind' (Debian name) instead of 'fd'
export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"

# Completion functions using fdfind
_fzf_compgen_path() { fdfind --hidden --exclude .git . "$1"; }
_fzf_compgen_dir() { fdfind --type=d --hidden --exclude .git . "$1"; }

# Preview Window (Uses batcat explicitly)
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else batcat --color=always --style=numbers --line-range :500 {}; fi'"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"

# 7. Final Loads
# Starship
eval "$(starship init bash)"

# Ble.sh attach
[[ ${BLE_VERSION-} ]] && ble-attach
