naive-bayes-lua
===============

Naive Bayes classifier module written in Lua


How to use
----------

Require the thing:

```lua
local simple = require('naivebayes/simple')
```

Instantiate a classifier:

```lua
local classifier = simple.new()
```

Make the classifier learn stuff (replace `[data]` with a simple table and `[classification]` with whatever):

```lua
classifier:learn([data], [classification])
```

Finally, ask the classifiers opinion on new data (replace `[data]` with a simple table):

```lua
local guessedClassification = classifier:guess([data])
```


### Example

Simple text analysis:

```lua
local simple = require('naivebayes/simple')

local function splitSentenceToWords(sentence)
  -- *snip*
end

local positiveSentence = 'ice-cream is delicious and tasty'
local negativeSentence = 'escargots are slimy and gross'

local classifier = simple.new()
classifier:learn(splitSentenceToWords(positiveSentence), 'positive')
classifier:learn(splitSentenceToWords(negativeSentence), 'negative')

-- gets assigned 'negative'
local guessedClassification =
  classifier:guess(splitSentenceToWords('slimy escargots are not delicious'))
```
