class QuestionAnswer

  attr_accessor :word_list
  
  def initialize
    @word_list = File.open('words.txt').readlines.map(&:chomp)
  end
  
  def answers
    # Get all the possible unique words (answers) from the wordlist that are a length of greater then 3
    @answers = []
    @word_list.uniq.each do |word|
      @answers << word if word.length > 3
    end
    @answers
  end  
  
  def four_letter_sequences(word)
    # Get all the 4 letter sequences (questions) from all the answers
    word.scan(/./).each_cons(4).map { |characters| characters.join('') }.uniq
  end

  def questions_hash
    # Creates a questions hash with all the possible answers
    @questions = {}
    answers.each do |answer|
      posible_questions = four_letter_sequences(answer)
      posible_questions.each do |question|
        (@questions[question.to_sym] ||= []) << answer
      end
    end
    @questions
  end
  
  def remove_questions_with_more_then_one_answer
    # Delete any question that has more then one answer
    questions_hash.reject do |key, value|
      value.count != 1
    end
  end
  
  def write_files
    # Writes the hash keys to questions.txt and the values to answers.txt
    question_and_answers_to_write = remove_questions_with_more_then_one_answer
    write_file('questions.txt', question_and_answers_to_write.keys)
    write_file('answers.txt', question_and_answers_to_write.values.flatten)
  end

  def write_file(file, data)
    File.open(file, 'w') do |f|
      f.write(data.join("\n"))
    end
  end

end

QuestionAnswer.new.write_files
