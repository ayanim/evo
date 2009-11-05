
class Evo
  def self.core_root
    File.expand_path File.dirname(__FILE__)  
  end
  
  def self.package_load_path
    ["#{root}/application/packages", "#{core_root}/packages"]
  end
end