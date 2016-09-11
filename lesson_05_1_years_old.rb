# 1. Модуль определения возраста
# Напишите модуль CalculateYears для определения возраста (полных лет). Затем подключите его в классы User и Winery. Благодаря этому мы сможем узнать возраст пользователя или количество лет существования винодельни.
require 'date'
module CalculateYears
  def years_old
    if (Time.now.to_date < @date)
      p "Date #{@date} is incorrect (>now)"
    else
      p ((Time.now.to_date - @date)/365).to_i #unless (Time.now.to_date < @date)
    end

    # TODO: add some logic
  end
end

class User
  attr_accessor :name, :date
  include CalculateYears
  def initialize name, date_of_birth
    @name = name
    @date = Date.parse date_of_birth
  end
  def to_s
    "User #{@name} - #{@date}"
  end
end

# p1 = User.new('Julie', '1996-07-22')
# puts p1
# p (p1.date)
# p Time.now.to_date
# p ((Time.now.to_date - p1.date)/365).to_i

class Winery
  include CalculateYears
  def initialize title, date_of_foundation
    @title = title
    @date = Date.parse date_of_foundation
  end
end
#
User.new('Julie', '1996-07-22').years_old # => 19
Winery.new('A Light Drop', '1954-08-01').years_old # => 61
User.new('Max', '2027-07-22').years_old
