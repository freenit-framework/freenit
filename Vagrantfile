# -*- mode: ruby -*-

require 'yaml'
servers = YAML.load_file('env.yml')
API_VERSION = "2"
Vagrant.configure(API_VERSION) do |config|
  servers.each do | servers |
    config.vm.define servers["name"] do |machine|
      machine.vm.box = servers["box"]
      machine.vm.network "private_network", ip: servers["box_ip"]
      machine.vm.network :forwarded_port, guest: 22, host: servers["ssh"], id: 'ssh'
      machine.vm.provider :virtualbox do |vb|
        vb.name = servers["name"]
        vb.memory = servers["memory"]
        vb.cpus = servers["cpu"]
      end
    end
  end
end
