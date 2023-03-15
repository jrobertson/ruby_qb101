#!/usr/bin/env ruby

# file: ruby_qb101.tb

# Description: Ruby related questions to ask Chat GPT. #experimental
# see https://github.com/jrobertson/ruby_qb101/blob/main/data/ruby_qb101.txt for questions used

require 'qb101'



# This file contains 2 classes, the question book class and 
# the answer book class.


class Ruby_Qb101 < Qb101

  def initialize(questions_file=nil)
    
    questions_file ||= File.join(File.dirname(__FILE__), '..',
                                'data', 'ruby_qb101.txt')

    super(questions_file)

  end
  
end

class Ruby_Ab101 < Ab101

  # note: the ab_xml file can be in CGRecorder log XML format
  
  def initialize(qb, ab_xml=nil, filepath: '.', debug: false)
        
    super(qb, ab_xml, filepath: filepath, debug: debug)
  end


end
