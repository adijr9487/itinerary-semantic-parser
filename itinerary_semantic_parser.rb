# Semantic parser for the itinerary domain


# REL_AFTER = {
#   :have => %w[food],
#   :after => %w[food],
#   :at => %w[time place],
#   :in => %w[time place],
#   :by => %w[time],
#   :on => %w[time place],
#   :to => %w[place],
#   :travel => %w[to in at place],
#   :place => %w[via through to],
#   :via => %w[convence],
#   'star activity' => %w[at],
#   :through => %w[convence]
# }.freeze


# Parsing the sentences
class Parser
  ''' Parsing the sentence '''
  # all article
  @@article = %w[a an the is].freeze

  # all relation
  @@relation = %w[have after at to and ',' by in via on through].freeze

  # all category
  @@cateogry = %w[food time travel convence start_activity basic_activity place].freeze

  @@sub_category = {
    :person => %w[i you he she we they me him her us them my your our],
    :food => %w[breakfast lunch dinner meal],
    :time => %w[day morning afternoon evening night yestarday tomorrow],
    :travel => %w[arrive depart arrival departure explore travel drive go visit reach return back],
    :convence => %w[car bus flight train],
    'star activity' => %w[skydiving ziplining rafting],
    :join => %w[, and],
    :break => %w[.]
  }

  @@cat_relation = {
    :have => %w[food],
    :after => %w[food],
    :food => %w[at in by],
    :at => %w[time place],
    :in => %w[time place],
    :by => %w[time],
    :on => %w[time],
    :time => %w[travel time],
    :travel => %w[to in at],
    :place => %w[via through to],
    :via => %w[convence],
    'star activity' => %w[at],
    :through => %w[convence]
  }.freeze
  
  @@possible_relation = {
    :have => %w[food],
    :after => %w[food],
    :travel => %w[place],
    :to => %w[place],
    :in => %w[place],
    :via => %w[convence],
    :through => %w[convence],
  }

  attr_accessor :sentence, :sentence_art, :tag_result, :confidence

  def initialize(sentence)
    @sentence = sentence
    @sentence_art = nil
    @tag_result = []
    @confidence = 1
  end

  def remove_articles
    new_sentence = ''
    @sentence.split(' ').each do |word|
      if @@article.include? word.downcase
        next
      else
        new_sentence += word + ' '
      end
    end
    @sentence_art = new_sentence
  end

  def get_category(word)
    @@sub_category.each do |cat, array|
      if array.include? word.downcase
        return cat
      end
    end
    nil
  end

  def mark_category
    word = ''
    @sentence_art.split('').map do |letter|
      if letter.match?(/[a-zA-Z0-9]/)
        word += letter
      else
        cat = get_category(letter)
        if !cat.nil?
          w_cat = get_category(word)
          if !w_cat.nil?
            @tag_result.push( "[#{w_cat.upcase}]" )
          else
            @tag_result.push(word)
          end
          @tag_result.push("[#{cat.upcase}]")
        else
          cat = get_category(word)
          if !cat.nil?
            @tag_result.push("[#{cat.upcase}]")
          else
            @tag_result.push(word)
          end
        end
        word = ''
      end
    end

  end

  def get_between_tags()
    pre_tag = nil
    post_tag = nil
    content = []
    new_result = []
    @tag_result.each_with_index do |word, index|
      if word.match?(/\[.*\]/)
        if pre_tag.nil? || content.length == 0
          pre_tag = word
        else
          post_tag = word

          #getting relation of content and tag
          rel = get_relation(pre_tag, post_tag, content)
          puts pre_tag, content, post_tag 
          new_result.push(pre_tag)
          new_result.push(rel)
          new_result.push(post_tag)

          content = []
          pre_tag = post_tag
          post_tag = nil
        end
      else
        if(word.length > 0)
          content.push(word)
        end
      end

    end


  end

  def get_relation(pre_tag, post_tag, content)
    
    possible = @@cat_relation[pre_tag]
    puts possible

  end

  def tokenize
    @sentence.split(' ')
  end
end

sentence = 'Day 1: Arrive in Jaipur and visit Amber Fort, City Palace and Jantar Mantar.
Day 2: Explore Jaipur further, including Hawa Mahal, Jal Mahal and Birla Temple.
Day 3: Drive to Jodhpur and visit Mehrangarh Fort and Jaswant Thada Memorial.
Day 4: Drive to Udaipur and visit the City Palace and Jagdish Temple.
Day 5: Take a boat ride on Lake Pichola and visit Jagmandir Island Palace.
Day 6: Drive to Jaisalmer and explore the Golden Fort, Patwon Ki Haveli and Gadisar Lake.
Day 7: Drive back to Jaipur for your departure flight.
Day 8: Go to Hawa Mahal and then Go back to hotel.'
# sentence = 'Day 1: Arrive in Jaipur and visit Amber Fort'
puts sentence
parser = Parser.new(sentence)
parser.remove_articles
parser.mark_category
print parser.tag_result
parser.get_between_tags