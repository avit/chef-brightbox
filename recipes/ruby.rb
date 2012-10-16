#
# Cookbook Name:: brightbox
# Recipe:: ruby
#
# Copyright 2012, Andrew Vit
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

apt_repository "brightbox-ruby-ng" do
  action       :add
  uri          "http://ppa.launchpad.net/brightbox/ruby-ng-experimental/ubuntu"
  distribution node['lsb']['codename']
  components   ["main"]
  keyserver    "keyserver.ubuntu.com"
  key          "C3173AA6"
end

apt_package "build-essential"
apt_package "libreadline-dev"
apt_package "libsqlite3-dev"
apt_package "libmysqlclient-dev"
apt_package "libssl-dev"
apt_package "libxml2-dev"
apt_package "libxslt-dev"
apt_package "libyaml-dev"
apt_package "openssl"
apt_package "sqlite3"
apt_package "zlib1g"

apt_package "ruby"
apt_package "ruby1.9.3"

execute "update-alternatives ruby" do
  command "update-alternatives --set ruby /usr/bin/ruby1.9.1"
end

cookbook_file "/etc/gemrc" do
  action :create_if_missing
  source "gemrc"
  mode "0644"
end

["bundler", "rake", "rubygems-bundler"].each do |gem|
  gem_package gem do
    gem_binary "/usr/bin/gem"
    action :install
    options "-E --no-rdoc --no-ri"
  end
end
