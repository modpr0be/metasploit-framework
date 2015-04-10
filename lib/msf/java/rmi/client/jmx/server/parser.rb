# -*- coding: binary -*-

module Msf
  module Java
    module Rmi
      module Client
        module Jmx
          module Server
            module Parser
              # Parses a javax/management/remote/rmi/RMIServer_Stub#newClient() return value
              # to find out the remote reference information.
              #
              # @param return_value [Rex::Java::Serialization::Model::ReturnValue]
              # @return [Hash, NilClass] The remote interface information if success, nil otherwise
              def parse_jmx_new_client_endpoint(return_value)
                values_size = return_value.value.length
                end_point_block_data = return_value.value[values_size - 2]

                unless end_point_block_data.is_a?(Rex::Java::Serialization::Model::BlockData)
                  return nil
                end

                return_io = StringIO.new(end_point_block_data.contents, 'rb')

                reference = extract_reference(return_io)

                reference
              end
            end
          end
        end
      end
    end
  end
end