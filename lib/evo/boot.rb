
class Evo
  def self.core_root
    File.expand_path File.dirname(__FILE__)  
  end
  
  def self.load_paths
    [root, core_root]
  end
  
  def self.path_to file
    paths_to(file).first
  end
  
  def self.paths_to file
    load_paths.map do |path|
      path / file if File.exists? path / file
    end.compact
  end
  
  def self.package_paths
    paths_to(:packages).map do |dir|
      Dir[dir / '*']
    end.flatten
  end
  
  def self.load_packages!
    package_paths.each do |dir|
      file = dir / File.basename(dir) + '.rb'
      load file if File.exists? file
    end
  end
end