class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    
  end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(c)
    raise ArgumentError, "The guess has to be a character" if c.nil? || c.empty?
    raise ArgumentError, "The guess must be alphabetic" unless c.match(/\A[a-zA-Z]+\z/)
    

    if @guesses.downcase.include?(c.downcase) || @wrong_guesses.downcase.include?(c.downcase)
      return false
    end

    if @word.include?(c) 
      @guesses += c
    else
      @wrong_guesses += c
    end
  end

  def word_with_guesses
    @word.chars.map do |c|
      @guesses.include?(c) ? c : '-'
    end.join
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif @word.chars.all? { |c| guesses.include?(c) }
      :win
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
