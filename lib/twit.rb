require "Date"
require "pry"

class Twit
  attr_accessor :msg, :username
  attr_reader :msg, :username
  
  def initialize(msg, start_date = nil, end_date = nil)
    @start_date = start_date || Date.today - 1
    @end_date = end_date || Date.today + 1
    @msg = msg
    @favs = 0
    @username = username
  end
  
  def status
    result = (@start_date..@end_date).to_a.include? Date.today
    result ? "visible" : "invisible"
  end
  
  def popular?
    @favs
  end

  def hashtags
    @hashtags = []
    @msg.scan(/#(\w+)/).each { |hastag| @hashtags.push(hastag[0]) }
    @hashtags
  end
  
  def valid?
    @msg.length < 140
  end

  # def load_img(img)
  #   allowed_formats = [".jpg",".png",".jpeg"]
  #   ext = File.extname(img)
  #   if allowed_formats.include? ext
  #     @img = img
  #   else
  #     "Unsuported format"
  #   end
  #   # @img = allowed_formats.include? ext ? img : "Unsuported format"

  # end
end