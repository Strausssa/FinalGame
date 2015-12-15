class Game
    $guessedLetters = []
    $chances = 0
    $chanceCount = 0
    def generate_word
        dictionary_file = File.open("words.txt", "r")
        dictionary = []
        dictionary_file.each do |entry|
          dictionary << entry.to_s
        end
        number = Random.rand(1..dictionary.length)
        puts
        puts
        puts
        for i in 2..dictionary[number-1].length
            print "_ "
        end
        $chances = dictionary[number-1].length + 3
        puts
        puts
        puts
        return dictionary[number-1]
    end

    def printLetters(letters, word)
        str = ""
        amount = 0
        for i in 2..word.length
            str += "_ "
        end
        for a in 1..word.length
            for i in 1..letters.length
                if letters[i-1] == word[a-1]
                    str[(a-1)*2] = letters[i-1]
                    amount += 1
                    if amount*2 == str.length
                        puts
                        puts
                        puts "You won!"
                        puts
                        print "The word was ", str, "!"
                        return "good"
                    end
                end
            end
        end
        puts
        puts
        return str
    end

    def guessLetters(word)
        puts "Guess some letters!"
        puts
        print "You have ", ($chances - $chanceCount).to_s, " letters left."
        puts
        letter = gets.chomp
        if (!$guessedLetters.include? letter) && letter.length == 1
            if word[letter]
                puts
                print "Word contains ", letter
                puts
                $guessedLetters << letter
                print "Guessed Letters: "
                $guessedLetters.each do |single|
                    print single, ", "
                end
                a = printLetters($guessedLetters, word)
                if a == "good"
                    return
                else
                    if $chances == $chanceCount
                        puts
                        puts "You ran out of turns!"
                        puts
                        return
                    else
                        $chanceCount += 1
                        puts a
                    end
                end
                puts
                guessLetters(word)
            else
                puts
                print "Word does not contain ", letter
                puts
                $guessedLetters << letter
                print "Guessed Letters: "
                $guessedLetters.each do |single|
                    print single, ", "
                end
                a = printLetters($guessedLetters, word)
                if a == "good"
                    return
                else
                    if $chances == $chanceCount
                        puts
                        puts "You ran out of turns!"
                        puts
                        return
                    else
                        $chanceCount += 1
                        puts a
                    end
                end
                puts
                guessLetters(word)
            end
        else
            puts "That letter has already been guessed or you have too many letters."
            guessLetters(word)
        end
    end
end
game = Game.new
word = game.generate_word
game.guessLetters(word)
