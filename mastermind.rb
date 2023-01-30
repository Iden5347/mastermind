class Mastermind
  attr_reader :wins
  def initialize ()
    @wins = 0
  end

  def new_game ()
    @code = Array.new(4) {(rand() * 6).ceil()}
    @number_of_guesses = 0
    @won = false
    while @number_of_guesses < 12 and @won == false
      guess()
      @won = @code == @guess
      @number_of_guesses += 1
    end
    if @won
      puts "Congrats! You won!"
      @wins += 1
    else
      print "L, you lost, the answer was "
      @code.each{|digit| print digit}
      puts
    end
  end

  def get_guess()
    @guess = nil
    while @guess == nil or @guess.length != 4 or @guess.any?{|digit| digit < 1 || digit > 6}
      print("guess: ")
      @guess = gets().strip.split("")
      @guess.map!{|digit| digit.to_i}
    end
  end 

  def reset_code_hash()
    @code_hash = Hash.new(0)
    @code.each {|digit| @code_hash[digit] += 1}
  end

  def guess()
    exact = 0
    similar = 0
    get_guess()
    reset_code_hash()
    @guess.each_with_index{|digit, index| if digit == @code[index] then exact += 1 end}
    @guess.each {|digit| if @code_hash[digit] > 0 then similar += 1; @code_hash[digit] -= 1 end}
    puts "exact: " + exact.to_s +  "\s\s\s\ssimilar: " + similar.to_s
  end

end

mastermind = Mastermind.new()
continue = "y"
while continue == "y"
  mastermind.new_game()
  print "Want to play again (y/n)? "
  continue = gets.strip
end
puts "You won " + mastermind.wins.to_s + " games!"