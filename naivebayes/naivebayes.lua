-- Simple naive Bayes classifier
--
-- Adapted from https://github.com/yannickl88/blog-articles/blob/master/src/machine-learning-naive-bayes/Classifier.php

local NaiveBayes = {}

-- Calculate the total probability for a classification
local function calculate_total_probability(self, classification)
   local classification_count = 0
   for _ in pairs(self.learned_data_tallies) do
      classification_count = classification_count + 1
   end

   return (self.learned_data_tallies[classification] + 1) / (classification_count + 1)
end

-- Calculate the probability of a datum within a given classification
local function calculate_probability(self, datum, classification)
   local datum_count = self.data_by_classification[classification][datum]
   if datum_count == nil then
      datum_count = 0
   end

   local classification_count = 0
   for _ in pairs(self.data_by_classification) do
      classification_count = classification_count + 1
   end

   return (datum_count + 1) / (classification_count + 1)
end

-- Figure out the best classification for given data
function NaiveBayes:guess(data)
   local best_likelihood = 0
   local best_classification = nil

   for classification in pairs(self.data_by_classification) do
      local likelihood = calculate_total_probability(self, classification)

      for _, datum in pairs(data) do
         likelihood =
            likelihood * calculate_probability(self, datum, classification)
      end

      if likelihood > best_likelihood then
         best_likelihood = likelihood
         best_classification = classification
      end
   end

   return best_classification
end

-- Understand how data should be classified
function NaiveBayes:learn(data, classification)
   for _, datum in pairs(data) do
      -- For initializing values possibly missing
      -- TODO: Replace with metatables
      self.data_by_classification[classification] =
         self.data_by_classification[classification] or {}
      self.data_by_classification[classification][datum] =
         self.data_by_classification[classification][datum] or 0

      self.data_by_classification[classification][datum] =
         self.data_by_classification[classification][datum] + 1 or 0
   end

   self.learned_data_tallies[classification] =
      self.learned_data_tallies[classification] + 1
end

return {
   new = function ()
      local self = {
         data_by_classification = {},
         learned_data_tallies = {}
      }

      setmetatable(self.learned_data_tallies, {
         __index = function () return 0 end
      })

      setmetatable(self, {__index = NaiveBayes})
      return self
   end
}
