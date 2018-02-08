# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
 config.vm.box = "centos/7"
 config.vm.define "classroom" do |s|
  s.vm.network "private_network", ip: "192.168.122.254"
  s.vm.synced_folder ".", "/vagrant", disabled: true
  #s.vm.synced_folder "../repos", "/repos"
  s.vm.synced_folder "scripts/classroom", "/usr/local/scripts", type: "rsync", owner: "root", group: "root"
  s.vm.provision "shell", inline: <<-SHELL
   chmod u+x /usr/local/scripts/classroom.sh
   /usr/local/scripts/classroom.sh
  SHELL
 end
 config.vm.define "server" do |a|
  a.vm.provider "libvirt" do |v|
    v.storage :file, :size => '20G'
  end
  a.vm.network "private_network", ip: "192.168.122.11"
  a.vm.synced_folder ".", "/vagrant", disabled: true
  a.vm.synced_folder "scripts/server", "/usr/local/scripts", type: "rsync", owner: "root", group: "root"
  a.vm.provision "shell", inline: <<-SHELL
   chmod u+x /usr/local/scripts/server.sh
   /usr/local/scripts/server.sh
  SHELL
  end
  
 config.vm.define "desktop" do |b|
  b.vm.provider "libvirt" do |v|
    v.storage :file, :size => '20G'
  end
  b.vm.network "private_network", ip: "192.168.122.10"
  b.vm.synced_folder ".", "/vagrant", disabled: true
  b.vm.synced_folder "scripts/desktop", "/usr/local/scripts", type: "rsync", owner: "root", group: "root"
  b.vm.provision "shell", inline: <<-SHELL
   chmod u+x /usr/local/scripts/desktop.sh
   /usr/local/scripts/desktop.sh
  SHELL
  end
end
