module Scrabble
  class Word
    attr_accessor :score, :word, :bonus

    def initialize(input)
      @word = input.downcase
      @bonus = bonus
    end

    def letters
      word.split("")
    end

    def score
      @score = letters.inject(0) do |sum, letter|
        sum + Word.alphabet[letter]
      end
      @score
    end

    def save
      Word.data.insert(  word: word,
                    score: score  )
    end

    def self.all
      data.order(Sequel.desc(:id)).collect do |row|
        Word.new(row[:word])
      end
    end

    def self.alphabet
      {"a"=>1, "b"=>3, "c"=>3, "d"=>2, "e"=>1, 
      "f"=>4, "g"=>2, "h"=>4, "i"=>1, "j"=>8,
      "k"=>5, "l"=>1, "m"=>3, "n"=>1, "o"=>1,
      "p"=>3, "q"=>10, "r"=>1, "s"=>1, "t"=>1,
      "u"=>1, "v"=>4, "w"=>4, "x"=>8, "y"=>4, "z"=>10}
    end

    def self.data
      verify_table_exists
      database[:words]
    end

    def self.database
      @words ||= Sequel.sqlite("./db/scrabble.sqlite3")
    end

    def self.verify_table_exists
      @table_exists ||= (create_table || true)
    end

    def self.create_table
      database.create_table? :words do
        primary_key :id
        String      :word, :size => 15
        Integer     :score,  :size => 4
      end
    end

  end
end