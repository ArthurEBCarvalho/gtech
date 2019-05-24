class Materium < ActiveRecord::Base
  attr_accessible :descricao, :nome

  validates :nome, presence: true, uniqueness: {case_sensitive: false}
  validates :descricao, presence: true

  has_many :provas, dependent: :delete_all
end
