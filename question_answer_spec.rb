require "rspec"
require "mocha"
require "question_answer"
  
describe QuestionAnswer do  

  let :q_a do
    q_a = QuestionAnswer.new
    q_a.instance_variable_set('@word_list', [
      "arrows", "carrots", "give", "me", "10th", "1st", "2nd", "3rd", "4th",
      "5th", "6th", "7th", "8th", "9th"])
    q_a
  end

  describe ".answers" do
    it "includes all words from the word list that are greater then 3 characters" do
      q_a.answers.should == ["arrows", "carrots", "give", "10th"]
    end
  end

  describe ".four_letter_sequences(word)" do
    it "includes all the four letter sequences from a word" do
      q_a.four_letter_sequences("carrots").should == ["carr", "arro", "rrot", "rots"]
    end
  end
  
  describe ".questions_hash" do
    it "creates a questions hash with all the possible answers where 'arro' has two answers" do
      q_a.questions_hash.should == {
        "10th" => ["10th"], 
        "rrow" => ["arrows"], 
        "rows" => ["arrows"], 
        "arro" => ["arrows", "carrots"], 
        "carr" => ["carrots"], 
        "rrot" => ["carrots"], 
        "give" => ["give"], 
        "rots" => ["carrots"]
      }
    end
  end

  describe ".remove_questions_with_more_then_one_answer" do
    it "should not include any question that has more then one answer" do
      q_a.remove_questions_with_more_then_one_answer.should == {
        "10th" => ["10th"], 
        "rrow" => ["arrows"], 
        "rows" => ["arrows"], 
        "carr" => ["carrots"], 
        "rrot" => ["carrots"], 
        "give" => ["give"], 
        "rots" => ["carrots"]
      }
    end
  end

  describe ".write_files" do
    it "should write the hash keys to questions.txt and the hash values to answers.txt" do
      q_a.expects(:write_file).with('questions.txt',
        ['rrow', '10th', 'rows', 'carr', 'rrot', 'rots', 'give'])
      q_a.expects(:write_file).with('answers.txt',
        ['arrows', '10th', 'arrows', 'carrots', 'carrots', 'carrots', 'give'])
      q_a.write_files
    end
  end

end
