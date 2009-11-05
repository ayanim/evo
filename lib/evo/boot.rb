
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
end