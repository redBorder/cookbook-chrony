# Cookbook:: chrony
#
# Provider:: config
#
action :add do
  begin
    user = new_resource.user
    ntp_servers = new_resource.ntp_servers

    service 'chronyd' do
      action [:enable, :start]
    end

    dnf_package 'chrony' do
      action :upgrade
      flush_cache[:before]
    end

    template '/etc/chrony.conf' do
      source 'chrony.conf.erb'
      cookbook 'rb-chrony'
      variables(
        servers: ntp_servers
      )
      notifies :restart, 'service[chronyd]', :delayed
    end

    Chef::Log.info('cookbook chrony has been processed.')
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin
    service 'chronyd' do
      service_name 'chronyd'
      supports status: true, restart: true, start: true, enable: true, disable: true
      action [:disable, :stop]
    end
    Chef::Log.info('cookbook chrony has been processed.')
  rescue => e
    Chef::Log.error(e.message)
  end
end
