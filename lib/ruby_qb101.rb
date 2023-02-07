#!/usr/bin/env ruby

# file: ruby_qb101.tb

# Description: Ruby related questions to ask Chat GPT. #experimental
# see https://github.com/jrobertson/ruby_qb101/blob/main/data/ruby_qb101.txt for questions used

require 'yatoc'
require 'polyrex-headings'


# This file contains 2 classes, the question book class and 
# the answer book class.


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
  
  def questions()
    doc = Rexle.new('<root>' + self.to_html + '</root>')
    a = doc.root.xpath('//p/text()').map(&:to_s)    
  end

  def tags()
    @px.summary.tags
  end
  
  def title()
    @px.summary.title
  end
  
  def to_md()
    @questions
  end
  
  def to_html()
    s = @questions.strip.gsub(/^([^\n#].[^\n]+)[\n]+/,'\1' + "\n\n")
    Kramdown::Document.new(s).to_html
  end
  
  def to_toc()
    Yatoc.new(self.to_html(), min_sections: 1)    
  end
  
  def to_xml()
    @px.to_xml(pretty: true)
  end

end

class Ruby_Ab101

  def initialize(qb_txt, ab_xml=nil, filepath: '.', debug: false)
    
    @debug = debug
    
    @qb = Ruby_Qb101.new(qb_txt)
    
    @dx = Dynarex.new('book[title, tags]/item(question, answer)')
    @dx.title = @qb.title
    @dx.tags = @qb.tags
    
    @qb.questions.each {|q| @dx.create({question: q}) }
    
    if ab_xml then
      
      dx = Dynarex.new(ab_xml)
      
      # using each question, find the associated answer and 
      # add it the main record
      
      @qb.questions.each do |q|
        
        found = dx.find_by_question q
        
        if found then
          rx = @dx.find_by_question q
          rx.answer = found.answer 
        end        
        
      end
      
      @dx.save ab_xml
      
    end
    
  end

  def save(filename)
    @dx.save filename
  end
  
  def to_html()

    doc = Rexle.new('<body>' + @qb.to_html.gsub(/<p>[^>]+>/,'<div>\0</div>') \
                    + '</body>')
    answers = @dx.all.map(&:answer)
    
    puts 'answers: ' + answers.inspect if @debug
    
    doc.root.xpath('//p').each.with_index do |para, i|
      e = Rexle::Element.new('p', attributes: {class: 'answer'}).add_text answers[i]
      para.insert_after e
    end
    
    doc.root.xml pretty: true
  end
  
  def to_xml()
    @dx.to_xml(pretty: true)
  end

end
