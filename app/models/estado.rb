class Estado < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "nome", "sigla", "updated_at"]
    end
    
    # validates :nome, presence: true, acceptance: { message: 'não pode ser null' }
    validates :nome, presence: { message: 'deve ser preenchido' }
    validates :sigla, presence: { message: 'deve ser preenchido' }

end

