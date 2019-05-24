# encoding: utf-8
class Prova < ActiveRecord::Base
	include ActiveModel::Validations
	attr_accessible :aluno_id, :data, :materium_id, :nota

	validate :validate_date, :validate_before_today

	validates :nota, presence: true, :inclusion => 0..10
	validates :aluno_id, presence: true
	validates :materium_id, presence: true

	belongs_to :materium
	belongs_to :aluno

	private

	def validate_date
		begin
			Date.parse(data_us(self.data))
		rescue Exception => e
			errors.add(:data, "inválida")
		end	
	end

	def validate_before_today
		return if data.blank?
		errors.add(:data, "superior a atual") if Date.parse(data_us(self.data)) > Date.today
	end

	def data_us data
		array = data.is_a?(Date) ? data.strftime("%Y-%m-%d").split("-") : data.split("/")
		"#{array[2]}-#{array[1]}-#{array[0]}"
	end
end
