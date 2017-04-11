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

Make the classifier learn stuff (replace `[data]` and `[classification]` with anything you want):

```lua
classifier:learn([data], [classification])
```

Finally, ask the classifiers opinion on new data:

```lua
local guessedClassification = classifier:guess([data])
```

See the `tests/` directory for examples.
