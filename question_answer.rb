class QuestionAnswer

  attr_accessor :word_list
  
  def initialize(word_list=false)   
    word_list = File.open("words.txt").readlines.map(&:chomp) if word_list == false
    @word_list = word_list 
  end
  
  def answers
    # Get all the possible unique words (answers) from the wordlist that are a length of greater then 3
    @answers = []
    @word_list.uniq.each do |word|
      if word.length > 3
        @answers << word
      end
    end
    @answers
  end  
  
  def four_letter_sequences(word)
    # Get all the 4 letter sequences (questions) from all the answers
    word.scan(/./).each_cons(4).map { |group| group.join('') }
  end

  def questions_hash
    # Creates a questions hash with all the possilbe answers
    @questions = {}
    answers.each do |answer|
      posible_questions = four_letter_sequences(answer).uniq.flatten
      posible_questions.each do |question|
        if @questions[question]
          @questions[question] << answer
        else
          @questions[question] = [answer]
        end
      end
    end
    @questions
  end
  
  def delete_questions_with_more_then_one_answer
    # Delete any question that has more then one answer
    for question in questions_hash.keys
      unless @questions[question].count == 1
        @questions.delete(question)
      end
    end
    @questions
  end
  
  def write
    # Writes the hash keys to questions.txt and the values to answers.txt
    question_and_answers_to_write = delete_questions_with_more_then_one_answer
    File.open("questions.txt", 'w') {|f| f.write(question_and_answers_to_write.keys.join("\n")) }
    File.open("answers.txt", 'w') {|f| f.write(question_and_answers_to_write.values.join("\n")) }
  end
end
QuestionAnswer.new.write