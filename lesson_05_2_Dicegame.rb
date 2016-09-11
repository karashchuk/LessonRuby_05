# 2. Игра в «Кости»
# Напишите приложение для игры в «Кости». Основные правила игры:
# •	По умолчанию в игре используется 2 кубика с 6 гранями. Однако, необходимо предусмотреть возможность изменения числа кубиков и количества граней
# •	В игре может принимать произвольное количество пользователей
# •	Необходимо обеспечить проверку того что все пользователи, принимающие участие в игре сделали ставку
# •	Также необходимо проверять валидна ли ставка (число очков соответствует возможному варианту очков которое может выпасть у кубиков, количество кредитов ставки не привышает общее количество кредитов пользователя)
# •	По умолчанию выигрыш пользователя составляет 25% от его ставки (требуется предусмотреть простую возможность изменения этой величины)
# •	По завершении игры выводятся результаты с указанием общей суммы выигрыша/проигрыша в кредитах для каждого игрока
module DiceGame
  class Dice

    QUANTITY = 2
    EDGES = 6
    WIN = 0.25
    def initialize
      @qty = QUANTITY
      @edges = EDGES
    end
    def to_s
      "Dices: #{@qty} with #{@edges} edges"
    end
    def create *args
      @users = []
      for i in args
        @users.push(i)
      end
      #p @users
    end

    def turn
      points = 0
      r = Random.new
      (1..@qty).each {|x|points += r.rand(1..@edges)}
#      p points
      p "Wheel of fortune throws: #{points}"
      @users.each do |user|
        # p "User #{user.name} score #{user.score}"
        if user.score == points
          does = "wins"
          user.money += user.credits * (1 + WIN)
        else
          does = "lost"
          user.money -= user.credits
        end
        p "User #{user.name} #{does} and has #{user.money}"
        user.score = nil
        user.credits = nil
      end
    end

    def finish
      p "Game finished"
      @users.each do |user|
        difference = user.money - user.money_start
        does = "earns"
        if difference < 0
          does = "loses"
          difference = - difference
        end
        p "User #{user.name} #{does} #{difference} and has #{user.money}"
      end
    end

  end

  class User
    attr_accessor :name, :money, :score, :credits
    attr_reader :money_start
    def initialize name:"anonim", money:
      @name = name
      @money = money
      @money_start = money
    end
    def to_s
      "User #{@name} with #{@money} $"
    end
    def bet score:,credits:
      @score = score
      @credits = credits
    end

  end
end

include DiceGame
dg = Dice.new
u1 = User.new(name:"U1",money:1000)
u2 = User.new(name:"U2",money:1000)

dg.create u1,u2
u1.bet(score:4,credits:100)
u2.bet(score:5,credits:100)
dg.turn
# u1 = DiceGame::User.new(money:1000)
dg.finish


# Пример игры:
# current_game = DiceGame.create user_1, user_2
#
# user_1.bet score: 12, credits: 400
# user_2.bet score: 7,  credits: 350
#
# current_game.turn
#
# # => Wheel of fortune throws: 7
# # => user_1 loses
# # => user_2 wins
#
# user_1.bet score: 6, credits: 100
# user_2.bet score: 7, credits: 300
#
# current_game.turn
#
# # => Wheel of fortune throws: 6
# # => user_1 wins
# # => user_2 loses
#
# current_game.finish
#
# # => Game results:
# # => user_1 earns -375 credits
# # => user_2 earns -212.5 credits
# Вы можете использовать любую структуру каталогов, классы и модули. Один из вариантов:
# •	User класс пользователя
# •	Dice класс игральной кости
# •	DiceGame модуль всего приложения
# •	Validations модуль валидаций
