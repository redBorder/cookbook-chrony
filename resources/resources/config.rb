# Cookbook:: :: chrony
#
# Resource:: config
#

unified_mode true
actions :add, :remove
default_action :add

attribute :user, kind_of: String, default: 'chrony'
attribute :ntp_servers, kind_of: Array, default: ['2.rocky.pool.ntp.org']