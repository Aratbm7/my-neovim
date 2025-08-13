#!/usr/bin/env bash
set -e

echo "شروع نصب ابزارهای مورد نیاز..."

# تابع برای نصب اگر برنامه نصب نیست
install_if_not_found() {
    local cmd=$1
    local install_cmd=$2
    if ! command -v "$cmd" &> /dev/null; then
        echo "نصب $cmd ..."
        eval "$install_cmd"
    else
        echo "$cmd قبلا نصب شده"
    fi
}

# نصب stylua با cargo
install_if_not_found "stylua" "cargo install stylua --features lua52"

# نصب black با pipx یا pip
install_if_not_found "black" "pip install --break-system-packages --upgrade black || echo 'لطفا black را به صورت دستی نصب کنید'"

# نصب prettier با npm
install_if_not_found "prettier" "sudo npm install -g prettier"

# نصب deno
install_if_not_found "deno" "curl -fsSL https://deno.land/x/install/install.sh | sh && export PATH=\"$HOME/.deno/bin:\$PATH\""

# ایجاد مسیر اسکریپت‌ها
mkdir -p ~/.local/scripts

# اضافه کردن اسکریپت tmux-sessionizer
cat > ~/.local/scripts/tmux-sessionizer <<'EOF'
#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/projects ~/tests -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
else
    tmux switch-client -t $selected_name
fi
EOF

chmod +x ~/.local/scripts/tmux-sessionizer

# اضافه کردن ~/.local/scripts به PATH در bash, zsh, fish اگر نیست
add_path_to_shell_config() {
    local shell_rc=$1
    local path_line='export PATH="$HOME/.local/scripts:$PATH"'
    if ! grep -Fxq "$path_line" "$shell_rc" 2>/dev/null; then
        echo "$path_line" >> "$shell_rc"
        echo "افزودن ~/.local/scripts به PATH در $shell_rc"
    else
        echo "~/.local/scripts قبلا به PATH در $shell_rc اضافه شده"
    fi
}

if [ -f "$HOME/.bashrc" ]; then
    add_path_to_shell_config "$HOME/.bashrc"
fi
if [ -f "$HOME/.zshrc" ]; then
    add_path_to_shell_config "$HOME/.zshrc"
fi
if [ -f "$HOME/.config/fish/config.fish" ]; then
    local fish_path_line='set -gx PATH $HOME/.local/scripts $PATH'
    if ! grep -Fxq "$fish_path_line" "$HOME/.config/fish/config.fish"; then
        echo "$fish_path_line" >> "$HOME/.config/fish/config.fish"
        echo "افزودن ~/.local/scripts به PATH در fish"
    else
        echo "~/.local/scripts قبلا به PATH در fish اضافه شده"
    fi
fi

# تنظیم bindkey و bind در bash و zsh و fish
append_if_not_exists() {
    local file=$1
    local text=$2
    grep -Fqx "$text" "$file" 2>/dev/null || echo "$text" >> "$file"
}

if [ -f "$HOME/.bashrc" ]; then
    append_if_not_exists "$HOME/.bashrc" 'bind "\"\C-f\":\"tmux-sessionizer\n\""'
fi
if [ -f "$HOME/.zshrc" ]; then
    append_if_not_exists "$HOME/.zshrc" 'bindkey -s ^f "tmux-sessionizer\n"'
fi
if [ -f "$HOME/.config/fish/config.fish" ]; then
    append_if_not_exists "$HOME/.config/fish/config.fish" 'bind \cf "tmux-sessionizer"'
fi

# اضافه کردن bind-key به .tmux.conf
if [ -f "$HOME/.tmux.conf" ]; then
    if ! grep -q 'bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"' "$HOME/.tmux.conf"; then
        echo 'bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"' >> "$HOME/.tmux.conf"
        echo "افزودن تنظیم bind-key به .tmux.conf"
    else
        echo "bind-key در .tmux.conf قبلا اضافه شده"
    fi
else
    echo 'bind-key -r f run-shell "tmux neww ~/.local/scripts/tmux-sessionizer"' > "$HOME/.tmux.conf"
    echo "ساخت .tmux.conf و افزودن bind-key"
fi

echo "تمام شد! لطفا ترمینال جدید باز کنید یا فایل‌های rc خود را source کنید."

