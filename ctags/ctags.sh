#!/usr/bin/env bash

# Install ctags before usage
: "${PROJECT_ROOT?Need to set PROJECT_ROOT}"
: "${RUBY_GEMSET?Need RVM ruby@gemset in RUBY_GEMSET}"

source ~/.rvm/scripts/rvm
rvm ${RUBY_GEMSET}

shopt -s nullglob
cd ${PROJECT_ROOT}

bin=exctags # See http://docs.ctags.io/en/latest/autotools.html

${bin} -f ${PROJECT_ROOT}/tags.tmp --recurse ${PROJECT_ROOT} `bundle show --paths` $MY_RUBY_HOME/lib/ruby/[0-9]* $MY_RUBY_HOME/lib/ruby/site_ruby/[0-9]* $MY_RUBY_HOME/lib/ruby/vendor_ruby/[0-9]* --exclude=.git,log,tmp,doc,coverage,pkg --languages=-javascript
${bin} -f ${PROJECT_ROOT}/tags.tmp --recurse --append --languages=C,C++ $MY_RUBY_HOME/include

mv tags.tmp tags
