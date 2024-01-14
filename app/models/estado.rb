class Estado < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "nome", "sigla", "updated_at"]
      end    
end
