# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# Synced folders are declared here,
# host => guest
VAGRANT_SYNCED_FOLDERS = {
  # This code
  '.' => '/vagrant',

  # For access to sibling repos (e.g. pulp_rpm, pulp_docker, ...)
  '..' => '/home/vagrant/selinuxgameel',

  # You can speed up package installs in subsequent "vagrant up" operations by making the dnf
  # cache a synced folder. This is essentially what the vagrant-cachier plugin would do for us
  # if it supported dnf, and unfortunately that project is in need of maintainers so this might
  # be the best we can do for now. Note that you'll have to manually create the '.dnf-cache'
  # directory in the same directory as this Vagrantfile for this to work.
  '.dnf-cache' => '/var/cache/dnf'
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # It is possible to use URLs to nightly images produced by the Fedora project here. You can find
  # the nightly composes here: https://kojipkgs.fedoraproject.org/compose/
  # Sometimes, a nightly compose is incomplete and does not contain a Vagrant image, so you may need
  # to browse that repository a bit to find the latest successful Vagrant image. For example, at the
  # time of this writing, I could set this setting like this for the latest F24 image:
  # config.vm.box = "https://kojipkgs.fedoraproject.org/compose/rawhide/latest-Fedora-Rawhide/compose/CloudImages/x86_64/images/<imagename>.vagrant-libvirt.box"
  config.vm.box = "fedora/25-cloud-base"

  # Comment out if you don't want Vagrant to add and remove entries from /etc/hosts for each VM.
  # requires the vagrant-hostmanager plugin to be installed
  if Vagrant.has_plugin?("vagrant-hostmanager")
      config.hostmanager.enabled = true
      config.hostmanager.manage_host = true
  end

  # provision with ansible
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/selinux-playbook.yml"
      ansible.extra_vars = {
         # Uncomment this if you want debug tools like gdb, tcpdump, et al. installed
         # (you probably don't, unless you know you do)
         # use_debug_role: true,
         # This role is required when provisioning in vagrant
         use_vagrant_role: true,
         scenario_name: 'broken_antivirus',
         # The selinuxgame playbook does not work without python3
         ansible_python_interpreter: '/usr/bin/python3'
      }
  end

  # Create the "selinuxgame" box
  config.vm.define "selinuxgame" do |selinuxgame|
    selinuxgame.vm.host_name = "selinuxgame.example.com"

    selinuxgame.vm.provider :libvirt do |domain, override|
        domain.cpus = 4
        # In some cases, the guest gets stuck at "Waiting for domain to get an IP address..." if
        # the default cpu_mode, 'host-model', is used. Using 'host-passthrough' cpu_mode prevents
        # VM migration between hosts with different CPUs. However, selinuxgameelopment environments are
        # expected to live on a single host for the duration of their existence. Due to this known
        # issue and our use case, the default cpu_mode is overridden.
        domain.cpu_mode = "host-passthrough"
        domain.graphics_type = "spice"
        domain.memory = 2048
        domain.video_type = "qxl"

    end

 end
end
