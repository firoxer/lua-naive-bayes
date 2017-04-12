package = "naive-bayes"
version = "dev-0"

source = {
  url = "git://github.com/firoxer/naive-bayes-lua.git"
}

description = {
  summary = "Generic naive Bayes implementations",
  detailed = [[
    Naive Bayes implementations to satisfy your classification needs.
    In-memory, simple-to-use, no-frills.
  ]],
  homepage = "https://github.com/firoxer/naive-bayes-lua",
  license = "MIT",
  maintainer = "Oliver Vartiainen <oliver@iki.fi>"
}

dependencies = {
  "lua >= 5.1"
}

build = {
  type = "builtin",
  modules = {
    simple = "naivebayes/simple.lua"
  }
}
