require "rspec"
require "mocha"
require "question_answer"
  
describe QuestionAnswer do  
  q_a = QuestionAnswer.new(["arrows", "carrots", "give", "me", "10th", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th"])
  
  describe ".answers" do
    it "includes all words from the word list that are greater then 3 characters" do
      q_a.answers.should == ["arrows", "carrots", "give", "10th"]
    end
  end

  describe ".four_letter_sequences(word)" do
    it "includes all the four letter sequences from .answers " do
      question_answer = QuestionAnswer.new(["carrots"])
      question_answer.four_letter_sequences("carrots").should == ["carr", "arro", "rrot", "rots"]
    end
  end
  
  describe ".questions_hash" do
    it "Creates a questions hash with all the possilbe answers arro has two answers " do
      q_a.questions_hash.should == {"10th"=>["10th"], "rrow"=>["arrows"], "rows"=>["arrows"], "arro"=>["arrows", "carrots"], "carr"=>["carrots"], "rrot"=>["carrots"], "give"=>["give"], "rots"=>["carrots"]}
    end
  end

  describe ".delete_questions_with_more_then_one_answer" do
    it "Delete any question that has more then one answer " do
      q_a.delete_questions_with_more_then_one_answer.should == {"10th"=>["10th"], "rrow"=>["arrows"], "rows"=>["arrows"], "carr"=>["carrots"], "rrot"=>["carrots"], "give"=>["give"], "rots"=>["carrots"]}
    end
  end

  # describe ".write" do
  #   it "Writes the hash keys to questions.txt and the values to answers.txt " do
  #     question_answer.write.should == 
  #   end
  # end

end