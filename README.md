# SELinuxGame

### Building a scenario

#### Requirements:

 * ansible 2.3+ installed in the local environment
 * root access to a machine with virtualbox, libvirt, vagrant, ansible, and packer fully installed
 * if these are separate hosts, the local ssh-agent must be running and store the private key for
   accessing the remote machine

#### Commands:

 The following command builds a scenario called 'all_about_context_part_1'. A box with the same
 name must exist in Vagrant Cloud. A successful build will produce 2 Fedora 27 box with the
 scenario installed: one virtualbox and the other libvirt. They will be both uploaded to Vagrant Cloud under
 version '0.0.2-0.1.beta'.

 Run this command from the root of this repository.

`ansible-playbook --extra-vars "scenario_name=all_about_context_part_1 version=0.0.2-0.1.beta vagrant_cloud_token=QOUfirKFU8E4fqHVU4" --user root -i hosts ansible/build_scenario_vagrant_box.yml`