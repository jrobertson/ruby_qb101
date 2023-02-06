Gem::Specification.new do |s|
  s.name = 'ruby_qb101'
  s.version = '0.2.0'
  s.summary = 'Ruby related questions to ask Chat GPT. #experimental'
  s.authors = ['James Robertson']
  s.files = Dir["lib/ruby_qb101.rb", "data/ruby_qb101.txt"]
  s.add_runtime_dependency('yatoc', '~> 0.3', '>=0.3.5')
  s.add_runtime_dependency('polyrex-headings', '~> 0.3', '>=0.3.0')
  s.signing_key = '../privatekeys/ruby_qb101.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/ruby_qb101'
end
