require 'minctest'

local simple = require('naivebayes/simple')

local function splitToWords(sentence)
  local words = {}
  for word in string.gmatch(sentence, '%S+') do
    table.insert(words, word)
  end

  return words
end

-- Test data to learn
local sentences = {
  ['heartwarming optimists achieved harmony'] = 'positive',
  ['tranquil benefactors rejoiced in sunshine'] = 'positive',
  ['menacing filth smells foul'] = 'negative',
  ['sinister villains horrified the injured'] = 'negative'
}

local classifier = simple.new()

-- Split the test sentences to words and learn them
for sentence, classification in pairs(sentences) do
  classifier:learn(splitToWords(sentence), classification)
end

lrun('test', function()
  local words

  -- completely positive
  words = splitToWords('tranquil optimists rejoiced')
  lok(classifier:guess(words) == 'positive')

  -- mostly positive
  words = splitToWords('heartwarming optimists were injured')
  lok(classifier:guess(words) == 'positive')

  -- balanced
  words = splitToWords('tranquil filth horrified sunshine ')
  lok(classifier:guess(words) == 'positive'
    or classifier:guess(words) == 'negative')

  -- mostly negative
  words = splitToWords('sinister harmony smells')
  lok(classifier:guess(words) == 'negative')

  -- completely negative
  words = splitToWords('foul filth menacing the injured')
  lok(classifier:guess(words) == 'negative')
end)
