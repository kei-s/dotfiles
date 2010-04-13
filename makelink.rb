Dir.glob(File.join(File.dirname(__FILE__),'*'),File::FNM_DOTMATCH).reject{|file|
  ['..','.','.svn',File.basename(__FILE__)].include? File.basename(file)
}.each{|file|
  Dir.chdir do |path|
    system("ln -s #{file} #{File.basename(file)}")
  end
}
