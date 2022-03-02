FROM rd-addon

# COPY .tejutmux.conf /home/$USERNAME/.tmux.conf

# WORKDIR /home/$USERNAME

COPY agnoster.zsh-theme /home/$USERNAME/.oh-my-zsh/themes/agnoster.zsh-theme

COPY .zshrc /home/$USERNAME/.zshrc

COPY .tejutmux.conf /home/$USERNAME/.tmux.conf

CMD ["zsh"]