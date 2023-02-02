# Semantic parser for the itinerary domain

# all the node type
ARTICLES = ['a', 'an', 'the', 'is'].freeze

RELATION = ['have', 'after', 'at', 'to', 'and', ',', 'by', 'in', 'via', 'on', 'through'].freeze

# all category 
CATEGORY = ['food', 'time', 'travel', 'convence', 'start_activity', 'basic_activity', 'place'].freeze

SUB_CATEGORY = {
  'food' => ['breakfast', 'lunch', 'dinner', 'meal'].freeze,
  'time' => ['morning', 'afternoon', 'evening', 'night'].freeze,
  'travel' => ['arrive', 'depart', 'explor', 'travel', 'drive', 'go', 'visit', 'reach', 'return'].freeze,
  'convence' => ['car', 'bus', 'fligh', 'train'].freeze,
  'star activity' => ['skydiving', 'ziplining', 'rafting'].freeze,
}

CAT_RELATION = {
  'have' => ['foor'],
  'after' => ['food'],
  'food' => ['at', 'in', 'by'],
  'at' => ['time', 'place'],
  'in' => ['time'],
  'by' => ['time'],
  'on' => ['time'],
  'to' => ['place'],
  'time' => ['travel'],
  'travel' => ['to', 'place'],
  'place' => 'via',
  'via' => ['convence'],
  'star activity' => 'at'
}.freeze

# possible relation

# CAT1 CAT2 REL

def remove_articles(sentence)
  new_sentence = ""
  sentence.split(' ').each do |word|
    if ARTICLES.include? word.downcase
      next
    else
      new_sentence += word + " "
    end
  end
  new_sentence
end

def categorise_sentence(sentence)
  result = ''
  sentence.split(' ').map do |word|
    
  end
  result
end

sentence = 'Day 1: Arrive in Jaipur and visit Amber Fort, City Palace and Jantar Mantar.
Day 2: Explore Jaipur further, including Hawa Mahal, Jal Mahal and Birla Temple.
Day 3: Drive to Jodhpur and visit Mehrangarh Fort and Jaswant Thada Memorial.
Day 4: Drive to Udaipur and visit the City Palace and Jagdish Temple.
Day 5: Take a boat ride on Lake Pichola and visit Jagmandir Island Palace.
Day 6: Drive to Jaisalmer and explore the Golden Fort, Patwon Ki Haveli and Gadisar Lake.
Day 7: Drive back to Jaipur for your departure flight.'
# puts sentence
sentence = remove_articles(sentence)
puts categorise_sentence(sentence)