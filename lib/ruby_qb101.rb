#!/usr/bin/env ruby

# file: ruby_qb101.tb

# Description: Ruby related questions to ask Chat GPT. #experimental

require 'yatoc'
require 'polyrex-headings'


class Ruby_Qb101

  def initialize(questions_file=nil)
    
    questions_file ||= File.join(File.dirname(__FILE__), '..',
                                'data', 'ruby_qb101.txt')

    s = File.read(questions_file)
    @questions = s[/#.*/m]
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
  
  def to_html()
    Kramdown::Document.new(@questions).to_html
  end
  
  def to_toc()
    Yatoc.new(self.to_html(), min_sections: 1)    
  end
  
  def to_xml()
    @px.to_xml(pretty: true)
  end

end

#qb = Ruby_Qb101.new()
#qb.to_md
#qb.question('7')
