FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL Aswin Raghavan <aswin.raghavan@sri.com>

# ARG USERNAME=
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
ARG GPU

RUN apt-get update --fix-missing
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata locales
RUN ln -fs /usr/share/zoneinfo/US/Eastern /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
RUN locale-gen

# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
#     && apt-get update \
#     && apt-get install -y sudo wget \
#     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME \
#     #
#     # Clean up
#     && apt-get autoremove -y \
#     && apt-get clean -y \
#     && rm -rf /var/lib/apt/lists/*
# USER $USERNAME
COPY zsh-in-docker.sh /tmp
RUN /tmp/zsh-in-docker.sh \
    -p git \
    -p command-not-found \
    -p colored-man-pages \
    -p colorize \
    -p fzf \
    -p fd \
    -p kubectl \
    -p vi-mode \
    -p sudo \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -p 'history-substring-search'
RUN chsh -s /bin/zsh
SHELL ["/bin/zsh", "-lc"]
RUN exec /bin/zsh
WORKDIR /root

RUN apt-get update --fix-missing
RUN apt-get install -y software-properties-common make autoconf automake \
    pkg-config gcc build-essential g++  git wget libperl-dev cmake \
    fonts-powerline exuberant-ctags inetutils-ping libclang1 tmux \
    xauth curl  latexmk gettext libtool libtool-bin autoconf \
    cmake pkg-config unzip make build-essential libssl-dev zlib1g-dev  \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt-get install -y python3.7 python3.7-dev neovim
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.7 get-pip.py
RUN python3.7 -V && pip3 -V

RUN mkdir /opt/alias
RUN echo '#!/bin/bash' > /opt/alias/python3 && echo 'python3.7 "$@"' >> /opt/alias/python3 && chmod +x /opt/alias/python3
RUN echo '#!/bin/bash' > /opt/alias/pip3 && echo 'python3.7 -m pip "$@"' >> /opt/alias/pip3 && chmod +x /opt/alias/pip3
RUN echo '#!/bin/bash' > /opt/alias/python && echo 'python3.7 "$@"' >> /opt/alias/python && chmod +x /opt/alias/python
RUN echo '#!/bin/bash' > /opt/alias/pip && echo 'python3.7 -m pip "$@"' >> /opt/alias/pip && chmod +x /opt/alias/pip
ENV PATH /opt/alias:$PATH
RUN python3 -V && pip3 -V
RUN which python3.7
RUN python -V && pip -V
RUN which python

#Install FZF
RUN curl -L https://github.com/sharkdp/fd/releases/download/v8.0.0/fd_8.0.0_amd64.deb > fd_8.0.0_amd64.deb
RUN dpkg -i fd_8.0.0_amd64.deb
# alias fd -> fdfind
# RUN sudo mkdir /opt/alias && sudo echo 'fdfind "$@"' >> /opt/alias/fd && sudo chmod +x /opt/alias/fd
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
RUN  /root/.fzf/install --all

# Setting fd as the default source for fzf
ENV FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
ENV FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
ENV FZF_CTRL_T_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && \
				echo {} is a binary file || \
                (bat --style=numbers --color=always {} || \
                cat {}) 2> /dev/null | head -500'"
ENV FZF_BASE=/root/.fzf

RUN python3.7 -m pip install tornado 'python-language-server[all]' powerline-status powerline-gitstatus ipykernel jupyter jupyter_console notedown pillow  seaborn flake8 flake8-mypy yapf doq isort rope pylint jupyter-tensorboard   sklearn  scikit-image pandas Pillow pytest tornado greenlet pynvim neovim jedi parso==0.7.0 jedi-language-server debugpy rich matplotlib opencv-python ipython setuptools beautifulsoup4 colorama cython hickle image-classifiers==1.0.0b1 imageio imagesize lxml  numpy==1.16.4 requests scikit-learn tabulate tqdm wget xmltodict xxhash

RUN if [[ -n "$GPU" ]] ; then  python3.7 -m pip  install  torch torchvision tensorflow-gpu==1.15.0 keras==2.3.0; else  python3.7 -m pip install  tensorflow==1.15.0 keras==2.3.0 torch==1.4.0+cpu torchvision==0.5.0+cpu -f https://download.pytorch.org/whl/torch_stable.html; fi
RUN  python3.7 -m pip install  git+https://github.com/tensorflow/cleverhans.git#egg=cleverhans

# setup vim-plug
WORKDIR /root
ENV XDG_CONFIG_HOME=/root/.config
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN mkdir /root/.config
RUN mkdir /root/.config/nvim
COPY init.vim /root/.config/nvim/init.vim
RUN nvim +PlugInstall +qa
WORKDIR /root
EXPOSE 8888

ENTRYPOINT [ "/bin/zsh" ]
CMD ["-l"]
