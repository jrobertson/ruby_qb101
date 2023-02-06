#!/usr/bin/env ruby

# file: ruby_qb101.tb

# Description: Ruby related questions to ask Chat GPT. #experimental

require 'polyrex-headings'

QUESTIONS = <<-MARKDOWN

title: Questions to ask when learning the programming language Ruby
tags: ruby learning book questions answers

# Questions to ask when learning the programming language Ruby

## Introduction to Programming

Write a table of contents for a programming language
What is an expression in a programming language?
What is a statement in a programming language?


## Data types

Give me an example of using an integer in the programming language Ruby.
Give me an example of using a boolean in the programming language Ruby.


MARKDOWN

class Ruby_Qb101

  def initialize(questions=QUESTIONS)

    @questions = questions[/#.*/m]
    s = '<?ph schema="book[title,tags]/section[x]"?>' + questions
    @px = PolyrexHeadings.new(s, debug: false).to_polyrex

  end

  def question(id)

    found = @px.find_by_id(id.to_s)
    found.x if found

  end

  alias q question

  def to_md()
    @questions
  end
  
  def to_xml()
    @px.to_xml(pretty: true)
  end

end

