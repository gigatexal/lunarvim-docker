# TODO: make this a multi-stage build
# TODO: look into shrinking the size of this container, currently > 3GB!
FROM ubuntu:latest
RUN DEBIAN_FRONTEND=noninteractive apt update && DEBIAN_FRONTEND=noninteractive apt-get install -y git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen python3 python3-pip curl
RUN cd /var/tmp && curl https://nodejs.org/dist/v16.14.0/node-v16.14.0.tar.gz -o node.tar.gz && tar xvf node.tar.gz && cd node-v16.14.0 && ./configure && make -j12 && make install
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /var/tmp/rust-install.sh && sh /var/tmp/rust-install.sh -y 
RUN echo "source $HOME/.cargo/env" >> /root/.bashrc
RUN ln -s /root/.cargo/bin/cargo /usr/local/bin/cargo
RUN cargo install fd-find
RUN cargo install ripgrep
RUN python3 -m pip install pynvim
RUN npm install -g neovim tree-sitter-cli
RUN cd /var/tmp && git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && make install
RUN mkdir /installer
COPY ./install.sh /installer/install.sh
RUN chmod u+x /installer/install.sh 
RUN ./installer/install.sh
RUN ln -s /root/.local/bin/lvim /usr/local/bin/lvim
ENTRYPOINT "bash"

