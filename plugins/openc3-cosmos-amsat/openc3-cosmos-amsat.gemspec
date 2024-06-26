# encoding: ascii-8bit

Gem::Specification.new do |s|
  s.name = 'openc3-cosmos-amsat'
  s.summary = 'OpenC3 plugin for AMSATs CubeSatSim'
  s.description = <<-EOF
    OpenC3 plugin for use with the AMSAT developed CubeSatSim
  EOF
  s.license = 'MIT'
  s.authors = ['Luke Korth']
  s.email = ['luke+github@lukekorth.com']
  s.homepage = 'https://github.com/lkorth/CubeSatSim-Ground-System'
  s.platform = Gem::Platform::RUBY

  if ENV['VERSION']
    s.version = ENV['VERSION'].dup
  else
    time = Time.now.strftime("%Y%m%d%H%M%S")
    s.version = '0.0.0' + ".#{time}"
  end
  s.files = Dir.glob("{targets,lib,tools,microservices}/**/*") + %w(Rakefile README.md LICENSE.txt plugin.txt)
end
