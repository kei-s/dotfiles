# Prepare
    $ cd dotfiles
    $ git submodule init
    $ git submodule update
    $ ln -s .vim/autoload/pathogen.vim .vim/bundle/vim-pathogen/autoload/pathogen.vim
# Add Module
    $ git submodule add https://github.com/digitaltoad/vim-jade.git .vim/bundle/vim-jade
# Update All Modules
    $ git submodule foreach 'git co master; git pull origin master'
