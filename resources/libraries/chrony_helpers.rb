module Chrony
  module Helpers
    def self.contains_role(name, node)
      roles = node['roles']
      roles.any? { |role| role.start_with?(name) }
    end
  end
end
