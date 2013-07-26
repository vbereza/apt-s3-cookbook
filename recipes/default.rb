#
# Cookbook Name:: apt-s3-cookbook
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "build-essential"

%w{libapt-pkg-dev libcurl4-openssl-dev git make build-essential}.each do |pkg|
  package pkg do
    action :install
  end
end

unless File.exists?("/usr/lib/apt/methods/s3")
  execute "clone apt-s3 from git" do
    command "git clone #{node[:apt][:git]}"
    creates "apt-s3"
    cwd "/tmp"
    action :run
  end

  execute "build apt-s3" do
    command "make"
    creates "/tmp/apt-s3/src/s3"
    cwd "/tmp/apt-s3"
    action :run
  end

  execute "install s3 apt methods" do
    command "sudo cp src/s3 /usr/lib/apt/methods/s3"
    creates "/usr/lib/apt/methods/s3"
    cwd "/tmp/apt-s3"
    action :run
  end

  execute "remove apt-s3 source" do
    command "rm -rf apt-s3"
    cwd "/tmp"
    action :run
  end
end
