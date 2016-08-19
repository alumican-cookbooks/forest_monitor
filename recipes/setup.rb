#
# Cookbook Name:: forest_monitor
# Recipe:: setup
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#APT_OPT = '-y --allow-unauthenticated --force-yes -o DPkg::Options::="--force-overwrite" -o DPkg::Options::="--force-confdef"'
APT_OPT = '-y -o Dpkg::Options::="--force-confnew"'
#execute "export DEBIAN_FRONTEND=noninteractive"

packages = ["build-essential","git"]
execute "DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade #{APT_OPT}"

packages.each do |p|
  package p
end

git "/usr/local/rbenv" do
  repository 'http://github.com/sstephenson/rbenv.git'
end

directory "/usr/local/rbenv/plugins"

git "/usr/local/rbenv/plugins/ruby-build" do
  repository 'http://github.com/sstephenson/ruby-build.git'
end

bash "setup bashrc" do
  code <<-EOH
echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> ~/.bashrc
echo 'export RBENV_ROOT="/usr/local/rbenv"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> /root/.bashrc
echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /root/.bashrc
echo 'eval "$(rbenv init -)"' >> /root/.bashrc
EOH
  not_if 'grep RBENV_ROOT /root/.bashrc'
end

directory "/usr/local/rbenv/shims"
directory "/usr/local/rbenv/versions"

bash "setup rbenv" do
  code <<-EOH
export PATH="/usr/local/rbenv/bin:$PATH"
export RBENV_ROOT="/usr/local/rbenv"
eval "$(rbenv init -)"
/usr/local/rbenv/plugins/ruby-build/install.sh
rbenv install 2.3.1
rbenv global 2.3.1
EOH
  not_if '/usr/local/rbenv/bin/rbenv versions | grep -E "^\* 2.3.1"'
end

gem_package "fluentd"
execute "fluentd --setup /opt/fluent"
#execute "fluentd -c /opt/fluent/fluent.conf -vv &"

packages = ["wvdial"]
packages.each do |p|
  package p
end

#sudo -u autossh autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3"  -R 8022:localhost:22 graph.alumican.info

