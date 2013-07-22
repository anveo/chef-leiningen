#
# Cookbook Name:: leiningen
# Recipe:: default
#
# Copyright 2010, Opscode, Inc.
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

include_recipe "java"

jar_file ="#{node[:leiningen][:jar_dir]}/leiningen-#{node[:leiningen][:version]}-standalone.jar"

remote_file "/usr/local/bin/lein" do
  source node[:leiningen][:install_script]
  owner node[:leiningen][:user]
  group node[:leiningen][:group]
  mode 0755
  notifies :create, "ruby_block[lein-system-wide]", :immediately
  not_if "grep -qx 'export LEIN_VERSION=\"#{node[:leiningen][:version]}\"' /usr/local/bin/lein"
end

#ruby_block "lein-system-wide" do
#  block do
#    rc = Chef::Util::FileEdit.new("/usr/local/bin/lein")
#    rc.search_file_replace_line(/^LEIN_JAR=.*/, "LEIN_JAR=#{jar_file}")
#    rc.write_file
#  end
#  action :nothing
#end
#
#directory node[:leiningen][:jar_dir] do
#  owner node[:leiningen][:user]
#  group node[:leiningen][:group]
#  mode "0744"
#  action :create
#end
#
#execute "lein_self_install" do
#  command "export LEIN_ROOT=1; lein self-install"
#  user   node[:leiningen][:user] 
#  group  node[:leiningen][:group]
#  not_if{ File.exists?(jar_file) }
#end
