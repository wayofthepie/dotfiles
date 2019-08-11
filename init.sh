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
 
node_loc=/var/tmp/nodesetup
curl -sL https://deb.nodesource.com/setup_12.x > ${node_loc}
if [ "08067e98d5d523a033868a7779d601d687bdc2538fbc3a50c4d47ba1de2bae6f" != "`sha256sum ${node_loc} | awk '{print $1}'`" ]; then
    echo "SHA256 for node installer does not match previous sha!"
    exit 1
fi
sudo -E bash ${node_loc}
sudo apt-get install -y nodejs

npm config set prefix ~/.npm-global

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rls rust-analysis rust-src
cargo install cargo-edit
