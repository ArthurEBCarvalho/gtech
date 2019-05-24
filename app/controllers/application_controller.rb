class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def data_br data
  	array = data.is_a?(Date) ? data.strftime("%Y-%m-%d").split("-") : data.split("-")
    "#{array[2]}/#{array[1]}/#{array[0]}"
  end

  def data_us data
  	array = data.is_a?(Date) ? data.strftime("%Y-%m-%d").split("-") : data.split("/")
    "#{array[2]}-#{array[1]}-#{array[0]}"
  end
end
