module DiceGame
  module Validations
    attr_reader :error

    def validuser? user
      User===user
    end

    def valid_bet?
      clear_error!
      @users.each do |user|
        @error = "User #{user.name} does not have bet \n" unless user.score > 0 && user.credits > 0
      end
      @error.nil? ? true : false
    end

    def valid_score? score
      clear_error!
      @error = "The score should be an Integer number between #{@min} and #{@max}" unless Fixnum === score && (@min..@max).include?(score)
      @error.nil? ? true : false
    end

    def valid_credits? credits
      clear_error!
      @error = " User's money  (#{@money} $) is less than credits (#{credits}) $. " unless  credits < @money
      @error.nil? ? true : false
    end

    private

    def clear_error!
      @error = nil
    end

  end
end
