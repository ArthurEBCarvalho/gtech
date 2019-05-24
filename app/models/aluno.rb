# encoding: utf-8
class Aluno < ActiveRecord::Base
	attr_accessible :endereco, :nascimento, :nome

	validate :validate_date, :validate_before_today
	validates :nome, presence: true, uniqueness: {case_sensitive: false}
	validates :endereco, presence: true

	has_many :provas, dependent: :delete_all

	private

	def validate_date
		begin
			Date.parse(data_us(self.nascimento))
		rescue Exception => e
			errors.add(:nascimento, "inválida")
		end	
	end

	def validate_before_today
		return if nascimento.blank?
		errors.add(:nascimento, "superior a atual") if Date.parse(data_us(self.nascimento)) > Date.today
	end

	def data_us data
		array = data.is_a?(Date) ? data.strftime("%Y-%m-%d").split("-") : data.split("/")
		"#{array[2]}-#{array[1]}-#{array[0]}"
	end
end
