class TimeFormat

  TIME_FORMAT = {year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S'}.freeze

  def initialize(user_format)
    @user_format = user_format
    check_format
  end

  def incorrect_format
    @user_format - @format
  end

  def apply?
    @invalid_format.empty?
  end

  def check_format
    format = @user_format.split(',')
    @invalid_format = format.reject{ |format| TIME_FORMAT.key? format.to_sym }
    @valid_format = format - @invalid_format
  end

  def return_date
    if apply?
      format = @valid_format.map { |format| TIME_FORMAT[format.to_sym] }
      Time.now.strftime(format.join('-'))
    else
      "Unknown time format #{@invalid_format}"
    end
  end

end