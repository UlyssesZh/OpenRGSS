PKG_VERSION = '0.2.0'
PKG_FILES = %w[README.txt LICENSE.txt] + Dir.glob('lib/**/*.rb')
Gem::Specification.new do |spec|
	spec.name = 'openrgss'
	spec.version = PKG_VERSION
	spec.summary = 'Open-source implementation of the Ruby Game Script System.'
	spec.description = 'Open-source implementation of the Ruby Game Script System.'
	spec.required_ruby_version = '>= 1.9'
	spec.requirements << 'SDL'
	
	if RUBY_PLATFORM['mingw'] || RUBY_PLATFORM['mswin']
		spec.platform = Gem::Platform::CURRENT
		spec.add_dependency 'rubysdl-mswin32-1.9'
	else
		spec.platform = Gem::Platform::RUBY
		spec.add_dependency 'rubysdl'
	end
	
	spec.files = PKG_FILES
	
	#spec.has_rdoc = true
	spec.extra_rdoc_files = %w[README.txt LICENSE.txt]
	spec.rdoc_options << '--main' << 'README.txt' << '--encoding' << 'UTF-8'
	
	spec.author = 'zh99998'
	spec.email = 'zh99998@gmail.com'
	spec.homepage = 'http://openrgss.org'
end
