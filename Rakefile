require 'pathname'

HOME = Pathname.new(ENV['HOME'])

verbose true

task default: 'dotfiles:symlink'

def link_files
  Pathname.glob('dot.*').map(&:expand_path).map do |path|
    {
      from: path.relative_path_from(HOME),
      to: HOME + path.basename.sub(/^dot\./, '.')
    }
  end
end

namespace :dotfiles do
  desc 'Create symlink'
  task :symlink do
    link_files.each do |file|
      ln_sf file[:from], file[:to]
    end
  end

  namespace :symlink do
    desc 'Rollback symlink'
    task :rollback do
      link_files.each do |file|
        rm file[:to]
      end
    end
  end
end
