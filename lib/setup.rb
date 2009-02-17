require 'yaml'

require 'lib/racer.rb'

if File.exists?('conf.yml')
  CONFIG = YAML::load(File.read('conf.yml'))
else
  `cp conf-sample.yml conf.yml`
  CONFIG = YAML::load(File.read('conf.yml'))
end

CONFIG['race_distance'] = CONFIG['race_distance'].to_f
CONFIG['roller_circumference'] = CONFIG['roller_circumference'].to_f
CONFIG['bikes'].delete('')
