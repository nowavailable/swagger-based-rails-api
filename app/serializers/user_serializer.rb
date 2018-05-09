class UserSerializer < ActiveModel::Serializer
  attributes :id, :password, :email, :login, :birthday, :nickname, :last_name, :first_name, :kana_last_name, :kana_first_name
end
