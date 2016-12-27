# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant box images to use. Override via VAGRANT_CUSTOM_BOX env var.
BOX_IMAGE = ENV["VAGRANT_CUSTOM_BOX"] || "centos/7"
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Machine based on Centos/7.
  config.vm.box = "#{BOX_IMAGE}"
  hostname = "#{BOX_IMAGE}-rpm-builder".gsub!(/\W/, '-')
  config.vm.hostname = hostname

  # Install FPM Cookery and its prereqs (ruby etc)
  config.vm.provision "shell" do |s|
    s.privileged = true
    s.inline = "/vagrant/scripts/install-fpm-cookery.sh"
  end
end
