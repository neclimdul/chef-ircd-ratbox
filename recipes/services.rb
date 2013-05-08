#
# Cookbook Name:: ircd-ratbox
# Recipe:: services
#
# Copyright 2012, Rafael Fonseca
#

include_recipe "ircd-ratbox"

if platform? "debian", "ubuntu"
    node.set[:ircd][:services_config_path] = "/etc/ratbox-services"
end

package "ratbox-services-common"

service "ratbox-services" do
    supports :restart => true, :reload => true
    action :nothing
end

if Chef::Config[:solo]
    server_opers = [ {
        :nick => "admin",
        :user => "*",
        :host => "*",
        :password => "$1$uoIXxCX6$..iXN0jLHHLq6h/RYEG/Y/"
    } ]
else
    server_opers = node[:ircd][:ircd_opers]
end

directory node[:ircd][:services_config_path] do
    mode 0775
    owner "root"
    group "irc"
    action :create
end

template "#{node[:ircd][:services_config_path]}/ratbox-services.conf" do
    source "ratbox-services.conf.erb"
    mode 0644
    owner "root"
    group "root"
    variables(
        :opers => server_opers,
        :server_admin_name => node[:ircd][:admin][:name],
        :server_admin_email => node[:ircd][:admin][:email],
        :server_description => node[:ircd][:description],
        #:server_name => node[:ircd][:name],
        #:server_ip => node[:ircd][:ip],
        #:server_port => node[:ircd][:port],
        #:server_user => node[:ircd][:auth][:user],
        #:server_class => node[:ircd][:auth][:class],
        #:network_name => node[:ircd][:network_name],
        #:network_description => node[:ircd][:network_description],
        #:user_classes => node[:ircd][:auth][:classes],
        #:user_class_mapping => node[:ircd][:auth][:class_mapping]
    )
    notifies :reload, "service[#{node[:ircd][:service]}]"
end

if platform? "debian", "ubuntu"
    cookbook_file "/etc/default/ratbox-services" do
        source "default.init"
        action :create
    end
end

service "ratbox-services" do
    action [ :enable, :start ]
end
