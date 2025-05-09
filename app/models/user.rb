
class User < ApplicationRecord
    has_secure_password # Isso usa a gem bcrypt para criptografar a senha
    validates :email, presence: true, uniqueness: true
end
