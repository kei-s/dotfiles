require 'pathname'
require 'fileutils'

HOME = Pathname.new(ENV['HOME'])

verbose true

task default: 'dotfiles:symlink'

def link_files
  Pathname.glob('dot.*').reject { |path| path.to_s == 'dot.config' }.map(&:expand_path).map do |path|
    {
      from: path,
      to: HOME + path.basename.sub(/^dot\./, '.')
    }
  end
end

def link_config_files
  Pathname.glob('dot.config/*').map(&:expand_path).map do |path|
    {
      from: path,
      to: HOME + '.config' + path.basename
    }
  end
end

namespace :dotfiles do
  desc 'Create symlink'
  task :symlink do
    link_files.each do |file|
      ln_sf file[:from], file[:to]
    end

    FileUtils.mkdir_p(File.expand_path('.config', ENV['HOME']))
    # for .config
    link_config_files.each do |file|
      ln_sf file[:from], file[:to]
    end
    # for neovim
    ln_sf File.expand_path('~/.vim'), File.expand_path('~/.config/nvim')
    ln_sf File.expand_path('~/.vimrc'), File.expand_path('~/.config/nvim/init.vim')
  end

  namespace :symlink do
    desc 'Rollback symlink'
    task :rollback do
      (link_files + link_config_files).each do |file|
        rm_f file[:to]
      end
      rm_f File.expand_path('~/.config/nvim')
      rm_f File.expand_path('~/.config/nvim/init.vim')
    end
  end
end
