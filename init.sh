#!/usr/bin/env bash
# Temporary init script, might go back to nixos, hmmm...
sudo apt install -y \
    curl \
    git \
    automake cmake libtool libtool-bin m4 `# for neovim source compile` \
    compton `# helps with tearing when using xmonad, I think ...`\
    libx11-dev `# for xmonad` \
    libxinerama-dev  `# for xmonad` \
    libxrandr-dev `# for xmonad` \
    xscreensaver `# for xmonad` \
    libxss-dev `# for xmonad` \
    dmenu `# for xmonad - mod-p run command` \
    gmrun `# for xmonad - mod-shift-p run command` \
    pkg-config `# for xmonad-contrib` \
    libxft-dev `# for xmonad-contrib` \
    libssl-dev `# various dev libs` \
    libpq-dev `# for diesel` \
    libavcodec-extras `# for netflix`

# Source code pro fonts
[ -d /usr/share/fonts/opentype ] || sudo mkdir /usr/share/fonts/opentype
sudo git clone https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
sudo fc-cache -f -v

mkdir -p ~/repos
git clone git@github.com:neovim/neovim.git ~/repos/neovim
pushd ~/repos/neovim
make CMAKE_BUILD_TYPE=Release



# Here be dragons ... 😬
curl -sSL https://get.haskellstack.org/ | sh
stack install xmonad
stack install xmonad-contrib
stack install xmobar
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
nvm install v11.15.0

# Does not support node 12 as of writing
npm i -g bash-language-server
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rls rust-analysis rust-src
cargo install cargo-edit


