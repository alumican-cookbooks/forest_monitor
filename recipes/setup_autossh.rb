packages = ["autossh"]
packages.each do |p|
  package p
end

user "autossh" do
  home  '/home/autossh'
  shell '/bin/false'
end

directory "/home/autossh/.ssh" do
  recursive true
  user 'autossh'
  group 'autossh'
end

execute "sudo -u autossh -s /bin/bash -c 'ssh-keygen -f /home/autossh/.ssh/id_rsa -t rsa -b 4096 -P \"\" '" do
  not_if "test -f /home/autossh/.ssh/id_rsa.pub"
end

template "/etc/init.d/autossh" do
  mode 0755
end

service "autossh" do
  action [:enable,:start]
end

