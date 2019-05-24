module ApplicationHelper
	def data_br data
		array = data.to_s.split("-")
		"#{array[2]}/#{array[1]}/#{array[0]}"
	end
end
