class Metis
  STATUS_OK = 0
  STATUS_WARNING = 1
  STATUS_CRITICAL = 2
end

require 'metis/version'
require 'metis/mixin/from_file'
require 'metis/mixin/params_validate'
require 'metis/context'
require 'metis/check_definition'
require 'metis/check_definition_list'
require 'metis/configuration_definition'
require 'metis/provider'
require 'metis/nrpe_packet'
require 'metis/server'
require 'metis/client'
require 'metis/configuration'