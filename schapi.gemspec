Gem::Specification.new do |s|
    s.name        = 'schapi'
    s.version     = '0.0.1'
    s.date        = '2018-05-26'
    s.summary     = "Schapi for Ruby"
    s.description = "School API for Ruby"
    s.authors     = ["Toygrammer"]
    s.email       = 'gdh0608@naver.com'
    s.files       = ["lib/api.rb"]
    s.homepage    = ''
    s.license     = 'Apache-2.0'
    s.metadata   = { "source_code_uri" => "https://github.com/DSM-SchoolAPI/Schapi-RB" }
    s.add_runtime_dependency 'nokogiri', '~> 1.8', '>= 1.8.2'
end