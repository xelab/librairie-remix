# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

guard 'livereload' do
  watch(%r{app/assets/.+\.(sass|scss|css|js|coffee)$})
  watch(%r{app/views/.+\.(erb|haml|slim|jbuilder|coffee)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{app/controllers/.+\.rb})
  watch(%r{app/models/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
end